import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codegen/generated/locale_keys.g.dart';
import 'package:codegen/model/article_model/article_model.dart';
import 'package:codegen/model/topic/topic.dart';
import 'package:codegen/model/user/user_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:newsapp/src/common/base/base_response.dart';
import 'package:newsapp/src/common/utils/enums/firebase_collection.dart';
import 'package:newsapp/src/common/utils/enums/pref_keys.dart';
import 'package:newsapp/src/data/data_source/local/local_ds.dart';

abstract class IFirestoreRepository {
  String get userId;

  Future<void> saveUser({required UserModel user});

  Future<NetworkResponse<bool>> updateProfile(UserModel user);

  Future<void> updateTopic({required List<Topic> topics});

  Future<NetworkResponse<String>> updateProfilePhoto(File imageFile);

  Future<UserModel?> getUserInfo();

  Future<void> saveNews(Article article);

  Future<void> removeNews(Article article);

  Future<List<Article>> getNews();

  Future<void> isRememberMeAndSetAuthStatus({
    required bool isRememberMe,
    required String userId,
  });

  Future<void> setAuthAndSaveUser({
    required bool isRememberMe,
    required UserModel user,
    bool isNewsUser = false,
  });
}

final class FirestoreRepository implements IFirestoreRepository {
  factory FirestoreRepository() {
    return _instance ??= FirestoreRepository._();
  }
  FirestoreRepository._() {
    _firestore = FirebaseFirestore.instance;
    _cacheRepository = CacheRepository.instance;
    _storage = FirebaseStorage.instance;
  }
  static FirestoreRepository? _instance;
  late final FirebaseFirestore _firestore;
  late final FirebaseStorage _storage;
  late final CacheRepository _cacheRepository;

  @override
  String get userId =>
      _cacheRepository.getString(PrefKeys.isUserLoggedIn) ?? '';

  Reference? storageRef;

  @override
  Future<void> saveUser({required UserModel user}) async {
    String? profilePhotoUrl;
    var userToSave = user;

    if (user.profilePhoto != null && user.profilePhoto!.isNotEmpty) {
      final file = File(user.profilePhoto!);
      if (await file.exists()) {
        final storageRef = _storage
            .ref()
            .child('profile_photos')
            .child('${user.id}.jpg');
        await storageRef.putFile(file);
        profilePhotoUrl = await storageRef.getDownloadURL();
        userToSave = user.copyWith(profilePhoto: profilePhotoUrl);
      }
    }

    await _firestore
        .collection(FirebaseCollection.users.collectionName)
        .doc(user.id)
        .set(userToSave.toJson());

    await _firestore
        .collection(FirebaseCollection.news.collectionName)
        .doc(user.id)
        .set({
          FirebaseCollection.savedNews.collectionName: List<String>.empty(),
        });
  }

  @override
  Future<NetworkResponse<bool>> updateProfile(UserModel user) async {
    try {
      await _firestore
          .collection(FirebaseCollection.users.collectionName)
          .doc(user.id)
          .update(user.toJson());
      return NetworkResponse.success(data: true);
    } on FirebaseAuthException catch (e) {
      return NetworkResponse.failure(message: e.message ?? '');
    }
  }

  @override
  Future<void> updateTopic({required List<Topic> topics}) async {
    await _firestore
        .collection(FirebaseCollection.users.collectionName)
        .doc(userId)
        .update({'topics': topics.map((e) => e.toJson()).toList()});
  }

  @override
  Future<UserModel?> getUserInfo() async {
    final snapshot = await _firestore
        .collection(FirebaseCollection.users.collectionName)
        .doc(userId)
        .get();
    if (!snapshot.exists) return null;
    return UserModel.fromJson(snapshot.data()!);
  }

  @override
  Future<void> saveNews(Article article) async {
    await _firestore
        .collection(FirebaseCollection.news.collectionName)
        .doc(userId)
        .update({
          FirebaseCollection.savedNews.collectionName: FieldValue.arrayUnion([
            article.toJson(),
          ]),
        });
  }

  @override
  Future<void> removeNews(Article article) async {
    await _firestore
        .collection(FirebaseCollection.news.collectionName)
        .doc(userId)
        .update({
          FirebaseCollection.savedNews.collectionName: FieldValue.arrayRemove([
            article.toJson(),
          ]),
        });
  }

  @override
  Future<List<Article>> getNews() async {
    final snapshot = await _firestore
        .collection(FirebaseCollection.news.collectionName)
        .doc(userId)
        .get();

    if (snapshot.exists) {
      final data = snapshot.data();
      if (data != null) {
        final articlesData =
            data[FirebaseCollection.savedNews.collectionName] as List<dynamic>?;
        if (articlesData == null) return [];
        return articlesData
            .map((e) => Article.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    }
    return [];
  }

  @override
  Future<NetworkResponse<String>> updateProfilePhoto(File imageFile,) async {
    try {
      final storageRef = _storage
          .ref()
          .child('profile_photos')
          .child('$userId.jpg');
      await storageRef.putFile(imageFile);

      final downloadUrl = await storageRef.getDownloadURL();

      await _firestore
          .collection(FirebaseCollection.users.collectionName)
          .doc(userId)
          .update({'profilePhoto': downloadUrl});

      return NetworkResponse.success(data: downloadUrl);
    } on FirebaseException catch (e) {
      return NetworkResponse.failure(
        message: e.message ?? LocaleKeys.unknownError.tr(),
      );
    } catch (e) {
      return NetworkResponse.failure(message: e.toString());
    }
  }

  @override
  Future<void> isRememberMeAndSetAuthStatus({
    required bool isRememberMe,
    required String userId,
  }) async {
    if (isRememberMe) {
      await _cacheRepository.setString(PrefKeys.isUserLoggedIn, userId);
    }
  }

  @override
  Future<void> setAuthAndSaveUser({
    required bool isRememberMe,
    required UserModel user,
    bool isNewsUser = false,
  }) async {
    if (user.id == null) return;
    await _cacheRepository.setString(PrefKeys.isUserLoggedIn, user.id!);
    await isRememberMeAndSetAuthStatus(
      isRememberMe: isRememberMe,
      userId: user.id!,
    );
    if (!isNewsUser) return;
    await saveUser(user: user);
  }
}

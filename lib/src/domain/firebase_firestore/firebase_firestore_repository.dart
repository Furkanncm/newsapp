import 'package:codegen/model/article_model/article_model.dart';
import 'package:codegen/model/topic/topic.dart';
import 'package:codegen/model/user/user_model.dart';
import 'package:newsapp/src/common/base/base_response.dart';
import 'package:newsapp/src/data/data_source/remote/firebase_ds.dart';

abstract class IFirebaseFirestoreRepository {
  Future<void> saveUser({required UserModel user});

  Future<NetworkResponse<bool>> updateProfile(UserModel user);

  Future<void> updateTopic({required List<Topic> topics});

  Future<UserModel?> getUserInfo();

  Future<void> saveNews(Article article);

  Future<void> removeNews(Article article);

  Future<List<Article>> getNews();
}

final class FirebaseFirestoreRepository
    implements IFirebaseFirestoreRepository {
  factory FirebaseFirestoreRepository() {
    return _instance ??= FirebaseFirestoreRepository._();
  }
  FirebaseFirestoreRepository._() {
    _firebaseDataSource = FirebaseDataSource();
  }
  static FirebaseFirestoreRepository? _instance;

  late final FirebaseDataSource _firebaseDataSource;

  @override
  Future<void> saveUser({required UserModel user}) async =>
      _firebaseDataSource.saveUser(user: user);

  @override
  Future<NetworkResponse<bool>> updateProfile(UserModel user) async =>
      _firebaseDataSource.updateProfile(user);

  @override
  Future<void> updateTopic({required List<Topic> topics}) async =>
      _firebaseDataSource.updateTopic(topics: topics);

  @override
  Future<UserModel?> getUserInfo() async => _firebaseDataSource.getUserInfo();

  @override
  Future<void> saveNews(Article article) async =>
      _firebaseDataSource.saveNews(article);

  @override
  Future<void> removeNews(Article article) async =>
      _firebaseDataSource.removeNews(article);

  @override
  Future<List<Article>> getNews() async => _firebaseDataSource.getNews();
}

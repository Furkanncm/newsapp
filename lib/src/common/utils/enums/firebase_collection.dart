enum FirebaseCollection {
  users('users'),
  articles('articles'),
  news('news'),
  savedNews('saved_news'),
  topics('topics'),
  profilePhotos('profile_photos')
  ;

  const FirebaseCollection(this.collectionName);
  final String collectionName;
}

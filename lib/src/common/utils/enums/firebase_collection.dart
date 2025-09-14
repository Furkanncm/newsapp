enum FirebaseCollection {
  users('users'),
  articles('articles'),
  news('news'),
  savedNews('saved_news'),
  topics('topics');

  const FirebaseCollection(this.collectionName);
  final String collectionName;


}

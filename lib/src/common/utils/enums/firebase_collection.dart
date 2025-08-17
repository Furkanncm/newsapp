enum FirebaseCollection {
  users('users'),
  articles('articles'),
  topics('topics');

  const FirebaseCollection(this.collectionName);
  final String collectionName;


}

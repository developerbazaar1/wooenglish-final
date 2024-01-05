class FirebaseUser{
  String? uid;
  String? fcmId;
  String? refreshToken;
  String? displayName;
  String? email;
  String? photoURL;
  String? phoneNumber;

  FirebaseUser({this.uid, this.fcmId, this.refreshToken, this.displayName,
    this.email, this.photoURL, this.phoneNumber});
}
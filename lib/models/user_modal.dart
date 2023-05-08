class UserModal {
  String userId;
  String name;
  String emailId;
  String phoneNumber;
  String isOnline;
  String profileImage;
  Map fullData;

  UserModal({
    required this.userId,
   required this.emailId,
    required this.name,
    required this.profileImage,
    required this.phoneNumber,
    required this.isOnline,
    required this.fullData
  });

  factory UserModal.fromJson(Map userMap) {
    return UserModal(
      userId: userMap['id'].toString()??'0',
      name: userMap['name'].toString()??'NA',
      emailId: userMap['email'].toString()??"",
      phoneNumber: userMap['phone'].toString()??'',
      profileImage: userMap['profile_img'].toString()??'',
      isOnline: userMap['isOnline'].toString()??'',
      fullData: userMap,
    );
  }



}


/*      SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("is_login", "true");
          prefs.setString("user_id", response['data']['id'].toString());
          prefs.setString("phone", response['data']['phone'].toString());
          prefs.setString("name", response['data']['name'].toString());
          prefs.setString("email", response['data']['email'].toString());
          prefs.setString("profile_img", response['data']['profile_img'].toString());*/
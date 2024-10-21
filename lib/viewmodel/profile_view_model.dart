import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:weather/models/user_profile_model.dart';

class ProfileViewModel extends ChangeNotifier{
  final UserProfileModel _mainuser = UserProfileModel(userName: "Aed24", email: "doseraliemre@gmail.com", profilPhotoLink: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixabay.com%2Fvectors%2Fblank-profile-picture-mystery-man-973460%2F&psig=AOvVaw1X5SDdwC7tTQze0uuzol5h&ust=1729330607286000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCIiO-dXQl4kDFQAAAAAdAAAAABAE");
  UserProfileModel get mainuser => _mainuser;






}
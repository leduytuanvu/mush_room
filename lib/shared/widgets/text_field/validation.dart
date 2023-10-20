import 'package:mush_room/shared/widgets/text_field/mush_room_text_field_widget.dart';

class MushRoomValidation {
  static String email(String value) {
    final RegExp emailRegExp =
        RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value.isEmpty) {
      return 'Email is required';
    } else if (!emailRegExp.hasMatch(value)) {
      return 'Enter a valid email address';
    }else{
      return "";
    }
  }

  static String password(String value) {

    if (value.isEmpty) {
      return 'password is required';
    } else if (value.length < 8) {
      return 'Minimum password 8 characters';
    }else{
      return "";
    }
  }
  static String confirmPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return 'password is required';
    } else if (confirmPassword.length < 8) {
      return 'Minimum password 8 characters';
    }else if(password != confirmPassword){
      return "confirm password must match password";
    }else{
      return "";
    }
  }
  static String phoneNumber(String phoneNumber){
    if (phoneNumber.isEmpty) {
      return 'password is required';
    } else if (phoneNumber.length < 8) {
      return 'Minimum password 8 characters';
    } else{
      return "";
    }
  }
  static String address(String address){
    if (address.isEmpty) {
      return 'password is required';
    } else if (address.length < 8) {
      return 'Minimum password 8 characters';
    } else{
      return "";
    }
  }
}

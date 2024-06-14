

//responsible for loading and saving itself
import 'dart:async';

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class DataRepository{

  static String loginName = ""; //initially it's empty string
  static String loginPassword = "";
  static String firstName = "";
  static String lastName = "";
  static String phoneNumber = "";
  static String emailAddress = "";

  static void loadLoginData()
  {
    //load your variables here
    var prefs = EncryptedSharedPreferences();
    prefs.getString("loginName").then( (endProduct) {loginName = endProduct;}    );
    prefs.getString("loginPassword").then( (endProduct) {loginPassword = endProduct;}    );
  }

  static void loadProfileData()
  {
    //load your variables here
    var prefs = EncryptedSharedPreferences();
    prefs.getString("firstName").then( (endProduct) {firstName = endProduct;}    );
    prefs.getString("lastName").then( (endProduct) {lastName = endProduct;}    );
    prefs.getString("phoneNumber").then( (endProduct) {phoneNumber = endProduct;}    );
    prefs.getString("emailAddress").then( (endProduct) {emailAddress = endProduct;}    );
    //firstName =  await prefs.getString("firstName");
  }


  static void saveLoginData()
  {
    //save your variables
    var prefs = EncryptedSharedPreferences();
    prefs.setString("loginName", loginName);
    prefs.setString("loginPassword", loginPassword);

  }

  static void saveProfileData()
  {
    //save your variables
    var prefs = EncryptedSharedPreferences();
    prefs.setString("firstName", firstName);
    prefs.setString("lastName", lastName);
    prefs.setString("phoneNumber", phoneNumber);
    prefs.setString("emailAddress", emailAddress);
  }

  static void clearLoginData()
  {
    var prefs = EncryptedSharedPreferences();
    prefs.remove("loginName");
    prefs.remove("loginPassword");

  }

  static void clearProfileData()
  {
    var prefs = EncryptedSharedPreferences();
    prefs.remove("firstName");
    prefs.remove("lastName");
    prefs.remove("phoneNumber");
    prefs.remove("emailAddress");
  }

}
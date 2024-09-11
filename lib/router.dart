import 'package:findhomeforpets/states/PetIdentifier.dart';
import 'package:findhomeforpets/states/authen.dart';
import 'package:findhomeforpets/states/chat/chat.dart';
import 'package:findhomeforpets/states/create_account.dart';
import 'package:findhomeforpets/states/create_google_acc.dart';
import 'package:findhomeforpets/states/editprofile.dart';
import 'package:findhomeforpets/states/forgot_password.dart';
import 'package:findhomeforpets/states/helppet/helppet.dart';
import 'package:findhomeforpets/states/home.dart';
import 'package:findhomeforpets/states/missingpet/missingpet_all.dart';
import 'package:findhomeforpets/states/mypost/mypost.dart';
import 'package:findhomeforpets/states/post_helppet.dart';
import 'package:findhomeforpets/states/post_missingpet.dart';
import 'package:findhomeforpets/states/profile.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/forgotPassword': (BuildContext context) => ForgotPassword(),
  '/home': (BuildContext context) => Home(),
  '/postmissingpet': (BuildContext context) => PostMissingPet(),
  '/posthelppet': (BuildContext context) => Posthelppet(),
  '/profile': (BuildContext context) => Profile(),
  '/missingpet': (BuildContext context) => MissingPet_all(),
  '/helppet': (BuildContext context) => Helppet(),
  '/createGoogleAcc': (BuildContext context) => createGoogleAcc(),
  '/editprofile': (BuildContext context) => EditProfile(),
  '/chat': (BuildContext context) => Chat(),
  '/PetIdentifier': (BuildContext context) => PetIdentifier(),
  '/Mypost': (BuildContext context) => MyPost(),
};

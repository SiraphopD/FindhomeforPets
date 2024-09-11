// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:findhomeforpets/api/access_firebase_token.dart';
// import 'package:findhomeforpets/models/message.dart';
// import 'package:findhomeforpets/models/user_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:http/http.dart';

// class APIs {
//   // for authentication
//   static FirebaseAuth auth = FirebaseAuth.instance;
//   // for storing self information
//   static UserModel usermodel = UserModel(
//     name: user.uid.toString(),
//     gender: '',
//     phonenum: '',
//     province: '',
//     introduce: '',
//     PathImage: user.photoURL.toString(),
//     pushToken: '',
//   );
//   // to return current user
//   static User get user => auth.currentUser!;

//   static FirebaseMessaging fMessaging = FirebaseMessaging.instance;

//   static Future<void> sendPushNotification(MessageChat chat, String msg) async {
//     await Firebase.initializeApp().then((value) async {
//       String uid = chat.idTo;
//       DocumentSnapshot userDoc =
//           await FirebaseFirestore.instance.collection('user').doc(uid).get();
//       String name = userDoc.get('name');
//       String pushToken = userDoc.get('pushToken');

//       AccessFirebaseToken accessToken = AccessFirebaseToken();
//       String bearerToken = await accessToken.getAccessToken();

//       final body = {
//         "message": {
//           "token": pushToken.toString(),
//           "notification": {"title": usermodel.name, "body": msg},
//         }
//       };
//       try {
//         var res = await post(
//           Uri.parse(
//               'https://fcm.googleapis.com/v1/projects/findhomeforpets/messages:send'),
//           headers: {
//             "Content-Type": "application/json",
//             'Authorization': 'Bearer $bearerToken'
//           },
//           body: jsonEncode(body),
//         );
//         print("Response statusCode: ${res.statusCode}");
//         print("Response body: ${res.body}");
//       } catch (e) {
//         print("\nsendPushNotification: $e");
//       }
//     });
//   }
// }

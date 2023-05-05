import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:toyunity/screens/components/forms/custom_text.dart';
import 'package:toyunity/screens/login/social_login/social_login_screen.dart';

import '../../../constants/constants.dart';
import '../../../main.dart';
import '../../../models/user_model.dart';
import '../../components/forms/costum_text_field.dart';
import 'chat_screen.dart';
import 'search_screen.dart';

class ChatHomeScreen extends StatefulWidget {
  ChatHomeScreen();
  @override
  _ChatHomeScreenState createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  UserModel user = MyApp.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CustumText(
              text: 'T-U Chat',
              size: 20,
              color: white,
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () async {
                await GoogleSignIn().signOut();
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (route) => false);
              },
              icon: Icon(
                Icons.logout,
                color: textColor,
              ))
        ],
      ),
      body: user == null
          ? Container()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .collection('messages')
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.docs.length < 1) {
                        return Center(
                          child: Text("Aucun Chat disponible"),
                        );
                      }
                      return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            var friendId = snapshot.data.docs[index].id;
                            var lastMsg = snapshot.data.docs[index]['last_msg'];
                            return FutureBuilder(
                              future: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(friendId)
                                  .get(),
                              builder: (context, AsyncSnapshot asyncSnapshot) {
                                if (asyncSnapshot.hasData) {
                                  var friend = asyncSnapshot.data;
                                  return ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(80),
                                      child: CachedNetworkImage(
                                        imageUrl: friend['image'],
                                        placeholder: (conteext, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(
                                          Icons.error,
                                        ),
                                        height: 50,
                                      ),
                                    ),
                                    title: Text(friend['name']),
                                    subtitle: Container(
                                      child: Text(
                                        "$lastMsg",
                                        style:
                                            const TextStyle(color: Colors.grey),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ChatScreen(
                                                  currentUser: user,
                                                  friendId: friend['uid'],
                                                  friendName: friend['name'],
                                                  friendImage:
                                                      friend['image'])));
                                    },
                                  );
                                }
                                return LinearProgressIndicator();
                              },
                            );
                          });
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor,
        child: Icon(Icons.chat_rounded),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SearchScreen(user)));
        },
      ),
    );
  }
}

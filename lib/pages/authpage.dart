import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:markethelper/pages/add_item_page.dart';
import 'package:markethelper/pages/kart_list_page.dart';
import 'package:markethelper/pages/search_page.dart';

import 'loginpage.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return SearchPage();
          }else{
            return LoginPage();
          }
        },
    );
  }
}

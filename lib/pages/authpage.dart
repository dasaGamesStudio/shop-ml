import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:markethelper/pages/cart_list_page.dart';
import 'package:markethelper/pages/drawmap_page.dart';
import 'package:markethelper/pages/search_page.dart';
import 'package:markethelper/pages/showmap_page.dart';
import 'package:markethelper/services/authservice.dart';

import 'loginpage.dart';

//
class AuthPage extends StatelessWidget {
  AuthPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            AuthService().getCurrentUser();
            return CartPage(); //add cart page here
          }else{
            return LoginPage();
          }
        },
    );
  }
}

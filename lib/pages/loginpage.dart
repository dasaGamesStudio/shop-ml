import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markethelper/services/authservice.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {

    Size scSize = MediaQuery.of(context).size;
    double refLength = (scSize.width > scSize.height) ? scSize.height : scSize.width;
    double paddingVal = refLength * 0.05;
    double fontSize = refLength * 0.04;
    double borderRadius = refLength * 0.02;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: scSize.height * 0.2),
              Image.asset("assets/Images/Shopping_Center.png", width: refLength * 0.7, fit: BoxFit.contain,),
              SizedBox(height: paddingVal,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingVal * 3),
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(paddingVal * 0.3)),
                    backgroundColor: MaterialStateProperty.all(Colors.orange.shade600)
                  ),
                    onPressed: () => AuthService().SignInWithGoogle(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("assets/Icons/google.png", height: fontSize *2, fit: BoxFit.contain,),
                        Text(
                          "Signin With Google",
                          style: GoogleFonts.fredokaOne(color: Colors.white, fontSize: fontSize * 1.1),
                        ),
                      ],
                    )
                ),
              ),
              ElevatedButton(onPressed: ()=> AuthService().SignOut(), child: Text("Sign Out"))
            ],
          ),
        ),
      ),
    );
  }
}

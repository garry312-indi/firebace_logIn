import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneScreen extends StatelessWidget {

  final _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _body(context)
    );
  }

  Widget _body(BuildContext context)
  {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
              height: 150,
              child: Center(
                child: Image.asset("assets/images/call.png",),
              ),
            ),

            Container(
              margin: EdgeInsets.fromLTRB(16, 50, 16, 16),

              child: Card(
                margin: EdgeInsets.all(8),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),

                ),
                child: Container(
                  height: 40,

                  child: TextFormField(
                    cursorColor: Colors.black,
                      keyboardType: TextInputType.phone,
                    controller: _phoneController,
                    decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding:
                        EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                        hintText: "Phone no"),
                  ),

              ),
            )
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16, 80, 16, 0),
              child: FlatButton(
                child: Text('Send Otp', style: TextStyle(fontSize: 20.0),),
                color: Colors.blueAccent,
                textColor: Colors.white,
                onPressed: () {
                  loginUser("+91"+_phoneController.text.trim().toString(), context);
                },
              ),
            ),
          ],
        ),


      ),
    );
  }



  Future<bool> loginUser(String phone, BuildContext context) async{
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async{
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          // FirebaseUser user = result.user;
          //
          // if(user != null){
          //   Navigator.push(context, MaterialPageRoute(
          //       builder: (context) => HomeScreen(user: user,)
          //   ));
          // }else{
          //   print("Error");
          // }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (AuthException exception){
          print(exception);
        },
        codeSent: (String verificationId, [int? forceResendingToken]){
          // showDialog(
          //     context: context,
          //     barrierDismissible: false,
          //     builder: (context) {
          //       return AlertDialog(
          //         title: Text("Give the code?"),
          //         content: Column(
          //           mainAxisSize: MainAxisSize.min,
          //           children: <Widget>[
          //             TextField(
          //               controller: _codeController,
          //             ),
          //           ],
          //         ),
          //         actions: <Widget>[
          //           FlatButton(
          //             child: Text("Confirm"),
          //             textColor: Colors.white,
          //             color: Colors.blue,
          //             onPressed: () async{
          //               final code = _codeController.text.trim();
          //               AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: code);
          //
          //               AuthResult result = await _auth.signInWithCredential(credential);
          //
          //               FirebaseUser user = result.user;
          //
          //               if(user != null){
          //                 Navigator.push(context, MaterialPageRoute(
          //                     builder: (context) => HomeScreen(user: user,)
          //                 ));
          //               }else{
          //                 print("Error");
          //               }
          //             },
          //           )
          //         ],
          //       );
              }
          );
    return true;
        }



}

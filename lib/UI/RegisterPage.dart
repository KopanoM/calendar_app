import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaanifycalendar/UI/Dialogs.dart';
import 'package:spaanifycalendar/UI/LogIn.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Home.dart';
class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<AuthResult> signUp(String email, String password) async {
    try{
      final FirebaseAuth _auth = FirebaseAuth.instance;
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    }catch(e){
      print(e);
    }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Create New Account here',style: TextStyle(color: Colors.black,fontSize: 50.0,fontWeight: FontWeight.bold),),
            SizedBox(height: 10.0,),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40.0))
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: 'Email',
                  fillColor: Colors.white70
              ),

            ),
            SizedBox(height: 20.0,),

            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40.0))
                  ),
                  filled: false,
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: 'Password',
                  fillColor: Colors.white70

              ),
            ),
            SizedBox(height: 20.0,),

            TextField(
              controller: repasswordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40.0))
                  ),
                  filled: false,
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: 'Re - Enter Password',
                  fillColor: Colors.white70

              ),
            ),

               Container(
                padding: EdgeInsets.only(top: 15.0,bottom: 15.0),
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  padding: EdgeInsets.all(10.0),
                  onPressed: (){

                    if(repasswordController.text!=passwordController.text){
                      Dialogs().ShowToast('Your passwords do not match, please re-enter your password again');

                    }else if(emailController.text==''||passwordController.text==''||repasswordController.text==''){
                      Dialogs().ShowToast('Your passwords do not match, please re-enter your password again');


                    }else{

                      signUp(emailController.text, repasswordController.text).then((auth){
                        if(auth!=null){
                          // Dialogs().ShowToast('Your passwords do not match, please re-enter your password again');
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
                        }

                      });


                    }



                  },
                  color: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: Text('SIGN UP',style: TextStyle(fontSize: 20.0,color: Colors.white),),

                ),
                //



            ),

            SizedBox(height: 10.0,),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LogIn()));
              },
              child:  Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Text('Already have an Account?',style: TextStyle(color: Colors.grey),),
                  Text('Sign In',style: TextStyle(color: Colors.blueAccent),),

                ],
              ),)









          ],),




      ),





    );
  }
}

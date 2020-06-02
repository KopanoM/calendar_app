import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaanifycalendar/UI/Dialogs.dart';
import 'package:spaanifycalendar/UI/Home.dart';
import 'package:spaanifycalendar/UI/RegisterPage.dart';
class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  void CheckIfUserLoggedIn(){

    FirebaseAuth auth = FirebaseAuth.instance;
    auth.currentUser().then((user){

      if(user!=null){

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
      }
    });




  }

  Future<AuthResult> signIn(String email, String password) async {
    try{
      final FirebaseAuth _auth = FirebaseAuth.instance;
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    }catch(e){
      Dialogs().ShowToast(e.toString());
      print(e);
    }


  }
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CheckIfUserLoggedIn();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            
            Image.asset('assets/calendar.jpg'),


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


            Container(
              padding: EdgeInsets.only(top: 15.0,bottom: 15.0),
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                padding: EdgeInsets.all(10.0),
                onPressed: (){
                  if(emailController.text==''||passwordController.text==''){
                    Dialogs().ShowToast('Please do not leave any fields empty');
                  }else{
                    signIn(emailController.text, passwordController.text).then((auth){
                      if(auth!=null){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));

                      }else{
                        Dialogs().ShowToast('An Error Occurred');
                      }

                    });

                  }


                },
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)
                ),
                child: Text('SIGN IN',style: TextStyle(fontSize: 20.0,color: Colors.white),),

              ),


            ),
            SizedBox(height: 10.0,),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Register()));

              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Text('Dont have an Account?',style: TextStyle(color: Colors.grey),),
                  Text('Sign Up',style: TextStyle(color: Colors.blueAccent),),

                ],
              ),


            )




          
          
          
          
          
        ],),
        
        
        
        
      ),
      




    );
  }
}

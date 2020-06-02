import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaanifycalendar/Helper/Dome.dart';
import 'package:spaanifycalendar/UI/Calendar.dart';
import 'package:spaanifycalendar/UI/Home.dart';
import 'package:spaanifycalendar/main.dart';
import 'package:intl/intl.dart';
class MoreDetails extends StatefulWidget {

  DooMe dooMe;
  int index;
  MoreDetails(this.dooMe,this.index);
  @override
  _MoreDetailsState createState() => _MoreDetailsState(dooMe,index);
}

class _MoreDetailsState extends State<MoreDetails> {
  DooMe dooMe;
  int index;
  _MoreDetailsState(this.dooMe,this.index);
  //String a = Title;
   TextEditingController titleController ;
   TextEditingController desController ;
  DatabaseReference databaseReference;
  //var subDt = DateTime.now().subtract(Duration(days: 10, hours: 10));
  var subDt = DateTime.now();
  int todaysDate;
  int State = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController(text: dooMe.Title);
    desController = TextEditingController(text: dooMe.Description);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      body: Container(

        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Card(child: Container(
              padding: EdgeInsets.all(32.0),
              child: Column(
                children: <Widget>[
                  //Text('Title'),
                  TextFormField(
                    controller: titleController,
                    //initialValue: 'Title',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0
                    ),
                  )

                ],
              ),
            ),),


            Card(child: Container(
              padding: EdgeInsets.all(32.0),
              child: Column(
                children: <Widget>[
                  // Text('Body'),
                  TextFormField(
                    controller: desController,
                    //initialValue: 'I want to... ',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0
                    ),
                  )
                  //TextField(),

                ],
              ),
            ),),
            SizedBox(height: 10,),
            Card(

              child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[


                      GestureDetector(

                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: State==1?Colors.lightGreen:Colors.grey,
                          ),
                          child: Text('Mark as Complete'),

                        ),
                        onTap: (){
                          State=1;
                          setState(() {

                          });

                        },

                      ),

                      SizedBox(width: 10.0,),
                      GestureDetector(

                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: State==2?Colors.lightGreen:Colors.grey,
                          ),
                          child: Text('Delete'),

                        ),
                        onTap: (){
                          State = 2;
                          setState(() {

                          });


                        },

                      ),
                      /*
                      SizedBox(width: 10.0,),
                      GestureDetector(

                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: State==3?Colors.lightGreen:Colors.grey,
                          ),
                          child: Text('Another Date'),

                        ),
                        onTap: (){
                          State=3;
                          setState(() {

                          });

                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CalendarView()));



                        },

                      ),
                      */
                    ],


                  )),

            ),

            SizedBox(height: 40.0,),




            RaisedButton(
              onPressed: (){

                if(State == 1){

                  MyApp.myTasks[index].Active = false;
                  MyApp.myTasks[index].Complete = true;
                  FirebaseAuth.instance.currentUser().then((user){

                    databaseReference = FirebaseDatabase.instance.reference()
                        .child(user.uid)
                        .child(user.uid).child(MyApp.myTasks[index].UID);
                    databaseReference.set(MyApp.myTasks[index].toMap());

                  });




                }else if(State == 2){

                  MyApp.myTasks[index].Active = true;
                  MyApp.myTasks[index].Complete = true;

                  FirebaseAuth.instance.currentUser().then((user){

                    FirebaseDatabase.instance.reference()
                        .child(user.uid)
                        .child(user.uid).child(MyApp.myTasks[index].UID).set(MyApp.myTasks[index]);

                  });



                }else{
                  MyApp.myTasks[index].Active = false;

                  FirebaseAuth.instance.currentUser().then((user){

                    FirebaseDatabase.instance.reference()
                        .child(user.uid)
                        .child(user.uid).child(MyApp.myTasks[index].UID).set(MyApp.myTasks[index]);

                  });


                }








                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));

                //Navigator.pop(context);



              },
              color: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),


              ),
              child: Text('Confirm',style: TextStyle(fontSize: 20.0),),
            )



          ],


        ),)


      ,);

  }
}

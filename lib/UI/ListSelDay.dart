import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spaanifycalendar/Helper/Dome.dart';
import 'package:spaanifycalendar/UI/Calendar.dart';
import 'package:spaanifycalendar/UI/Home.dart';
import 'package:spaanifycalendar/main.dart';
import 'package:intl/intl.dart';
class ListSelDay extends StatefulWidget {
  DateTime dateTime;
  ListSelDay(this.dateTime);
  @override
  _ListSelDayState createState() => _ListSelDayState(dateTime);
}

class _ListSelDayState extends State<ListSelDay> {

  DateTime dateTime;
  _ListSelDayState(this.dateTime);
  final titleController = new TextEditingController(text: 'Title s');
  final desController = new TextEditingController(text: 'I want to do...');
  //var subDt = DateTime.now().subtract(Duration(days: 10, hours: 10));
  var subDt = DateTime.now();
  int todaysDate;
  int State = 0;
  FirebaseAuth firebaseAuth;
  DatabaseReference databaseReference;

  void writeData(DooMe doome){

    try{
      FirebaseAuth AUTH = FirebaseAuth.instance;
      AUTH.currentUser().then((user){


        databaseReference = FirebaseDatabase.instance.reference()
            .child(user.uid)
            .child(user.uid)
            .child(doome.UID);
        databaseReference.set(doome.toMap());


      });

    }catch(exception){
      print(exception.toString());
    }
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

            /*
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
                          child: Text('Today'),

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
                          child: Text('Tomorrow'),

                        ),
                        onTap: (){
                          State = 2;
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
                    ],


                  )),

            ),
            */

            SizedBox(height: 40.0,),




            RaisedButton(
              onPressed: (){

                  String title = titleController.text;
                  String description = desController.text;
                  bool active = true;
                  bool complete = false;
                  String task = '';
                  String option = 'option';
                  int calendar = 2020;
                  String pic = 'Icones';
                  String day;
                  var subDt = DateTime.now();
                  //var subDt = DateTime.now().subtract(Duration(days: 10, hours: 10));
                  DateFormat dateFormat = DateFormat("yyyyMMdd");

                    day = 'T';
                    subDt = dateTime;
                    String format = dateFormat.format(subDt);




                  //DateTime now = DateTime.now();

                  calendar = int.parse(format);
                  //String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);

                  String UID = subDt.toIso8601String().replaceAll(':', '').replaceAll('-', '').replaceAll('.', '');


                  DooMe doMe = DooMe(
                      title,
                      description,
                      active,
                      complete,
                      task,
                      option,
                      calendar,
                      pic,
                      day,
                      subDt.year,
                      subDt.month,
                      subDt.day,
                      UID
                  );
                  MyApp.myTasks.add(doMe);

                  writeData(doMe);

                  setState(() {

                  });
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

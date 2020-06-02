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

class ToDo extends StatefulWidget {
  @override
  _ToDoState createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  final titleController = new TextEditingController(text: 'Title');
  final desController = new TextEditingController(text: 'I want to do...');
  //var subDt = DateTime.now().subtract(Duration(days: 10, hours: 10));
  var subDt = DateTime.now();
  int todaysDate;
  int State = 0;
  DatabaseReference databaseReference;
  //final databaseReference = Firestore.instance;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getData();


  }

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

            SizedBox(height: 40.0,),




            RaisedButton(
              onPressed: (){
                if(State !=0) {
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
                  if (State == 0) {
                    day = 'T';
                    subDt = DateTime.now();
                    todaysDate = int.parse(
                        subDt.year.toString() + subDt.month.toString() +
                            subDt.day.toString());
                  } else if (State == 1) {
                    day = 'T'; // Today
                    subDt = DateTime.now();
                    String format = dateFormat.format(subDt);
                    todaysDate = int.parse(format);
                  } else if (State == 2) {
                    day = 'TM'; // Tomorrow
                    DateFormat dateFormat = DateFormat("yyyyMMdd");

                    subDt = DateTime.now().add(Duration(days: 1));
                    String format = dateFormat.format(subDt);
                    todaysDate = int.parse(format);
                  } else if (State == 3) {
                    day = 'AD'; // ANOTHER DAY
                    subDt = DateTime.now().add(Duration(days: 2));
                    String format = dateFormat.format(subDt);
                    todaysDate = int.parse(format);
                  }
                  //DateTime now = DateTime.now();

                  calendar = todaysDate;
                  String UID = subDt.toIso8601String().replaceAll(':', '').replaceAll('-', '').replaceAll('.', '');
                  //String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);

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



                  writeData(doMe);
                  MyApp.myTasks.add(doMe);

                  setState(() {

                  });
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
                }else{

                  Fluttertoast.showToast(
                      msg: "Please select a date",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                }








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

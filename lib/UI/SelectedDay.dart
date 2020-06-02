import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spaanifycalendar/Helper/Dome.dart';
import 'package:spaanifycalendar/UI/Calendar.dart';
import 'package:spaanifycalendar/UI/EnterToDo.dart';
import 'package:spaanifycalendar/UI/ListSelDay.dart';
import 'package:spaanifycalendar/UI/MoreDetailsPage.dart';
import 'package:spaanifycalendar/main.dart';
import 'package:intl/intl.dart';

class SelectedDay extends StatefulWidget {
  DateTime dateTime;
  SelectedDay(this.dateTime);
  @override
  _SelectedDayState createState() => _SelectedDayState(dateTime);
}

class _SelectedDayState extends State<SelectedDay> {

  DateTime dateTime;
  _SelectedDayState(this.dateTime);

  bool state1, state2, state3;
  //var subDt = DateTime.now().subtract(Duration(days: 10, hours: 10));
  var subDt = DateTime.now();
  var tomorrow = DateTime.now().add(Duration(days: 1));
  var nextDay = DateTime.now().add(Duration(days: 2));
  //var tomorrow = DateTime.now().add(Duration(days: 1));
  String format,formatcom;

  int todaysDate,tomorrowsDate,nextDate;
  DatabaseReference databaseReference;





  Widget _Day(String text, bool state) {
    return GestureDetector(
      onTap: () {
        /*
        Fluttertoast.showToast(
            msg: "This is Center Short $text",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

         */
        setState(() {
          state1 = !state1;
        });
      },
      child: state
          ? Container(
        padding: EdgeInsets.all(10.0),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20.0),
        ),
      )
          : Container(
        padding: EdgeInsets.all(10.0),
        child: Text(
          text,
          style: TextStyle(color: Colors.grey, fontSize: 20.0),
        ),
        decoration: BoxDecoration(
          //color: Colors.black,
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //String selDate = dateTime.
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateFormat dateFormatcom = DateFormat("yyyyMMdd");

    format = dateFormat.format(dateTime);
    formatcom = dateFormatcom.format(dateTime);
    /*
    DateFormat dateFormat = DateFormat("yyyyMMdd");
    String format = dateFormat.format(subDt);
    String format1 = dateFormat.format(tomorrow);
    String format2 = dateFormat.format(nextDay);
    todaysDate = int.parse(format);
    tomorrowsDate = int.parse(format1);
    nextDate = int.parse(format2);

     */
    //todaysDate = int.parse(subDt.year.toString()+subDt.month.toString()+subDt.day.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[

          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: (){},
              child: Icon(
                Icons.search,
                size: 26.0,
              ),

            ),

          )

        ],
        leading: GestureDetector(
          child: Icon(Icons.calendar_today),
          onTap: (){
            //Calendar();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CalendarView()));
            /*
              Fluttertoast.showToast(
                  msg: "This is Center Short",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );

               */
          },
        ),
        title: Center(
          child: Column(
            children: <Widget>[
              Text('Calendar App'),
              Text(format,style:TextStyle(color: Colors.grey,fontSize: 16.0) ,),

            ],) ,),
        backgroundColor: Colors.white,
        elevation: 0,

      ),
      body:
/*
          Container(
            child: ListView(

              children: <Widget>[
                SizedBox(height: 10,),
                Center(child: Text('To Do(1)',style: TextStyle(fontWeight: FontWeight.bold),)),
                SizedBox(height: 10,),
                ListTile(leading: Icon(Icons.tv),title: Text('Finish App Homework',),subtitle: Text('2 of 3 tasks completed'),trailing: Icon(Icons.more_vert),),
                ListTile(leading: Icon(Icons.shopping_basket),title: Text('Buy Groceries',),subtitle: Text('1 of 3 tasks completed'),trailing: Icon(Icons.more_vert),),
                ListTile(leading: Icon(Icons.delete),title: Text('Take Out Trash',),subtitle: Text('1 of 4 tasks completed'),trailing: Icon(Icons.more_vert),)


              ],

            ),
          ),

          */

        ListView.builder(
            itemCount: MyApp.myTasks.length,
            itemBuilder: (context,index){
              if(MyApp.myTasks[index].CalendarDate ==int.parse(formatcom)){
                return GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MoreDetails(MyApp.myTasks[index],index)));
                  },
                  child: ListTile(leading: Icon(Icons.camera),title: Text(MyApp.myTasks[index].Description,style: TextStyle(decoration: MyApp.myTasks[index].Active?TextDecoration.none:TextDecoration.lineThrough),),subtitle: Text('1 of 1 tasks completed'),trailing: Icon(Icons.more_vert),),
                );
              }else{
                return Container();
              }


            })



        /*
          Container(
            child: ListView(

              children: <Widget>[
                SizedBox(height: 10,),
                Center(child: Text('To Do(2)',style: TextStyle(fontWeight: FontWeight.bold),)),
                SizedBox(height: 10,),
                ListTile(leading: Icon(Icons.camera),title: Text('Go Exercise',),subtitle: Text('1 of 1 tasks completed'),trailing: Icon(Icons.more_vert),),
                ListTile(leading: Icon(Icons.tv),title: Text('Finish App Homework',),subtitle: Text('2 of 3 tasks completed'),trailing: Icon(Icons.more_vert),),
                ListTile(leading: Icon(Icons.shopping_basket),title: Text('Buy Groceries',),subtitle: Text('1 of 3 tasks completed'),trailing: Icon(Icons.more_vert),),
                ListTile(leading: Icon(Icons.delete),title: Text('Take Out Trash',),subtitle: Text('1 of 4 tasks completed'),trailing: Icon(Icons.more_vert),)


              ],

            ),
          ),
          */


        /*
          Container(
            child: ListView(

              children: <Widget>[
                SizedBox(height: 10,),
                Center(child: Text('To Do(3)',style: TextStyle(fontWeight: FontWeight.bold),)),
                SizedBox(height: 10,),
                ListTile(leading: Icon(Icons.tv),title: Text('Finish App Homework',),subtitle: Text('2 of 3 tasks completed'),trailing: Icon(Icons.more_vert),),
                //ListTile(leading: Icon(Icons.shopping_basket),title: Text('Buy Groceries',),subtitle: Text('1 of 3 tasks completed'),trailing: Icon(Icons.more_vert),),
                //ListTile(leading: Icon(Icons.delete),title: Text('Take Out Trash',),subtitle: Text('1 of 4 tasks completed'),trailing: Icon(Icons.more_vert),)


              ],

            ),
          ),
          */




     ,






      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add),
        onPressed: (){
          //subDt.year;

          //todaysDate = (subDt.year.toString()+subDt.month.toString()+subDt.day.toString()+subDt.hour.toString()+subDt.minute.toString()+subDt.second.toString());
          //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ToDo() ));

          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              opaque: false, // set to false
              pageBuilder: (_, __, ___) => ListSelDay(dateTime),
            ),
          );
          /*
            Fluttertoast.showToast(
                msg: "This is Center Short ",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );

           */

        },
      ),



    );

  }
}

class DaySwitch extends StatelessWidget {
  String text;
  bool state;

  DaySwitch({this.text, this.state});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        state = !state;
      },
      child: state
          ? Container(
        padding: EdgeInsets.all(10.0),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20.0),
        ),
      )
          : Container(
        padding: EdgeInsets.all(10.0),
        child: Text(
          text,
          style: TextStyle(color: Colors.grey, fontSize: 20.0),
        ),
        decoration: BoxDecoration(
          //color: Colors.black,
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}

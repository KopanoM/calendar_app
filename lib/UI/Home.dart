import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spaanifycalendar/Helper/Dome.dart';
import 'package:spaanifycalendar/UI/Calendar.dart';
import 'package:spaanifycalendar/UI/EnterToDo.dart';
import 'package:spaanifycalendar/UI/MoreDetailsPage.dart';
import 'package:spaanifycalendar/main.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  String userUID='';
  bool state1, state2, state3;
  DatabaseReference databaseReference;
  //var subDt = DateTime.now().subtract(Duration(days: 10, hours: 10));
  var subDt = DateTime.now();
  var tomorrow = DateTime.now().add(Duration(days: 1));
  var nextDay = DateTime.now().add(Duration(days: 2));
  //var tomorrow = DateTime.now().add(Duration(days: 1));

  int todaysDate,tomorrowsDate,nextDate;
  FirebaseAuth auth;

   Future GetData(){
     /*

     FirebaseAuth _auth = FirebaseAuth.instance;
     _auth.currentUser().then((user){


       databaseReference = FirebaseDatabase.instance.reference()
           .child(user.uid)
           .child(user.uid);

       databaseReference.onChildAdded((snapshot){

       })

       MyApp.myTasks.add(value)


     });

      */





   }


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

    DateFormat dateFormat = DateFormat("yyyyMMdd");
    String format = dateFormat.format(subDt);
    String format1 = dateFormat.format(tomorrow);
    String format2 = dateFormat.format(nextDay);
    todaysDate = int.parse(format);
    tomorrowsDate = int.parse(format1);
    nextDate = int.parse(format2);
    auth = FirebaseAuth.instance;
    auth.currentUser().then((user){

      setState(() {
        userUID = user.uid;
      });
    });
    //todaysDate = int.parse(subDt.year.toString()+subDt.month.toString()+subDt.day.toString());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CalendarView()));
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
                    Text('8 tasks, 3 completed',style:TextStyle(color: Colors.grey,fontSize: 16.0) ,),

          ],) ,),
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(

            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.blue

            ),
            tabs: <Widget>[
              Tab(
                child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                 // border: Border.all(color: Colors.redAccent,width: 1)
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Today',),
                ),

              ),),
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                   // border: Border.all(color: Colors.redAccent,width: 1),
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('Tomorrow'),
                  ),
                ),

              ),
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                //    border: Border.all(color: Colors.redAccent,width: 1)
                  ),
                  child: Align(
                  child: Text('Next Day'),),
                ),
              )

            ],


          ),
        ),
        body:



        userUID!=''?StreamBuilder(
          stream: FirebaseDatabase.instance.reference()
              .child(userUID)
              .child(userUID).onValue,
          builder: (BuildContext context,snapshoot){

            if(snapshoot.hasData){
              var value = snapshoot.data.snapshot.value;
             // List<dynamic> myList = value;

              Map<dynamic,dynamic> map= value;
              List<dynamic> myList = map.values.toList();
              /*
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

               */

              for(int i =0; i<myList.length;i++) {
                String description = myList[i]['Description'];
                String title = myList[i]['Title'];
                String pic = myList[i]['Pic'];
                String option = myList[i]['Option'];
                String tasks = myList[i]['Tasks'];
                bool complete = myList[i]['Complete'];
                bool active = myList[i]['Active'];
                int calendarDate = myList[i]['CalendarDate'];
                String day = myList[i]['Day'];
                int sMonth = myList[i]['SMonth'];
                int dDaY = myList[i]['SDaY'];
                int sYear = myList[i]['SYear'];
                String uID = myList[i]['UID'];

                DooMe doome = DooMe(
                    title,
                    description,
                    active,
                    complete,
                    tasks,
                    option,
                    calendarDate,
                    pic,
                    day,
                    sYear,
                    sMonth,
                    dDaY,
                    uID);
                bool state = false;

                for (int q = 0; q < MyApp.myTasks.length; q++) {
                  if (doome.UID == MyApp.myTasks[q].UID) {
                    state = true;
                  }
                }
                if (!state) {
                  MyApp.myTasks.add(doome);
                }
              }







              return TabBarView(children: <Widget>[
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
              if(MyApp.myTasks[index].CalendarDate ==todaysDate){
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MoreDetails(MyApp.myTasks[index],index)));
                  },
                  child: ListTile(leading: Icon(Icons.camera),title: Text(MyApp.myTasks[index].Description,style: TextStyle(decoration: MyApp.myTasks[index].Active?TextDecoration.none:TextDecoration.lineThrough),),subtitle: Text('1 of 1 tasks completed'),trailing: Icon(Icons.more_vert),),
                );
              }else{
                return Container();
              }


            })
          ,
          ListView.builder(
              itemCount: MyApp.myTasks.length,
              itemBuilder: (context,index){
                //String last = todaysDate.toString().substring(todaysDate.toString().length-1,todaysDate.toString().length);
                //int checker = 0;


                if(MyApp.myTasks[index].CalendarDate ==tomorrowsDate){
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MoreDetails(MyApp.myTasks[index],index)));
                    },
                    child: ListTile(leading: Icon(Icons.camera),title: Text(MyApp.myTasks[index].Description,style: TextStyle(decoration: MyApp.myTasks[index].Active?TextDecoration.none:TextDecoration.lineThrough)),subtitle: Text('1 of 1 tasks completed'),trailing: Icon(Icons.more_vert),),
                  );
                }else{
                  return Container();
                }


          }),


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

          ListView.builder(
              itemCount: MyApp.myTasks.length,
              itemBuilder: (context,index){
                if(MyApp.myTasks[index].CalendarDate ==nextDate){
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MoreDetails(MyApp.myTasks[index],index)));
                    },
                    child: ListTile(leading: Icon(Icons.camera),title: Text(MyApp.myTasks[index].Description,style: TextStyle(decoration: MyApp.myTasks[index].Active?TextDecoration.none:TextDecoration.lineThrough)),subtitle: Text('1 of 1 tasks completed'),trailing: Icon(Icons.more_vert),),
                  );
                }else{
                  return Container();
                }


              }),

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




        ],);







            }


            return Container();
          },


        ):Center(child: CircularProgressIndicator(),)
,






        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.add),
          onPressed: (){
            //subDt.year;

            //todaysDate = (subDt.year.toString()+subDt.month.toString()+subDt.day.toString()+subDt.hour.toString()+subDt.minute.toString()+subDt.second.toString());
            //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ToDo() ));

            Navigator.of(context).push(
              PageRouteBuilder(
                opaque: false, // set to false
                pageBuilder: (_, __, ___) => ToDo(),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spaanifycalendar/UI/SelectedDay.dart';

class CalendarView extends StatefulWidget {
  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime dateTime;
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
                  Calendar(
                    onDateSelected: (date){

                      dateTime = date;


                    },
                    isExpandable: true,)

                ],
              ),
            ),),



            RaisedButton(
              onPressed: (){

                if(dateTime!=null){

                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SelectedDay(dateTime)));

                }else{
                  Fluttertoast.showToast(
                      msg: "Please Select a date",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                }


                },
              color: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),


              ),
              child: Text('Confirm'),
            )



          ],


        ),)


      ,);

  }
}

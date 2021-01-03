import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:umurinzi/profile.dart';

class TodayActivity extends StatefulWidget{
  @override
  _TodayActivityState createState() => _TodayActivityState();
}

class _TodayActivityState extends State<TodayActivity> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.menu), onPressed: (){
          Navigator.push(context, CupertinoPageRoute(fullscreenDialog: true,builder: (context)=>Profile()));
        },color: Colors.black,),
        backgroundColor: Colors.pink.shade50,
        elevation: 1.0,
        title: Text("Ovulation",style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue.shade100,
                      Colors.blue.shade200,
                      Colors.blue.shade300,
                    ],
                  )
                      ,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Production Day Of",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),),
                      SizedBox(height: 7),
                      Text("Ovulation",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 38),),
                      SizedBox(height: 7),

                      Text("High chance of getting pregnant",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16),),
                      SizedBox(height: 14),
                      RaisedButton(onPressed: (){},child: Text("Log Period"),shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),elevation: 1.0,color: Colors.white,textColor: Colors.blue,)
                    ],

                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("My Daily Insights",style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20
                    ),),
                  ),
                  Expanded(
                    child: ListView.builder(scrollDirection: Axis.horizontal,itemBuilder: (context,index){
                      return Container(
                        width: 140,
                        child: Card(
child: index == 0 ? Padding(
  padding: const EdgeInsets.all(18.0),
  child:   Column(
    children: [
      Expanded(child: Text("Log your symptoms",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),textAlign: TextAlign.center,)),
      IconButton(icon: Icon(Icons.add), onPressed: (){},color: Colors.blue,)
    ],
  ),
) : null,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:umurinzi/discover.dart';
import 'package:umurinzi/electronic_commerce.dart';
import 'package:umurinzi/social_information.dart';
import 'package:umurinzi/super_base.dart';
import 'package:umurinzi/today_activity.dart';

import 'json/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Umurinzi',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Umurinzi'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with Superbase {
  int _currentIndex = 0;

  bool _loading = true;

  User _user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      this.signedIn((token, user) {
        setState(() {
          _user = user;
          _loading = false;
        });
      }, () {
        initiateSession();
      });
    });
  }

  void initiateSession() {
    String username = "App";
    this.ajax(
        url: "session/?username=$username&key=PzUFEwALd3JRnPzPQvhF2rZq0qXh2UAKTrBaDVWtVxNixaQr2OLNEaalFfbaIlTwCfKcqrfG0lYAMoh6USAcc84lBC3tnAIDWz6fzNQqGd1vLp3rW3rx0MsbO7hkPcbQRm4Pmq2EcP3qZOBGp2j6sOCRZU2DnncnM7ElHNdmOJUhYJdBepwpD4DinDz6f8h6pc1In025zpzAiU3VXFKtgIBjgXwL4du4nY1Y8rn21xdWvju1h1WPOTkXfaeTLppM",
      method: "POST",
      server: true,
      onValue: (source,url){
          print(source);
          var user = User.fromJson(source,username: username);
          auth(user.token, jsonEncode(user), user.token);
          setState(() {
            _user = user;
          });

      },
      onEnd: (){
          setState(() {
            _loading = false;
          });
      }
    );
  }


  User getUser() =>_user;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return _loading
        ? Scaffold(
      body: Center(child: CircularProgressIndicator()),
    )
        : Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.pink.shade50,
                Colors.pink.shade50,
                Colors.pink.shade100,
              ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: IndexedStack(
          index: _currentIndex,
          children: [
            ElectronicCommerce(getUser: getUser,),
            TodayActivity(),
            Discover(),
            SocialInformation()
          ],
        ),
        bottomNavigationBar: Card(
          color: Colors.pink.shade50,
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            elevation: 0.0,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  label: "E-commerce", icon: Icon(Icons.shopping_cart)),
              BottomNavigationBarItem(
                  label: "Today", icon: Icon(Icons.calendar_today)),
              BottomNavigationBarItem(
                  label: "Insights", icon: Icon(Icons.insights)),
              BottomNavigationBarItem(
                  label: "Secret chats",
                  icon: Icon(Icons.mark_chat_unread_sharp)),
            ],
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SocialInformation extends StatefulWidget{
  @override
  _SocialInformationState createState() => _SocialInformationState();
}

class _SocialInformationState extends State<SocialInformation> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.pink.shade50,
        elevation: 1.0,
        centerTitle: true,
        title: Text("Following adivice",style: TextStyle(color: Colors.black),),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: (){},color: Colors.black,)
        ],
      ),
      body: ListView.builder(itemBuilder: (context,index){
        return Container(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/avatar.png"),
                    ),
                  ),
                  Text("Relationship Advice"),
                  FlatButton(onPressed: (){}, child: Text("Follow"),textColor: Colors.blue,),
                  Spacer(),
                  IconButton(icon: Icon(Icons.more_vert), onPressed: (){})
                ],
              ),
              Image.asset(index % 2 == 0 ? "assets/image3.jpg" : "assets/image4.png"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton(child: Row(
                    children: [
                      Icon(Icons.favorite),
                      SizedBox(width: 7),
                      Text("20.6K")
                    ],
                  ), onPressed: (){}),
                  FlatButton(child: Row(
                    children: [
                      Icon(Icons.comment),
                      SizedBox(width: 7),
                      Text("20.6K")
                    ],
                  ), onPressed: (){}),
                  FlatButton(child: Row(
                    children: [
                      Icon(Icons.share),
                      SizedBox(width: 7),
                      Text("20.6K")
                    ],
                  ), onPressed: (){}),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
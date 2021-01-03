import 'package:flutter/material.dart';

class Discover extends StatefulWidget {
  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade50,
        elevation: 1.0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 43,
            child: TextFormField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.pink.shade100,
                  filled: true,
                  hintText: "Articles, Audio, Video and More"),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0).copyWith(bottom: 0),
            child: Text(
              "Popular on Umurinzi",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
            ),
          ),
          Container(
            height: 300,
            child: ListView.builder(
                padding: EdgeInsets.all(15),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 340,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        backgroundBlendMode: BlendMode.overlay,
                        color: Colors.pink,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 2.0,
                            spreadRadius: 1.0,
                            offset: Offset(0.8,1)
                          )
                        ],
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/image.jpg"))),
                    padding: EdgeInsets.all(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 16),
                                  decoration: BoxDecoration(
                                      color: Colors.black45,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "Video Course",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )),
                              Text(
                                "Mastering Your \nOrgasm",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w900),
                              ),
                              Text(
                                "Jordan Rullo, PhD Sex \n Therapist",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 50),
                        Container(
                          height: 30,
                          width: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                                color: Colors.black45,
                            ),
                            child: Icon(
                              Icons.lock,
                              size: 20,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0).copyWith(bottom: 0),
            child: Text(
              "Cycle Phase And Periods",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
            ),
          ),
          Container(
            height: 300,
            child: ListView.builder(
                padding: EdgeInsets.all(15),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        backgroundBlendMode: BlendMode.overlay,
                        color: Colors.pink,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 2.0,
                            spreadRadius: 1.0,
                            offset: Offset(0.8,1)
                          )
                        ],
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/image${index%2==0?2:""}.jpg"))),
                    padding: EdgeInsets.all(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mastering Your \nOrgasm",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w900),
                              ),
                              Text(
                                "Jordan Rullo, PhD Sex \n Therapist",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                                color: Colors.black45,
                            ),
                            child: Icon(
                              Icons.lock,
                              size: 20,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
      backgroundColor: Colors.transparent,
    );
  }
}

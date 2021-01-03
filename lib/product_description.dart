import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umurinzi/cart_screen.dart';
import 'package:umurinzi/json/product.dart';
import 'package:umurinzi/super_base.dart';

import 'json/user.dart';

class Description extends StatefulWidget {
  final Product product;
  final User Function() getUser;

  const Description({Key key, @required this.product,@required this.getUser}) : super(key: key);

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> with Superbase {

  bool _adding = false;

  void addToCart() {

    if( widget.getUser() == null){
      toast("User not authenticated");
      return;
    }

    setState(() {
      _adding = true;
    });

    this.ajax(
        url: "cart/add",
        method: "POST",
        server: true,
        data: FormData.fromMap({
          "api_token": widget.getUser()?.token,
          "product_id": widget.product?.id
        }),onValue: (object,v){
          if( object is Map){
            toast(object['message']);
          }
    },onEnd: (){
          setState(() {
            _adding = false;
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text("QuickView"),
          centerTitle: true,
          actions: [
            Container(
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.pink),
              width: 40,
              margin: EdgeInsets.only(right: 7),
              height: 40,
              child: new IconButton(
                  icon: new Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>CartScreen(getUser: widget.getUser)));
                  }),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Image.asset("assets/Background.png"),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          width: 40,
                          margin: EdgeInsets.only(right: 7),
                          height: 40,
                          child: new IconButton(
                              icon: Text("S",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w900)),
                              onPressed: () {}),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          width: 40,
                          margin: EdgeInsets.only(right: 7, top: 7),
                          height: 40,
                          child: new IconButton(
                              icon: Text("M",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Colors.pink)),
                              onPressed: () {}),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          width: 40,
                          margin: EdgeInsets.only(right: 7, top: 7),
                          height: 40,
                          child: new IconButton(
                              icon: Text("L",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w900)),
                              onPressed: () {}),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "${widget.product?.name}",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "2020 Hot Handbags New Fashion Edition",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "Description",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${widget.product?.description}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "\$299.99",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                          color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Text(
                        "\$345.99",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.black,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.all(20),
                  height: 55,
                  child: RaisedButton(
                    color: Colors.pink,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 0.5,
                    onPressed: _adding ? null : addToCart,
                    textColor: Colors.white,
                    child: _adding ? CupertinoActivityIndicator() : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Add To Cart",
                          style: TextStyle(fontSize: 20),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(Icons.add_shopping_cart),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

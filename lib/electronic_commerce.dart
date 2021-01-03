import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umurinzi/product_description.dart';

import 'json/product.dart';
import 'json/user.dart';
import 'super_base.dart';

class ElectronicCommerce extends StatefulWidget {
  final User Function() getUser;

  const ElectronicCommerce({Key key,@required this.getUser}) : super(key: key);
  @override
  _ElectronicCommerceState createState() => _ElectronicCommerceState();
}

class _ElectronicCommerceState extends State<ElectronicCommerce>
    with Superbase {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadProducts();
    });
  }

  List<Product> _list = [];

  void loadProducts() {
    ajax(
        url: "product",
        onValue: (value, url) {
          if (value is Map && value['status'] == 200) {
            setState(() {
              _list = (value['data']['products'] as Iterable)
                  .map((e) => Product.fromJson(e))
                  .toList();
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.pink.shade200,
                    Colors.pink.shade100,
                  ]),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10)
                      .copyWith(top: MediaQuery.of(context).padding.top + 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/logo.png",
                        height: 35,
                      ),
                      Spacer(),
                      Container(
                          width: 40,
                          child: RaisedButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            color: Colors.white,
                            child: Icon(Icons.shopping_cart_sharp),
                          ))
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 15)
                      .copyWith(top: 50, bottom: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: "I am looking for ...",
                              filled: true,
                              prefixIcon: Icon(Icons.search),
                              suffixIcon: Icon(
                                Icons.sort,
                                color: Colors.pink.shade300,
                              ),
                              contentPadding: EdgeInsets.only(left: 10),
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icons.add_shopping_cart,
                        Icons.shopping_cart,
                        Icons.security,
                        Icons.shopping_cart,
                      ]
                          .map((e) => Container(
                              width: 85,
                              height: 85,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(1000)),
                                child: InkWell(
                                    onTap: () {},
                                    borderRadius: BorderRadius.circular(1000),
                                    child: Icon(e)),
                              )))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  "New Arrivals",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                )),
                FlatButton(
                  onPressed: () {},
                  child: Text("View all"),
                  textColor: Colors.amber,
                )
              ],
            ),
          ),
          Container(
            height: 230,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _list.length,
                itemBuilder: (context, index) {
                  var obj = _list[index];
                  return Container(
                    width: 175,
                    child: Card(
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              Colors.pink.shade300,
                              Colors.pink.shade200,
                              Colors.pink.shade100,
                              Colors.pink.shade50,
                              Colors.white,
                              Colors.white
                            ])),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        Description(product: obj,getUser: widget.getUser,)));
                          },
                          child: Column(
                            children: [
//                              Expanded(
//                                  child: Image(
//                                image: CachedNetworkImageProvider(obj.image),
//                                frameBuilder: (context,child,frame,progress){
//                                  return frame == null ? CupertinoActivityIndicator() : child;
//                                },
//                                fit: BoxFit.cover,
//                              )),
                              Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset("assets/Background.png"),
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${obj.name}",
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("${obj.price} RWF",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

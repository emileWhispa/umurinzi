import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:umurinzi/super_base.dart';

import 'json/cart.dart';
import 'json/user.dart';

class CartScreen extends StatefulWidget {
  final User Function() getUser;

  const CartScreen({Key key, @required this.getUser}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with Superbase {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _refreshKey.currentState?.show();
    });
  }

  List<Cart> _list = [];

  var _refreshKey = new GlobalKey<RefreshIndicatorState>();

  Future<void> loadCart() {
    return ajax(
        url: "cart/products",
        method: "POST",
        data: FormData.fromMap({"api_token": widget.getUser()?.token}),
        onValue: (source, url) {
          if (source is Map && source['status'] == 200) {
            setState(() {
              _list = (source['data']['products'] as Iterable)
                  .map((e) => Cart.fromJson(e))
                  .toList();
            });
          } else
            toast("$source");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text("Shopping Cart"),
          centerTitle: true,
        ),
        body: RefreshIndicator(
            key: _refreshKey,
            child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                      height: 0,
                    ),
                itemCount: _list.length,
                itemBuilder: (context, index) {
                  var pro = _list[index];
                  return Container(
                    child: ListTileTheme(
                      style: ListTileStyle.drawer,
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.pink.shade200,
                                    Colors.pink.shade50,
                                    Colors.white
                                  ])),
                          child: Image.asset("assets/Background.png",height: 40,),
                        ),
                        onTap: () {},
                        title: Text(pro.productName),
                        subtitle: Text(pro.total),
                        trailing: Text("${pro.quantity} qty",style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                    ),
                  );
                }),
            onRefresh: loadCart),
      ),
    );
  }
}

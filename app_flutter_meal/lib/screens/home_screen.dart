import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Categories"),
          ),
          Expanded(
            child: listFilter(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Area"),
          ),
          Expanded(
            child: listFilter(),
          ),
        ],
      ),
    );
  }

  ListView listFilter() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        GestureDetector(
            onTap: () {
              print("Container clicked cyan");
            },
            child: new Container(
              width: 500.0,
              padding: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
              color: Colors.cyan,
              child: new Column(children: [
                new Text("Ableitungen cyan"),
              ]),
            )),
        GestureDetector(
            onTap: () {
              print("Container clicked red");
            },
            child: new Container(
              width: 500.0,
              padding: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
              color: Colors.red,
              child: new Column(children: [
                new Text("Ableitungen red"),
              ]),
            )),
        GestureDetector(
            onTap: () {
              print("Container clicked black");
            },
            child: new Container(
              width: 500.0,
              padding: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
              color: Colors.black,
              child: new Column(children: [
                new Text("Ableitungen black"),
              ]),
            )),
        GestureDetector(
            onTap: () {
              print("Container clicked green");
            },
            child: new Container(
              width: 500.0,
              padding: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
              color: Colors.green,
              child: new Column(children: [
                new Text("Ableitungen green"),
              ]),
            )),
        GestureDetector(
            onTap: () {
              print("Container clicked yellow");
            },
            child: new Container(
              width: 500.0,
              padding: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
              color: Colors.yellow,
              child: new Column(children: [
                new Text("Ableitungen yellow"),
              ]),
            )),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        onPressed: () {},
        icon: SvgPicture.asset("assets/icons/menu.svg"),
      ),
    );
  }
}

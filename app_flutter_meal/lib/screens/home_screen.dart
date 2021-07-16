import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatelessWidget {
  final String apiUrl =
      "https://www.themealdb.com/api/json/v1/1/list.php?c=list/";

  Future<List<dynamic>> fetchCategories() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body)['meals'];
  }

  String _name(dynamic category) {
    return category['strCategory'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: Container(
          child: FutureBuilder<List<dynamic>>(
            future: fetchCategories(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print(snapshot.hasError);
              if (snapshot.hasData) {
                return ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                /*backgroundImage: NetworkImage(snapshot
                                      .data[index]['picture']['large'])*/
                              ),
                              title: Text(_name(snapshot.data[index])),
                              subtitle: Text(""),
                              //trailing: Text(_name(snapshot.data[index])),
                            )
                          ],
                        ),
                      );
                    });
                ;
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }

/*
Column(
        children: <Widget>[
          titleSection("Categories"),
          Expanded(
            child: listFilter(),
          ),
          titleSection("Area"),
          Expanded(
            child: listFilter(),
          ),
        ],
      ),
*/
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
      title: Text("Best Recipes"),
      leading: IconButton(
        onPressed: () {},
        icon: SvgPicture.asset("assets/icons/menu.svg"),
      ),
    );
  }

  Widget titleSection(title) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

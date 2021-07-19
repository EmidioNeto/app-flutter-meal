import 'package:app_flutter_meal/models/category.dart';
import 'package:app_flutter_meal/screens/recipes_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({Key? key, required this.title, required this.filter})
      : super(key: key);

  final String title;
  final String filter;

  @override
  _CategoryScreenState createState() => _CategoryScreenState(filter);
}

class _CategoryScreenState extends State<CategoryScreen> {
  final String apiUrlTemplate =
      "https://www.themealdb.com/api/json/v1/1/list.php?filterParam=list/";

  final String filter;

  late Future<CategorySeries> categorySeries;

  _CategoryScreenState(this.filter);

  Future<String> _loadRemoteData(String filter) async {
    String apiUrl = apiUrlTemplate.replaceFirst("filterParam", filter);
    final response = await (http.get(Uri.parse(apiUrl)));
    if (response.statusCode == 200) {
      print('response statusCode is 200');
      return response.body;
    } else {
      print('Http Error: ${response.statusCode}!');
      throw Exception('Invalid data source.');
    }
  }

  Future<CategorySeries> fetchItems() async {
    String jsonString = await _loadRemoteData(this.filter);

    final jsonResponse = json.decode(jsonString);

    CategorySeries categorySeries = new CategorySeries.fromJson(jsonResponse);

    return categorySeries;
  }

  @override
  void initState() {
    super.initState();
    categorySeries = fetchItems();
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text("Best Recipes"),
    );
  }

  Widget mealCard(CategoryItem item) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            print("navigating to RecipesScreen with param:" + item.name);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RecipesScreen(
                      key: null,
                      title: "Here our best " + item.name + " recipes",
                      filter: item.name,
                      category: this.filter)),
            );
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.local_dining,
                        color: Colors.black,
                        size: 24.0,
                        semanticLabel: 'Meal ' + item.name,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.name,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<CategorySeries>(
          future: categorySeries,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.dataModel.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      mealCard(snapshot.data!.dataModel[index])
                    ],
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }
            return CircularProgressIndicator();
          }),
    );
  }
}

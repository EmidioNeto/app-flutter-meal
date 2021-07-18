import 'dart:convert';

import 'package:app_flutter_meal/models/meal.dart';
import 'package:app_flutter_meal/screens/recipe_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class RecipeScreen extends StatefulWidget {
  final String apiUrlTemplate =
      "https://www.themealdb.com/api/json/v1/1/lookup.php?i=filterParam";

  RecipeScreen({Key? key, required this.title, required this.filter})
      : super(key: key);

  final String title;
  final String filter;

  @override
  _RecipeScreenState createState() => _RecipeScreenState(this.filter);
}

class _RecipeScreenState extends State<RecipeScreen>
    with SingleTickerProviderStateMixin {
  final String apiUrlTemplate =
      "https://www.themealdb.com/api/json/v1/1/lookup.php?i=filterParam";

  final String filter;

  late final Future<Meal> meal;
  late TabController _tabController;
  late ScrollController _scrollController;

  _RecipeScreenState(this.filter);

  Future<Meal> fetchMeal() async {
    String jsonString = await _loadRemoteData(this.filter);

    final jsonResponse = json.decode(jsonString);

    Meal meal = new MealSeries.fromJson(jsonResponse).dataModel.first;

    return meal;
  }

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

  @override
  void initState() {
    super.initState();
    meal = fetchMeal();
    _tabController = TabController(vsync: this, length: 2);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Meal>(
        future: meal,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
              ),
              body: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerViewIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.white,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        background: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RecipeImage(snapshot.data!.thumb),
                          ],
                        ),
                      ),
                      expandedHeight: 400.0,
                      pinned: true,
                      floating: true,
                      elevation: 2.0,
                      forceElevated: innerViewIsScrolled,
                      bottom: TabBar(
                        tabs: <Widget>[
                          Tab(
                              child: Text(
                            "Ingredients",
                            style: TextStyle(color: Colors.black),
                          )),
                          Tab(
                              child: Text(
                            "Preparation",
                            style: TextStyle(color: Colors.black),
                          )),
                        ],
                        controller: _tabController,
                      ),
                    )
                  ];
                },
                body: TabBarView(
                  children: <Widget>[
                    IngredientsView(snapshot.data!.ingredients),
                    PreparationView(snapshot.data!.instructions),
                  ],
                  controller: _tabController,
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  print("" + snapshot.data!.youtube);
                  _launchURL(snapshot.data!.youtube);
                },
                child: Icon(
                  Icons.live_tv,
                  color: Theme.of(context).iconTheme.color,
                ),
                elevation: 2.0,
                backgroundColor: Colors.white,
              ),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          return CircularProgressIndicator();
        });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class IngredientsView extends StatelessWidget {
  final List<Ingredient> ingredients;

  IngredientsView(this.ingredients);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = List.empty(growable: true);
    ingredients.forEach((item) {
      children.add(
        new Row(
          children: <Widget>[
            new Icon(Icons.done),
            new SizedBox(width: 5.0),
            new Text(item.measure),
            new Text(" - "),
            new Text(item.name),
          ],
        ),
      );
      // Add spacing between the lines:
      children.add(
        new SizedBox(
          height: 5.0,
        ),
      );
    });
    return ListView(
      padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 75.0),
      children: children,
    );
  }
}

class PreparationView extends StatelessWidget {
  final String instructions;

  PreparationView(this.instructions);

  @override
  Widget build(BuildContext context) {
    List<Widget> textElements = List.empty(growable: true);
    textElements.add(
      Text(this.instructions),
    );
    textElements.add(
      SizedBox(
        height: 10.0,
      ),
    );
    return ListView(
      padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 75.0),
      children: textElements,
    );
  }
}

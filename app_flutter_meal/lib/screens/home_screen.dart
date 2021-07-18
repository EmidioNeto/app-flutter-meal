import 'package:app_flutter_meal/models/category_filter.dart';
import 'package:app_flutter_meal/screens/category_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text("World's Best Recipes"),
    );
  }

  Widget categoryFilterCard(CategoryFilter filter) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            print("navigating to RecipesScreen with param:" + filter.name);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CategoryScreen(
                      key: null,
                      title: filter.title,
                      filter: filter.externalName)),
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
                        filter.icon,
                        color: Colors.black,
                        size: 24.0,
                        semanticLabel: 'Filter ' + filter.name,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        filter.name,
                      ),
                      Text(
                        filter.description,
                      )
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
    List<CategoryFilter> filters = <CategoryFilter>[];
    filters.add(new CategoryFilter(
        name: 'Types of meal',
        title: 'Select your favorite type of meal',
        externalName: 'c',
        description: 'Find everyday cooking inspiration',
        icon: Icons.restaurant));
    filters.add(new CategoryFilter(
        name: "World's Recipes",
        title: "Select your favorite world's cuisine",
        externalName: 'a',
        description: "Discover world's cuisine recipes",
        icon: Icons.public));

    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        child: Column(
          children: <Widget>[
            Column(
                children: filters.map((p) {
              return categoryFilterCard(p);
            }).toList())
          ],
        ),
      ),
    );
  }
}

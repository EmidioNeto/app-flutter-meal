import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'components/random_words/list_recipes.dart';

class RecipesScreen extends StatelessWidget {
  final wordPair = WordPair.random();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Center(
        child: ListRecipes(),
      ),
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

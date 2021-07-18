import 'package:flutter/material.dart';

class RecipeImage extends StatelessWidget {
  final String imageURL;

  RecipeImage(this.imageURL);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(imageURL)),
        ),
      ),
    );
  }
}

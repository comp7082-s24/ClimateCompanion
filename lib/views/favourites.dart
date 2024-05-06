import 'package:flutter/material.dart';

import "../components/appbar.dart";

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(final BuildContext context) {
    return const Scaffold(
      appBar: MainAppBar(),
      body: Center(
        child: Text(
            "Favourites"
        ),
      ),
    );
  }
}

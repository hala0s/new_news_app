import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ny_times1/screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/model/model.dart';

class favlist extends StatefulWidget {
  favlist({Key? key}) : super(key: key);

  @override
  State<favlist> createState() => _favlistState();
}

class _favlistState extends State<favlist> {
  List<Results> _favres = [];

  @override
  void initState() {
    loadFav();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fav New'),
      ),
      body: ListView.builder(
          itemCount: _favres.length,
          itemBuilder: (context, index) {
            return Item(
              results: _favres[index],
            );
          }),
    );
  }

  loadFav() async {
    var ins = await SharedPreferences.getInstance();
    var resultString = ins.getString("fav");
    if (resultString != null) {
      _favres = (jsonDecode(resultString) as List)
          .map((e) => Results.fromJson(e))
          .toList();
      if(mounted) {
        setState(() {});
      }
    }
  }
}

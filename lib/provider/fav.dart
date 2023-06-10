import 'package:flutter/material.dart';
import 'package:ny_times1/screens/homepage.dart';
import '../data/model/model.dart';

class favlist extends StatefulWidget {
   favlist({Key? key , required this.favres}) : super(key: key);
  List<Results> favres = [];
  @override
  State<favlist> createState() => _favlistState();
}

class _favlistState extends State<favlist> {

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
   appBar: AppBar(title: const Text('Fav New'),
   ),
      body: ListView.builder(
        itemCount: widget.favres.length,
          itemBuilder: (context,index) {
            return Item(results: widget.favres[index] ,);

          }
          ) ,
      
    );
  }
}

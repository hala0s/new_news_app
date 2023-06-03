import 'package:flutter/material.dart';
import '../data/model/model.dart';

class favlist extends StatefulWidget {
  const favlist({Key? key}) : super(key: key);

  @override
  State<favlist> createState() => _favlistState();
}

class _favlistState extends State<favlist> {
  List<Results> _favres = [];
  List<Results> results = [];

  void toggleFav(Results results) {
    setState(() {
      if (_favres.contains(results)) {
        _favres.remove(results);
      }else {
        _favres.add(results);
      }
    });
  }
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
   appBar: AppBar(title: Text('Fav New'),
   ),
      body: ListView.builder(
        itemCount: results.length,
          itemBuilder: (context,index) {
            final result = results[index];
            final isFav = _favres.contains(results?[index].title ?? "");
            return ListTile(title: Text(results?[index].title ?? ""),
            trailing: IconButton(
              icon: Icon(
                  isFav? Icons.favorite : Icons.favorite_outline_outlined,
                color: isFav? Colors.red : null ,
              ),
              onPressed: ()=> toggleFav(result),
            ),
            );

          }


      ) ,
      
    );
  }
}

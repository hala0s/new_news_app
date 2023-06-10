import 'package:flutter/material.dart';
import 'package:ny_times1/screens/homepage.dart';

import '../data/model/model.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);
  List resultSearch = [];
  List<Results> searchForTitle(String title, List<Results> result) {
    return result
        .where((element) => element.title?.contains(title) ?? false)
        .toList();
  }
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Page"),
      ),

      body: Column(
        children: [
          TextField(
            obscureText: false,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: "Search",
                prefixIcon: Icon(Icons.search)),


          ),
          SizedBox(height: 20,),
          Expanded(
            child: ListView.builder(
              itemCount: widget.resultSearch.length,
                itemBuilder: (context,index) {
                  return Item(results: widget.resultSearch[index],);
                }
            ),
          )
        ],
      ),
    );
  }
}

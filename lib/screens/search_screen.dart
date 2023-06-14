import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ny_times1/bloc/news_bloc.dart';
import 'package:ny_times1/screens/homepage.dart';

import '../data/model/model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List resultSearch = [];
  final getIt = GetIt.instance;

  List<Results> searchForTitle(String title, List<Results> result) {
    return result
        .where((element) => element.title?.contains(title) ?? false)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<NewsBloc>(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Search Page"),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                obscureText: false,
                decoration: InputDecoration(
                  fillColor: Color(0xFFE5F9DB),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: "Search",
                    prefixIcon: const Icon(Icons.search)),
                onChanged: (c) {
                  print(resultSearch);
                  print(context
                      .read<NewsBloc>()
                      .state
                      .allResults
                      ?.results
                      ?.length);
                  resultSearch = searchForTitle(c,
                      context.read<NewsBloc>().state.allResults?.results ?? []);
                  print(resultSearch);

                  setState(() {});
                },
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: resultSearch.length,
                    itemBuilder: (context, index) {
                      return Item(
                        results: resultSearch[index],
                      );
                    }),
              )
            ],
          ),
        );
      }),
    );
  }
}

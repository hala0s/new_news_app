import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ny_times1/bloc/news_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/theme_bloc.dart';
import '../data/model/model.dart';
import '../main.dart';
import '../notification/notification.dart';

final dio = Dio(BaseOptions(
    sendTimeout: const Duration(seconds: 20),
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20)));

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ///Search
  ///New screen
  ///pass All result to new screen
  ///
  /// TextField
  ///  list resultSearch
  ///
  /// user [Item] to show Result in screen
  ///

  loadFav() async {
    var ins = await SharedPreferences.getInstance();
    var resultString = ins.getString("fav");
    if (resultString != null) {
      _favres = (jsonDecode(resultString) as List).map((e) => Results.fromJson(e)).toList();
      setState(() {});
    }
  }



  @override
  Widget build(BuildContext context) {
    final bloc=context.read<NewsBloc>()..add(Newsfetch());
    return  Scaffold(

      body: BlocBuilder<NewsBloc, NewsState>(
        bloc: bloc,
        builder: (context, state) {
          if (state.status == NewsStatus.success) {
            return CustomScrollView(slivers: [
              SliverAppBar(
                expandedHeight: 250.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text(" " ),
                  background: Image.network(
                    'https://img.freepik.com/free-vector/breaking-news-tv-concept-backdrop-banner_1017-14194.jpg?w=996&t=st=1686738862~exp=1686739462~hmac=bef35dc2d822cf306f6517fe5434575306233cbfffc1f257285c802a3e91d9ac',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverToBoxAdapter(child: BlocBuilder<ThemeBloc, bool>(
                builder: (context, isDark) {
                  return Container(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Top News'  ,style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {
                              context.read<ThemeBloc>().add(ThemeEvent.toggle);
                            },
                            icon: isDark ? Icon(Icons.dark_mode) : Icon(Icons.light_mode , size: 25,)),
                     IconButton(onPressed: (){
                       Noti.showBigTextNotification(title: 'hello ', body: 'you have new news ', fln: flutterLocalNotificationsPlugin);
                     }, icon: Icon(Icons.notifications))
                      ],
                    ),
                  );
                },
              )),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final isFav = _favres.contains(state.allResults!.results![index]  );
                  return Item(
                    results: state.allResults!.results![index],
                    child: IconButton(
                        onPressed: () async {
                          await toggleFav(state.allResults!.results![index]);
                        },
                        icon: Icon(
                          isFav ? Icons.favorite : Icons.favorite_outline_outlined,
                          color: Colors.redAccent ,
                        )),
                  );
                }, childCount: state.allResults?.results?.length),
              )
            ]);
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  List<Results> _favres = [];

  Future<void> toggleFav(Results results) async {
    setState(() {
      if (_favres.contains(results)) {
        _favres.remove(results);
      } else {
        _favres.add(results);
      }
    });
    final pref = await SharedPreferences.getInstance();
    List<Map> convertListToListOfMap = _favres.map((e) => e.toJson()).toList();
    var convertListToString = json.encode(convertListToListOfMap);
    await pref.setString("fav", convertListToString);
  }
}

class Item extends StatelessWidget {
  const Item({Key? key, this.child, required this.results}) : super(key: key);
  final Widget? child;
  final Results results;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border.symmetric(),
      ),
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      results.media.firstOrNull?.mediaMetadata.firstOrNull?.url ??
                          "https://library.northwestu.edu/wp-content/uploads/2019/06/nytimes.png",
                      fit: BoxFit.fill,
                      height: 150.0,
                      width: 100.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              results.title ?? "",

              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16),
            ),
          ),

          if (child != null) child!,
        ],
      ),
    );

  }
}

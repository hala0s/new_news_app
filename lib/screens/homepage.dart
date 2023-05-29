import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ny_times1/bloc/news_bloc.dart';

import '../bloc/theme_cubit.dart';

final dio = Dio(BaseOptions(
    sendTimeout: const Duration(seconds: 20),
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20)));

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
       create: (context) => NewsBloc(dio)..add(Newsfetch()),
      child : Scaffold(
    body: BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state.status == NewsStatus.success) {
          return CustomScrollView(
              slivers: [
            SliverAppBar(
              actions: [
                IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none_outlined, color: Colors.black,)),

              ],

              expandedHeight: 250.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(""),
                background: Image.network(
                  'https://img.freepik.com/free-photo/top-view-old-french-newspaper-pieces_23-2149318857.jpg?w=1060&t=st=1685283474~exp=1685284074~hmac=b3570da209a25fb18c5fc5f71474d36a6a7a25d4e98b055e89dde6d79a9bea8d0',
                  fit: BoxFit.cover,
                ),
              ),
            ),
                SliverToBoxAdapter(
                  child: BlocBuilder<ThemeCubit, bool>(
                    builder: (context, state) {
                      return SwitchListTile(
                        title: Text("Breaking News", style:Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 30,fontWeight:FontWeight.bold),),
                        value: state,
                        onChanged: (value) {
                          BlocProvider.of<ThemeCubit>(context).toggleTheme(value: value);
                        },

                      );
                    },
                  ),
                ),
            SliverList(delegate: SliverChildBuilderDelegate((context, index) {
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
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          Container(
                            width: 100.0,
                            height: 150.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            child: ClipRect(
                              child: Image.network(
                                state.allResults?.results?[index].media.firstOrNull
                                        ?.mediaMetadata.firstOrNull?.url ??
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
                    Expanded(flex: 2, child: Text(state.allResults?.results?[index].title ?? "",style:  Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 20),
                    ),),
                  ],
                ),
              );

            },
                childCount: state.allResults?.results?.length
            ),

            )
          ]
          );

        }

        return const Center(child: CircularProgressIndicator());
      },
    ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius:BorderRadius.circular(16),
            color: Colors.blueGrey.withOpacity(0.5)
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            selectedItemColor: Colors.white,

            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.rss_feed),label: "Feed"),


            ],
          ),
        ),
)
    );
  }
}

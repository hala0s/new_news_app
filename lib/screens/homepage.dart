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
            SliverToBoxAdapter(
             child: BlocBuilder<ThemeCubit, bool>(
            builder: (context, state) {
              return SwitchListTile(
                value: state,
                title: const Text('Theme'),
                onChanged: (value) {
                  BlocProvider.of<ThemeCubit>(context).toggleTheme(value: value);
                },
              );
            },
            ),
          ),
            SliverAppBar(
              expandedHeight: 250.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(""),
                background: Image.network(
                  'https://library.northwestu.edu/wp-content/uploads/2019/06/nytimes.png',
                  fit: BoxFit.cover,
                ),
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
                    Expanded(flex: 2, child: Text(state.allResults?.results?[index].title ?? "")),
                    Expanded(
                      child: Container(
                        width: 100.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
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
                    ),
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

        return Center(child: CircularProgressIndicator());
      },
    ),
)
    );
  }
}

import 'package:get_it/get_it.dart';
import 'package:ny_times1/bloc/news_bloc.dart';

import '../screens/homepage.dart';

final GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerSingleton<NewsBloc>(NewsBloc(dio));
}
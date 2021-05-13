import 'package:egyptnews/shared/component.dart';
import 'package:egyptnews/shared/cubit/appcubit.dart';
import 'package:egyptnews/shared/cubit/appstates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
      listener: ( context , state){},
      builder: ( context , state)
      {
        var cubit = AppCubit.get(context);
        var list = cubit.sportsArticles;
        return  ArticleBuilder(list, context);
      },
    );
  }
}
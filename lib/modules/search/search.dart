import 'package:egyptnews/shared/component.dart';
import 'package:egyptnews/shared/cubit/appcubit.dart';
import 'package:egyptnews/shared/cubit/appstates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget
{
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
      listener: (context , state){},
      builder: (context , state){
       var  list = AppCubit.get(context).searchArticles;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: defaultFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  validate: (String value){
                    if(value.isEmpty){
                      return 'please enter search word';
                    }
                    return null;
                  },
                  label: 'Search',
                  prefix: Icons.search,
                  onChange: (value){
                    AppCubit.get(context).getSearchArticles(value);
                  },
                ),
              ),
              Expanded(child: ArticleBuilder(list, context , isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}

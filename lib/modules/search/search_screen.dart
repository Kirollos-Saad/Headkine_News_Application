import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/cubit/cubit.dart';
import 'package:news_application/cubit/states.dart';
import 'package:news_application/shared/components.dart';

class SearchScreen extends StatelessWidget {

  bool isSearch = true;
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: DefaultFormField(
                  Controller: searchController,
                  Type: TextInputType.text,
                  onChange: (value){
                    NewsCubit.get(context).getSearch(value);
                  },
                  Validator: (String ? value){
                    if(value!.isEmpty){
                      return 'Search must not be empty';
                    }
                    return null;
                  },
                  Label: 'Search',
                  Prefix: Icons.search,
                ),
              ),
              Expanded(
                  child: ConditionalBuilder(
                    condition: list.isNotEmpty,
                    builder: (context) => ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildArticlesItem(list[index],context),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: 10),
                    fallback: (context) => isSearch ? Container() : const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
              )
            ],
          ),
        );
      },
    );
  }
}

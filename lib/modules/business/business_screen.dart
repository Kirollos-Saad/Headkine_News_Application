import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/cubit/cubit.dart';
import 'package:news_application/cubit/states.dart';
import 'package:news_application/shared/components.dart';

class BusinessScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        var list=NewsCubit.get(context).business;
        return ConditionalBuilder(
            condition: list.length>0,
            builder: (context)=> ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder:(context,index)=>buildArticleItem(list[index],context),
              separatorBuilder:(context,index)=>myDivider(),
              itemCount: 10,
              ),
            fallback: (context)=> Center(child: CircularProgressIndicator()));
      },

    );
  }
}

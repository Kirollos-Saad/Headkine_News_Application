import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/cubit/cubit.dart';
import 'package:news_application/cubit/states.dart';
import 'package:news_application/modules/search/search_screen.dart';
import 'package:news_application/shared/components.dart';

import '../shared/darkCubit.dart';

class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (BuildContext context, state){},
      builder: (BuildContext context, state) {
        var cubit=NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'News App'
            ),
            actions: [
              IconButton(
                  onPressed: ()
                  {
                   navigateTo(context, SearchScreen(),);
                  },
                  icon: Icon(Icons.search)),
              IconButton(
                  onPressed: (){
                    AppCubit.get(context).changeAppMode();
              },
                  icon: Icon(Icons.brightness_4_outlined)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items:cubit.bottomItems,
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeBottomNavBar(index);
            },

          ),
        );
      }


    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/layout/cubit/movieCubit.dart';
import 'package:movie_app/layout/cubit/moviestates.dart';

class MovieLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>LayoutCubit()..getPopular()..getNowPlaying(context)..getTopRated()..getUpComing(),
    child :BlocConsumer<LayoutCubit,LayoutStates>(
        listener:(context,state){},
        builder:(context,state){
          return Scaffold(
            body: LayoutCubit.get(context).screens[ LayoutCubit.get(context).current_Index],

            bottomNavigationBar: BottomNavigationBar(
                currentIndex: LayoutCubit.get(context).current_Index,
                onTap: (index){
                  LayoutCubit.get(context).changeNavBar(index);
                },
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.home_filled),label: 'Home'),
                  BottomNavigationBarItem(icon: Icon(Icons.search),label: 'Search'),
                ]),
          );
        }
    ),
    );
  }
}

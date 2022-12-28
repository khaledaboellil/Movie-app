import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/layout/cubit/movieCubit.dart';
import 'package:movie_app/layout/cubit/moviestates.dart';
import 'package:movie_app/model/popular%20model/popularmodel.dart';
import 'package:movie_app/module/Moviedetails/DetailsScreen.dart';
import 'package:movie_app/shared/companents/companents.dart';

class HomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {


    return Builder(
      builder: (context) {

        return BlocConsumer<LayoutCubit,LayoutStates>(
          listener:(context,state){},
          builder: (context,state) {
            if(LayoutCubit.get(context).popularModel == null&&LayoutCubit.get(context).nowPlayingModel == null
                &&LayoutCubit.get(context).topRatedModel == null&&LayoutCubit.get(context).upComingModel == null)
              {
                LayoutCubit.get(context).getPopular();
                LayoutCubit.get(context).getUpComing();
                LayoutCubit.get(context).getNowPlaying(context);
                LayoutCubit.get(context).getTopRated();
              }


            return ConditionalBuilder(
                condition: LayoutCubit.get(context).popularModel != null&&LayoutCubit.get(context).nowPlayingModel != null
                &&LayoutCubit.get(context).topRatedModel != null&&LayoutCubit.get(context).upComingModel != null,
                builder:(context)=>SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselSlider(items:LayoutCubit.get(context).Images, options: CarouselOptions(
                        height: 400,
                        autoPlay: true ,
                        scrollDirection: Axis.horizontal,
                        autoPlayAnimationDuration: Duration(milliseconds: 100),
                        autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                        viewportFraction: 1.0,
                      )),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text('Popular Movies',style:Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 25
                        ),),
                      ),
                      buildMovieScroller(LayoutCubit.get(context).popularModel! , context),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text('Top Rated Movies',style:Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 25
                        ),),
                      ),
                      buildMovieScroller(LayoutCubit.get(context).topRatedModel! , context),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text('UpComing Movies',style:Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 25
                        ),),
                      ),
                      buildMovieScroller(LayoutCubit.get(context).upComingModel! , context),

                    ],
                  ),
                ),
                fallback:(context)=>Center(child: CircularProgressIndicator()));
          }
        );
      }
    );
  }
  Widget buildMovieScroller(PopularModel model , context)=>Container(
    width: double.infinity,
    height: 200,
    child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index)=>buildPopularMovies(model.results[index],context),
        separatorBuilder: (context,index)=>SizedBox(width: 10,),
        itemCount: model.results.length),
  );
  Widget buildPopularMovies(Data model,context)=>InkWell(
    onTap: (){
      navigateTo(context, DetailsScreen(model.id));
    },
    child: Card(

      color: Colors.grey.shade800,
      child: Container(
        width: 125,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(image: NetworkImage(model.backdrop_path)
                          ,fit: BoxFit.fill
                      ),
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5)),
                      color: Colors.grey.withOpacity(0.6),
                    ),
                    width: double.infinity,
                    child: Text(model.original_title,maxLines: 1,overflow: TextOverflow.ellipsis,),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  height: 30,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        model.release_date.substring(0,4),
                        style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.white
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Icon(Icons.star,color: Colors.yellow,size: 15,),
                Text(double.parse((model.vote_average).toStringAsFixed(1)).toString()
                  ,style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.white,fontSize: 15
                  ),),

              ],
            ),
          ],
        ),
      ),
    ),
  );
}

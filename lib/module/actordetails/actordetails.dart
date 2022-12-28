import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/layout/cubit/movieCubit.dart';
import 'package:movie_app/layout/cubit/moviestates.dart';
import 'package:movie_app/module/actordetails/biography.dart';

import '../../model/popular model/popularmodel.dart';
import '../../shared/companents/companents.dart';
import '../Moviedetails/DetailsScreen.dart';

class ActorDetails extends StatelessWidget {
dynamic id;
ActorDetails(this.id);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>LayoutCubit()..getActor(id)..getActorPopular(id) ,
    child: BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
            condition: LayoutCubit.get(context).actorModel!=null&&LayoutCubit.get(context).actorPopularModel!=null,
            builder: (context)=>Scaffold(
              appBar: AppBar(
                title: Text('${LayoutCubit.get(context).actorModel!.name}'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${LayoutCubit.get(context).actorModel!.name}',
                        style:Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 25
                        ) ,),
                      SizedBox(height: 10,),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 150,
                            width: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(image: NetworkImage('${LayoutCubit.get(context).actorModel!.profilePath}')),
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(child: InkWell(
                            onTap: (){
                              navigateTo(context, Biography(LayoutCubit.get(context).actorModel!.biography));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${LayoutCubit.get(context).actorModel!.biography}',maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.subtitle1,
                                ),
                                if(LayoutCubit.get(context).actorModel!.birthday!=null)
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text('Born : ${LayoutCubit.get(context).actorModel!.birthday}',
                                  style: Theme.of(context).textTheme.subtitle1
                                    ,),
                                ),
                                if(LayoutCubit.get(context).actorModel!.deathday!=null)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text('Death : ${LayoutCubit.get(context).actorModel!.deathday}',
                                      style: Theme.of(context).textTheme.subtitle1
                                      ,),
                                  )
                              ],
                            ),
                          )),

                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text('Popular Movies',style:Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 25
                        ),),
                      ),
                      // buildMovieScroller(LayoutCubit.get(context).actorPopularModel! , context),
                      GridView.count(crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                        children:List.generate(LayoutCubit.get(context).actorPopularModel!.results.length,
                                (index) => buildPopularMovies(LayoutCubit.get(context).actorPopularModel!.results[index], context)),)
                    ],
                  ),
                ),
              ),
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator(),));
      },
    ),
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

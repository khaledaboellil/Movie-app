import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/layout/cubit/moviestates.dart';
import 'package:movie_app/module/actordetails/actordetails.dart';

import '../../layout/cubit/movieCubit.dart';
import '../../model/CastModel/CastModel.dart';
import '../../model/popular model/popularmodel.dart';
import '../../shared/companents/companents.dart';

class DetailsScreen extends StatelessWidget {

  dynamic id ;
  DetailsScreen(this.id) ;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
    ));
    return Builder(
      builder: (context) {
        return BlocProvider(
          create: (context)=>LayoutCubit()..getDetails(id)..getCast(id)..getSimilar(id),
          child: BlocConsumer<LayoutCubit,LayoutStates>(
              listener:(context,state){},
              builder: (context,state){
                return Scaffold(
                    extendBodyBehindAppBar: true,
                    body: ConditionalBuilder(
                        condition: LayoutCubit.get(context).detailsModel != null&& LayoutCubit.get(context).castModel != null
                            && LayoutCubit.get(context).similarModel != null ,
                        builder: (context) => SingleChildScrollView(
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 450,
                                    child: Stack(

                                      children: [
                                        Container(
                                          height: 450,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      LayoutCubit.get(context).detailsModel!.backdrop_path),
                                                  fit: BoxFit.fill)),
                                        ),
                                        Row(
                                          children: [
                                            Spacer(),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  height: 60,
                                                ),
                                                CircleAvatar(
                                                  backgroundColor: Colors.black,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon: Icon(
                                                      Icons.arrow_forward_ios_rounded,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                CircleAvatar(
                                                  backgroundColor: Colors.transparent,
                                                  child: IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons.star_border,
                                                      color: Colors.black,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 20,
                                            )
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            width: double.infinity,
                                            color: Colors.grey.withOpacity(0.3),
                                            child: Text(LayoutCubit.get(context).detailsModel!.title,
                                              style:Theme.of(context).textTheme.bodyText1,),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade800,
                                                  borderRadius: BorderRadius.circular(5)
                                              ),
                                              height: 40,
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: Text(
                                                    LayoutCubit.get(context).detailsModel!.release_date,
                                                    style: Theme.of(context).textTheme.caption!.copyWith(
                                                        color: Colors.white
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width:10),
                                            Icon(Icons.star,color: Colors.yellow,size: 15,),
                                            Text(LayoutCubit.get(context).detailsModel!.vote_average.toString().substring(0,3)
                                            ,style: Theme.of(context).textTheme.caption!.copyWith(
                                                  color: Colors.white,fontSize: 15
                                              ),),

                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text(LayoutCubit.get(context).detailsModel!.overview,
                                            style:Theme.of(context).textTheme.subtitle2!.copyWith(
                                              color: Colors.white
                                            ),),
                                        ),
                                        Row(
                                          children: [
                                            for(int i=0;i<LayoutCubit.get(context).detailsModel!.genres.length;i++)
                                            Expanded(child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade800,
                                                  borderRadius: BorderRadius.circular(5)
                                                ),
                                                height: 40,
                                                child: Center(
                                                  child: Text(
                                                      LayoutCubit.get(context).detailsModel!.genres[i].name,
                                                      style: Theme.of(context).textTheme.caption!.copyWith(
                                                        color: Colors.white
                                                      ),
                                                      textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            )),

                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text('Cast',
                                            style:Theme.of(context).textTheme.bodyText1!.copyWith(
                                              fontSize: 30
                                            )),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 150,
                                          child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context,index)=>buildCast(LayoutCubit.get(context).castModel!.cast![index],context),
                                              separatorBuilder: (context,index)=>SizedBox(width: 10,),
                                              itemCount: LayoutCubit.get(context).castModel!.cast!.length),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text('Similar Movies',
                                              style:Theme.of(context).textTheme.bodyText1!.copyWith(
                                                  fontSize: 30
                                              )),
                                        ),
                                        GridView.count(
                                            crossAxisCount: 3,
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            mainAxisSpacing: 5,
                                            crossAxisSpacing: 0,

                                            children:List.generate(LayoutCubit.get(context).similarModel!.results.length,
                                                    (index) => buildSimilarMovies(LayoutCubit.get(context).similarModel!.results[index],context),),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator())));
              },
          ),
        );
      }
    );
  }
  Widget buildCast(Cast model,context)=>InkWell(
    onTap: (){
      navigateTo(context, ActorDetails(model.id));
    },
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(image: NetworkImage('${model.profilePath}')
                ,fit: BoxFit.fill
            ),
            color: Colors.grey,
          ),
        ),
        Container(
          width: 100,
          child: Text('${model.name}',maxLines: 1,overflow: TextOverflow.ellipsis,),
          color: Colors.grey.withOpacity(0.6),
        ),
      ],
    ),
  );
  Widget buildSimilarMovies(Data model,context)=>InkWell(
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

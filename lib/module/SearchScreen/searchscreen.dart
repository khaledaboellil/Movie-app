import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/layout/cubit/movieCubit.dart';
import 'package:movie_app/layout/cubit/moviestates.dart';
import 'package:movie_app/shared/companents/companents.dart';

import '../../model/popular model/popularmodel.dart';
import '../Moviedetails/DetailsScreen.dart';

class SearchScreen extends StatelessWidget {

  var searchController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>LayoutCubit()
    ,child: BlocConsumer<LayoutCubit,LayoutStates>(
        listener: (context,state){},
        builder: (context,state){
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Icon(Icons.search),
                        ),

                        Expanded(
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            controller: searchController,
                            onChanged: (index){

                                LayoutCubit.get(context).getSearch(index);

                            },
                            decoration: InputDecoration(
                             border: UnderlineInputBorder(borderSide: BorderSide.none)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ) ,
                SizedBox(height: 20 ,),
                Expanded(
                  child: ConditionalBuilder(
                      condition: state is ! GetSearchLoadingState && LayoutCubit.get(context).searchModel!=null&&searchController.text.isNotEmpty ,
                      builder: (context)=>GridView.count(crossAxisCount: 2,
                        scrollDirection: Axis.vertical,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                      children:List.generate(LayoutCubit.get(context).searchModel!.results.length,
                              (index) => buildSearchMovies(LayoutCubit.get(context).searchModel!.results[index], context)),)
                      , fallback:  (context)=>Center(child: CircularProgressIndicator(),)),
                )
              ],
            ),
          ) ;
        },
      ),
    );
  }
  Widget buildSearchMovies(Data model,context)=>InkWell(
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
                if(model.release_date!='')
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

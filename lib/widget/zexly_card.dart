import 'package:chexproject/model/zexly_model.dart';
import 'package:flutter/material.dart';

class ZexlyCard extends StatelessWidget {
  final MovieModel model;
  final int index;
  final Function(double val) onHeight;

  ZexlyCard({required this.model,required this.index,
    required this.onHeight});


  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onHeight((context.size!.height) /
          (model.movies.length / 4));
    });
    return  buildListMovies(size,index, model.movies);
  }

  Widget buildListMovies(Size size,int index, List<Movie> movies) {
    return Container(
      height: movies.length*76,
      width: size.width,
      child: ListView.builder(
          itemCount: movies.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context,index){
            return SizedBox(
              height: 75,
              child: Card(
                child: Center(child: Text(movies[index].name,style: TextStyle(fontSize: 17),)),
              ),
            );
          }),
    );
  }

}

import 'package:chexproject/model/zexly_model.dart';
import 'package:chexproject/state/tabbar_change.dart';
import 'package:chexproject/zexly.dart';
import 'package:flutter/material.dart';

abstract class MovieViewModel extends State<Zexly>{
  ScrollController scrollController=ScrollController();
  int currentCategoryIndex=0;
  ScrollController headerScrollController=ScrollController();

  List<MovieModel>movieList=[];

  @override
  void initState() {
    super.initState();
    movieList=List.generate(
      10,
        (index)=>MovieModel(
          categoryName: "Category",
          movies: List.generate(6, (index) => Movie(
            "${index+1}. Movie ",
              index*100
          ))
        ),
    );
    scrollController.addListener(() {
      final index=movieList.indexWhere((element) => element.position>=scrollController.offset);
      tabBarNotifier.changeIndex(index);

      headerScrollController.animateTo(
        index*(MediaQuery.of(context).size.width*0.2),
        duration: Duration(seconds: 1),
        curve: Curves.decelerate
      );
    });
  }

  void headerListChangePosition(int index) {
    scrollController.animateTo(movieList[index].position,
        duration: Duration(seconds: 1), curve: Curves.ease);
  }
  double oneItemHeight = 0;


  void fillListPositionValues(double val) {
    if (oneItemHeight == 0) {
      oneItemHeight = val;
      movieList.asMap().forEach((key, value) {
        if (key == 0) {
          movieList[key].position = 0;
        } else {
          movieList[key].position = getMovieListPosition(val, key);
        }
      });
    }
  }

  double getMovieListPosition(double val, int index) =>
      val * (movieList[index].movies.length / 4) +
          movieList[index - 1].position;

}
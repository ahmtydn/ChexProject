import 'package:chexproject/state/tabbar_change.dart';
import 'package:chexproject/widget/zexly_card.dart';
import 'package:chexproject/zexly_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';

class ZexlyView extends MovieViewModel{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chex Project"),
      ),
      body: buildChangeBody(),
    );
  }

  ChangeNotifierProvider<TabBarChange> buildChangeBody() {
    return ChangeNotifierProvider.value(
      value: tabBarNotifier,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: buildListViewHeader),
          Divider(),
          Expanded(flex: 9, child: buildListViewMovie()),
        ],
      ),
    );
  }

  ListView  buildListViewMovie() {
    return ListView.builder(
      controller: scrollController,
      itemCount: movieListAndSpaceAreaLength,
      itemBuilder: (context, index) {
        print(index);
        if (index == movieListLastIndex)
          return emptyWidget;
        else
          return StickyHeader(
            header: Container(
              width: double.infinity,
              color: Colors.amber,
              padding: const EdgeInsets.all(16),
              child: Text("${movieList[index].categoryName} ${index+1}",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20,color: Colors.black),),
            ),
            content: ZexlyCard(
              model: movieList[index],
              index: index,
              onHeight: (val) {
                fillListPositionValues(val);
              },
            ),
          );
      },
    );
  }

  int get movieListAndSpaceAreaLength => movieList.length + 1;

  int get movieListLastIndex => movieList.length;

  Container get emptyWidget => Container(height: oneItemHeight * 2);

  Widget get buildListViewHeader {
    return Consumer<TabBarChange>(
      builder: (context, value, child) => ListView.builder(
        itemCount: movieList.length,
        controller: headerScrollController,
        padding: EdgeInsets.all(10),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => buildPaddingHeaderCard(index),
      ),
    );
  }

  Padding buildPaddingHeaderCard(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: OutlinedButton(
        onPressed: () => headerListChangePosition(index),
        child: Text("${movieList[index].categoryName} ${index+1}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black),),
      ),
    );
  }

}

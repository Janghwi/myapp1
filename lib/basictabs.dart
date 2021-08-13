import 'package:flutter/material.dart';

class BasicTabViewModel {
  final String title;
  final Widget widget;

  const BasicTabViewModel({
    this.title,
    this.widget,
  });
}

class BasicTabs extends StatelessWidget {
  final String title;
  final List<BasicTabViewModel> tabcategories;
  final bool tabScrollable;
  final TabController tabController;

  BasicTabs({
    this.title,
    this.tabcategories,
    this.tabScrollable = true,
    this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        bottom: TabBar(
          controller: this.tabController,
          isScrollable: this.tabScrollable,
          tabs: this.tabcategories.map((item) => Tab(text: item.title)).toList(),
        ),
      ),
      //여기가 하위의 아이콘이 나오는 부분이다... 
      body: TabBarView(
        controller: this.tabController,
        children: this.tabcategories.map((item) => item.widget).toList(),
      ),
      
    );
  }
}
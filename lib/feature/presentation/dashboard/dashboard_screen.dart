import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:login_demo/core/router/route_constants.dart';
import 'package:sizer/sizer.dart';

import '../../../di/di.dart';
import 'bloc/categories_listing_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  FetchCategoriesBloc bloc = si<FetchCategoriesBloc>();
  int _selectedIndex = 0;
  final List<String> imgList = [
    'https://picsum.photos/250?image=9',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    bloc.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              height: 60.h,
              enableInfiniteScroll: true,
              viewportFraction: 1.0,
            ),
            items: imgList
                .map((item) => Center(
                      child: Image.network(
                        item,
                        fit: BoxFit.fill,
                        height: 60.h,
                      ),
                    ))
                .toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w, top: 2.h),
                child: Text(
                  "Today Recipes",
                  style: TextStyle(fontSize: 10.sp),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(right: 10.w, top: 2.h),
                  child: Text("View all")),
            ],
          ),
          Expanded(
            child: StreamBuilder<List<String>>(
                stream: bloc.categoryListStream,
                initialData: null,
                builder: (context, categoriesData) {
                  return categoriesData.data == null
                      ? Column(
                          children: const [
                            Center(
                              child: CircularProgressIndicator(
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        )
                      : categoriesData.data!.isEmpty
                          ? Center(
                              child: Text(
                                "No Data found",
                                style: TextStyle(fontSize: 12.0.sp),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: categoriesData.data!.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    Navigator.pushNamed(context,
                                        drinksListingAsPerCategoryRoute,
                                        arguments: categoriesData.data![index]);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 0.2.w, right: 0.2.w),
                                    width: 25.w,
                                    child: Card(
                                      color: Color(0xFFE8F2F8),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0.w)),
                                      elevation: 2.0.w,
                                      child: Center(
                                        child: Container(
                                          margin: EdgeInsets.only(left: 1.w, right: 1.w),
                                          child: Text(
                                            categoriesData.data![index],
                                            style: TextStyle(
                                                fontSize: 9.sp,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                }),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outlined),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Shopping',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../core/router/route_constants.dart';
import '../../../di/di.dart';
import '../../data/model/drinks_listing_model.dart';
import '../common_widgets/search_text_field.dart';
import 'bloc/drinks_listing_bloc.dart';
import 'package:sizer/sizer.dart';

class DrinksListingScreen extends StatefulWidget {
  final String categoryName;

  const DrinksListingScreen({super.key, required this.categoryName});

  @override
  State<DrinksListingScreen> createState() => _DrinksListingScreenState();
}

void onItemTapped() {}

class _DrinksListingScreenState extends State<DrinksListingScreen> {
  final TextEditingController _searchController = TextEditingController();
  FetchDrinksListingBloc bloc = si<FetchDrinksListingBloc>();

  @override
  Widget build(BuildContext context) {
    bloc.fetchDrinksListAsPerCategoryCategories(widget.categoryName);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Container(
            padding: EdgeInsets.symmetric(vertical: 1.0.h),
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  "assets/png/back_arrow.png",
                  width: 0.6.w,
                  height: 0.8.h,
                ))),
        leadingWidth: 66,
        title: SearchTextField.build(context, "Search here..",
            _searchController, (String value) {}), // Row
      ),
      body: StreamBuilder<DrinksListingByCategoryModel?>(
          stream: bloc.drinksListAsPerCategoryListStream,
          initialData: null,
          builder: (context, drinksData) {
            return drinksData.data == null
                ? Column(
                    children: const [
                      Center(
                        child: CircularProgressIndicator(
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  )
                : drinksData.data!.drinks!.isEmpty
                    ? Center(
                        child: Text(
                          "No Data found",
                          style: TextStyle(fontSize: 12.0.sp),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : GridView.builder(
                        itemCount: drinksData.data!.drinks!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                        ),
                        itemBuilder: (
                          context,
                          index,
                        ) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context,
                                  drinkDetailsRoute,
                                  arguments: drinksData.data!.drinks![index].idDrink);
                            },
                            child: Container(
                              margin:
                                  EdgeInsets.only(left: 0.2.w, right: 0.2.w),
                              width: 25.w,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 17.h,
                                    child: Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(2.0.w)),
                                      elevation: 2,
                                      child: Image.network(
                                          drinksData.data!.drinks![index]
                                                  .strDrinkThumb ??
                                              "",
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            drinksData.data!.drinks![index]
                                                    .strDrink ??
                                                "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
          }), //
    );
  }
}

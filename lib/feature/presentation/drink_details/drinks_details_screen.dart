import 'package:flutter/material.dart';
import 'package:login_demo/core/router/routes.dart';
import 'package:sizer/sizer.dart';

import '../../../di/di.dart';
import 'bloc/drinks_details_bloc.dart';

class DrinksDetailsScreen extends StatefulWidget {
  final String drinkId;

  const DrinksDetailsScreen({super.key, required this.drinkId});

  @override
  State<DrinksDetailsScreen> createState() => _DrinksListingScreenState();
}

class _DrinksListingScreenState extends State<DrinksDetailsScreen> {
  DrinkDetailsBloc bloc = si<DrinkDetailsBloc>();

  @override
  Widget build(BuildContext context) {
    bloc.fetchDrinksDetailsAsPerId(widget.drinkId);
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          StreamBuilder<String>(
              stream: bloc.drinkImageStream,
              initialData: null,
              builder: (context, drinkImage) {
                return drinkImage.data == null
                    ? Column(
                        children: const [
                          Center(
                            child: CircularProgressIndicator(
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      )
                    : drinkImage.data!.isEmpty
                        ? Center(
                            child: Text(
                              "No Data found",
                              style: TextStyle(fontSize: 12.0.sp),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : Image.network(drinkImage.data ?? "",
                            fit: BoxFit.fill);
              }),
          Container(
              margin: EdgeInsets.only(top: 1.5.h),
              width: 50.w,
              height: 2.5.h,
              child: Text(
                "Ingredients",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10.sp),
              )),
          Container(
            margin: EdgeInsets.only(top: 0.5.h, bottom: 1.h),
            width: 50.w,
            height: 35.h,
            child: StreamBuilder<List<String>>(
                stream: bloc.drinkIngredientsStream,
                initialData: null,
                builder: (context, drinksIngredients) {
                  return drinksIngredients.data == null
                      ? Column(
                          children: const [
                            Center(
                              child: CircularProgressIndicator(
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        )
                      : drinksIngredients.data!.isEmpty
                          ? Center(
                              child: Text(
                                "No Data found",
                                style: TextStyle(fontSize: 12.0.sp),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: drinksIngredients.data!.length,
                              itemBuilder: (context, index) {
                                return Text(
                                  drinksIngredients.data![index],
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 9.sp, color: Colors.white),
                                );
                              });
                }),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.all(16.0),
              textStyle: TextStyle(fontSize: 12.sp),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.drinkRecipeSteps,
                  arguments: widget.drinkId);
            },
            child: const Text('Start Mixing'),
          )
        ]));
  }
}

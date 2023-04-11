import 'package:flutter/material.dart';

import '../../../di/di.dart';
import '../drink_details/bloc/drinks_details_bloc.dart';
import 'package:sizer/sizer.dart';

class DrinksRecipeStepsScreen extends StatefulWidget {
  final String drinkId;

  const DrinksRecipeStepsScreen({super.key, required this.drinkId});

  @override
  State<DrinksRecipeStepsScreen> createState() => _DrinksRecipeStepsState();
}

class _DrinksRecipeStepsState extends State<DrinksRecipeStepsScreen> {
  DrinkDetailsBloc bloc = si<DrinkDetailsBloc>();

  @override
  Widget build(BuildContext context) {
    bloc.fetchDrinksRecipeStepsAsPerId(widget.drinkId);
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
              width: 80.w,
              height: 2.5.h,
              child: Text(
                "Steps",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10.sp),
              )),
          Container(
            width: 80.w,
            height: 45.h,
            margin: EdgeInsets.only(top: 0.5.h, bottom: 1.h),
            child: StreamBuilder<List<String>>(
                stream: bloc.drinkRecipeStepsStream,
                initialData: null,
                builder: (context, drinksRecipeSteps) {
                  return drinksRecipeSteps.data == null
                      ? Column(
                          children: const [
                            Center(
                              child: CircularProgressIndicator(
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        )
                      : drinksRecipeSteps.data!.isEmpty
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
                              itemCount: drinksRecipeSteps.data!.length,
                              itemBuilder: (context, index) {
                                int count = 0;
                                count = index + 1;
                                return Row(
                                  children: [
                                    SizedBox(
                                      width: 1.w,
                                      child: Text(
                                        count.toString(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 9.sp,
                                            color: Colors.yellow),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 4.w,
                                            right: 1.w,
                                            top: 1.h,
                                            bottom: 1.h),
                                        child: Text(
                                          drinksRecipeSteps.data![index],
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 9.sp,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                }),
          ),
        ]));
  }
}

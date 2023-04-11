import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DrinksDetailsScreen extends StatefulWidget {
  final String drinkId;

  const DrinksDetailsScreen({super.key, required this.drinkId});

  @override
  State<DrinksDetailsScreen> createState() => _DrinksListingScreenState();
}

class _DrinksListingScreenState extends State<DrinksDetailsScreen> {

  @override
  Widget build(BuildContext context) {
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
        title: Text(widget.drinkId), // Row
      ),
    );
  }
}

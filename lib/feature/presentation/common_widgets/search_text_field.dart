import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SearchTextField {
  static Widget build(BuildContext context,String hintText,TextEditingController controller,Function(String) value) {
     return Container(
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            color: Color(0xff484646),
            borderRadius: BorderRadius.circular(4.0.w)
        ),
        child: TextFormField(
          controller: controller,
          onChanged: value,
          onFieldSubmitted: (_) {},
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
                color: Color(0xffd2cfcf),
                fontWeight: FontWeight.w400,
                fontFamily: "OpenSans",
                fontStyle: FontStyle.normal,
                fontSize: 10.0.sp),
            prefixIcon: InkWell(
              onTap: () {},
              child: Icon(
                Icons.search,
                color: Color(0xff888888),
                size: 7.0.w,
              ),
            ),suffixIcon: InkWell(
              onTap: () {},
              child: Icon(
                Icons.close,
                color: Color(0xff0e0d0d),
                size: 7.0.w,
              ),
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.only(
                left: 5.0.w,top: 1.0.h,right: 5.0.h),
          ),
        )
    );
  }
}
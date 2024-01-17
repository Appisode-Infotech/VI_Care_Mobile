import 'package:flutter/material.dart';
import 'package:vicare/main.dart';
import 'package:vicare/utils/app_colors.dart';

getPrimaryAppButton(BuildContext context, String label, {required Null Function() onPressed}){
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: screenSize!.width,
      height: 50,
      decoration: const BoxDecoration(color: AppColors.primaryColor,borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Center(child: Text(label,style: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)),
    ),
  );
}
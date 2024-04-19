import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../application_constants/app_constant.dart';

screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

screenWidth(BuildContext context) => MediaQuery.of(context).size.width;


Future<bool?> toast(String txt) => Fluttertoast.showToast(
    msg: txt,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColors.blueColor,
    textColor: AppColors.whiteColor,
    fontSize: 16.0);



class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator(color: AppColors.whiteColor));
  }
}

class LoadingWidget2 extends StatelessWidget {
  const LoadingWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator(color: AppColors.blueColor));
  }
}

class LoadingStateWidget extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const LoadingStateWidget({required this.isLoading, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
        ignoring: isLoading, child: Stack(alignment: Alignment.center, children: [child, isLoading ? const LoadingWidget2() : const SizedBox()]));
  }
}

Widget cachedImageForItem(String url, {double? height, double? width, BoxFit? boxFit}) => CachedNetworkImage(
    imageUrl: url,
    height: height,
    width: width,
    fit: boxFit,
    placeholder: (context, url) => const LoadingWidget2(),
    errorWidget: (context, url, error) => const Icon(
          Icons.error,
        ));

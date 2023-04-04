import 'package:flutter/material.dart';

class GridListAnimator extends StatelessWidget {
  final List<Widget>? data;
  final int? crossAxisCount;
  final bool? neverScrollView ;
  final double? aspectRatio;
  final Axis? direction;

  const GridListAnimator({Key? key, this.data, this.crossAxisCount, this.aspectRatio, this.neverScrollView = false,this.direction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.only(top: 5),
      crossAxisCount: crossAxisCount ?? 2,
      physics: neverScrollView! ? const NeverScrollableScrollPhysics():const BouncingScrollPhysics(),
      addAutomaticKeepAlives: true,
      childAspectRatio: aspectRatio ??  1.7,
      scrollDirection: direction?? Axis.vertical,
      children: data!
    );
  }
}

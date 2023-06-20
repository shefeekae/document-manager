import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GridViewShimmer extends StatelessWidget {
  const GridViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300] as Color,
      highlightColor: Colors.grey[100] as Color,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 100,
            crossAxisSpacing: 10,
            mainAxisExtent: 150,
            crossAxisCount: 3),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(1),
            child: Column(
              children: [
                Container(
                  height: 90,
                  width: 65,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 10,
                  width: 50,
                  decoration: const BoxDecoration(color: Colors.white),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 10,
                  width: 60,
                  decoration: const BoxDecoration(color: Colors.white),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 10,
                  width: 50,
                  decoration: const BoxDecoration(color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

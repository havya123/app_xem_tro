import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  TabWidget({
    required this.indexTab,
    super.key,
  });
  int indexTab;
  @override
  Widget build(BuildContext context) {
    return Container();
    // List type = ["now_playing", "upcoming", "top_rated", "popular"];
    // return Consumer<MovieProvider>(builder: (context, value, child) {
    //   return Column(
    //     children: [
    //       GridView.builder(
    //         physics: const NeverScrollableScrollPhysics(),
    //         shrinkWrap: true,
    //         scrollDirection: Axis.vertical,
    //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //           crossAxisCount: 3,
    //           childAspectRatio: 1 / 1.6,
    //           crossAxisSpacing: 10,
    //           mainAxisSpacing: 10,
    //         ),
    //         itemBuilder: (context, index) {
    //           return Item(
    //             image: movie[indexTab][index].posterPath,
    //             id: movie[indexTab][index].id,
    //           );
    //         },
    //         itemCount: movie[indexTab].length,
    //       ),
    //     ],
    //   );
    // });
  }
}

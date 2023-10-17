import 'package:app_xem_tro/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:read_more_text/read_more_text.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.yellow,
            ),
            spaceWidth(context),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("Nameeeeee"),
                SizedBox(
                  height: 30,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    itemCount: 5,
                  ),
                )
              ],
            ),
          ],
        ),
        spaceHeight(context, height: 0.02),
        ReadMoreText(
          'Reiciendis earum ea non doloribus exercitationem omnis. Commodi id inventore nostrum eos aut. Voluptatibus et et eos laudantium et.'
          'Reiciendis earum ea non doloribus exercitationem omnis. Commodi id inventore nostrum eos aut. Voluptatibus et et eos laudantium et.',
          style: mediumTextStyle(context),
          numLines: 3,
          readMoreText: "Read More",
          readLessText: "Read Less",
        ),
      ],
    );
  }
}

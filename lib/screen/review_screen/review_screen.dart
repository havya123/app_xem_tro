import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/button.dart';
import 'package:app_xem_tro/config/widget/text_field.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:transparent_image/transparent_image.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                buildHeader(context),
                spaceHeight(context, height: 0.02),
                buildRatingRow(context, "Chất lượng phòng trọ"),
                spaceHeight(context, height: 0.01),
                buildRatingRow(context, "Dịch vụ của người cho thuê"),
                spaceHeight(context),
                const Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                ),
                spaceHeight(context),
                buildReviewTextField(context),
                spaceHeight(context),
                buildSubmitButton(context),
                spaceHeight(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return SizedBox(
      height: getHeight(context, height: 0.2),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              height: getHeight(context, height: 0.15),
              child: FadeInImage.memoryNetwork(
                fit: BoxFit.cover,
                placeholder: kTransparentImage,
                image:
                    "https://img.freepik.com/free-photo/blue-house-with-blue-roof-sky-background_1340-25953.jpg",
                imageErrorBuilder: (context, error, stackTrace) {
                  return const Image(
                      image: AssetImage("assets/images/home_img/home.png"));
                },
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Nha ABCCCCCCCCCCCCCCccc",
                style: largeTextStyle(context),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildRatingRow(BuildContext context, String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title,
            style: mediumTextStyle(context),
          ),
        ),
        Expanded(
          flex: 5,
          child: RatingBar.builder(
            itemSize: 30,
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {},
          ),
        ),
      ],
    );
  }

  Widget buildReviewTextField(BuildContext context) {
    return Container(
      width: double.infinity,
      height: getHeight(context, height: 0.5),
      color: Colors.grey.shade300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text("Hãy để lại đánh giá của bạn!"),
          ),
          const Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          Expanded(
            flex: 9,
            child: TextFieldWidget(
              hint: "",
              removeBorder: true,
              maxline: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSubmitButton(BuildContext context) {
    return ButtonWidget(
      function: () {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Xác nhận gửi đánh giá?'),
            content: const Text('Bạn có muốn gửi đánh giá này không?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Show a loading indicator
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Cảm ơn bạn đã gửi đánh giá"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.homeRoute);
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
      textButton: "Gửi đánh giá",
    );
  }
}

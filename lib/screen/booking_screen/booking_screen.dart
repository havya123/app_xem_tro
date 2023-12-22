import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/booking_item.dart';
import 'package:app_xem_tro/models/users.dart';
import 'package:app_xem_tro/provider/booking_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(padding(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spaceHeight(context),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu),
                  Icon(FontAwesomeIcons.bell),
                ],
              ),
              spaceHeight(context),
              Text(
                'My Bookings',
                style: largeTextStyle(context, color: Colors.black),
              ),
              spaceHeight(context),
              Consumer<User>(builder: (context, valueUser, child) {
                if (valueUser.role == 0) {
                  return Consumer<BookingProvider>(
                    builder: (context, value, child) {
                      if (value.listBookingUser.isEmpty) {
                        return const Center(
                          child: Text('Hiện bạn chưa có lịch hẹn nào'),
                        );
                      }
                      return ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return BookingItem(
                              role: valueUser.role,
                              room: value.listRoom[index],
                              booking: value.listBookingUser[index],
                            );
                          },
                          separatorBuilder: (context, index) =>
                              spaceHeight(context),
                          itemCount: value.listBookingUser.length);
                    },
                  );
                }
                return Consumer<BookingProvider>(
                  builder: (context, value, child) {
                    if (value.listBookingLandlord.isEmpty) {
                      return const Center(
                        child: Text('Hiện bạn chưa có lịch hẹn nào'),
                      );
                    }
                    return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return BookingItem(
                            role: valueUser.role,
                            room: value.listRoom[index],
                            booking: value.listBookingLandlord[index],
                          );
                        },
                        separatorBuilder: (context, index) =>
                            spaceHeight(context),
                        itemCount: value.listBookingLandlord.length);
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

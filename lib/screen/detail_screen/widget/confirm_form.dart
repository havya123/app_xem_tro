import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/button.dart';
import 'package:app_xem_tro/config/widget/text_field.dart';
import 'package:app_xem_tro/models/users.dart';
import 'package:app_xem_tro/provider/booking_provider.dart';
import 'package:app_xem_tro/provider/user_login_provider.dart';
import 'package:app_xem_tro/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ConfirmFormWidget extends StatefulWidget {
  ConfirmFormWidget(
      {required this.roomId,
      required this.landlordId,
      required this.landlordName,
      required this.landlordPhone,
      required this.houseAddress,
      super.key});
  String landlordId, landlordName, landlordPhone, roomId, houseAddress;
  @override
  State<ConfirmFormWidget> createState() => _ConfirmFormWidgetState();
}

class _ConfirmFormWidgetState extends State<ConfirmFormWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<User?>(builder: (context, value, child) {
      nameController.text = value!.name;
      phoneController.text = value.phoneNumber;
      return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: FractionallySizedBox(
          heightFactor: getHeight(context, height: 0.002),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
              border: Border.all(width: 1),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: padding(context), horizontal: padding(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Xác nhận đặt lịch hẹn",
                        style: largeTextStyle(context),
                      ),
                    ),
                    spaceHeight(context),
                    const Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                    ),
                    Text(
                      "Thông tin cá nhân",
                      style: mediumTextStyle(context, size: 0.03),
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          detail(context, "Tên", nameController, 100,
                              TextInputType.name, false, null, () {}),
                          detail(context, 'Số điện thoại', phoneController, 10,
                              TextInputType.phone, false, null, () {}),
                          detail(
                            context,
                            "Ngày: ",
                            dateController,
                            20,
                            TextInputType.name,
                            true,
                            FontAwesomeIcons.calendar,
                            () async {
                              DateTime currentDate = DateTime.now();
                              DateTime maxDate =
                                  currentDate.add(const Duration(days: 30));

                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: currentDate,
                                lastDate: maxDate,
                              );

                              if (pickedDate != null &&
                                  pickedDate != selectedDate) {
                                setState(() {
                                  selectedDate = pickedDate;
                                  dateController.text = DateFormat()
                                      .add_yMMMd()
                                      .format(selectedDate);
                                });
                              }
                            },
                          ),
                          detail(
                              context,
                              "Thời gian: ",
                              timeController,
                              20,
                              TextInputType.name,
                              true,
                              FontAwesomeIcons.clock, () async {
                            final TimeOfDay currentTime = TimeOfDay.now();

                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: currentTime,
                              builder: (BuildContext context, Widget? child) {
                                return MediaQuery(
                                  data: MediaQuery.of(context)
                                      .copyWith(alwaysUse24HourFormat: false),
                                  child: child!,
                                );
                              },
                            );

                            if (pickedTime != null &&
                                pickedTime != selectedTime &&
                                pickedTime.hour >= currentTime.hour &&
                                !(pickedTime.hour >= 0 &&
                                    pickedTime.hour < 6) &&
                                !(pickedTime.hour >= 22)) {
                              setState(() {
                                selectedTime = pickedTime;
                                timeController.text =
                                    selectedTime.format(context);
                              });
                            } else {
                              return showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title:
                                        const Text("Chọn giờ không thành công"),
                                    content: const Text(
                                        "Vui lòng chọn khung giờ từ 6 giờ sáng tới trước 22h đêm"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text("Ok")),
                                    ],
                                  );
                                },
                              );
                            }
                          }),
                        ],
                      ),
                    ),
                    spaceHeight(context),
                    ButtonWidget(
                      function: () async {
                        if (formKey.currentState!.validate() &&
                            dateController.text.isNotEmpty &&
                            timeController.text.isNotEmpty) {
                          await context
                              .read<BookingProvider>()
                              .saveBooking(
                                nameController.text,
                                phoneController.text,
                                context.read<UserLoginProvider>().userPhone,
                                widget.landlordName,
                                widget.landlordPhone,
                                widget.landlordId,
                                widget.roomId,
                                dateController.text,
                                timeController.text,
                                widget.houseAddress,
                              )
                              .then((value) {
                            if (value) {
                              return showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text(
                                        "Đặt lịch hẹn không thành công"),
                                    content: const Text(
                                        "Bạn đã có lịch hẹn về phòng trọ này, vui lòng xem lại chi tiết ở trang cá nhân hoặc đặt lại lịch hẹn sau 7 ngày"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Get.back();
                                            Get.back();
                                          },
                                          child: const Text("Ok")),
                                    ],
                                  );
                                },
                              );
                            }
                            context.read<BookingProvider>().getListBookingUser(
                                  context.read<UserLoginProvider>().userPhone,
                                );
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Đặt lịch hẹn thành công"),
                                  content: const Text(
                                      "Vui lòng xem chi tiết lịch hẹn tại trang cá nhân"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Get.back();
                                          Get.back();
                                        },
                                        child: const Text("Ok")),
                                  ],
                                );
                              },
                            );
                          });
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Có lỗi xảy ra"),
                                content: const Text(
                                    "Vui lòng điền đầy đủ thông tin"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text("Ok")),
                                ],
                              );
                            },
                          );
                          return;
                        }
                      },
                      textButton: "Đặt lịch",
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Row detail(
    BuildContext context,
    String title,
    TextEditingController nameController,
    lengthText,
    TextInputType type,
    bool suffixIcon,
    IconData? icon,
    VoidCallback function,
  ) {
    return Row(
      children: [
        Text(
          title,
          style: mediumTextStyle(context),
        ),
        Expanded(
          child: TextFieldWidget(
            hint: "",
            controller: nameController,
            removeBorder: true,
            numberOfLetter: lengthText,
            type: type,
            icon: IconButton(
              icon: Icon(icon),
              onPressed: function,
            ),
          ),
        ),
      ],
    );
  }
}

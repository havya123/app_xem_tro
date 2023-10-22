import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/button.dart';
import 'package:app_xem_tro/config/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConfirmFormWidget extends StatefulWidget {
  const ConfirmFormWidget({super.key});

  @override
  State<ConfirmFormWidget> createState() => _ConfirmFormWidgetState();
}

class _ConfirmFormWidgetState extends State<ConfirmFormWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    nameController.text = "Gà";
  }

  @override
  Widget build(BuildContext context) {
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        detail(context, "Tên: ", nameController, 100,
                            TextInputType.name, false, null),
                        detail(context, "Số điện thoại: ", phoneController, 10,
                            TextInputType.phone, false, null),
                        detail(
                            context,
                            "Ngày: ",
                            dateController,
                            20,
                            TextInputType.name,
                            true,
                            FontAwesomeIcons.calendar),
                        detail(context, "Time: ", timeController, 20,
                            TextInputType.name, true, FontAwesomeIcons.clock),
                      ],
                    ),
                    spaceHeight(context),
                    ButtonWidget(
                      function: () {
                        Navigator.pop(context);
                      },
                      textButton: "Đặt lịch",
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Row detail(
    BuildContext context,
    String title,
    TextEditingController nameController,
    lengthText,
    TextInputType type,
    bool suffixIcon,
    IconData? icon,
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
          icon: suffixIcon
              ? IconButton(
                  icon: Icon(icon),
                  onPressed: () {},
                )
              : null,
        ))
      ],
    );
  }
}

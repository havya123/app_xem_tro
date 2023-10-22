import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/button.dart';
import 'package:app_xem_tro/config/widget/button_list_tile.dart';
import 'package:app_xem_tro/config/widget/text_field.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DetailProfileScreen extends StatefulWidget {
  const DetailProfileScreen({super.key});

  @override
  State<DetailProfileScreen> createState() => _DetailProfileScreenState();
}

class _DetailProfileScreenState extends State<DetailProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(padding(context)),
          child: Column(
            children: [
              spaceHeight(context, height: 0.02),
              const EditPicture(),
              ButtonListTile(
                title: 'Trần Nguyễn Hiếu Trung',
                icon: FontAwesomeIcons.userLarge,
                iconbutton: FontAwesomeIcons.penToSquare,
                onPressIcon: () {
                  dialogPopUp("Name", TextInputType.text);
                },
              ),
              ButtonListTile(
                title: '000-000-0000',
                icon: FontAwesomeIcons.phone,
                iconbutton: FontAwesomeIcons.plus,
                onPressIcon: () {
                  dialogPopUp("Phone", TextInputType.number);
                },
              ),
              ButtonListTile(
                title: 'Trung@gmail.com',
                icon: FontAwesomeIcons.envelope,
                iconbutton: FontAwesomeIcons.penToSquare,
                onPressIcon: () {
                  dialogPopUp("Email", TextInputType.emailAddress);
                },
              ),
              ButtonListTile(
                title: 'Nam',
                icon: FontAwesomeIcons.genderless,
                iconbutton: FontAwesomeIcons.penToSquare,
                onPressIcon: () {
                  dialogPopUp("Sex", TextInputType.text);
                },
              ),
              ButtonListTile(
                title: 'Bình Thạnh',
                icon: FontAwesomeIcons.mapLocation,
                iconbutton: FontAwesomeIcons.penToSquare,
                onPressIcon: () {
                  dialogPopUp("Address", TextInputType.text);
                },
              ),
              const Divider(color: Colors.black87),
              Switchs(
                title: 'Switch to Landlord',
                isSwitch: false,
              ),
              spaceHeight(context),
              ButtonWidget(
                function: () async {
                  Navigator.pushReplacementNamed(context, Routes.loginRoute);
                },
                textButton: "Đăng xuất",
              ),
            ],
          ),
        ),
      ),
    );
  }

  var isLoading = false.obs;
  dialogPopUp(String textMg, TextInputType type) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (builder, setStateForDialog) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius(context))),
            ),
            scrollable: true,
            title: Text(
              textMg,
              textAlign: TextAlign.center,
            ),
            contentPadding: EdgeInsets.all(padding(context)),
            content: Column(
              children: [
                TextFieldWidget(
                  type: type,
                  hint: "",
                ),
                spaceHeight(context),
                ButtonWidget(
                  function: () {},
                  textButton: "Save",
                ),
                spaceHeight(context, height: 0.01),
                ButtonWidget(
                  function: () async {
                    Navigator.pop(context);
                  },
                  textButton: "Exit",
                ),
              ],
            ),
          );
        });
      },
    );
  }
}

class EditPicture extends StatelessWidget {
  const EditPicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: getWidth(context, width: 0.4),
          height: getHeight(context, height: 0.2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset("assets/images/splash_img/teat.png",
                fit: BoxFit.cover),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: Container(
            width: getWidth(context, width: 0.1),
            height: getHeight(context, height: 0.05),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100), color: Colors.grey),
            child: const Icon(
              FontAwesomeIcons.camera,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/avatar_selected.dart';
import 'package:app_xem_tro/config/widget/button.dart';
import 'package:app_xem_tro/config/widget/button_list_tile.dart';
import 'package:app_xem_tro/config/widget/text_field.dart';
import 'package:app_xem_tro/models/users.dart';
import 'package:app_xem_tro/provider/user_login_provider.dart';
import 'package:app_xem_tro/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DetailProfileScreen extends StatefulWidget {
  const DetailProfileScreen({super.key});

  @override
  State<DetailProfileScreen> createState() => _DetailProfileScreenState();
}

class _DetailProfileScreenState extends State<DetailProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<User?>(builder: (context, value, child) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(padding(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              spaceHeight(context, height: 0.02),
              const EditPicture(),
              spaceHeight(context),
              options(
                  context,
                  "assets/images/profile_img/user 1.png",
                  value!.name,
                  () => dialogPopUp("Name", TextInputType.name, nameController,
                          () async {
                        await context.read<UserProvider>().changeName(
                            context.read<UserLoginProvider>().userPhone,
                            nameController.text);
                      })),
              spaceHeight(context),
              options(
                  context,
                  "assets/images/profile_img/call 1.png",
                  value.phoneNumber,
                  () =>
                      dialogPopUp("Phone", TextInputType.phone, phoneController,
                          () async {
                        await context.read<UserProvider>().addPhone(
                            context.read<UserLoginProvider>().userPhone,
                            phoneController.text);
                      })),
              spaceHeight(context),
              options(
                  context,
                  "assets/images/profile_img/gmail 1.png",
                  value.email,
                  () => dialogPopUp(
                          "Gmail", TextInputType.emailAddress, emailController,
                          () async {
                        await context.read<UserProvider>().changeEmail(
                            context.read<UserLoginProvider>().userPhone,
                            emailController.text);
                      })),
              spaceHeight(context),
              options(
                  context,
                  "assets/images/profile_img/payment-details (1).png",
                  value.gender,
                  () {}),
              spaceHeight(context),
              options(
                  context,
                  "assets/images/profile_img/payment-details.png",
                  value.address,
                  () => dialogPopUp(
                      "Address",
                      TextInputType.text,
                      addressController,
                      () => dialogPopUp(
                              "Address", TextInputType.text, addressController,
                              () async {
                            await context.read<UserProvider>().changeAddress(
                                context.read<UserLoginProvider>().userPhone,
                                addressController.text);
                          }))),
              spaceHeight(context),
              const Divider(color: Colors.black87),
              Consumer<User?>(builder: (context, value, child) {
                return value!.role == 1
                    ? const SizedBox()
                    : Switchs(
                        title: 'Switch to Landlord',
                        isSwitch: false,
                      );
              }),
              spaceHeight(context),
              ButtonWidget(
                function: () async {
                  context.read<UserLoginProvider>().logOut();
                },
                textButton: "Đăng xuất",
              ),
            ],
          ),
        ),
      );
    }));
  }

  var isLoading = false.obs;
  dialogPopUp(String textMg, TextInputType type,
      TextEditingController controller, Function function) {
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
                  controller: controller,
                  type: type,
                  hint: "",
                ),
                spaceHeight(context),
                ButtonWidget(
                  function: () {
                    function();
                  },
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

Row options(
  context,
  String image,
  String name,
  Function function,
) {
  return Row(
    children: [
      Container(
        width: 40,
        height: 40,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1), // Set the shadow color
              spreadRadius: 5.0, // Set the spread offset
              blurRadius: 5.0,
              offset: const Offset(0, 1), // Set the offset
            ),
          ],
        ),
        child: Center(
          child: Image.asset(
            image,
          ),
        ),
      ),
      spaceWidth(context),
      Expanded(
        child: Text(
          name,
          style: mediumTextStyle(context),
        ),
      ),
      Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffF6F5F8),
          ),
          child: Center(
              child: IconButton(
            icon: const Icon(FontAwesomeIcons.penToSquare),
            onPressed: () {
              function();
            },
          ))),
    ],
  );
}

class EditPicture extends StatelessWidget {
  const EditPicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Consumer<User?>(builder: (context, value, child) {
          return Container(
            width: 150,
            height: 150,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1)),
            child: Image.network(value!.avatar as String, fit: BoxFit.cover),
          );
        }),
        Positioned(
          bottom: 5,
          right: 5,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100), color: Colors.grey),
            child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return const AvatarSelected();
                    });
              },
              icon: const Icon(FontAwesomeIcons.camera),
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

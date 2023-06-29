import 'dart:io';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/constants/app_constants.dart';
import '../../../app/constants/ui_constants.dart';
import '../../../app/navigation/router.dart';
import '../../../app/navigation/routes.dart';
import '../../../data/user/bloc/user_bloc.dart';
import '../../../data/user/model/model.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/dancing_dots.dart';
import '../../widgets/snack_bar_message.dart';

class EnterNameScreen extends StatefulWidget {
  EnterNameScreen({Key? key}) : super(key: key);

  @override
  State<EnterNameScreen> createState() => _EnterNameScreenState();
}

class _EnterNameScreenState extends State<EnterNameScreen> {
  File? image;
  final TextEditingController _nameTC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: kWhite,
    ));
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserCreateUserSuccessfulState) {
          AppRouter.navigateTo(AppRoutes.homeRoute.route, clearStack: true);
        }
        if (state is UserCreateUserFailedState) {
          CustomErrorSnackBarMsg(time: 3, text: state.msg, context: context);
        }
      },
      builder: (context, state) {
        final _bloc = context.read<UserBloc>();

        return IgnorePointer(
          ignoring: (state is UserAboutYouLoadingState) ? true : false,
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(BootstrapIcons.arrow_left_circle_fill,
                          size: 40, color: kDark),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        poppinsText(
                            txt: 'About',
                            fontSize: 25,
                            weight: FontWeight.w600,
                            color: kDark),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                            color: kOtherColor,
                            border: Border.all(
                              color: kDark,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: poppinsText(
                              txt: 'you',
                              fontSize: 23,
                              weight: FontWeight.w700,
                              color: kDark),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    poppinsText(
                        txt: "What's your name",
                        fontSize: 17,
                        weight: FontWeight.w500,
                        color: kDark),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomUnderlineTextField(
                        controller: _nameTC,
                        textInputType: TextInputType.name,
                        hint: "Enter your name...",
                        inputLength: 20),
                    const Spacer(),
                    MaterialButton(
                      height: 65,
                      minWidth: double.infinity,
                      color: kDark,
                      padding: const EdgeInsets.symmetric(vertical: 17),
                      child: (state is UserAboutYouLoadingState)
                          ? JumpingDots()
                          : poppinsText(
                              txt: "Get started",
                              fontSize: 17,
                              weight: FontWeight.w600,
                              color: kWhite,
                            ),
                      onPressed: () async {
                        SharedPreferences sp =
                            await SharedPreferences.getInstance();

                        if (_nameTC.text.isEmpty) {
                          CustomErrorSnackBarMsg(
                              time: 3,
                              text: "Oops! Can't have an empty name.",
                              context: context);
                        } else {
                          _bloc.add(
                            UserAboutYouSubmittedEvent(
                                UserModel(
                                  phone: sp.getInt(AppConstant.spPhone),
                                  name: _nameTC.text,
                                  createdAt: FieldValue.serverTimestamp(),
                                ),
                                profilePic: image),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _nameTC.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/constants/asset_constants.dart';
import '../../../app/constants/ui_constants.dart';
import '../../../data/auth/bloc/auth_bloc.dart';
import '../../widgets/dancing_dots.dart';
import '../../widgets/snack_bar_message.dart';

class EnterPhoneNumberScreen extends StatefulWidget {
  EnterPhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<EnterPhoneNumberScreen> createState() => _EnterPhoneNumberScreenState();
}

class _EnterPhoneNumberScreenState extends State<EnterPhoneNumberScreen> {
  final TextEditingController _mobileNumberTC = TextEditingController();
  final myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: kWhite,
    ));
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationOTPSentFailedState) {
          CustomErrorSnackBarMsg(time: 3, text: state.msg, context: context);
        }
      },
      builder: (context, state) {
        final _bloc = context.read<AuthenticationBloc>();
        return IgnorePointer(
          ignoring: (state is AuthenticationPhoneSubmittedLoadingState)
              ? true
              : false,
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70.0),
                      child: Image.asset(
                        Assets.images.logo,
                        height: 40,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        poppinsText(
                            txt: 'Enter',
                            fontSize: 22,
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
                              txt: 'Mobile Number',
                              fontSize: 20,
                              weight: FontWeight.w600,
                              color: kDark),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(children: [
                      poppinsText(
                          txt: '+91',
                          color: kTextPrimary,
                          fontSize: 17,
                          weight: FontWeight.w600),
                      const SizedBox(width: 35),
                      Expanded(
                          child: TextField(
                        focusNode: myFocusNode,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                        ],
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: kTextPrimary,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        cursorColor: kDark,
                        controller: _mobileNumberTC,
                        onSubmitted: (value) {
                          if (state is AuthenticationPhoneNumberValidState) {
                            _bloc.add(AuthenticationLoginSubmittedEvent(value));
                          } else {
                            CustomErrorSnackBarMsg(
                                time: 3,
                                text: "Please, enter a valid number.",
                                context: context);
                          }
                        },
                        decoration: InputDecoration(
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: kTextTertiary,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: kOtherColor, width: 1),
                          ),
                          hintText: "Mobile Number",
                          hintStyle: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: kTextTertiary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          _bloc.add(AuthenticationPhoneNumberChangedEvent(
                              _mobileNumberTC.text));
                        },
                      )),
                    ]),
                    const Spacer(),
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        text: 'By signing up, you agree to the ',
                        style: TextStyle(fontSize: 14, color: kTextSecondary),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              fontSize: 14,
                              // fontWeight: FontWeight.bold,
                              // fontStyle: FontStyle.italic,
                              color: kTextPrimary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(
                            text: '  and  ',
                            style: TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                color: kTextSecondary),
                          ),
                          TextSpan(
                            text: 'Terms and Conditions',
                            style: TextStyle(
                              fontSize: 14,
                              // fontStyle: FontStyle.italic,
                              // fontWeight: FontWeight.bold,
                              color: kTextPrimary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      height: 65,
                      minWidth: double.infinity,
                      color: kDark,
                      padding: const EdgeInsets.symmetric(vertical: 17),
                      child: (state is AuthenticationPhoneSubmittedLoadingState)
                          ? JumpingDots()
                          : poppinsText(
                              txt: "Next",
                              fontSize: 17,
                              weight: FontWeight.w600,
                              color: kWhite,
                            ),
                      onPressed: () {
                        myFocusNode.unfocus();

                        if (state is AuthenticationPhoneNumberValidState) {
                          _bloc.add(AuthenticationLoginSubmittedEvent(
                              _mobileNumberTC.text));
                        } else {
                          CustomErrorSnackBarMsg(
                              time: 3,
                              text: "Please, enter a valid number.",
                              context: context);
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
    _mobileNumberTC.dispose();
    myFocusNode.dispose();

    super.dispose();
  }
}

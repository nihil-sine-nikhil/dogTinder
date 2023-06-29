import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../services.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  late final AuthenticationServices _authServices;

  AuthenticationBloc({required AuthenticationServices authServices})
      : _authServices = authServices,
        super(AuthenticationInitial()) {
    on<AuthenticationStatusChangedEvent>((event, emit) async {
      final res = await _authServices.checkSignedIn();
      if (res) {
        emit(AuthenticationLoggedInState());
      } else {
        emit(AuthenticationUnknownState());
      }
    });

    /// start of PHONE NUMBER SEND OTP
    on<AuthenticationPhoneNumberChangedEvent>((event, emit) {
      if (event.phoneNumber.length == 10) {
        emit(AuthenticationPhoneNumberValidState());
      } else {
        emit(AuthenticationPhoneNumberInvalidState());
      }
    });

    on<AuthenticationLoginSubmittedEvent>((event, emit) async {
      emit(AuthenticationPhoneSubmittedLoadingState());
      final response = await _authServices.signInWithPhone(event.phoneNumber);
      if (response.status!) {
        emit(AuthenticationOTPSentSuccessfulState(response.msg ?? "NA"));
      } else if (!response.status!) {
        emit(AuthenticationOTPSentFailedState(
            response.msg ?? "Something went wrong."));
      }
    });

    /// end of PHONE NUMBER SEND OTP

    /// start of OTP VERIFICATION
    on<AuthenticationOTPChangedEvent>((event, emit) {
      if (event.otp.length == 6) {
        emit(AuthenticationOTPValidState());
      } else {
        emit(AuthenticationOTPInvalidState());
      }
    });

    on<AuthenticationOTPVerificationSubmittedEvent>((event, emit) async {
      emit(AuthenticationOTPVerificationSubmittedLoadingState());
      final response =
          await _authServices.verifyOTP(event.otp, event.verificationID);
      if (response.status!) {
        emit(AuthenticationOTPVerifiedSuccessfulState(response.msg ?? "NA"));
      } else {
        emit(AuthenticationOTPVerifiedFailedState(
            response.msg ?? "Something went wrong."));
      }
    });

    /// end of OTP VERIFICATION

    /// RESEND OTP
    on<AuthenticationResendOTPEvent>((event, emit) async {
      emit(AuthenticationResendOTPLoadingState());
      final response = await _authServices.resendOTP(event.phoneNumber);
      print('nikhil 74 $response');
      if (response) {
        emit(const AuthenticationOTPResentSuccessfulState("NA"));
      } else if (!response) {
        emit(const AuthenticationOTPResentFailedState("Something went wrong."));
      }
    });

    /// end of RESEND OTP
  }
}

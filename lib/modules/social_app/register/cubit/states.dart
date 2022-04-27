
abstract class SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates{}

class SocialRegisterLoadingState extends SocialRegisterStates{}

class SocialRegisterSuccessState extends SocialRegisterStates{}

class SocialRegisterErrorState extends SocialRegisterStates{
  final String error;
  SocialRegisterErrorState(this.error);
}
class SocialCreateUserSuccessState extends SocialRegisterStates{}

class SocialCreateUserErrorState extends SocialRegisterStates{
  final String error;
  SocialCreateUserErrorState(this.error);
}
class Loading extends SocialRegisterStates {}

class ErrorOccurred extends SocialRegisterStates {
  final String errorMsg;

  ErrorOccurred({required this.errorMsg});
}

class PhoneNumberSubmited extends SocialRegisterStates{}

class PhoneOTPVerified extends SocialRegisterStates{}

class SocialChangeRegisterPasswordVisibilityState extends SocialRegisterStates{}


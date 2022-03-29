abstract class RegisterStates{}

class RegisterInitState extends RegisterStates{}
class RegisterLoadingState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates{
  final String uid;

  RegisterSuccessState(this.uid);
}
class RegisterErrorState extends RegisterStates{
  final String error;

  RegisterErrorState(this.error);
}
class RegisterChangePasswordVisibilityState extends RegisterStates{}

class CreateUserSuccessState extends RegisterStates {}

class CreateUserErrorState extends RegisterStates {
  final String error;

  CreateUserErrorState(this.error);
}
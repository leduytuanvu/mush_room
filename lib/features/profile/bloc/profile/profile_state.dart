abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccessState extends ProfileState {}

class ProfileDeleteAccountReturnNullState extends ProfileState {}

class ProfileErrorState extends ProfileState {}

class ResetProfileState extends ProfileState {}

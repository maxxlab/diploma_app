// lib/screens/profile/bloc/profile_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import '../../../models/user.dart';
import '../../../repositories/user_repository.dart';
import '../../../services/image_picker_service.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;
  final ImagePickerService _imagePickerService;

  ProfileBloc(this._userRepository, this._imagePickerService) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfileImage>(_onUpdateProfileImage);
    on<UpdateProfileName>(_onUpdateProfileName);
    on<PickImageFromGallery>(_onPickImageFromGallery);
    on<CaptureImageFromCamera>(_onCaptureImageFromCamera);
  }

  Future<void> _onLoadProfile(
      LoadProfile event,
      Emitter<ProfileState> emit,
      ) async {
    emit(ProfileLoading());

    try {
      final user = await _userRepository.getUserProfile();
      emit(ProfileLoaded(user: user));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> _onUpdateProfileImage(
      UpdateProfileImage event,
      Emitter<ProfileState> emit,
      ) async {
    if (state is! ProfileLoaded) return;

    final currentState = state as ProfileLoaded;
    emit(currentState.copyWith(isUpdatingImage: true));

    try {
      final updatedUser = await _userRepository.updateUserProfile(
        profileImage: event.imageUrl,
      );
      emit(ProfileLoaded(user: updatedUser));
    } catch (e) {
      emit(currentState.copyWith(
        isUpdatingImage: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onUpdateProfileName(
      UpdateProfileName event,
      Emitter<ProfileState> emit,
      ) async {
    if (state is! ProfileLoaded) return;

    final currentState = state as ProfileLoaded;
    emit(currentState.copyWith(isUpdatingName: true));

    try {
      final updatedUser = await _userRepository.updateUserProfile(
        name: event.name,
      );
      emit(ProfileLoaded(user: updatedUser));
    } catch (e) {
      emit(currentState.copyWith(
        isUpdatingName: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onPickImageFromGallery(
      PickImageFromGallery event,
      Emitter<ProfileState> emit,
      ) async {
    if (state is! ProfileLoaded) return;

    final currentState = state as ProfileLoaded;
    emit(currentState.copyWith(isUpdatingImage: true));

    try {
      final imageUrl = await _imagePickerService.pickAndUploadProfileImage();
      if (imageUrl != null) {
        add(UpdateProfileImage(imageUrl: imageUrl));
      } else {
        emit(currentState.copyWith(isUpdatingImage: false));
      }
    } catch (e) {
      emit(currentState.copyWith(
        isUpdatingImage: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onCaptureImageFromCamera(
      CaptureImageFromCamera event,
      Emitter<ProfileState> emit,
      ) async {
    if (state is! ProfileLoaded) return;

    final currentState = state as ProfileLoaded;
    emit(currentState.copyWith(isUpdatingImage: true));

    try {
      final imageUrl = await _imagePickerService.captureAndUploadProfileImage();
      if (imageUrl != null) {
        add(UpdateProfileImage(imageUrl: imageUrl));
      } else {
        emit(currentState.copyWith(isUpdatingImage: false));
      }
    } catch (e) {
      emit(currentState.copyWith(
        isUpdatingImage: false,
        error: e.toString(),
      ));
    }
  }
}

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {}

class UpdateProfileImage extends ProfileEvent {
  final String imageUrl;

  const UpdateProfileImage({required this.imageUrl});

  @override
  List<Object?> get props => [imageUrl];
}

class UpdateProfileName extends ProfileEvent {
  final String name;

  const UpdateProfileName({required this.name});

  @override
  List<Object?> get props => [name];
}

class PickImageFromGallery extends ProfileEvent {}

class CaptureImageFromCamera extends ProfileEvent {}

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User user;
  final bool isUpdatingImage;
  final bool isUpdatingName;
  final String? error;

  const ProfileLoaded({
    required this.user,
    this.isUpdatingImage = false,
    this.isUpdatingName = false,
    this.error,
  });

  ProfileLoaded copyWith({
    User? user,
    bool? isUpdatingImage,
    bool? isUpdatingName,
    String? error,
  }) {
    return ProfileLoaded(
      user: user ?? this.user,
      isUpdatingImage: isUpdatingImage ?? this.isUpdatingImage,
      isUpdatingName: isUpdatingName ?? this.isUpdatingName,
      error: error,
    );
  }

  @override
  List<Object?> get props => [user, isUpdatingImage, isUpdatingName, error];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError({required this.message});

  @override
  List<Object?> get props => [message];
}
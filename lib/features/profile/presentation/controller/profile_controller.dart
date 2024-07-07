import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends StateNotifier<File> {
  ProfileController() : super(File(""));

  getProfilePhoto({
    required ImageSource source,
  }) async {
    try {
      final imageFile = await ImagePicker().pickImage(source: source);
      if (imageFile == null) return;
      state = File(imageFile.path);
    } catch (error) {
      state = File("");
    }
  }
}

final profileProvider = StateNotifierProvider<ProfileController, File>((ref) {
  return ProfileController();
});

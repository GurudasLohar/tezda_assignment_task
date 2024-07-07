import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tezda_task/features/common/controller/shared_pref_utils.dart';
import 'package:tezda_task/features/common/widgets/common_snackbar.dart';
import 'package:tezda_task/features/profile/presentation/controller/profile_controller.dart';
import 'package:tezda_task/utils/app_strings.dart';
import 'package:tezda_task/utils/color_utils.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> profileFormKey = GlobalKey();
    var nameRestored = SharedPrefUtil.getValue('name', "") as String;
    var emailRestored = SharedPrefUtil.getValue('email', "") as String;
    final nameText = TextEditingController(text: nameRestored);
    final emailText = TextEditingController(text: emailRestored);
    File imageSelected = ref.watch(profileProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Form(
          key: profileFormKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 60.0),
              const Text(
                "Profile",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Edit and update profile details",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 60.0),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  imageSelected.path.isEmpty
                      ? const Icon(
                          Icons.account_circle,
                          size: 150,
                        )
                      : CircleAvatar(
                          radius: 80,
                          backgroundImage: Image.file(
                            imageSelected,
                            fit: BoxFit.cover,
                          ).image,
                        ),
                  Positioned(
                    bottom: 10,
                    right: -20,
                    child: RawMaterialButton(
                      onPressed: () async {
                        await ref
                            .read(profileProvider.notifier)
                            .getProfilePhoto(source: ImageSource.gallery);
                      },
                      elevation: 2.0,
                      fillColor: const Color(0xFFF5F6F9),
                      padding: const EdgeInsets.all(10.0),
                      shape: const CircleBorder(),
                      child: const Icon(
                        Icons.photo_camera_back_outlined,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nameText,
                cursorColor: Colors.black,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "This field is required.";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.deepOrangeAccent.withOpacity(0.1),
                  filled: true,
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailText,
                cursorColor: Colors.black,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "This field is required.";
                  }
                  if (!AppString.emailRegExp.hasMatch(value)) {
                    return 'Please enter valid email address.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.deepOrangeAccent.withOpacity(0.1),
                  filled: true,
                  prefixIcon: const Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {

                    SharedPrefUtil.setValue("name", nameText.text);
                    SharedPrefUtil.setValue("email", emailText.text);
                    CommonSnackBar(
                        bgColor: AppColors.greenLinearColorDark, message: 'Profile data updated successfully')
                        .showSnackBar(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.deepOrangeAccent,
                  ),
                  child: const Text(
                    "Update",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

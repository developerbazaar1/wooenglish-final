import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/theme/colors/colors.dart';

class IP{
  static Future<File?> pickImage({
    bool pickImageFromGallery = false,
    bool wantCropper = false,
    Color? cropperThemeColor ,
  }) async {
    XFile? imagePicker = pickImageFromGallery
        ? await ImagePicker().pickImage(source: ImageSource.gallery)
        : await ImagePicker().pickImage(source: ImageSource.camera);
    if (imagePicker != null) {
      if (wantCropper) {
        CroppedFile? cropImage = await ImageCropper().cropImage(
          sourcePath: imagePicker.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          uiSettings: [
            AndroidUiSettings(
              toolbarColor: cropperThemeColor??Col.primary,
              toolbarTitle: "Cropper",
              activeControlsWidgetColor: cropperThemeColor??Col.primary,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
            ),
          ],
          compressQuality: 40,
        );
        if (cropImage != null) {
          return File(cropImage.path);
        } else {
          CM.error();
          return null;
        }
      } else {
        //return File(imagePicker.path);
        return null;
      }
    } else {
      CM.error();
      return null;
    }
  }
}
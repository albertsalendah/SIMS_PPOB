import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sims_ppob_richard_albert_salendah/core/utils/show_snackbar.dart';

Future<File?> pickImage(BuildContext context) async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpeg', 'png'],
    );

    if (result != null && result.files.isNotEmpty) {
      PlatformFile file = result.files.first;
      File imageFile = File(file.path!);

      int fileSizeInBytes = imageFile.lengthSync();
      double fileSizeInKb = fileSizeInBytes / 1024;

      if (fileSizeInKb > 100) {
        if (!context.mounted) {
          return null;
        }
        showSnackBarError(
            context: context,
            message: 'Ukuran gambar terlalu besar, max 100kb');
        return null;
      }

      return imageFile;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

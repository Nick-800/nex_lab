import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:nex_lab/helpers/functions_helper.dart';

Future<File?> pickFiles() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: false,
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );

  if (result != null) {
    if (result.files.single.path != null) {
      File file = File(result.files.single.path!);
      printDebug("Selected file path: ${file.path}");
    } else {
      printDebug("File path is null");
    }
  } else {
    printDebug("No file selected");
  }
  if (result != null) {
    return (File(result.files.first.path!));
  } else {
    return null;
  }
}

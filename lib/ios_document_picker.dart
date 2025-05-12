import 'dart:io';

import 'package:ios_document_picker/types.dart';

import 'ios_document_picker_platform_interface.dart';

class IosDocumentPicker {
  Future<List<IosDocumentPickerPath>?> pick(
    IosDocumentPickerType type, {
    bool? multiple,
    List<String>? allowedUtiTypes,
  }) {
    return IosDocumentPickerPlatform.instance.pick(type, multiple: multiple, allowedUtiTypes: allowedUtiTypes);
  }

  Future<FileSystemEntity> resolveBookmark(String bookmark, {bool isDirectory = false}) async {
    return IosDocumentPickerPlatform.instance.resolveBookmark(bookmark, isDirectory: isDirectory);
  }

  Future<bool> startAccessing(String fileUrl) {
    return IosDocumentPickerPlatform.instance.startAccessing(fileUrl);
  }

  Future<void> stopAccessing(String fileUrl) async {
    return IosDocumentPickerPlatform.instance.stopAccessing(fileUrl);
  }
}

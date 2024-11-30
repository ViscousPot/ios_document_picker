import 'package:ios_document_picker/types.dart';

import 'ios_document_picker_platform_interface.dart';

class IosDocumentPicker {
  Future<List<IosDocumentPickerPath>?> pick(
    IosDocumentPickerType type, {
    bool? multiple,
    List<String>? allowedUtiTypes,
  }) {
    return IosDocumentPickerPlatform.instance
        .pick(type, multiple: multiple, allowedUtiTypes: allowedUtiTypes);
  }
}

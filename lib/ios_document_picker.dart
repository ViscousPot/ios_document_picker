import 'ios_document_picker_platform_interface.dart';

class IosDocumentPicker {
  Future<List<DocumentPickerPath>?> pick(
    DocumentPickerType type, {
    bool? multiple,
    List<String>? allowedUtiTypes,
  }) {
    return IosDocumentPickerPlatform.instance
        .pick(type, multiple: multiple, allowedUtiTypes: allowedUtiTypes);
  }
}

import 'ios_document_picker_platform_interface.dart';

class IosDocumentPicker {
  Future<List<DocumentPickerPath>?> pick(DocumentPickerType type) {
    return IosDocumentPickerPlatform.instance.pick(type);
  }
}

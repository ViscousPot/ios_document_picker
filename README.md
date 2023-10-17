# ios_document_picker

[![pub package](https://img.shields.io/pub/v/ios_document_picker.svg)](https://pub.dev/packages/ios_document_picker)

Flutter wrapper of iOS `UIDocumentPickerViewController`.

## Usage

```dart
import 'package:ios_document_picker/ios_document_picker.dart';

final _iosDocumentPickerPlugin = IosDocumentPicker();

var result = await _iosDocumentPickerPlugin.pick(/* DocumentPickerType.file or directory */);
if (result == null) {
  // Cancelled.
  return;
}
print(result.url);
print(result.path);
```

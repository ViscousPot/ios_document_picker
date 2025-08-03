# ios_document_picker

[![pub package](https://img.shields.io/pub/v/ios_document_picker.svg)](https://pub.dev/packages/ios_document_picker)

Flutter wrapper of iOS `UIDocumentPickerViewController` with bookmark resolution and security-scoped resource access support.

## Usage

```dart
import 'package:ios_document_picker/ios_document_picker.dart';

final _iosDocumentPickerPlugin = IosDocumentPicker();

// Pick a file or folder
var result = await _iosDocumentPickerPlugin.pick(
  type: DocumentPickerType.file, // or DocumentPickerType.directory
  multiple: false,
  allowedUtiTypes: ['public.image'], // optional
);

if (result == null) {
  // Cancelled
  return;
}

print(result.url);
print(result.path);
print(result.bookmark); // base64-encoded bookmark

// Resolve a bookmark to a usable file path
var resolved = await _iosDocumentPickerPlugin.resolveBookmark(result.bookmark);
print(resolved['path']);

// Start accessing security-scoped resource
bool hasAccess = await _iosDocumentPickerPlugin.startAccessing(resolved['path']);
if (hasAccess) {
  // Do file operations here
  await _iosDocumentPickerPlugin.stopAccessing(resolved['path']);
}
```

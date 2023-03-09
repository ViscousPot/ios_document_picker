import 'package:flutter_test/flutter_test.dart';
import 'package:ios_document_picker/ios_document_picker.dart';
import 'package:ios_document_picker/ios_document_picker_platform_interface.dart';
import 'package:ios_document_picker/ios_document_picker_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockIosDocumentPickerPlatform
    with MockPlatformInterfaceMixin
    implements IosDocumentPickerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final IosDocumentPickerPlatform initialPlatform = IosDocumentPickerPlatform.instance;

  test('$MethodChannelIosDocumentPicker is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelIosDocumentPicker>());
  });

  test('getPlatformVersion', () async {
    IosDocumentPicker iosDocumentPickerPlugin = IosDocumentPicker();
    MockIosDocumentPickerPlatform fakePlatform = MockIosDocumentPickerPlatform();
    IosDocumentPickerPlatform.instance = fakePlatform;

    expect(await iosDocumentPickerPlugin.getPlatformVersion(), '42');
  });
}

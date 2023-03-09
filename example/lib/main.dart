import 'package:flutter/material.dart';
import 'dart:async';

import 'package:ios_document_picker/ios_document_picker.dart';
import 'package:ios_document_picker/ios_document_picker_platform_interface.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _iosDocumentPickerPlugin = IosDocumentPicker();
  var _output = '';
  var _mode = DocumentPickerType.file;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(_output),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: const Text('File'),
                  leading: Radio<DocumentPickerType>(
                    value: DocumentPickerType.file,
                    groupValue: _mode,
                    onChanged: (DocumentPickerType? value) {
                      setState(() {
                        _mode = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Directory'),
                  leading: Radio<DocumentPickerType>(
                    value: DocumentPickerType.directory,
                    groupValue: _mode,
                    onChanged: (DocumentPickerType? value) {
                      setState(() {
                        _mode = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                OutlinedButton(onPressed: _start, child: const Text('Pick'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _start() async {
    var result = await _iosDocumentPickerPlugin.pick(_mode);
    if (result == null) {
      setState(() {
        _output = 'Cancelled';
      });
      return;
    }
    setState(() {
      _output = result.toString();
    });
  }
}

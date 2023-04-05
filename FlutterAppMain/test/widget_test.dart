// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';

import 'package:tutorial/main.dart';
import 'package:tutorial/pages/image_test/image_test_widget.dart' as f;
import 'package:tutorial/pages/image_test/image_test_widget.dart';

void main() {
  test('saveImage should save the image and info as a text file', () async {
    // Mock the image file
    final imageFile = File(
        'assets/images/Leaf_H5_Material_Background_On_Green_Gradient_Background.jpg');

    // Mock the disease, fertilizer, and solution
    final disease = 'test disease';
    final fertilizer = 'test fertilizer';
    final solution = 'test solution';

    // Create an instance of the state class
    final state = ImageTestWidget().createState();
    state.diseaseName = disease;
    state.fertilizer = fertilizer;
    state.solution = solution;
    state.imageFile = imageFile;
    print("oakt");
    // Call the function
    await state.saveImage();
    final appDir = await getApplicationDocumentsDirectory();
    final newFileName = await state.getNewImageFileName();
    final savedImageFile = File('${appDir.path}/$newFileName.jpg');
    final savedTextFile = File('${appDir.path}/$newFileName.txt');
    expect(await savedImageFile.exists(), true);
    expect(await savedTextFile.exists(), true);
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    //   Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
  });
}

// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tutorial/main.dart';
import 'package:tutorial/pages/image_test/image_test_widget.dart';

//void main() {
//  test('saveImage should save the image and info as a text file', () async {
// Mock the image file
// final imageFile = File('test_image.jpg');

// Mock the disease, fertilizer, and solution
final disease = 'test disease';
final fertilizer = 'test fertilizer';
final solution = 'test solution';
    
    
    // Call the function
   // await _saveImage(imageFile, disease, fertilizer, solution);
    
    // Check if the image file was saved
   // final appDir = await getApplicationDocumentsDirectory();
   // final newFileName = await _getNewImageFileName();
   // final savedImage = File('${appDir.path}/$newFileName.jpg');
    //expect(await savedImage.exists(), true);
    
    // Check if the text file was saved
    //final textFile = File('${appDir.path}/$newFileName.txt');
    //expect(await textFile.exists(), true);
    
    // Check if the text file contains the correct info
    //final text = await textFile.readAsString();
    //expect(text, '$disease:$fertilizer:$solution');
    
    // Delete the saved files to clean up
  //  await savedImage.delete();
  //  await textFile.delete();
 // });
 // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
   // await tester.pumpWidget(MyApp());
  //});
//}
//
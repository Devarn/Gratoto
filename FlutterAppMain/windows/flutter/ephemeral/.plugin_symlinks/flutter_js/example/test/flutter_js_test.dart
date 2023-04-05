import 'package:flutter/services.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_js');

  TestWidgetsFlutterBinding.ensureInitialized();

  late JavascriptRuntime jsRuntime;

  setUp(() {
    jsRuntime = getJavascriptRuntime();
  });

  tearDown(() {
    try {
      jsRuntime.dispose();
    } on Error catch (_) {}
  });

  test('evaluate javascript', () {
    final result = jsRuntime.evaluate('Math.pow(5,3)');
    print('${result.rawResult}, ${result.stringResult}');
    print(
        '${result.rawResult.runtimeType}, ${result.stringResult.runtimeType}');
    expect(result.rawResult, equals(125));
    expect(result.stringResult, equals('125'));
  });
}

import 'package:controller/src/utils/functions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('utils ...', () async {
    var r = compareVersion('2.0.1', '2.0.0');
    expect(r, true);
    r = compareVersion('2.0.0', '2.0.1');
    expect(r, false);
    r = compareVersion('2.0.0', '2.0.0');
    expect(r, true);
  });
}

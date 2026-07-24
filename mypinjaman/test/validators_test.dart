import 'package:flutter_test/flutter_test.dart';
import 'package:mypinjaman/utils/validators.dart';

void main() {
  group('validateIc', () {
    test('accepts exactly 12 digits', () {
      expect(validateIc('051231145678'), isNull);
    });
    test('accepts 12 digits with dashes', () {
      expect(validateIc('051231-14-5678'), isNull);
    });
    test('rejects 11 digits', () {
      expect(validateIc('05123114567'), 'No. KP mesti 12 digit');
    });
    test('rejects empty', () {
      expect(validateIc(''), 'No. KP wajib diisi');
    });
  });

  group('validateEmail', () {
    test('accepts valid email', () => expect(validateEmail('a@b.com'), isNull));
    test('rejects malformed', () => expect(validateEmail('nope'), isNotNull));
  });

  group('validatePhone', () {
    test('accepts 0123456789', () => expect(validatePhone('0123456789'), isNull));
    test('rejects too short', () => expect(validatePhone('123'), isNotNull));
  });

  group('validateRequired', () {
    test('rejects blank', () => expect(validateRequired('   '), isNotNull));
    test('accepts text', () => expect(validateRequired('x'), isNull));
  });
}

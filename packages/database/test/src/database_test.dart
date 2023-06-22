// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';
import 'package:database/database.dart';

void main() {
  group('Database', () {
    test('can be instantiated', () {
      expect(DatabaseUser(), isNotNull);
    });
  });
}

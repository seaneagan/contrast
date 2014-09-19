
library contrast.ordered_test;

import 'package:unittest/unittest.dart';
import 'package:contrast/contrast.dart';

main() {

  group('isOrdered', () {

    test('should determine whether iterable is ordered', () {
      expect(isOrdered([]), isTrue);
      expect(isOrdered([1]), isTrue);
      expect(isOrdered([1, 2]), isTrue);
      expect(isOrdered([2, 1]), isFalse);
      expect(isOrdered([1, 1]), isTrue);
    });

    test('should use `compare` to compare items', () {
      c(a, b) => 0;
      expect(isOrdered([2, 1], compare: c), isTrue);
    });

  });

  group('isStrictlyOrdered', () {

    test('should determine whether iterable is strictly ordered', () {
      expect(isStrictlyOrdered([]), isTrue);
      expect(isStrictlyOrdered([1]), isTrue);
      expect(isStrictlyOrdered([1, 2]), isTrue);
      expect(isStrictlyOrdered([2, 1]), isFalse);
      expect(isStrictlyOrdered([1, 1]), isFalse);
    });

    test('should use `compare` to compare items', () {
      c(a, b) => 0;
      expect(isStrictlyOrdered([1, 2], compare: c), isFalse);
    });

  });

}

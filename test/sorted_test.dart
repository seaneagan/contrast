
library contrast.sorted_test;

import 'package:unittest/unittest.dart';
import 'package:contrast/contrast.dart';

main() {

  group('sorted', () {

    test('should return a sorted copy', () {
      expect(sorted([2, 1, 3]), [1, 2, 3]);
    });

    test('should respect growable', () {
      expect(() => sorted([2, 1, 3], growable: true).add(4), returnsNormally);
      expect(() => sorted([2, 1, 3], growable: false).add(4), throws);
    });

    test('should use `compare` to compare items', () {
      expect(sorted([2, 1, 3], compare: (a, b) => b.compareTo(a)), [3, 2, 1]);
    });

  });

}

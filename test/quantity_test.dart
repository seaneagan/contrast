
library contrast.quantity_test;

import 'package:unittest/unittest.dart';
import 'package:contrast/contrast.dart';

main() {

  group('Quantity', () {

    test('should correctly implement comparison operators', () {

      testOperator(op(a, b), bool lt, bool eq, bool gt) {
        boolMatcher(bool v) => v ? isTrue : isFalse;
        var one = new TestQuantity(1);
        expect(op(new TestQuantity(0), one), boolMatcher(lt));
        expect(op(new TestQuantity(1), one), boolMatcher(eq));
        expect(op(new TestQuantity(2), one), boolMatcher(gt));
      }

      testOperator((a, b) => a <  b, true,  false, false);
      testOperator((a, b) => a <= b, true,  true,  false);
      testOperator((a, b) => a == b, false, true,  false);
      testOperator((a, b) => a >= b, false, true,  true);
      testOperator((a, b) => a >  b, false, false, true);

    });

  });
}

class TestQuantity extends Object with Quantity<TestQuantity> {

  final int i;

  TestQuantity(this.i);

  int compareTo(TestQuantity other) => i.compareTo(other.i);
}

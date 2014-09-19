
library contrast.all_tests;

import 'extrema_test.dart' as extrema;
import 'comparators_test.dart' as comparators;
import 'ordered_test.dart' as ordered;
import 'quantity_test.dart' as quantity;
import 'sorted_test.dart' as sorted;

main() {
  extrema.main();
  comparators.main();
  ordered.main();
  quantity.main();
  sorted.main();
}

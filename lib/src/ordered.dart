
part of contrast;

/**
 * Tests if [iterable] is in increasing order.
 */
bool isOrdered(
    Iterable iterable,
    {Comparator compare : Comparable.compare}) =>
    _isOrdered(iterable, compare, (v) => v > 0);

/**
 * Tests if [iterable] is in strict increasing order.
 */
bool isStrictlyOrdered(
    Iterable iterable,
    {Comparator compare : Comparable.compare}) =>
  _isOrdered(iterable, compare, (v) => v >= 0);

bool _isOrdered(
    Iterable iterable,
    Comparator compare,
    bool ordered(comaratorResult)) {
  var iterator = iterable.iterator;
  if (iterator.moveNext()) {
    var previous = iterator.current;
    while (iterator.moveNext()) {
      if (ordered(compare(previous, iterator.current))) {
        return false;
      }
      previous = iterator.current;
    }
  }
  return true;
}

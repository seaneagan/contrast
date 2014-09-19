
part of contrast;

/**
 * Returns the minimum of a and b, according to the order specified by
 * [compare].  Returns [a] if `compare(a, b) == 0`.
 */
dynamic min(a, b, {Comparator compare : Comparable.compare}) =>
    compare(a, b) <= 0 ? a : b;

/**
 * Returns the maximum of a and b, according to the order specified by
 * [compare].  Returns [a] if `compare(a, b) == 0`.
 */
dynamic max(a, b, {Comparator compare : Comparable.compare}) =>
    compare(a, b) >= 0 ? a : b;

/**
 * Clamps [value] to be in the range from [lower] to [upper].
 *
 * If [value] is less than [lower], returns [lower].  If [value] is greater than
 * [upper] returns [upper].  Otherwise, returns [value].  Values are compared
 * using [compare].
 */
dynamic clamp(value, lower, upper, {Comparator compare : Comparable.compare}) =>
    min(max(value, lower, compare: compare), upper, compare: compare);

/**
 * Returns whether [value] is in the range from [lower] to [upper].
 *
 * Values are compared using [compare].
 */
bool between(value, lower, upper, {Comparator compare : Comparable.compare}) =>
    !(compare(value, lower) < 0) && !(compare(value, upper) > 0);

/**
 * Returns the minimum value in [iterable].
 *
 * Values in [iterable] are compared using [compare].  If two values compare
 * equal, the earlier is kept as the minimum.  If [iterable] is empty,
 * returns the result of `orElse()`, or `null` if [orElse] is null.
 *
 * If [iterable] is null, an exception will be thrown.
 */
dynamic minOf(
    Iterable iterable,
    {Comparator compare : Comparable.compare,
     orElse()}) {
  var iterator = iterable.iterator;
  if(!iterator.moveNext()) return orElse == null ? null : orElse();
  var value = iterator.current;
  while (iterator.moveNext()) {
    value = min(value, iterator.current, compare: compare);
  }
  return value;
}

/**
 * Returns the maximum value in [iterable].
 *
 * Values in [iterable] are compared using [compare].  If two values compare
 * equal, the earlier is kept as the maximum.  If [iterable] is empty,
 * returns the result of `orElse()`, or `null` if [orElse] is null.
 *
 * If [iterable] is null, an exception will be thrown.
 */
dynamic maxOf(
    Iterable iterable,
    {Comparator compare : Comparable.compare,
     orElse()}) {
    var iterator = iterable.iterator;
    if(!iterator.moveNext()) return orElse == null ? null : orElse();
    var value = iterator.current;
    while (iterator.moveNext()) {
      value = max(value, iterator.current, compare: compare);
    }
    return value;
}

part of contrast;

/**
 * Returns a comparator that compares the result of calling [key] on the
 * items being compared.
 *
 * Example:
 *     ['Bob', 'alice', 'Alice']
 *         ..sort(by((s) => s.toLowerCase())); // alice, Alice, Bob
 */
Comparator by(
    key(e),
    [Comparator compare = Comparable.compare]) => (a, b) =>
        compare(key(a), key(b));

/**
 * Returns a comparator which returns the first non-zero result from
 * [comparators], or zero.
 *
 * If [comparators] is empty, throws an ArgumentError.
 *
 * Example:
 *     [{'id': 5, 'name': 'foo'}, {'id': 2, 'name': 'foo'}]..sort(compound(
 *            [by((m) => m['name']), by((m) => m['id'])]));
 *
 *            // {'id': 2, 'name': 'foo'}, {'id': 5, 'name': 'foo'}]
 */
Comparator compound(Iterable<Comparator> comparators) {
  if(comparators.isEmpty) {
    throw new ArgumentError('comparator must not be empty');
  }
  return (a, b) =>
      comparators.map((c) => c(a, b)).firstWhere((v) => v != 0,
          orElse: () => 0);
}

/**
 * Returns a comparator that reverses the order specified by [compare].
 *
 * Example:
 *     [1, 2, 0]..sort(reverse()); // 2, 1, 0
 */
Comparator reverse(
    [Comparator compare = Comparable.compare]) => (a, b) =>
        compare(b, a);

/**
 * Returns a comparator that orders iterables by comparing corresponding
 * elements pairwise until a nonzero result is found. If the end of one iterable
 * is reached, but not the other, the shorter iterable is considered to be less
 * than the longer one.
 *
 * Example:
 *     [[0, 2], [0, 1]]..sort(lexicographic()); // [[0, 1], [0, 2]]
 */
Comparator<Iterable> lexicographic(
    [Comparator compare = Comparable.compare]) => (Iterable a, Iterable b) {

  var aIterator = a.iterator;
  var bIterator = b.iterator;

  while(true) {
    var aDone = !aIterator.moveNext();
    var bDone = !bIterator.moveNext();
    if(aDone && bDone) return 0;
    if(aDone) return -1;
    if(bDone) return 1;
    var v = compare(aIterator.current, bIterator.current);
    if(v != 0) return v;
  }
};

/**
 * Returns a comparator that orders `null` values before non-null values.
 *
 * Example:
 *     [2, null, 1]..sort(nullsFirst()); // null, 1, 2
 */
Comparator nullsFirst([Comparator compare = Comparable.compare]) => (a, b) {
  if (a == null && b == null) return 0;
  if (a == null) return -1;
  if (b == null) return 1;
  return compare(a, b);
};

/**
 * Returns a comparator that orders `null` values after non-null values.
 *
 * Example:
 *     [2, null, 1]..sort(nullsLast()); // 1, 2, null
 */
Comparator nullsLast([Comparator compare = Comparable.compare]) => (a, b) {
  if (a == null && b == null) return 0;
  if (a == null) return 1;
  if (b == null) return -1;
  return compare(a, b);
};

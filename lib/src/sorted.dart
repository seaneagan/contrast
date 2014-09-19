
part of contrast;

/**
 * Returns a sorted copy of [iterable].
*/
List sorted(
    Iterable iterable,
    {Comparator compare : Comparable.compare,
     bool growable : true}) =>
    new List.from(iterable, growable: growable)..sort(compare);

contrast
=======

[![Build Status](https://drone.io/github.com/seaneagan/contrast/status.png)](https://drone.io/github.com/seaneagan/contrast/latest)

Utilities for comparing (and contrasting) dart values:

* Comparator combinators (by/compound/reverse/lexicographic/nullsFirst/nullsLast)
* Comparison operator mixin (Quantity)(<, <=, ==, >, >=)
* Find extrema of Comparables and Iterables (min/max/minOf/maxOf)
* Test and obtain clamped comparables (clamp/between)
* Test and obtain sorted iterables (sorted/isOrdered/isStrictlyOrdered)

#Example

```dart

import 'package:contrast/contrast.dart';
import 'dart:math' as math;

main() {
  
  // Easily define comparison operators (see Point class below).
  assert(Point.ZERO < Point.UNIT);
  assert(Point.UNIT >= Point.ZERO);
  assert(Point.ZERO == new Point(0, 0));

  // Find extrema of arbitrary comparables.
  // (dart:math's min/max only work with numbers)
  assert(min(Point.ZERO, Point.UNIT) == Point.ZERO);
  assert(max(Point.ZERO, Point.UNIT) == Point.UNIT);
  assert(clamp(new Point(1, 2), Point.ZERO, Point.UNIT) == Point.UNIT);
  assert(between(new Point(0.5, 0.5), Point.ZERO, Point.UNIT));
  
  // Find extrema of iterables.
  var points = [Point.UNIT, new Point(1, 2), Point.ZERO, new Point(0, 1)];
  assert(minOf(points) == Point.ZERO);
  assert(maxOf(points) == new Point(1, 2));
  
  // Sort into a new List easily ( vs. iterable.toList()..sort() ).
  var sortedPoints = sorted(points);
  
  // Check ordering of iterables.
  assert(isOrdered(sortedPoints));
  assert(isStrictlyOrdered(sortedPoints));

  // Define comparators using combinator helpers...
  
  // By key function
  var byMagnitude = by((point) => point.magnitude);
  assert(max(Point.ZERO, new Point(-1, -1), 
      compare: byMagnitude) == new Point(-1, -1));
  
  // Compound
  assert(max(Point.ZERO, new Point(-1, -1), 
      compare: compound([byMagnitude, Comparable.compare])) == new Point(-1, -1));
  
  // Reversed
  assert(max(Point.ZERO, Point.UNIT, compare: reverse()) == Point.ZERO);

  // Lexicographic
  assert(min([Point.ZERO, Point.UNIT], [Point.ZERO, new Point(2, 2)], 
      compare: lexicographic()).last == Point.UNIT);
  
  // Null safe
  var maybePoints = [Point.UNIT, null, Point.ZERO, null];
  assert(sorted(maybePoints, compare: nullsFirst()).first == null);
  assert(sorted(maybePoints, compare: nullsLast()).last == null);
}

// Mixin `Comparable`-based comparison operators with `Quantity`.
class Point extends Object with Quantity<Point> {
  
  static Point ZERO = new Point(0, 0);
  static Point UNIT = new Point(1, 1);
  
  final num x, y;
  
  num get magnitude => math.sqrt(x*x + y*y);
  
  Point(this.x, this.y);
  
  // Use comparator combinators`compound` and `by`.
  static final _comparator = compound([by((p) => p.x), by((p) => p.y)]);
  
  int compareTo(Point other) => _comparator(this, other);
  
  toString() => '($x, $y)';
}
```

part of contrast;

/// A mixin to add comparison operators to classes which implement 
/// [Comparable].
abstract class Quantity<T> implements Comparable<T> {
  bool operator < (T other) => compareTo(other) < 0;
  bool operator <= (T other) => compareTo(other) <= 0;
  bool operator > (T other) => compareTo(other) > 0;
  bool operator >= (T other) => compareTo(other) >= 0;
  bool operator == (T other) => compareTo(other) == 0;
}

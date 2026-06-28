module main

fn compare[T](a T, b T) int {
    if a < b { return -1 }
    if a > b { return 1 }
    return 0
}

fn main() {
  // Usage: Type inference works automatically
  println(compare(1, 0))       // T inferred as int
  println(compare("a", "b"))   // T inferred as string

  // Explicit type specification is also possible
  println(compare[int](1, 0))
  return
}
struct Optional[T] {
    value T
    is_defined bool = true
}

// Receiver must be Optional[T]
fn (o Optional[T]) or_else(default T) T {
    if o.is_defined {
        return o.value
    }
    return default
}

fn main() {
  // Usage
  op := Optional[string]{ is_defined: false }
  println(op.or_else("default")) // `default` because `is_defined` is `false`.
  return
}
struct Optional[T] {
    value T
    is_defined bool = true
}

fn main() {
  // now it requires explicit type
  op1 := Optional[int]{ value: 10 }
  op2 := Optional[string]{ value: "hello" }
  println("${op1} \n${op2}") // awsome
  return
}
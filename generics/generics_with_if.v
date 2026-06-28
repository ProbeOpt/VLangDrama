fn myprintln[T](data T) {
    $if T is $array {
        println("array: [")
        for i, elem in data {
            myprintln(elem)
            if i < data.len - 1 { print(", ") }
            println("")
        }
        println("]")
    } $else {
        println(data)
    }
}

fn main() {
  myprintln([1, 2, 3]) // Now this is what we call: `best`
  myprintln("hello")
  return
}
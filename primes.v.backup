import math { log }

// now this is a new idea, nice!
// and even nicer, the `or` syntax is fireeeeeeee......
n := arguments()[1] or { '10' }.int()

sz := if n < 15 {
	50
} else {
	ln := log(f64(n))
	int(f64(n) * (ln + log(ln))) + 1
}

mut sieve := []bool{len: sz}
for i := 2; i * i < sz; i++ {
	if !sieve[i] {
		for j := i * i; j < sz; j += i {
			sieve[j] = true
		}
	}
}

// overall, very nice.
mut c := 0
for i := 2; c < n && i < sz; i++ {
	if !sieve[i] {
		println(i)
		c++
	}
}
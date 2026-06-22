// lets implement BYTE-PAIR-ENCODING.

fn split_fixed_length(s string, n int) []string {
    if n <= 0 {
        return []string{}
    }

    mut result := []string{}
    mut i := 0

    for i < s.len {
        // Calculate the end index, ensuring it doesn't exceed string length
        end := if i + n > s.len { s.len } else { i + n }
        result << s.substr(i, end)
        i += n
    }

    return result
}

struct KV {
	key   string
	value int
}

// sort_map_by_value returns a sorted slice of KV structs
fn sort_map_by_value(m map[string]int, desc bool) []KV {
	// 1. Convert map to slice
	mut pairs := []KV{cap: m.len}
	for k, v in m {
		pairs << KV{k, v}
	}

	// 2. Sort based on 'desc' flag
	if desc {
		// Descending order (highest value first)
		pairs.sort(a.value > b.value)
	} else {
		// Ascending order (lowest value first)
		pairs.sort(a.value < b.value)
	}

	return pairs
}

// Helper function to match your previous logic
fn get_new_ident(ident_i int) (string, int) {
    alphabet := "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()`~{}[]:;'/\?<>,.|"

    if ident_i <= 0 || ident_i > alphabet.len {
        return '', 0
    }

    // V strings are byte arrays.
    // ident_i is 1-based, so index is ident_i - 1
    return alphabet[ident_i - 1].ascii_str(), 1
}

fn build_compression_map(bytepairs []string, _compressed string) string {
    mut compressed := _compressed
    mut ref_table := map[string]int{}

    for x in bytepairs {
        if ref_table[x] != 0 {
            ref_table[x] += 1
        } else {
            ref_table[x] = 1
        }
    }

    pairs := sort_map_by_value(ref_table, true)

    for i, pair in pairs {
        // i is count and pair is bytepair.
        // get_new_ident returns (string, int)
        if pair.value > 1 { // only do if pair occurrences are more then 1.
            ident, success := get_new_ident(i + 1) // +1 because i is 0-indexed but our logic might expect 1-based

            if success == 0 {
                break // Stop if we run out of characters (e.g., > 26)
            }

            println("${pair.key} -> ${ident} (which occurred ${pair.value} times.)")

            compressed = compressed.replace(pair.key, ident)
        } else {
            println("skipping: ${pair.key} (which occurred only ${pair.value} time.)")
        }
    }

    return compressed
}

fn main() {
    original := "The quick brown fox jumps over the lazy dog. This is a sample text for training a Markov chain model. Markov chains are useful for predicting the next token based on the previous one. In a simple language model, we can use word transitions to generate new text that resembles the training data. Hello world from Odin programming language. This is fun and educational. Let's see what the model generates next. The model learns patterns from the training data to predict likely next words.".to_lower()
    mut compressed := original
    // get pairs of bytes.
    // test: test := original.split("") // god! I love v language!

    mut bytepairs :=  split_fixed_length(original, 2)

    // test: yay, v lang is the best.....
    // for x in bytepairs {
    //     println(x) // Th \n e  \n qu
    // }

    compressed = build_compression_map(bytepairs, compressed)

    orig_len := f64(original.len)
    comp_len := f64(compressed.len)
    percent := ((orig_len/comp_len) * 100.0) - f64(100)
    println("# total compressed percentage: ${original.len}/${compressed.len} => ${percent}%")
    println("\n## before: ${original}\n## after: ${compressed}")
    return
}
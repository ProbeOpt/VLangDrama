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

fn get_new_ident(ident_i int) (string, int) {
    // v-lang's' strings are indexable directly, cool. But let's be safe with runes if we want characters.
    ident_str := "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    // Check bounds first, to make sure this does not crash.
    if ident_i == 0 {
        return '', 0
    }

    if ident_i > ident_str.len {
        return '', 0
    }

    to_char_ed := ident_str[ident_i - 1]

    return to_char_ed.str(), 1
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

    mut ref_table := map[string]int{}

    for x in bytepairs {
        if ref_table[x] != 0 {
            ref_table[x] += 1
        } else {
            ref_table[x] = 1
        }
    }

    sorted_bps := sort_map_by_value(ref_table, true)

    // test: really, cool, dude! THIS IS REALLY BETTER THEN GO!!!!!!
    // for x, y in sorted_bps {
    //     println("${x} -> ${y}")
    // }

    // test: println(get_new_ident(3))

    for x in 0..sorted_bps.len {
        ident, y := get_new_ident(x)
        bp := sorted_bps[x]
        if y != 0 {
            println("${bp.key} -> ${ident}")
            compressed.replace(bp.key, ident)
        } else {
            break
        }
    }

    println(compressed)

    return
}
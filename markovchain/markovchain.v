module main

import os
import x.json2
import rand

pub struct Markov {
    pub mut:
        model_path string
        model_data json2.Any
}

pub fn (mut markov Markov) load_model(model_path string) {
    json_text := os.read_file(model_path) or {
        eprintln("Error reading file: ${err}")
        return
    }
    root := json2.decode[json2.Any](json_text) or {
        eprintln("Failed to decode JSON: ${err}")
        return
    }
    data := root.as_map()

    // data is f type: map[string]map[string]f64
    /*
    for key, value in data {
        inner_map := value.as_map()

        println("Word: ${key}")
        for next_word, prob_any in inner_map {
            prob := prob_any.f64()
            println("  -> ${next_word}: ${prob}")
        }
    }
    */
    markov.model_data = data
}

fn (markov Markov) get_next_tok(current_tok string) map[string]f64 {
    	mut total_prob := map[string]f64{}

    	for word, value in markov.model_data.as_map() {
        		if word == current_tok {
            			inner_map := value.as_map()
            			for prob_wat, prob_page in inner_map {
                				total_prob[prob_wat] = prob_page.f64()
            			}
            			// because tokens are unique keys, so, we can break early if found, (i think)
            			break
        		}
    	}
    	return total_prob
}

fn pick_weighted(probs map[string]f64) string {
    	if probs.len == 0 {
        		return "" // fallback
    	}

    	// how to calculate total weight?
    	mut total_weight := 0.0
    	for _, w in probs {
        		total_weight += w // not the fastest, but an easy option.
    	}

    	if total_weight == 0.0 {
        		return ""
    	}

    	// lets generate random number between 0 and total_weight to select next tok, randomely.
    	r := rand.f64() * total_weight
    	mut cumulative := 0.0

    	for token, weight in probs {
        		cumulative += weight
        		if r <= cumulative {
        			return token
        		}
    	}

    	// fallback, unreachable.
    	return probs.keys()[0]
}

pub fn (markov Markov) predict(prompt string, max_tok int) ([]string, string) {
    	dprompt := prompt.to_lower().split(" ")

    	if dprompt.len == 0 {
        		return []string{}, "err: prompt has no tokens? strange. Btw, this is an error."
    	}

    	mut current_tok := dprompt[dprompt.len - 1]
    	mut result := []string{}

    	for _ in 0..max_tok {
        		probs := markov.get_next_tok(current_tok)

        		if probs.len == 0 {
        			    break // sadly, no next token found, so we stop generation process.
        		}

        		next_tok := pick_weighted(probs)

        		if next_tok == "" {
            			break
        		}

        		result << next_tok // i dint like `<<` they look like bitops, but do completely different thing.
        		current_tok = next_tok
    	}

    	return result, ""
}

fn main() {
    mut model := Markov{}
    model.load_model("./v1.json")
    ans, err := model.predict("The", 200)
    if err != "" {
        println("err: ${err}")
        return
    }

    println(ans)
}
// an example crafted by someone idk.
// edited by me..

// net.http - todo: read examples.
import net.http
import x.json2 // I dont

struct Payload {
	title string
	body  string
	userid int
}

struct Response {
	title string
	body  string
	userid int
	id   int
}

fn main() {
	data := Payload{
		title: "foo"
		body:  "bar"
		userid: 1
	}

 // this is cool, atleast better in go, this is anathor reason why v is better then go.
	json_data := json2.encode(data)

	headers := http.new_header_from_map({
		http.CommonHeader.content_type: "application/json"
	})

 // why cant we just use .post()?, its still okay.
	conf := http.FetchConfig{
		method: .post
		url:    "https://jsonplaceholder.typicode.com/posts"
		header: headers
		data:   json_data
	}

	resp := http.fetch(conf) or {
		println("Request failed: ${err}")
		return
	}

 // this describes the level of awsome-ness in v-lang, love you v-devs.
	result := json2.decode[Response](resp.body) or {
		println("json decode operation failed: ${err}")
		return
	}

	println("status: ${resp.status_code}")
	println("created post with id: ${result.id}")
	println("title: ${result.title}")
}
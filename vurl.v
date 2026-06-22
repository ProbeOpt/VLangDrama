// lets try to implement `curl` in v-lang as `vurl`.
import net.http
import json

fn main() {
    mut headers := http.Header{}
    headers.set('Content-Type', 'application/json')

    body := json.stringify({'key': 'value'})
    resp := http.post('https://api.example.com/data', body, headers)

    println(resp.str())
}
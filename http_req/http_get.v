import net.http

fn main() {
    resp := http.get('https://vlang.io') or {
        println('Error: ${err}')
        return
    }
    println("GOT HTML: ${resp.body}")
}
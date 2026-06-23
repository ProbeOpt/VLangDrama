// lets try to implement `curl` in v-lang as `vurl`.
import net.http

fn usage(name string) {
    println("Usage: ${name} <url> [OPTIONS]")
    println("[OPTIONS]:")
    println("\t--headers (currently non functional.)")
    println("\t--body (currently non functional.)")
}

fn main() {
    url := arguments()[1] or {
        usage(arguments()[0])
        return
    }
    resp := http.get(url) or {
        println('Error: ${err}')
        return
    }
    println("GOT HTML: ${resp.body}")
}
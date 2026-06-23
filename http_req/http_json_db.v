import net.http
import x.json2

struct Product {
	id          int
	name        string
	year        int
	color       string
}

// why still do i need a wrapper? not-cool man.
struct ProductResponse {
	data Product
}

fn main() {
 // this is as easy as it can get, totally 10/10.
	resp := http.get("https://reqres.in/api/products/1") or {
		println("Error fetching data: ${err}")
		return
	}

 // thank you god.
	product := json2.decode[ProductResponse](resp.body) or {
		println("Error decoding JSON: ${err}")
		return
	}
 // this deos not work for some reason, nevermind, will debug later.
	println("product: ${product.data.name} (${product.data.color})")
	println("id: ${product.data.id}, | year: ${product.data.year}")
}
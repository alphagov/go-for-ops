provider "todo" { 

  host = "localhost:9001"
}

resource "todo_item" "one" {
  description = "hello"
}

package main

import (
	"log"

	"github.com/rojanmagar2001/gosocial/internal/db"
	"github.com/rojanmagar2001/gosocial/internal/env"
	"github.com/rojanmagar2001/gosocial/internal/store"
)

func main() {
	addr := env.GetString("DB_ADDR", "postgres://admin:password@localhost/social?sslmode=disable")

	conn, err := db.New(addr, 3, 3, "15m")
	if err != nil {
		log.Fatal(err)
	}

	defer conn.Close()

	store := store.NewStorage(conn)

	db.Seed(store)
}

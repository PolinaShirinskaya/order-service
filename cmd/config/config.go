package config

import (
	"os"
)

func ConfigSetup() {
	os.Setenv("user", "polinashirinskaya")
	os.Setenv("password", "123")
	os.Setenv("dbname", "wb_L0")
	os.Setenv("sslmode", "disable")
	os.Setenv("CACHE_SIZE", "10")
	os.Setenv("APP_KEY", "WB-1")
}

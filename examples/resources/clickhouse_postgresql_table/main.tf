terraform {
  required_providers {
    clickhouse = {
      version = "0.0.15"
      source  = "registry.terraform.io/fox052-byte/clickhouse"
    }
  }
}

provider "clickhouse" {
  port = 8123
}

resource "clickhouse_db" "test_db" {
  name    = "test_db"
  comment = "Test database for PostgreSQL tables"
}

# PostgreSQL external table example
resource "clickhouse_postgresql_table" "external_table" {
  database = clickhouse_db.test_db.name
  name     = "external_users"

  # PostgreSQL engine params: [host:port, database, table, user, password, schema]
  engine_params = [
    "'postgresql-server:5432'",
    "'postgres_db'",
    "'users'",
    "'postgres_user'",
    "'postgres_password'",
    "'public'"
  ]

  column {
    name = "id"
    type = "Int32"
  }

  column {
    name = "name"
    type = "String"
  }

  column {
    name = "email"
    type = "Nullable(String)"
  }

  column {
    name = "created_at"
    type = "Nullable(DateTime)"
  }

  comment = "External table from PostgreSQL database"
}


# Create PostgreSQL database

Create a new PostgreSQL database.

## Usage

``` r
sbfx_create_pg(
  dbname,
  config_path = getOption("psql.config_path", NULL),
  config_value = getOption("psql.config_value", "default")
)
```

## Arguments

- dbname:

  A string of the name of the new database to create.

- config_path:

  A string of a file path to the yaml configuration file. The default
  value grabs the file path from the psql.config_path option and uses
  `NULL` if no value supplied.

- config_value:

  A string of the name of value. The default value grabs the value from
  the psql.config_value option and uses `"default"` if no value is
  supplied.

## Value

TRUE (or errors).

## Details

Wrapper on
[`psql::psql_create_db()`](https://rdrr.io/pkg/psql/man/psql_create_db.html).

## See also

Other postgresql functions:
[`sbfx_backup_pg()`](https://poissonconsulting.github.io/subfoldr2ext/reference/sbfx_backup_pg.md),
[`sbfx_close_pg()`](https://poissonconsulting.github.io/subfoldr2ext/reference/sbfx_close_pg.md),
[`sbfx_execute_pg()`](https://poissonconsulting.github.io/subfoldr2ext/reference/sbfx_execute_pg.md),
[`sbfx_get_config_file()`](https://poissonconsulting.github.io/subfoldr2ext/reference/sbfx_get_config_file.md),
[`sbfx_get_config_value()`](https://poissonconsulting.github.io/subfoldr2ext/reference/sbfx_get_config_value.md),
[`sbfx_get_schema()`](https://poissonconsulting.github.io/subfoldr2ext/reference/sbfx_get_schema.md),
[`sbfx_list_tables_pg()`](https://poissonconsulting.github.io/subfoldr2ext/reference/sbfx_list_tables_pg.md),
[`sbfx_load_data_from_pg()`](https://poissonconsulting.github.io/subfoldr2ext/reference/sbfx_load_data_from_pg.md),
[`sbfx_load_datas_from_pg()`](https://poissonconsulting.github.io/subfoldr2ext/reference/sbfx_load_datas_from_pg.md),
[`sbfx_open_pg()`](https://poissonconsulting.github.io/subfoldr2ext/reference/sbfx_open_pg.md),
[`sbfx_reset_config_file()`](https://poissonconsulting.github.io/subfoldr2ext/reference/sbfx_reset_config_file.md),
[`sbfx_reset_config_value()`](https://poissonconsulting.github.io/subfoldr2ext/reference/sbfx_reset_config_value.md),
[`sbfx_reset_schema()`](https://poissonconsulting.github.io/subfoldr2ext/reference/sbfx_reset_schema.md),
[`sbfx_save_data_to_pg()`](https://poissonconsulting.github.io/subfoldr2ext/reference/sbfx_save_data_to_pg.md),
[`sbfx_set_config_file()`](https://poissonconsulting.github.io/subfoldr2ext/reference/sbfx_set_config_file.md),
[`sbfx_set_config_value()`](https://poissonconsulting.github.io/subfoldr2ext/reference/sbfx_set_config_value.md),
[`sbfx_set_schema()`](https://poissonconsulting.github.io/subfoldr2ext/reference/sbfx_set_schema.md)

## Examples

``` r
if (FALSE) { # \dontrun{
sbfx_create_pg("new_database")
sbfx_create_pg("new_database", config_path = "keys/config.yml")
} # }
```

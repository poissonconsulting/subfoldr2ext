# Execute PostgreSQL statements

Execute SQL statement for PostgreSQL database.

## Usage

``` r
sbfx_execute_pg(
  sql,
  config_path = getOption("psql.config_path", NULL),
  config_value = getOption("psql.config_value", "default")
)
```

## Arguments

- sql:

  A string of the SQL statement to execute.

- config_path:

  A string of a file path to the yaml configuration file. The default
  value grabs the file path from the psql.config_path option and uses
  `NULL` if no value supplied.

- config_value:

  A string of the name of value. The default value grabs the value from
  the psql.config_value option and uses `"default"` if no value is
  supplied.

## Value

A scalar numeric of the number of rows affected by the statement.

## Details

Wrapper on
[`psql::psql_execute_db()`](https://rdrr.io/pkg/psql/man/psql_execute_db.html).

## See also

Other postgresql functions:
[`sbfx_backup_pg()`](https://poissonconsulting.github.io/subfoldr2ext/reference/sbfx_backup_pg.md),
[`sbfx_close_pg()`](https://poissonconsulting.github.io/subfoldr2ext/reference/sbfx_close_pg.md),
[`sbfx_create_pg()`](https://poissonconsulting.github.io/subfoldr2ext/reference/sbfx_create_pg.md),
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
sbfx_execute_pg("CREATE SCHEMA boat_count")

sbfx_execute_pg(
  "CREATE TABLE boat_count.input (
  file_name TEXT NOT NULL,
  comment TEXT)"
)
} # }
```

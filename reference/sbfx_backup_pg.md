# Save PostgreSQL backup

Save a copy of your database in plain text format. This saves all SQL
code to recreate the structure and data.

## Usage

``` r
sbfx_backup_pg(
  db_dump_name = subfoldr2::sbf_get_db_name(),
  sub = subfoldr2::sbf_get_sub(),
  main = subfoldr2::sbf_get_main(),
  config_path = getOption("psql.config_path", NULL),
  config_value = getOption("psql.config_value", "default")
)
```

## Arguments

- db_dump_name:

  A string of the name for the database backup file.

- sub:

  A string specifying the path to the sub folder (by default the current
  sub folder).

- main:

  A string specifying the path to the main folder (by default the
  current main folder)

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
[`psql::psql_backup()`](https://rdrr.io/pkg/psql/man/psql_backup.html).

## See also

Other postgresql functions:
[`sbfx_close_pg()`](https://poissonconsulting.github.io/subfoldr2ext/reference/sbfx_close_pg.md),
[`sbfx_create_pg()`](https://poissonconsulting.github.io/subfoldr2ext/reference/sbfx_create_pg.md),
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
sbfx_backup_pg()
sbfx_backup_pg("database-22")
} # }
```

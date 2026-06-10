# Add data frame to PostgreSQL database

Add data in a data frame to your PostgreSQL database. The data frame
name must match the table name in your database, if not use the
`tbl_name` argument to pass the table name.

## Usage

``` r
sbfx_save_data_to_pg(
  x,
  x_name = NULL,
  schema = getOption("psql.schema", "public"),
  config_path = getOption("psql.config_path", NULL),
  config_value = getOption("psql.config_value", "default")
)
```

## Arguments

- x:

  The data frame to save.

- x_name:

  A string of the name.

- schema:

  A string of the schema name. Default value is `"public"`.

- config_path:

  A string of a file path to the yaml configuration file. The default
  value grabs the file path from the psql.config_path option and uses
  `NULL` if no value supplied.

- config_value:

  A string of the name of value. The default value grabs the value from
  the psql.config_value option and uses `"default"` if no value is
  supplied.

## Value

A scalar numeric.

## Details

Wrapper on
[`psql::psql_add_data()`](https://rdrr.io/pkg/psql/man/psql_add_data.html).

## See also

Other postgresql functions:
[`sbfx_backup_pg()`](https://poissonconsulting.github.io/subfoldr2ext/reference/sbfx_backup_pg.md),
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
[`sbfx_set_config_file()`](https://poissonconsulting.github.io/subfoldr2ext/reference/sbfx_set_config_file.md),
[`sbfx_set_config_value()`](https://poissonconsulting.github.io/subfoldr2ext/reference/sbfx_set_config_value.md),
[`sbfx_set_schema()`](https://poissonconsulting.github.io/subfoldr2ext/reference/sbfx_set_schema.md)

Other save functions:
[`sbfx_save_aws_files()`](https://poissonconsulting.github.io/subfoldr2ext/reference/sbfx_save_aws_files.md)

## Examples

``` r
if (FALSE) { # \dontrun{
sbfx_save_data_to_pg(outing, "creel")
sbfx_save_data_to_pg(outing_new, "creel", "outing")
} # }
```

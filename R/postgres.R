#' Open PostgreSQL connection
#'
#' Connect to a PostgreSQL database with a config.yml file.
#'
#' @inheritParams psql::psql_connect
#' @return An S4 object that inherits from DBIConnection.
#'
#' @export
#' @details Wrapper on `psql::psql_connect()`.
#' @family postgresql functions
#'
#' @examples
#' \dontrun{
#' conn <- sbfx_open_pg()
#' sbfx_close_pg(conn)
#'
#' sbfx_open_pg("config.yml")
#' sbfx_close_pg(conn)
#'
#' sbfx_open_pg(config_path = "config.yml", config_value = "database")
#' sbfx_close_pg(conn)
#' }
sbfx_open_pg <- function(config_path = getOption("psql.config_path", NULL),
                         config_value = getOption("psql.config_value", "default")) {
  conn <- psql::psql_connect(
    config_path = config_path,
    config_value = config_value
  )
}

#' Close PostgreSQL connection
#'
#' Close the PostgreSQL connection when you are done using a database.
#'
#' @inheritParams DBI::dbDisconnect
#' @return TRUE (or errors).
#'
#' @export
#' @details Wrapper on `DBI::dbDisconnect()`. It is important to remember to
#'   close connections or your database performance can decrease over time.
#' @family postgresql functions
#'
#' @examples
#' \dontrun{
#' conn <- sbfx_open_pg()
#' sbfx_close_pg(conn)
#' }
sbfx_close_pg <- function(conn) {
  DBI::dbDisconnect(conn = conn)
  TRUE
}

#' Save PostgreSQL backup
#'
#' Save a copy of your database in plain text format. This saves all SQL code to
#' recreate the structure and data.
#'
#' @inheritParams psql::psql_backup
#' @inheritParams subfoldr2::sbf_save_object
#' @param db_dump_name A string of the name for the database backup file.
#' @return TRUE (or errors).
#'
#' @export
#' @details Wrapper on `psql::psql_backup()`.
#' @family postgresql functions
#'
#' @examples
#' \dontrun{
#' sbfx_backup_pg()
#' sbfx_backup_pg("database-22")
#' }
sbfx_backup_pg <- function(db_dump_name = subfoldr2::sbf_get_db_name(),
                           sub = subfoldr2::sbf_get_sub(),
                           main = subfoldr2::sbf_get_main(),
                           config_path = getOption("psql.config_path", NULL),
                           config_value = getOption("psql.config_value", "default")) {
  path <- file_name(main, "dbs", sub, db_dump_name, ext = "sql")
  psql::psql_backup(
    path = path,
    config_path = config_path,
    config_value = config_value
  )
}

#' Create PostgreSQL database
#'
#' Create a new PostgreSQL database.
#'
#' @inheritParams psql::psql_create_db
#' @return TRUE (or errors).
#'
#' @export
#' @details Wrapper on `psql::psql_create_db()`.
#' @family postgresql functions
#'
#' @examples
#' \dontrun{
#' sbfx_create_pg("new_database")
#' sbfx_create_pg("new_database", config_path = "keys/config.yml")
#' }
sbfx_create_pg <- function(dbname,
                           config_path = getOption("psql.config_path", NULL),
                           config_value = getOption("psql.config_value", "default")) {
  psql::psql_create_db(
    dbname = dbname,
    config_path = config_path,
    config_value = config_value
  )
}

#' Execute PostgreSQL statements
#'
#' Execute SQL statement for PostgreSQL database.
#'
#' @inheritParams psql::psql_execute_db
#' @return A scalar numeric of the number of rows affected by the statement.
#'
#' @export
#' @details Wrapper on `psql::psql_execute_db()`.
#' @family postgresql functions
#'
#' @examples
#' \dontrun{
#' sbfx_execute_pg("CREATE SCHEMA boat_count")
#'
#' sbfx_execute_pg(
#'   "CREATE TABLE boat_count.input (
#'   file_name TEXT NOT NULL,
#'   comment TEXT)"
#' )
#' }
sbfx_execute_pg <- function(sql,
                            config_path = getOption("psql.config_path", NULL),
                            config_value = getOption("psql.config_value", "default")) {
  psql::psql_execute_db(
    sql = sql,
    config_path = config_path,
    config_value = config_value
  )
}

#' List tables in a schema
#'
#' This function lists all the tables in a schema.
#'
#' @inheritParams psql::psql_list_tables
#' @return A vector of table names.
#'
#' @export
#' @details Wrapper on `psql::psql_list_tables()`.
#' @family postgresql functions
#'
#' @examples
#' \dontrun{
#' sbfx_list_tables_pg()
#' sbfx_list_tables_pg("boat_count")
#' }
sbfx_list_tables_pg <- function(schema = getOption("psql.schema", "public"),
                                config_path = getOption("psql.config_path", NULL),
                                config_value = getOption("psql.config_value", "default")) {
  psql::psql_list_tables(
    schema = schema,
    config_path = config_path,
    config_value = config_value
  )
}

#' Load a table from a PostgreSQL database
#'
#' Load a table from a PostgreSQL database into R as a data frame.
#'
#' @inheritParams psql::psql_read_table
#' @param x A string of the table name.
#' @return A data frame.
#'
#' @export
#' @details Wrapper on `psql::psql_read_table()`.
#' @family postgresql functions
#' @family load functions
#'
#' @examples
#' \dontrun{
#' sbfx_load_data_from_pg("capture")
#' sbfx_load_data_from_pg("counts", "boat_count")
#' }
sbfx_load_data_from_pg <- function(x,
                                   schema = getOption("psql.schema", "public"),
                                   config_path = getOption("psql.config_path", NULL),
                                   config_value = getOption("psql.config_value", "default")) {
  psql::psql_read_table(
    tbl_name = x,
    schema = schema,
    config_path = config_path,
    config_value = config_value
  )
}

#' Load data frames from a PostgreSQL database
#'
#' Load all the tables in a PostgreSQL database schema into R as data frames.
#'
#' @inheritParams subfoldr2::sbf_load_objects
#' @inheritParams psql::psql_list_tables
#' @return An invisible character vector of the paths to the saved objects.
#'
#' @export
#' @family postgresql functions
#' @family load functions
#'
#' @examples
#' \dontrun{
#' sbfx_load_datas_from_pg()
#' sbfx_load_datas_from_pg(schema = "capture")
#' sbfx_load_datas_from_pg(rename = toupper)
#' }
sbfx_load_datas_from_pg <- function(schema = getOption("psql.schema", "public"),
                                    rename = identity,
                                    env = parent.frame(),
                                    config_path = getOption("psql.config_path", NULL),
                                    config_value = getOption("psql.config_value", "default")) {
  chk::chk_s3_class(env, "environment")
  chk::chk_function(rename)

  tbl_names <- psql::psql_list_tables(
    schema = schema,
    config_path = config_path,
    config_value = config_value
  )
  datas <- lapply(
    tbl_names,
    psql::psql_read_table,
    schema = schema,
    config_path = config_path,
    config_value = config_value
  )
  names(datas) <- tbl_names
  names(datas) <- rename(names(datas))
  mapply(assign, names(datas), datas, MoreArgs = list(envir = env))
  invisible(names(datas))
}

#' Add data frame to PostgreSQL database
#'
#' Add data in a data frame to your PostgreSQL database. The data frame name
#' must match the table name in your database, if not use the `tbl_name`
#' argument to pass the table name.
#'
#' @inheritParams psql::psql_add_data
#' @inheritParams subfoldr2::sbf_save_data
#' @return A scalar numeric.
#'
#' @export
#' @details Wrapper on `psql::psql_add_data()`.
#' @family postgresql functions
#' @family save functions
#'
#' @examples
#' \dontrun{
#' sbfx_save_data_to_pg(outing, "creel")
#' sbfx_save_data_to_pg(outing_new, "creel", "outing")
#' }
sbfx_save_data_to_pg <- function(x,
                                 x_name = NULL,
                                 schema = getOption("psql.schema", "public"),
                                 config_path = getOption("psql.config_path", NULL),
                                 config_value = getOption("psql.config_value", "default")) {
  if (is.null(x_name)) x_name <- deparse(substitute(x))
  psql::psql_add_data(
    tbl = x,
    schema = schema,
    tbl_name = x_name,
    config_path = config_path,
    config_value = config_value
  )
}

#' Set schema name
#'
#' @param schema A string of the schema name. Default value is `"public"`.
#' @return An invisible schema name.
#'
#' @export
#' @family postgresql functions
#'
#' @examples
#' \dontrun{
#' sbfx_set_schema("capture")
#' }
sbfx_set_schema <- function(schema = "public") {
  chk::chk_string(schema)
  options(psql.schema = schema)
  invisible(schema)
}

#' Get schema name
#'
#' @return A string of the schema name.
#'
#' @export
#' @family postgresql functions
#'
#' @examples
#' \dontrun{
#' sbfx_get_schema()
#' }
sbfx_get_schema <- function() {
  getOption("psql.schema", character(0))
}

#' Reset schema name
#'
#' Reset schema name back to public
#'
#' @return An invisible string of the schema name the database is set to.
#'
#' @export
#' @family postgresql functions
#'
#' @examples
#' \dontrun{
#' sbfx_reset_schema()
#' }
sbfx_reset_schema <- function() {
  invisible(sbfx_set_schema())
}

#' Set config file path
#'
#' A wrapper to quickly set the `psql.config_path` options parameter.
#'
#' @param path A file path to the location of the yaml file containing your
#'   connection details.
#' @return An invisible string of the file path given.
#'
#' @export
#' @details This function is recommended to be added to your header when used.
#' @family postgresql functions
#'
#' @examples
#' \dontrun{
#' sbfx_set_config_file()
#' sbfx_set_config_file("Keys/config-captures.yml")
#' }
sbfx_set_config_file <- function(path = "config.yml") {
  chk::chk_string(path)
  options(psql.config_path = path)
  invisible(path)
}

#' Get config file path
#'
#' Get the option set for `psql.config_path`.
#'
#' @return A string of the config file path.
#'
#' @export
#' @family postgresql functions
#'
#' @examples
#' \dontrun{
#' sbfx_get_config_file()
#' }
sbfx_get_config_file <- function() {
  getOption("psql.config_path", character(0))
}

#' Reset config file path
#'
#' Reset the `psql.config_path` option to the default value.
#'
#' @return An invisible string of the default file path.
#'
#' @export
#' @family postgresql functions
#'
#' @examples
#' \dontrun{
#' sbfx_reset_config_file()
#' }
sbfx_reset_config_file <- function() {
  invisible(sbfx_set_config_file())
}

#' Set config value
#'
#' Wrapper for setting the `psql.config_value` options parameter.
#'
#' @param value A string of the config file value to grab.
#' @return An invisible string of the value given.
#'
#' @export
#' @details This function is recommended to be added to your header when used.
#' @family postgresql functions
#'
#' @examples
#' \dontrun{
#' sbfx_set_config_value("shinyapp")
#' }
sbfx_set_config_value <- function(value = NULL) {
  chk::chk_null_or(value, vld = chk::vld_string)
  options(psql.config_value = value)
  invisible(value)
}

#' Get config file value
#'
#' Get the value set for the `psql.config_value` options parameter.
#'
#' @return A string of the config file value.
#'
#' @export
#' @family postgresql functions
#'
#' @examples
#' \dontrun{
#' sbfx_get_config_value()
#' }
sbfx_get_config_value <- function() {
  getOption("psql.config_value", "default")
}

#' Reset config file value
#'
#' Reset the value for `psql.config_value` to the default value.
#'
#' @return An invisible string of the default file path.
#'
#' @export
#' @family postgresql functions
#'
#' @examples
#' \dontrun{
#' sbfx_reset_config_value()
#' }
sbfx_reset_config_value <- function() {
  invisible(sbfx_set_config_value())
}

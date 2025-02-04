# If you get an error like:
# ```
# psql: error: connection to server on socket "/tmp/.s.PGSQL.5432" failed:
# No such file or directory
# Is the server running locally and accepting connections on that socket?
# ```

# This error occurs because a local psql server isn't set up.
# For these tests to pass you must set up a local psql server.

# 1. Restart PostgreSQL in the terminal:
# `brew services restart postgresql`
# 2. Create a new database of your computer username/home folder:
# `createdb <computer_user>`
# 3. Now try connecting again, with the psql command:
# `psql`

test_that("test sbfx_open_pg works", {
  skip_on_ci()
  # set up
  withr::defer(DBI::dbDisconnect(conn))
  # tests
  conn <- sbfx_open_pg(config_path = NULL, config_value = "default")
  expect_s4_class(conn, "PqConnection")
})

test_that("test sbfx_close_pg works", {
  skip_on_ci()
  # set up
  withr::defer(suppressWarnings(DBI::dbDisconnect(conn)))
  conn <- local_connection_default()
  # tests
  sbfx_close_pg(conn)
  expect_error(
    DBI::dbExecute(conn, "SELECT 1+1;"),
    regexp = "bad_weak_ptr"
  )
})

test_that("test sbfx_backup_pg works", {
  skip_on_ci()
  # set up
  config_path <- create_local_database()
  temp_dir <- withr::local_tempdir()
  # tests
  sbfx_backup_pg(
    db_dump_name = "dump_db1",
    main = temp_dir,
    config_path = config_path
  )
  expect_true(file.exists(file.path(temp_dir, "dbs", "dump_db1.sql")))
})

test_that("test sbfx_create_pg works", {
  skip_on_ci()
  # set up
  clean_up_db("newdb")
  # tests
  output <- sbfx_create_pg("newdb", NULL, "default")
  expect_true(output)
})

test_that("test sbfx_execute_pg works", {
  skip_on_ci()
  # set up
  local_config <- create_local_database()
  clean_up_schema(local_config)
  # test
  output <- sbfx_execute_pg(
    "CREATE SCHEMA boat_count",
    config_path = local_config
  )
  schema_info <- check_schema_exists(local_config)
  expect_equal(output, 0L)
  expect_true("boat_count" %in% schema_info$schema_name)
})

test_that("test sbfx_list_tables_pg works", {
  skip_on_ci()
  # set up
  outing <- data.frame(x = 1:5, y = 6:10)
  local_config <- create_local_database(schema = "boat_count", table = outing)
  # test
  output <- sbfx_list_tables_pg(
    "boat_count",
    config_path = local_config
  )
  expect_equal(output, "outing")
})

test_that("test sbfx_load_data_from_pg works", {
  skip_on_ci()
  # set up
  outing <- data.frame(x = 1:5, y = 6:10)
  local_config <- create_local_database(schema = "boat_count", table = outing)
  # tests
  output <- sbfx_load_data_from_pg(
    x = "outing",
    schema = "boat_count",
    config_path = local_config
  )
  expect_equal(output, outing)
  expect_s3_class(output, "data.frame")
})

test_that("checking sbfx_load_datas_from_pg pulls data from tables", {
  skip_on_ci()
  # set up
  outing <- data.frame(x = c(1:5), y = c(5:9))
  local_config <- create_local_database(schema = "boat_count", table = outing)
  outing_dat <- rename_and_remove_data(outing)
  # tests
  output <- sbfx_load_datas_from_pg(
    "boat_count",
    config_path = local_config
  )
  expect_equal(output, "outing")
  expect_equal(outing, outing_dat)
})

test_that("checking sbfx_load_datas_from_pg pulls tables and renames them", {
  skip_on_ci()
  # set up
  outing <- data.frame(x = c(1:5), y = c(5:9))
  local_config <- create_local_database(schema = "boat_count", table = outing)
  # tests
  output <- sbfx_load_datas_from_pg(
    "boat_count",
    rename = toupper,
    config_path = local_config
  )
  expect_equal(output, "OUTING")
  expect_equal(OUTING, outing)
})

test_that("test sbfx_save_data_to_pg works when no x_name passed", {
  skip_on_ci()
  # set up
  outing <- data.frame(x = 1:5, y = 6:10)
  local_config <- create_local_database(
    schema = "boat_count",
    table = outing,
    data = FALSE
  )
  # tests
  output <- sbfx_save_data_to_pg(
    x = outing,
    schema = "boat_count",
    config_path = local_config
  )
  query <- check_db_table(local_config, "boat_count", "outing")
  expect_equal(output, 5)
  expect_equal(query, outing)
})

test_that("test sbfx_save_data_to_pg works with x_name passed", {
  skip_on_ci()
  # set up
  outing <- data.frame(x = 1:5, y = 6:10)
  local_config <- create_local_database(
    schema = "boat_count",
    table = outing,
    data = FALSE
  )
  # tests
  outing_new <- data.frame(x = 1:2, y = 2:3)
  output <- sbfx_save_data_to_pg(
    x = outing_new,
    schema = "boat_count",
    x_name = "outing",
    config_path = local_config
  )
  query <- check_db_table(local_config, "boat_count", "outing")
  expect_equal(output, 2)
  expect_equal(query, outing_new)
})

test_that("set and get schema", {
  schema <- "trucks"
  sbfx_set_schema(schema)
  set_schema <- sbfx_get_schema()
  expect_equal(set_schema, schema)
})

test_that("reset schema", {
  schema <- "trucks"
  sbfx_set_schema(schema)
  sbfx_reset_schema()
  set_schema <- sbfx_get_schema()
  expect_equal(set_schema, "public")
})

test_that("set and get config file path", {
  path <- "~/Keys/config.yml"
  sbfx_set_config_file(path)
  set_path <- sbfx_get_config_file()
  expect_equal(set_path, path)
})

test_that("reset config file path", {
  path <- "~/Keys/config.yml"
  sbfx_set_config_file(path)
  sbfx_reset_config_file()
  set_path <- sbfx_get_config_file()
  expect_equal(set_path, "config.yml")
})

test_that("set and get config file value", {
  value <- "database"
  sbfx_set_config_value(value)
  set_value <- sbfx_get_config_value()
  expect_equal(set_value, value)
})

test_that("reset config file value", {
  value <- "database"
  sbfx_set_config_value(value)
  sbfx_reset_config_value()
  set_value <- sbfx_get_config_value()
  expect_equal(set_value, "default")
})

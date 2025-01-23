#' Download files from AWS S3
#'
#' Download files from an AWS S3 bucket into the analysis.
#'
#' @param bucket_name A string of the AWS S3 bucket name.
#' @param data_type A string (by default `NULL`) for which data type to return.
#'   Check the folder names within the shiny-upload in AWS for options. Examples include
#'   punch-data, tracks, logger, image and pdf.
#' @param year A whole number (by default `NULL`) indicating which year to
#'   return. Format YYYY.
#' @param month A whole number (by default `NULL`) indicating which month to
#'   return. Format MM.
#' @param day A whole number (by default `NULL`) indicating which day to return.
#'   Format DD.
#' @param file_name A string (by default `NULL`) containing the name of the file
#'   to return. Do not include extension type.
#' @param file_extension A string (by default `NULL`) with the file extension to
#'   return. Do not include period.
#' @param max_request_size A whole number (by default `1000`) indicating the
#'   maximum number of files to be returned.
#' @param ask A flag specifying whether to ask before overwriting files.
#' @param silent A flag (by default `FALSE`) to silence messages about number of
#'   files returned. Set to `TRUE` to silence messages.
#' @param aws_access_key_id A string of your AWS user access key ID. The default
#'   is the environment variable named `AWS_ACCESS_KEY_ID`.
#' @param aws_secret_access_key A string of your AWS user secret access key. The
#'   default is the environment variable named `AWS_SECRET_ACCESS_KEY`.
#' @param region A string of the AWS region. The default is the environment
#'   variable named `AWS_REGION`.
#' @inheritParams subfoldr2::sbf_save_object
#'
#' @family save functions
#' @examples
#' \dontrun{
#' sbfx_save_aws_files(
#'   bucket_name = "exploit-upload-poissonconsulting",
#'   data_type = "upload-recapture",
#'   year = 2021,
#'   file_name = "processed_data",
#'   file_extension = "csv"
#' )
#' }
#' @export
sbfx_save_aws_files <- function(bucket_name,
                                sub = subfoldr2::sbf_get_sub(),
                                main = subfoldr2::sbf_get_main(),
                                data_type = NULL,
                                year = NULL,
                                month = NULL,
                                day = NULL,
                                file_name = NULL,
                                file_extension = NULL,
                                max_request_size = 1000,
                                ask = getOption("sbf.ask", TRUE),
                                silent = TRUE,
                                aws_access_key_id = Sys.getenv("AWS_ACCESS_KEY_ID"),
                                aws_secret_access_key = Sys.getenv("AWS_SECRET_ACCESS_KEY"),
                                region = Sys.getenv("AWS_REGION", "ca-central-1")) {
  rlang::check_installed("readwriteaws")

  file_list <- readwriteaws::rwa_list_su_files(
    bucket_name = bucket_name,
    data_type = data_type,
    year = year,
    month = month,
    day = day,
    file_name = file_name,
    file_extension = file_extension,
    max_request_size = max_request_size,
    silent = TRUE,
    aws_access_key_id = aws_access_key_id,
    aws_secret_access_key = aws_secret_access_key,
    region = region
  )

  dir <- file_path(main, "aws", sub)
  dir_create(dir)

  readwriteaws::rwa_download_files(
    file_list = file_list,
    directory = dir,
    bucket_name = bucket_name,
    ask = ask,
    aws_access_key_id = aws_access_key_id,
    aws_secret_access_key = aws_secret_access_key,
    region = region
  )

  invisible(file_list)
}

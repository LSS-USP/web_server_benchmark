# Capture samples
list_of_samples <- function(path)
{
  # Handling files
  file_samples <- list.files(path, pattern='*.csv', full.names = FALSE)
  file_numbers <- as.numeric(sub('\\.csv$', '', file_samples))

  # Read all files
  all_files <- lapply(file.path(path, file_samples), read.csv)

  return(all_files)
}

# Based on a folder with samples (csv files), read all of them and find out
# the median
find_median_from_samples <- function(path)
{
  all_files <- list_of_samples(path)

  # Set up variables
  total_lines <- nrow(all_files[[1]]) # Expected 101
  total_files <- length(all_files) # Total of samples, it can vary
  final_table <- data.frame(Percentage=numeric(), Time=numeric())

  # Go through each line
  for (lines in 1:total_lines)
  {
    tmprow <- data.frame(Percentage=numeric(), Time=numeric())
    # Cross all files, and get each column value
    for (target in 1:total_files)
    {
      sample_time <- all_files[[target]][lines, 2]
      value_sample <- data.frame(Percentage=lines, Time=sample_time)
      tmprow <- rbind(tmprow, value_sample)
    }
    # Find median
    calculed_median <- median(tmprow$Time)
    newrow <- data.frame(Percentage=lines, Time=calculed_median)
    final_table <- rbind(final_table, newrow)
  }

  return (final_table)
}

process_data_median <- function(path, dest)
{
  table_of_median <- find_median_from_samples(path)
  write.csv(table_of_median, file=dest)
}

# Read arguments
pathsArguments <- commandArgs(trailingOnly=TRUE)

# Test if there three argument. If not, return an error.
if (length(pathsArguments) < 2)
{
  stop('You have to supply the target path and destination')
} else if (length(pathsArguments) == 2)
{
  # default output file
  source_files <- pathsArguments[1]
  dest_files <- pathsArguments[2]
}

process_data_median(source_files, dest_files)

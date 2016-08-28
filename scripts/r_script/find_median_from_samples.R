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
find_median_from_samples <- function(path, dest)
{
  all_files <- list_of_samples(path)

  # Set up variables
  total_lines <- nrow(all_files[[1]]) # Expected 101
  total_files <- length(all_files) # Total of samples, it can vary
  final_table <- data.frame(percentage=numeric(), time=numeric())

  # Go through each line
  for (lines in 1:total_lines)
  {
    tmprow <- data.frame(percentage=numeric(), time=numeric())
    # Cross all files, and get each column value
    for (target in 1:total_files)
    {
      sample_time <- all_files[[target]][lines, 2]
      value_sample <- data.frame(percentage=lines, time=sample_time)
      tmprow <- rbind(tmprow, value_sample)
    }
    # Find median
    calculed_median <- median(tmprow$time)
    newrow <- data.frame(percentage=lines, time=calculed_median)
    final_table <- rbind(final_table, newrow)
  }

  return (final_table)
}

# Calculate average response time
# @param target_path Path with samples
process_data <- function(target_path)
{
  table_of_mean <- data.frame(ctime_m=numeric(), dtime_m=numeric(),
                              ttime_m=numeric(), wait_m=numeric())

  var_names <- c('starttime','seconds','ctime','dtime','ttime','wait')
  for (files in dir(path=target_path, pattern='*.tsv',full.names=TRUE))
  {
    temp <- read.table(file=files, sep='\t', skip=1, col.names=var_names)
    tmp_ttime_m <- mean(temp$ttime)
    tmp_ctime_m <- mean(temp$ctime)
    tmp_dtime_m <- mean(temp$dtime)
    tmp_wait_m <- mean(temp$wait)
    newrow <- data.frame(ctime_m=tmp_ctime_m, dtime_m=tmp_dtime_m,
                         ttime_m=tmp_ttime_m, wait_m=tmp_wait_m)
    table_of_mean <- rbind(table_of_mean, newrow)
  }

  return(table_of_mean)
}

create_table_of_mean <- function(src_path, dest_path)
{
  table_of_mean <- process_data(src_path)
  write.csv(table_of_mean, file=dest_path)
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

create_table_of_mean(source_files, dest_files)

get_data_table <- function(increase_rate, base_path, mpm)
{
  axis_x <- seq(from=increase_rate, by=increase_rate,length.out=10)
  options(scipen=100) # FIXME: Change the expansion. Not a good idea
  table_of_mean <- data.frame(requests=numeric(), average=numeric())
  for (target in axis_x)
  {
    current_file <- paste(mpm, target, sep='_')
    current_file <- paste(base_path,'/' ,current_file, '.csv', sep='')
    temp_data <- read.csv(file=current_file, col.names=c('X', 'ctime_m', 'dtime_m', 'ttime_m', 'wait_m'))
    average_now <- mean(temp_data$ttime_m)
    newrow <- data.frame(requests=target, average=average_now)
    table_of_mean <- rbind(table_of_mean, newrow)
  }
  return(table_of_mean)
}

plot_lines_graphs <- function(increase_rate, base_path, dest_path)
{
  # Get information and setup basic variables
  event_table <- get_data_table(increase_rate, base_path, 'event')
  worker_table <- get_data_table(increase_rate, base_path, 'worker')
  prefork_table <- get_data_table(increase_rate, base_path, 'prefork')
  max_on_x <-max(event_table$requests, worker_table$requests, prefork_table$requests)
  max_on_y <-max(event_table$average, worker_table$average, prefork_table$average)
  xlabel='Requests'
  ylabel='Average time (ms)'

  # Configure plot
  margin <- c(5.1, 4.1, 2, 9.1)
  png(dest_path, width=1024, height=768)
  par(mar=margin, xpd=TRUE)

  # Event
  plot(event_table$requests, event_table$average, type='l', col='blue',
       xlim=c(increase_rate, max_on_x), ylim=c(0, max_on_y),
       xlab=xlabel, ylab=ylabel)

  # Worker
  lines(worker_table$requests, worker_table$average, type='l', col='green')

  # Prefork
  lines(prefork_table$requests, prefork_table$average, type='l', col='red')

  # Legend
  legend('topright', inset=c(-0.15,0), legend=c('Event','worker','Prefork'),
         lty=c(1,1,1), lwd=c(2.5,2.5,2.5), col=c('blue', 'green','red'))
  dev.off()
  return(0)
}

# Read arguments
pathsArguments <- commandArgs(trailingOnly=TRUE)

# Test if there three argument. If not, return an error.
if (length(pathsArguments) < 3)
{
  stop('You have to supply: increase_rate, target path, and place to save the image ')
} else if (length(pathsArguments) == 3)
{
  # default output file
  increase_rate <- as.numeric(pathsArguments[1])
  target_path <- pathsArguments[2]
  dest_path <- pathsArguments[3]
}

plot_lines_graphs(increase_rate, target_path, dest_path)

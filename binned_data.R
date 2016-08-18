load_csv_file <- function(path_csv)
{
data <- read.csv(file=path_csv,skip=1,col.names=c('Percentage','Time'))
return(data)
} 

build_graph <- function(event, worker, prefork)
{
par(mar=c(5.1, 4.1, 4.1, 8.1), xpd=TRUE)
plot(event$Time,event$Percentage,type="l",col="blue",ylab="Percentage",xlab="Time (ms)", xlim=c(0,max(prefork$Time, event$Time, worker$Time)))
lines(worker$Time,worker$Percentage,type="l",col="green",ylab="Percentage",xlab="Time (ms)", xlim=c(0,max(prefork$Time, event$Time, worker$Time)))
lines(prefork$Time,prefork$Percentage,type="l",col="red",ylab="Percentage",xlab="Time (ms)", xlim=c(0,max(prefork$Time, event$Time, worker$Time)))
legend("topright", inset=c(-0.15,0), legend=c("Event","Prefork","worker"), lty=c(1,1,1), lwd=c(2.5,2.5,2.5), col=c("blue","red", "green"))
return(0)
}

# This template was based on:
# http://blog.secaserver.com/2012/03/web-server-benchmarking-apache-benchmark/

# ATTENTION: DO NOT CHANGE THIS FILE

# Output as png image
set terminal png size 1280,720
 
# Save file to "benchmark.png"
set output "__IMAGE_PATH__.png"
 
# Graph title
# set title "__TITLE__"
 
# Aspect ratio for image size
set size 1,1
 
# Enable grid on y-axis
set grid y
 
# X-axis label
set xlabel "Request"
 
# Y-axis label
set ylabel "Response Time (ms)"

# Tell gnuplot to use tabs as the delimiter instead of spaces (default)
set datafile separator '\t'

# We look at waiting time
# ATTENTION: ORDER IS IMPORTANT HERE
plot "__EVENT_FILE__" using 6 smooth sbezier with lines title "Event" linecolor rgb "blue", \
"__PREFORK_FILE__" using 6 smooth sbezier with lines title "Prefork" linecolor rgb "red", \
"__WORKER_FILE__" using 6 smooth sbezier with lines title "Worker" linecolor rgb "green"

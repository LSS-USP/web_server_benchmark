# output as png image
set terminal png size 1280,720

# save file to "benchmark.png"
set output "__IMAGE_PATH__.png"
 
# graph title
# set title "Event, Worker and Prefork"
 
# aspect ratio for image size
set size 1,1
 
# enable grid on y-axis
set grid y
 
# x-axis label
set xlabel "Time (%)"
 
# y-axis label
set ylabel "Served requests"

# Ready for csv
set datafile separator ","

plot "__EVENT_FILE__" using 2:1 smooth sbezier with lines title "Event" linecolor rgb "blue", \
"__PREFORK_FILE__" using 2:1 smooth sbezier with lines title "Prefork" linecolor rgb "red", \
"__WORKER_FILE__" using 2:1 smooth sbezier with lines title "Worker" linecolor rgb "green"

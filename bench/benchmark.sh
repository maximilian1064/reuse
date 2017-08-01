#!/usr/bin/sh

rm -f hbw_read hbw_write ddr_read ddr_write

for((i=1; i<=5; i=i+1))
do
    ./distgen-hbw -t    64 -1000 4m 2>>"hbw_read"
    ./distgen-hbw -w -t 64 -1000 4m 2>>"hbw_write"
    ./distgen-ddr -t    64 -1000 4m 2>>"ddr_read"
    ./distgen-ddr -w -t 64 -1000 4m 2>>"ddr_write"
done

# -t [#thread]  -iteration number [distance]
# -w enable writing
# total memory usage: distance * #thread

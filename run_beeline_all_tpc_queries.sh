HADOOP_CLIENT_OPTS="$HADOOP_CLIENT_OPTS -Djline.terminal=jline.UnsupportedTerminal"
outputdir=sample-queries-tpch_beeline_output
mkdir $outputdir

find sample-queries-tpch/ -name "*.sql" | while read sqlfile
do
echo "`date` - Started $sqlfile" >$outputdir/`basename $sqlfile.out` 2>&1
time beeline -u "jdbc:hive2://bbg1.nova.local:2181,bbg2.nova.local:2181,bbg3.nova.local:2181,bbg4.nova.local:2181,bbg5.nova.local:2181/tpch_flat_orc_5;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2" -f $sqlfile </dev/null >>$outputdir/`basename $sqlfile.out` 2>&1
echo "`date` - Completed $sqlfile" >>$outputdir/`basename $sqlfile.out` 2>&1
done >$outputdir/$outputdir.out 2>&1

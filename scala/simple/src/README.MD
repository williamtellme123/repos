
This repos/apachespark folder was cloned 2_20_16
in order to get the latest example files



git clone git@github.com:apache/spark.git

was performed and is available under /usr/local/spark
It was built using the following:
Also found in awsinstance5.txt

git clone git@github.com:apache/spark.git
./dev/change-scala-version.sh 2.11
export MAVEN_OPTS="-Xmx1300M -XX:MaxPermSize=512M -XX:ReservedCodeCacheSize=512m"
-- ------------------------------------------------
-- build spark 1.6.0_SNAPSHOT with scala 2.11 and sparkr
build/mvn -Pyarn -Phadoop-2.6 -Dscala-2.11 -DskipTests clean package

It’s possible to build Spark sub-modules using the mvn -pl option.
For instance, you can build the Spark Streaming module using:
mvn -pl :spark-streaming_2.10 clean install
where spark-streaming_2.10 is the artifactId as defined in streaming/pom.xml file.

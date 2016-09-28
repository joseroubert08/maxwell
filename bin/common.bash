# Which version of kafka-clients will be loaded, based on the presence of the
# --kafka0.9 option or not; should match the ones declared in the Makefile (0.8)
# and pom.xml (0.9).

base_dir=$(dirname $0)/..

KAFKA_08_VERSION=0.8.2.2
KAFKA_09_VERSION=0.9.0.1

CLASSPATH=$CLASSPATH:$base_dir/target/classes:../open-replicator/target/classes

for file in lib/*.jar target/dependency/*.jar
do
  if [[ "$@" == *--kafka0.8* ]] && [[ ! $file == *kafka-clients-$KAFKA_09_VERSION.jar* ]]; then
    CLASSPATH=$CLASSPATH:$file
  elif [[ ! "$@" == *--kafka0.8* ]] && [[ ! $file == *kafka-clients-$KAFKA_08_VERSION.jar* ]]; then
    CLASSPATH=$CLASSPATH:$file
  fi
done

if [ -z "$JAVA_HOME" ]; then
  JAVA="java"
else
  JAVA="$JAVA_HOME/bin/java"
fi


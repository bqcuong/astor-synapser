#!/bin/bash

jtestex7_jar="/opt/astor/jtestex7.jar"
astor_jar="/opt/astor/astor.jar"

args="$@"

to_search="jvmversion"
rest=${args#*$to_search}
jvmver_start_pos=$(( ${#args} - ${#rest} - ${#to_search} - 1))
jvmver_val_pos=$(( $jvmver_start_pos + 12 ))
jvm_version="${args:$jvmver_val_pos:1}"
if [ $jvm_version -eq "7" ]; then # always use Java 8 for running astor.jar
	JAVA_HOME=$JAVA8_HOME
else
	JAVA_HOME=$JAVA8_HOME
fi

jvmpath="$JAVA_HOME/bin"
export PATH="$jvmpath:$PATH"

args="$args -javacompliancelevel $jvm_version -jvm4testexecution $jvmpath -jvm4evosuitetestexecution $jvmpath"

# remove the -jvmversion from argument list
args="${args:0:$jvmver_start_pos}${args:$(( $jvmver_val_pos + 2 ))}"

repair_cmd="java -cp $jtestex7_jar:$astor_jar fr.inria.main.evolution.AstorMain $args"

echo "Setup based on JVM version $jvm_version:"
echo "--> JAVA_HOME=$JAVA_HOME"
echo "--> jvmpath=$jvmpath"
echo "--> refined args=$args"
echo "--> repair cmd=$repair_cmd"
echo "--------------------------"

echo "Running repair..."
bash -c "$repair_cmd"
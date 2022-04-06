#!/bin/bash

jtestex7_jar="/opt/astor/jtestex7.jar"
astor_jar="/opt/astor/astor.jar"

args="$@"
jvm_version="$2"

if [ $jvm_version -eq "7" ]; then
	JAVA_HOME=$JAVA7_HOME
else
	JAVA_HOME=$JAVA8_HOME
fi

jvmpath="$JAVA_HOME/bin"
args="$args -javacompliancelevel $jvm_version -jvm4testexecution $jvmpath -jvm4evosuitetestexecution $jvmpath"

# remove the -jvmversion from argument list
args=${args:14}

repair_cmd="java -cp $jtestex7_jar:$astor_jar fr.inria.main.evolution.AstorMain $args"

echo "Setup based on JVM version $jvm_version:"
echo "--> JAVA_HOME=$JAVA_HOME"
echo "--> jvmpath=$jvmpath"
echo "--> refined args=$args"
echo "--> repair cmd=$repair_cmd"
echo "--------------------------"

echo "Running repair..."
$repair_cmd

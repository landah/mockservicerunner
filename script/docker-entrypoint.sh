#!/bin/bash
#
# Default usage: docker-entrypoint.sh start-soapui
#
# ==> Note: for the SoapUI command reference see http://www.soapui.org/test-automation/running-from-command-line/soap-mock.html
#
# Default value of environment variables:
#     PROJECT           = $SOAPUI_PRJ/default-soapui-project.xml
#
#
# The following enviroment variable is required (and has no default value)
#     MOCK_SERVICE_NAME = << unset >>
#
#
# Setup default values for environment variables.
#
export SOAPUI_DIR=/usr/local/SmartBear/SoapUI-5.5.0
export PATH=$SOAPUI_DIR/bin:$PATH
if [ -z "$PROJECT" ]; then
    export PROJECT=$SOAPUI_PRJ/default-soapui-project.xml
elif [ $PROJECT == /* ]; then
	echo "Custom location is $PROJECT"
else
	export PROJECT=$SOAPUI_PRJ/$PROJECT
fi
if [ ! -f $PROJECT ]; then
	echo "The project $PROJECT not found"
	exit 1
fi
if [ -z "$MOCK_SERVICE_NAME" ]; then
	export MOCK_SERVICE_NAME="$(awk -F 'mockService' '{print $2}' $PROJECT  | grep -o "name.*" | cut -f2- -d \"  | cut -f1 -d \")"
fi

if [ -z "$MOCK_SERVICE_NAME" ]; then
	echo "MOCK_SERVICE_NAME undefined"
	exit 1
fi

if [ -z "$MOCK_SERVICE_PORT" ]; then
	export MOCK_SERVICE_PORT=8080
	echo "The default port is $MOCK_SERVICE_PORT"
fi
#if [ ! -z "$MOCK_SERVICE_PORT_FORCE" ]; then
#	export MOCK_SERVICE_PORT=$MOCK_SERVICE_PORT_FORCE
#	export MOCK_SERVICE_PORT_FORCE_TMP =$(grep mockService $PROJECT  | grep -o "port.*" | cut -f2- -d \"  | cut -f1 -d \")
#	if [ $MOCK_SERVICE_PORT_FORCE_TMP -ne $MOCK_SERVICE_PORT ]; then
#			echo "rewrite file PORT"
#			sed -i "s/port=\"$MOCK_SERVICE_PORT_FORCE_TMP\"/port=\"$MOCK_SERVICE_PORT\"/g" $PROJECT
#	fi
#fi
if [ -z "$MOCK_SERVICE_HOST" ]; then
	export MOCK_SERVICE_HOST=$(awk -F 'mockService' '{print $2}' $PROJECT  | grep -o "host.*" | cut -f2- -d \"  | cut -f1 -d \")
	echo "default service host: $MOCK_SERVICE_HOST"
else
	export MOCK_SERVICE_HOST_TMP=$(awk -F 'mockService' '{print $2}' $PROJECT  | grep -o "host.*" | cut -f2- -d \"  | cut -f1 -d \")
	echo "rewrite file host $MOCK_SERVICE_HOST_TMP to $MOCK_SERVICE_HOST"
	sed -i "s/host=\"$MOCK_SERVICE_HOST_TMP\"/host=\"$MOCK_SERVICE_HOST\"/g" $PROJECT
fi
if [ -z "$MOCK_SERVICE_PATH" ]; then
	export MOCK_SERVICE_PATH="$(awk -F 'mockService' '{print $2}' $PROJECT  | grep -o "path.*" | cut -f2- -d \"  | cut -f1 -d \")"
fi

mockservicerunner.sh -Djetty.host=0.0.0.0 -Djava.awt.headless=true -Dfile.encoding=UTF8 -p $MOCK_SERVICE_PORT -m "$MOCK_SERVICE_NAME" -a "$MOCK_SERVICE_PATH" "$PROJECT"
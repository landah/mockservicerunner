#!/bin/bash
#
# Default usage: docker-entrypoint.sh start-soapui
#
# ==> Note: for the SoapUI command reference see http://www.soapui.org/test-automation/running-from-command-line/soap-mock.html
#
# Default value of environment variables:
#     PROJECT           = $SOAPUI_PRJ/default-soapui-project.xml
#     MOCK_SERVICE_PATH = << unset >>  ; this implies that the path in the mockservice itself is used
#
#
# The following enviroment variable is required (and has no default value)
#     MOCK_SERVICE_NAME = << unset >>
#
#
# Setup default values for environment variables.
#
export SOAPUI_DIR=/usr/local/SmartBear/SoapUI-5.6.0
export PATH=$SOAPUI_DIR/bin:$PATH
if [ -z "$PROJECT" ]; then
    export PROJECT=$SOAPUI_PRJ/default-soapui-project.xml
fi
if [ -z "$MOCK_SERVICE_NAME" ]; then
    echo "Enviromentment variable MOCK_SERVICE_NAME should have been set explicitly (e.g. by  -e MOCK_SERVICE_NAME=BLZ-SOAP11-MockService"
    exit 1
fi
if [ -z "$MOCK_SERVICE_PORT" ]; then
	export MOCK_SERVICE_PORT=8080
fi
if [ -z "$MOCK_SERVICE_PATH" ]; then
	echo "MOCK_SERVICE_PATH Default"
else
	export MOCK_SERVICE_PATH=" -a $MOCK_SERVICE_PATH "
fi
mockservicerunner.sh -Djetty.host=0.0.0.0 -Djava.awt.headless=true -Dfile.encoding=UTF8 -p $MOCK_SERVICE_PORT -m "$MOCK_SERVICE_NAME" "$MOCK_PATH $PROJECT"
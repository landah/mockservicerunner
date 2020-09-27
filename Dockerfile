FROM openjdk:11
COPY script/installed /tmp
COPY bin/SoapUI-x64-5.6.0.sh /tmp
RUN  /tmp/SoapUI-x64-5.6.0.sh < /tmp/installed
RUN  rm /tmp/installed
RUN  rm /tmp/SoapUI-x64-5.6.0.sh
COPY bin/xmlbeans-3.1.0.jar  /usr/local/SmartBear/SoapUI-5.6.0/lib/xmlbeans-xmlpublic-2.6.0.jar
COPY test/default-soapui-project.xml /home/
COPY script/docker-entrypoint.sh /usr/local/SmartBear/SoapUI-5.6.0
ENV  SOAPUI_PRJ=/home
ENV  MOCK_SERVICE_NAME="CalculatorSoap MockService"
WORKDIR /home
CMD [ "sh", "/usr/local/SmartBear/SoapUI-5.6.0/docker-entrypoint.sh"]
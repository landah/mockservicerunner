FROM	openjdk:11
RUN 	[ "apt-get", "update" ]
RUN 	[ "apt-get", "install", "-y", "vim", "wget" ]
RUN 	[ "wget", "https://s3.amazonaws.com/downloads.eviware/soapuios/5.6.0/SoapUI-x64-5.6.0.sh", "-P", "/tmp" ]
RUN 	[ "wget", "https://repo1.maven.org/maven2/org/apache/xmlbeans/xmlbeans/3.1.0/xmlbeans-3.1.0.jar", "-P", "/tmp"]
RUN 	[ "mkdir", "-p", "/usr/local/SmartBear/SoapUI-5.6.0"]
COPY	test/default-soapui-project.xml /home/
COPY	script/install /tmp
COPY	script/docker-entrypoint.sh /usr/local/SmartBear/SoapUI-5.6.0
RUN 	sh /tmp/SoapUI-x64-5.6.0.sh < /tmp/install 
RUN 	[ "mv", "/tmp/xmlbeans-3.1.0.jar", "/usr/local/SmartBear/SoapUI-5.6.0/lib/xmlbeans-xmlpublic-2.6.0.jar" ]
ENV 	SOAPUI_PRJ=/home
ENV 	MOCK_SERVICE_NAME="CalculatorSoap MockService"
WORKDIR /home
CMD 	[ "sh", "/usr/local/SmartBear/SoapUI-5.6.0/docker-entrypoint.sh" ]
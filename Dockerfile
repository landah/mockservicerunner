FROM	ubuntu:20.04
RUN 	[ "apt-get", "update" ]
RUN 	[ "apt-get", "install", "-y", "vim", "wget", "sed" ]
RUN 	[ "wget", "https://s3.amazonaws.com/downloads.eviware/soapuios/5.5.0/SoapUI-x64-5.5.0.sh", "-P", "/tmp" ]
RUN 	[ "mkdir", "-p", "/usr/local/SmartBear/SoapUI-5.5.0"]
COPY	test/default-soapui-project.xml /home/
COPY	script/install /tmp
COPY	script/docker-entrypoint.sh /usr/local/SmartBear/SoapUI-5.5.0
RUN 	sh /tmp/SoapUI-x64-5.5.0.sh < /tmp/install 
RUN 	[ "rm", "/tmp/SoapUI-x64-5.5.0.sh", "/tmp/install" ]
ENV 	SOAPUI_PRJ=/home
WORKDIR /home
CMD 	[ "sh", "/usr/local/SmartBear/SoapUI-5.5.0/docker-entrypoint.sh" ]
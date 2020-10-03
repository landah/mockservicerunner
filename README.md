# SoapUI mockservicerunner


## mockservicerunner

See <https://www.soapui.org/docs/soap-mocking/service-mocking-overview/> for more information


## Getting Started

Run default project
>docker run -d -p 8080:8080 landah/mockservicerunner

Run my custom project 
>docker run -d -p 8080:8080 -e PROJECT=MyCustomProject.xml landah/mockservicerunner
Extra options 

Extra Args
- PROJECT The name of soapui project
- MOCK_SERVICE_NAME The name of the MockService to run
- MOCK_SERVICE_PORT The local port to listen on, overrides the port configured for the MockService
- MOCK_SERVICE_HOST Override the local hostname in wsdl
- MOCK_SERVICE_PATH The local path to listen on, overrides the path configured for the MockService

## Project 
See <https://github.com/landah/mockservicerunner/tree/1.2.0>

## License

See <https://www.soapui.org/docs/licenses/soapui-licenses/>
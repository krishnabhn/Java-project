FROM  tomcat:8.0-alpine
COPY ./target/TestCalculatorAppJuly21Batch.war  /usr/local/tomcat/webapps/
CMD ["catalina.sh", "run"]
EXPOSE 8086
FROM openjdk:11
WORKDIR application
COPY target/*.jar ./app.jar
ENTRYPOINT ["java", "-Duser.timezone=Asia/Colombo","-jar","app.jar"]
EXPOSE 80
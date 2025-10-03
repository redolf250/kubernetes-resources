FROM openjdk:latest
ADD target/kubernetes-deploy.jar kubernetes-deploy.jar
EXPOSE 8081
ENTRYPOINT ["java","-jar","kubernetes-deploy.jar"]


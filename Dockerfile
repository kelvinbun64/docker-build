FROM nginx:latest

WORKDIR /project

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
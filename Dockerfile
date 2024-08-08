FROM ubuntu:20.04
RUN echo "Hello from ubuntu!"
CMD [ "sh", "-c", "echo -n My home is $HOME" ]
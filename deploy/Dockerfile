# This file creates a container for deployment, it starts with the runtime environment
FROM koncluderun

# Copies the executable
COPY Release/Konclude /root

EXPOSE 8080

RUN mkdir /data

# And configures containers to call the installed program
ENTRYPOINT ["/root/Konclude"]

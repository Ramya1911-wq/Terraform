FROM ubuntu:20.04
ENV PATH=$PATH:/opt/jdk-21.0.3/bin:/opt/apache-maven-3.9.5/bin
ENV DOTNET_VERSION=6.0.0
EXPOSE 80
RUN apt update && \
    export DEBIAN_FRONTEND=noninteractive &&\
    apt install apache2 git wget curl -y && \
    apt-get install postgresql-client -y && \
    echo 'Hello, World!' > /var/www/html/index.html  
RUN curl -fSL --output dotnet.tar.gz https://dotnetcli.azureedge.net/dotnet/Runtime/$DOTNET_VERSION/dotnet-runtime-$DOTNET_VERSION-linux-x64.tar.gz && \
    mkdir -p /usr/share/dotnet && \
    tar -zxf dotnet.tar.gz -C /usr/share/dotnet && \
    rm dotnet.tar.gz && \
    ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

RUN  apt-get install gpg -y && \
     wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg && \
    install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg && \
     echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | tee /etc/apt/sources.list.d/vscode.list > /dev/null && \
    rm -f packages.microsoft.gpg && \
    apt install apt-transport-https -y && \
    apt update -y && \
    apt install code -y 
RUN wget 'https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.tar.gz' && \
    tar -xvf jdk-21_linux-x64_bin.tar.gz && \
    mv jdk-21.0.3 /opt && \
    wget https://dlcdn.apache.org/maven/maven-3/3.9.5/binaries/apache-maven-3.9.5-bin.tar.gz && \
    tar -xvf apache-maven-3.9.5-bin.tar.gz && \
    mv apache-maven-3.9.5 /opt
CMD ["apachectl", "-D", "FOREGROUND"]
#ENTRYPOINT ["apachectl", "-D", "FOREGROUND"] 

FROM jenkins/jenkins:lts-jdk21

# switch to root user to install python. Then switch back to jenkins user
USER root
RUN apt update && apt install -y python3 python3-pip curl jq vim unzip groff less ansible podman

USER jenkins

# Disable the setup wizard that would appear normally on new installations
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# Location of the CASC config file. This variable will be used by the Jenkins process.
ENV CASC_JENKINS_CONFIG=/var/jenkins_home/configuration-as-code.yaml

# Install required jenkins plugins
COPY jenkins_plugin_list.txt /usr/share/jenkins/ref/jenkins_plugin_list.txt
RUN jenkins-plugin-cli --verbose --plugin-file /usr/share/jenkins/ref/jenkins_plugin_list.txt


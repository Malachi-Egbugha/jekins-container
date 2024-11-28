# Use the official Jenkins LTS image as a base
FROM jenkins/jenkins:lts

# Switch to the root user to install custom plugins and dependencies
USER root

# Install necessary packages or dependencies (if any)
RUN apt-get update && \
    apt-get install -y curl

# Add custom plugins (if needed)
RUN jenkins-plugin-cli --plugins blueocean

# Switch back to the Jenkins user for security
USER jenkins

# Set the environment variable to configure Jenkins
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# Expose necessary ports
EXPOSE 8080 50000

# Set the entrypoint for Jenkins
ENTRYPOINT ["/bin/tini", "--", "/usr/local/bin/jenkins.sh"]

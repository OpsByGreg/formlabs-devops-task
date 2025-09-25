# We are using a slim version of the latest official
# released python image available as of 25/09/2025.
#
# Source Code:
# https://github.com/docker-library/python/blob/935e3081dbf0734d724482b987dd6ba6b8608329/3.13/slim-trixie/Dockerfile
FROM python:3.13-slim

# Move out of root for the working directory
WORKDIR /app

# Avoid using the root user by creating a custom
# user and group
RUN groupadd formlabs && useradd --gid formlabs formlabs

# We copy and install python requirements first
# to ensure cache is preserved during development
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Use the custom user for the remainder of the docker build
USER formlabs:formlabs

# Copy application files owned by formlabs user
COPY --chown=formlabs:formlabs helloapp helloapp

# Copy entrypoint script
COPY --chown=formlabs:formlabs entrypoint.sh .

# Copy app scripts
COPY --chown=formlabs:formlabs scripts/* ./scripts/

# Make all scripts executable
RUN chmod +x entrypoint.sh scripts/*

# Set the entrypoint as the entrypoint script
ENTRYPOINT [ "./entrypoint.sh" ]

# Set the default command to run the app
CMD [ "run" ]

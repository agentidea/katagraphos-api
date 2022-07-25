# pull down the pode image
FROM badgerati/pode:latest-alpine

# or use the following for GitHub
# FROM docker.pkg.github.com/badgerati/pode/pode:latest-alpine

# copy over the local files to the container
# web-pages-docker.ps1
COPY . /usr/src/app/

# expose the port
EXPOSE 8086

# install pwsh modules
RUN pwsh -c "Install-Module ImportExcel -Force"

# run the server
CMD [ "pwsh", "-c", "cd /usr/src/app; ./rest-api.ps1" ]

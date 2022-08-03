# pull down the pode image
FROM badgerati/pode:latest-alpine

# or use the following for GitHub
# FROM docker.pkg.github.com/badgerati/pode/pode:latest-alpine

# copy over the local files to the container
# web-pages-docker.ps1


COPY . /usr/src/app/

# expose the port
EXPOSE 8090

# install github cli GH
RUN apk -c "add github-cli"

# install pwsh modules
RUN pwsh -c "Install-Module ImportExcel -Force"
RUN pwsh -c "Install-Module Pode.Web -Force"


# run the server
CMD [ "pwsh", "-c", "cd /usr/src/app; ./katagraphosRestAPI.ps1" ]

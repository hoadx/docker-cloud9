## Supported tags
- latest, alpine (701MB ~ 230MB compressed)
- slim (201MB ~ 65MB compressed)
- usermode (198MB ~ 64MB compressed)

## What is Cloud9 IDE?
Cloud9 IDE is an online integrated development environment, published as open source from version 3.1.5. It supports hundreds of programming languages, including C, C++, PHP, Ruby, Perl, Python, JavaScript with Node.js, and Go. It enables developers to get started with coding immediately with pre-configured workspaces, collaborate with their peers with collaborative coding features, and web development features like live preview and browser compatibility testing.

## How to use this image
Start the Cloud9 instance as follows:

    docker run -it -d -p 8000:8000 -e USERNAME="username" -e PASSWORD="password" -v $(pwd):/workspace --name cloud9 hoadx/cloud9:slim

You can add a workspace as a volume directory with the argument -v /yourworkspace:/workspace

## Docker Compose
A docker-compose.yml looks like this:

    cloud9:
      container_name: cloud9
      image: hoadx/cloud9
      ports:
        - "8000:8000"
      environment:
        - USERNAME=username
        - PASSWORD=password
      volumes:
        - /home/www/projects:/workspace

## Environment Variables
- USERNAME
This variable is optional and specifies the user that will be set for Cloud9 HTTP Authentication; Unset to disable HTTP Authentication

- PASSWORD
This variable is optional and specifies the password that will be set for Cloud9 HTTP Authentication; Unset to disable HTTP Authentication

## Standalone Mode
Unset USERNAME and PASSWORD variables or set value to blank in order to enable standalone mode

    docker run -it -d -p 8000:8000 -v $(pwd):/workspace --name cloud9 hoadx/cloud9

## User Mode
Pull image using tagname "usermode" to enable usermode mode

    docker run -it -d -p 8000:8000 -v $(pwd):/workspace --name cloud9 hoadx/cloud9:usermode
    
A docker-compose.yml file for usermode:

    cloud9:
      container_name: cloud9
      image: hoadx/cloud9:usermode   # supported tag name: latest, alpine, slim, usermode
      ports:
        - "8000:8000"        # bind port
      environment:
        - USERNAME=username  # Access authentication user
        - PASSWORD=password  # Access authentication password
        - CHANGE_OWNER=0     # Set the value to 1 to change ownership of workspace folder
        - USERID=5000        # set user id; ${USERID:-id -u}
        - GROUPID=5000       # set group id; ${GROUPID:-id -u}
      volumes:
        - .:/workspace       # set workspace directory

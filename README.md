## Supported tags
- latest, alpine (584 MB - 198 MB compressed)
- slim (203 MB - 66 MB compressed)

## What is Cloud9 IDE?
Cloud9 IDE is an online integrated development environment, published as open source from version 3.0. It supports hundreds of programming languages, including C, C++, PHP, Ruby, Perl, Python, JavaScript with Node.js, and Go. It enables developers to get started with coding immediately with pre-configured workspaces, collaborate with their peers with collaborative coding features, and web development features like live preview and browser compatibility testing.

## How to use this image
Start the Cloud9 instance as follows:

    docker run -it -d -p 8000:8000 -e USERNAME="username" -e PASSWORD="password" -v $(pwd):/workspace --name cloud9 hoadx/cloud9:latest


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
This variable is mandatory and specifies the user that will be set for Cloud9 HTTP Authentication

- PASSWORD
This variable is mandatory and specifies the password that will be set for Cloud9 HTTP Authentication


#!/bin/bash
# Create new ASP.Net Core project with docker

dotnet new webapi -o $1 #--no-https
cd $1

echo "--------------------------------"
echo "FOLLOW THIS TO SETUP DOCKERFILE:"
code .
echo "After VS CODE opens, press ctrl+shift+p to open command line"
echo "Select Docker: Add Docker Files to Workspace"
echo ""
echo "Select debug, and add new configuration Docker: Launch .NET Core"
echo ""
echo "After first debug, it should ask you to create new tasks. Create new dotnet tasks as prompted."

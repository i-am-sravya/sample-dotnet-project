# Use the official .NET Core SDK image as the base image
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env

# Set the working directory inside the container
WORKDIR /app

# Copy the project file and restore dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the application source code
COPY . ./

# Build the application
RUN dotnet publish -c Release -o out

# Use a lighter .NET Core runtime image as the final base image
FROM mcr.microsoft.com/dotnet/aspnet:5.0

# Set the working directory inside the container
WORKDIR /app

# Copy the published output from the build stage to the final image
COPY --from=build-env /app/out .

# Expose the port that the application listens on
EXPOSE 7000

# Run the application
ENTRYPOINT ["dotnet", "MyDotNetApp.dll"]

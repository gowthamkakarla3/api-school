# Use the official .NET SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy everything to the container
COPY . . 

# Restore dependencies
RUN dotnet restore School_API/School_API.csproj

# Build and publish the application
RUN dotnet publish School_API/School_API.csproj -c Release -o out

# Use the ASP.NET runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/out .

EXPOSE 5000
EXPOSE 5001
ENTRYPOINT ["dotnet", "School_API.dll"]

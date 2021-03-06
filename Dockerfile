FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /publish
COPY . .
# COPY src/Nanoservice/file.txt .
RUN dotnet publish src/Nanoservice -c release -o out

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
COPY --from=build /publish/out .
ENV ASPNETCORE_ENVIRONMENT docker
ENV ASPNETCORE_URLS http://*:5000
ENTRYPOINT dotnet Nanoservice.dll
FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS build
WORKDIR /src
COPY . .
RUN dotnet restore
RUN dotnet publish Obsidian/ -c Release -r linux-musl-x64 --self-contained -p:PublishSingleFile=true -p:PublishReadyToRun=true -p:EnableCompressionInSingleFile=true -p:DebugType=embedded

FROM alpine:latest
WORKDIR /app
COPY --from=build /src/Obsidian/bin/Release/net6.0/linux-musl-x64/publish/ .
RUN apk upgrade --update-cache --available && apk add openssl libstdc++ && rm -rf /var/cache/apk/*

WORKDIR /files
ENTRYPOINT DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1 /app/Obsidian
# Build stage
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app

# Copy and restore the project
COPY . .
RUN dotnet restore "18_E_LEARN.Web/18_E_LEARN.Web.csproj"

# Copy SSL certificates to the container
COPY certificates/mssql.crt /usr/local/share/ca-certificates/

# Update SSL certificates in the container
RUN update-ca-certificates
#RUN openssl x509 -in /etc/ssl/certs/mssql.pem -text -noout # Verify the certificate

# Install the dotnet-ef tool globally
RUN dotnet tool install --global dotnet-ef --version 7.0.2
ENV PATH $PATH:/root/.dotnet/tools

# Copy appsettings.json file
COPY 18_E_LEARN.Web/appsettings.json /app/18_E_LEARN.Web/appsettings.json

# Apply migrations
RUN dotnet-ef database update --startup-project "18_E_LEARN.Web" --project "18_E_LEARN.DataAccess/18_E_LEARN.DataAccess.csproj"

# Publish the application
RUN dotnet publish "18_E_LEARN.Web/18_E_LEARN.Web.csproj" -c Release -o /app/build

# Final stage
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS final
WORKDIR /app

# Copy SSL certificates to the container
COPY certificates/mssql.crt /usr/local/share/ca-certificates/

# Update SSL certificates in the container
RUN update-ca-certificates

# Copy the published application from the build stage
COPY --from=build /app/build .

# Expose the port
EXPOSE 80

# Start the application
ENTRYPOINT ["dotnet", "18_E_LEARN.Web.dll"]
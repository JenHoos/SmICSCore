#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /app
EXPOSE 9787
WORKDIR /src
COPY ["SmICSWebApp/SmICSWebApp.csproj", "SmICSWebApp/"]
COPY ["SmICSCoreLib/SmICSCoreLib.csproj", "SmICSCoreLib/"]
COPY ["SmICSConnection.Test/SmICSConnection.Test.csproj", "SmICSConnection.Test/"]
COPY ["SmICSDataGenerator.Test/SmICSDataGenerator.Test.csproj", "SmICSDataGenerator.Test/"]
COPY ["SmICS.Tests/SmICSFactory.Tests.csproj", "SmICS.Tests/"]
COPY ["TestData/", "TestData/"]
RUN dotnet restore "SmICSWebApp/SmICSWebApp.csproj"

WORKDIR /src/.
COPY . .
RUN dotnet build "SmICSWebApp/SmICSWebApp.csproj" -c Release -o /app/build

ARG repo=default_value
ARG user=default_value
ARG passwd=default_value 
ENV OPENEHR_DB=$repo
ENV OPENEHR_USER=$user
ENV OPENEHR_PASSWD=$passwd

FROM build AS publish
COPY . ./
RUN dotnet test "SmICSConnection.Test" --logger:trx -c Release
RUN dotnet test "SmICSDataGenerator.Test" --logger:trx -c Release
RUN dotnet test "SmICS.Tests" --logger:trx -c Release
RUN dotnet publish "SmICSWebApp/SmICSWebApp.csproj" -c Release -o /app/out

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS final
WORKDIR /app
COPY --from=publish /app/out .
ENTRYPOINT ["dotnet", "SmICSWebApp.dll"]

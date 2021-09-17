#FROM mcr.microsoft.com/powershell:latest
FROM ubs00.ocampa.local:32443/tlaxps
 
EXPOSE 8080

COPY . /usr/src/app/
CMD [ "pwsh", "-c", "cd /usr/src/app; ./StartPodeServer.ps1" ]

# escape=`
FROM microsoft/windowsservercore:latest

LABEL Maintainer="Praveen Chamarthi" Version="0.9.2" Vendor="Hashicorp"

ENV VAULT_VERSION="0.9.2" `
    VAULT_ADDR="http://0.0.0.0:8200" `
    VAULT_SECRETS_DIR="c:\\vault\\secrets" `
    VAULT_LOGS_DIR="c:\\vault\\logs" `
    VAULT_LOG_LEVEL="debug" `
    VAULT_START_CONFIG="c:\\vault_config.hcl" `
    VAULT_PORT="8200"


ADD *.exe /
ADD vault_config.hcl /vault_config.hcl
#ADD vault_entrypoint.ps1 /

RUN SETX PATH "%PATH%;C:\\" /M && `
    SETX VAULT_ADDR "%VAULT_ADDR%" /M && `
    nssm install vault c:\\vault.exe server -config=%VAULT_START_CONFIG%

EXPOSE ${VAULT_PORT}

#RUN vault operator init > keys.txt

ENTRYPOINT [ "C:\\ServiceMonitor.exe", "vault" ]



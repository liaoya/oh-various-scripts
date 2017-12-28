@REM this script must be run in local git folder
@ECHO off
IF DEFINED http_proxy (
    @ECHO Set local credential.github.com.httpProxy to %http_proxy%
    git config --local http.proxy %http_proxy%
    git config --local credential.github.com.httpProxy %http_proxy%
) ELSE (
    @ECHO Unset local credential.github.com.httpProxy
    git config --local --unset http.proxy
    git config --local --unset credential.github.com.httpProxy
)

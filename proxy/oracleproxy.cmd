@ECHO OFF

IF [%~1]==[] (
   IF DEFINED proxy (SET proxy=)
) ELSE (
   SET proxy=%~1
)

@REM www-proxy-tyo.jp.oracle.com

IF "%proxy%"=="cn" (
   SET http_proxy=http://cn-proxy.jp.oracle.com:80
   GOTO :set_proxy
)
IF "%proxy%"=="jp" (
   SET http_proxy=http://jp-proxy.jp.oracle.com:80
   GOTO :set_proxy
)
IF "%proxy%"=="us" (
   SET http_proxy=http://www-proxy.us.oracle.com:80
   GOTO :set_proxy
)
IF NOT DEFINED proxy (
  IF DEFINED http_proxy (SET http_proxy=)
  GOTO :set_proxy
) ELSE (
  ECHO %proxy% is unknown
  GOTO :EOF
)

:set_proxy
IF NOT DEFINED proxy (
    ECHO "Remove proxy settings"
    IF DEFINED https_proxy (SET https_proxy=)
	IF DEFINED ftp_proxy (SET ftp_proxy=)
	IF DEFINED no_proxy (SET no_proxy=)

    IF DEFINED git_proxy (SET git_proxy=)
    FOR /F %%I IN ('git config --global http.proxy') DO SET git_proxy=%%I
    IF DEFINED git_proxy (
	    @ECHO Unset global http.proxy
		git config --global --unset http.proxy
	)
    IF DEFINED git_proxy (SET git_proxy=)
    FOR /F %%I IN ('git config --global credential.github.com.httpProxy') DO SET git_proxy=%%I
    IF DEFINED git_proxy (
	    @ECHO Unset global credential.github.com.httpProxy
		git config --global --unset credential.github.com.httpProxy
	)
) ELSE (
    ECHO "Set Proxy %http_proxy% for %proxy%"
    SET https_proxy=%http_proxy%
    SET ftp_proxy=%http_proxy%
    SET no_proxy=localhost,127.0.0.1,.cn.oracle.com,.jp.oracle.com,.us.oracle.com,.oraclecorp.com,10.113.69.79,10.113.69.101

    IF DEFINED git_proxy (SET git_proxy=)
    FOR /F %%I IN ('git config --global http.proxy') DO SET git_proxy=%%I
    IF NOT DEFINED git_proxy (
	    @ECHO Set global http.proxy to %http_proxy%
		git config --global http.proxy %http_proxy%
	)
    IF DEFINED git_proxy (SET git_proxy=)
    FOR /F %%I IN ('git config --global credential.github.com.httpProxy') DO SET git_proxy=%%I
    IF NOT DEFINED git_proxy (
	    @ECHO Set global credential.github.com.httpProxy to %http_proxy%
		git config --global credential.github.com.httpProxy %http_proxy%
	)
    git config --global http.proxy | grep -s -q %http_proxy%
	IF %ERRORLEVEL% NEQ 0 (
        @ECHO Set global http.proxy to %http_proxy%
        git config --global http.proxy %http_proxy%
	)
	git config --global credential.github.com.httpProxy | grep -s -q %http_proxy%
	IF %ERRORLEVEL% NEQ 0 (
	    @ECHO Set global credential.github.com.httpProxy to %http_proxy%
        git config --global credential.github.com.httpProxy %http_proxy%
	)
)

:EOF
IF DEFINED proxy (SET proxy=)
IF DEFINED git_proxy (SET git_proxy=)

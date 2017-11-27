@if "%DEBUG%" == "" @echo off
@rem ##########################################################################
@rem
@rem  SXP startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

@rem Add default JVM options here. You can also use JAVA_OPTS and SXP_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS=

set DIRNAME=%~dp0
if "%DIRNAME%" == "" set DIRNAME=.
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%..

@rem Find java.exe
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if "%ERRORLEVEL%" == "0" goto init

echo.
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" goto init

echo.
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:init
@rem Get command-line arguments, handling Windowz variants

if not "%OS%" == "Windows_NT" goto win9xME_args
if "%@eval[2+2]" == "4" goto 4NT_args

:win9xME_args
@rem Slurp the command line arguments.
set CMD_LINE_ARGS=
set _SKIP=2

:win9xME_args_slurp
if "x%~1" == "x" goto execute

set CMD_LINE_ARGS=%*
goto execute

:4NT_args
@rem Get arguments from the 4NT Shell from JP Software
set CMD_LINE_ARGS=%$

:execute
@rem Setup the command line

set CLASSPATH=%APP_HOME%\lib\SXP.jar;%APP_HOME%\lib\loremipsum-1.0.jar;%APP_HOME%\lib\httptunnel-0.92.jar;%APP_HOME%\lib\netty-3.5.7.Final.jar;%APP_HOME%\lib\Serpent.jar;%APP_HOME%\lib\log4j-1.2-api-2.1.jar;%APP_HOME%\lib\log4j-web-2.5.jar;%APP_HOME%\lib\jetty-webapp-9.3.22.v20171030.jar;%APP_HOME%\lib\commons-collections4-4.0.jar;%APP_HOME%\lib\jersey-server-2.7.jar;%APP_HOME%\lib\jersey-container-servlet-2.7.jar;%APP_HOME%\lib\jersey-container-servlet-core-2.7.jar;%APP_HOME%\lib\jersey-container-jetty-http-2.7.jar;%APP_HOME%\lib\jersey-media-moxy-2.7.jar;%APP_HOME%\lib\javaee-api-7.0.jar;%APP_HOME%\lib\derby-10.12.1.1.jar;%APP_HOME%\lib\eclipselink-2.6.3-M1.jar;%APP_HOME%\lib\javax.persistence-2.1.1.jar;%APP_HOME%\lib\jackson-databind-2.6.3.jar;%APP_HOME%\lib\jxse-2.7.jar;%APP_HOME%\lib\jdom2-2.0.6.jar;%APP_HOME%\lib\guava-19.0.jar;%APP_HOME%\lib\acme4j-utils-0.8.jar;%APP_HOME%\lib\javax.el-api-2.2.4.jar;%APP_HOME%\lib\javax.el-2.2.4.jar;%APP_HOME%\lib\javax.servlet-api-3.1.0.jar;%APP_HOME%\lib\jetty-xml-9.3.22.v20171030.jar;%APP_HOME%\lib\jersey-common-2.7.jar;%APP_HOME%\lib\jersey-client-2.7.jar;%APP_HOME%\lib\javax.ws.rs-api-2.0.jar;%APP_HOME%\lib\javax.annotation-api-1.2.jar;%APP_HOME%\lib\hk2-api-2.2.0.jar;%APP_HOME%\lib\javax.inject-2.2.0.jar;%APP_HOME%\lib\hk2-locator-2.2.0.jar;%APP_HOME%\lib\validation-api-1.1.0.Final.jar;%APP_HOME%\lib\jetty-continuation-9.1.1.v20140108.jar;%APP_HOME%\lib\jersey-entity-filtering-2.7.jar;%APP_HOME%\lib\org.eclipse.persistence.moxy-2.5.0.jar;%APP_HOME%\lib\org.eclipse.persistence.antlr-2.5.0.jar;%APP_HOME%\lib\javax.mail-1.5.0.jar;%APP_HOME%\lib\commonj.sdo-2.1.1.jar;%APP_HOME%\lib\javax.json-1.0.4.jar;%APP_HOME%\lib\jackson-annotations-2.6.0.jar;%APP_HOME%\lib\jackson-core-2.6.3.jar;%APP_HOME%\lib\bcprov-jdk15-140.jar;%APP_HOME%\lib\acme4j-client-0.8.jar;%APP_HOME%\lib\bcpg-jdk15on-1.55.jar;%APP_HOME%\lib\bcmail-jdk15on-1.55.jar;%APP_HOME%\lib\slf4j-api-1.7.21.jar;%APP_HOME%\lib\jersey-guava-2.7.jar;%APP_HOME%\lib\osgi-resource-locator-1.0.1.jar;%APP_HOME%\lib\hk2-utils-2.2.0.jar;%APP_HOME%\lib\aopalliance-repackaged-2.2.0.jar;%APP_HOME%\lib\javassist-3.18.1-GA.jar;%APP_HOME%\lib\org.eclipse.persistence.core-2.5.0.jar;%APP_HOME%\lib\activation-1.1.jar;%APP_HOME%\lib\jose4j-0.5.2.jar;%APP_HOME%\lib\bcprov-jdk15on-1.55.jar;%APP_HOME%\lib\bcpkix-jdk15on-1.55.jar;%APP_HOME%\lib\javax.inject-1.jar;%APP_HOME%\lib\org.eclipse.persistence.asm-2.5.0.jar;%APP_HOME%\lib\hibernate-validator-5.3.3.Final.jar;%APP_HOME%\lib\jboss-logging-3.3.0.Final.jar;%APP_HOME%\lib\classmate-1.3.1.jar;%APP_HOME%\lib\log4j-api-2.5.jar;%APP_HOME%\lib\log4j-core-2.5.jar;%APP_HOME%\lib\jetty-servlet-9.3.22.v20171030.jar;%APP_HOME%\lib\jetty-util-9.3.22.v20171030.jar;%APP_HOME%\lib\jetty-security-9.3.22.v20171030.jar;%APP_HOME%\lib\jetty-server-9.3.22.v20171030.jar;%APP_HOME%\lib\jetty-http-9.3.22.v20171030.jar;%APP_HOME%\lib\jetty-io-9.3.22.v20171030.jar

@rem Execute SXP
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %SXP_OPTS%  -classpath "%CLASSPATH%" controller.Application %CMD_LINE_ARGS%

:end
@rem End local scope for the variables with windows NT shell
if "%ERRORLEVEL%"=="0" goto mainEnd

:fail
rem Set variable SXP_EXIT_CONSOLE if you need the _script_ return code instead of
rem the _cmd.exe /c_ return code!
if  not "" == "%SXP_EXIT_CONSOLE%" exit 1
exit /b 1

:mainEnd
if "%OS%"=="Windows_NT" endlocal

:omega

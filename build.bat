@echo off
REM Requires a full JDK 17+ on PATH (javac, jar, jpackage) - not just a JRE.
REM Result: out\package\Order AutoPrint\Order AutoPrint.exe  (bundled runtime, no Java install needed)
setlocal
if exist out rmdir /s /q out
mkdir out\classes
mkdir out\dist
javac --release 17 -d out\classes src\com\orderautoprint\*.java || exit /b 1
jar --create --file out\dist\order-autoprint.jar --main-class com.orderautoprint.Main -C out\classes . || exit /b 1
set ICON=
if exist app.ico set ICON=--icon app.ico
jpackage --type app-image --name "Order AutoPrint" --app-version 1.0.0 %ICON% ^
  --input out\dist --main-jar order-autoprint.jar --main-class com.orderautoprint.Main ^
  --add-modules java.desktop,java.logging,java.prefs,jdk.httpserver,jdk.charsets ^
  --java-options "-Dfile.encoding=UTF-8" --dest out\package || exit /b 1
echo.
echo Done: out\package\Order AutoPrint\Order AutoPrint.exe

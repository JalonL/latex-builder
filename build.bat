@echo off
setlocal enabledelayedexpansion

REM =====================================================
REM  LaTeX Builder (Docker + texlive-full)
REM  Usage: build.bat path\to\document.tex
REM  Output: document.pdf (same folder)
REM  All temp files remain inside the container
REM =====================================================

if "%~1"=="" (
    echo Usage: build.bat path\to\document.tex
    exit /b 1
)

for %%I in ("%~1") do (
    set "TEX_FILE=%%~fI"
    set "DIR=%%~dpI"
    set "NAME=%%~nI"
)

echo.
echo Building LaTeX document: %TEX_FILE%
echo Output directory: %DIR%
echo.

docker run --rm ^
    --entrypoint /bin/sh ^
    -e FILE_NAME=%NAME% ^
    -v "%DIR%:/data" ^
    latex-builder ^
    -c "cp -r /data/* /build/ && cd /build && latexmk -pdf $FILE_NAME.tex && cp /build/$FILE_NAME.pdf /data/"

if %errorlevel% neq 0 (
    echo.
    echo ❌ Build failed.
    exit /b %errorlevel%
)

echo.
echo ✅ PDF successfully created: %DIR%%NAME%.pdf
endlocal

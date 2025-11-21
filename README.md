Latex Builder - Docker Version
=========================================================

This latex builder enables you to build latex documents in a docker container.
Therefore all annoying temp-files gets stuck inside the container and only the resulting pdf-File will be exported.

This Latex Builder uses textlive-full.

## Usage
To use this latex-builder you have the following options:

### Windows
On windows use the `build.bat` script:
```cmd
build.bat path/to/document.tex
```
### Linux
On linux use the `build.sh` script:
```shell
./build.sh path/to/document.tex
```
NOTE: Maybe you need to execute `chmod +x build.sh` to give the file permission to execute.

The pdf-File will be created at the same path where the `document.tex` is located. Also the input `.tex`-File can have any name you want (e.g. `main.tex`). The pdf-Name will be the same as your input `.tex`-File
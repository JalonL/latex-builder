#!/bin/sh

# =====================================================
#  LaTeX Builder (Docker + texlive-full)
#  Usage: ./build.sh path/to/document.tex
#  Output: document.pdf (same folder)
#  All temp files remain inside the container
# =====================================================

if [ -z "$1" ]; then
    echo "Usage: $0 path/to/document.tex"
    exit 1
fi

# Get absolute path, directory, and base filename (no extension)
TEX_FILE="$(realpath "$1")"
DIR="$(dirname "$TEX_FILE")"
NAME="$(basename "$TEX_FILE" .tex)"

echo
echo "Building LaTeX document: $TEX_FILE"
echo "Output directory: $DIR"
echo

docker run --rm \
    --entrypoint /bin/sh \
    -e FILE_NAME="$NAME" \
    -v "$DIR:/data" \
    latex-builder \
    -c "cp -r /data/* /build/ && cd /build && latexmk -pdf \"\$FILE_NAME.tex\" && cp /build/\"\$FILE_NAME.pdf\" /data/"

if [ $? -ne 0 ]; then
    echo
    echo "❌ Build failed."
    exit 1
fi

echo
echo "✅ PDF successfully created: $DIR/$NAME.pdf"

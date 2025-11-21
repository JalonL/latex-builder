# Start from a minimal Debian base and install full TeX Live
FROM debian:bookworm-slim

# Install texlive-full and latexmk
RUN apt-get update && apt-get install -y --no-install-recommends \
    texlive-full \
    latexmk \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /build

# Default entrypoint — can be overridden in docker run
ENTRYPOINT ["latexmk", "-pdf", "-interaction=nonstopmode", "-halt-on-error"]

# 🚀 ProtoXApp's Pico Firmware Generator 🚀

## Description

Welcome to **ProtoXApp's Pico Firmware Generator**, your one-stop solution for Raspberry Pi Pico firmware needs! This Docker image encapsulates all the tools and scripts needed to build Pico firmware like a pro, without the hassle. It's like having a personal assistant for firmware generation, but this one doesn't complain or take coffee breaks.

## Features

- 🛠️ **Automated Firmware Building**: Clone and compile Pico repositories with a single command.
- 🐍 **Python-Powered**: Uses a Python script that's as reliable as grandma's cookie recipe.
- 🐳 **Dockerized**: Everything is neatly packed into a Docker container for portable, reproducible builds.
- 🗂️ **Organized Output**: Get your compiled firmware and example files stored in an organized fashion.
- 🌍 **Environment Variable Support**: Customize your firmware builds by specifying repositories via environment variables.

## How to Use

1️⃣ **Pull the Docker Image**
```bash
docker pull protoxapp/pico-firmware-generator
```

2️⃣ **Run the Docker Container**
```bash
docker run -it --rm --name pico-container -v ~/Code/proto-x-app/pico-firmware-generator/output:/output protoxapp/pico-firmware-generator
```

3️⃣ **Check Output Directory**
Your freshly baked firmware and example files will be in the `/output` directory.

4️⃣ **Custom Repos**
To specify custom firmware repositories, set the `PICO_FIRMWARE_REPOS` environment variable.

## Environment Variables

### `PICO_FIRMWARE_REPOS`

This environment variable allows you to specify which Raspberry Pi Pico firmware repositories you'd like to clone and build. Set `PICO_FIRMWARE_REPOS` to a semicolon-separated list of repository URLs.

#### Why Is This Awesome? 🌟

Ever wanted to build firmware from multiple sources without the fuss? With `PICO_FIRMWARE_REPOS`, you can do just that! 

- **Official SDK**: By default, we use the official Pico SDK. So, if you don't set this variable, you're still good to go.
- **Your Own Repos**: Got your own custom firmware repository? Just add it to the list like so: `https://<source_control_url>/my-pico-project.git`.
- **Multiple Sources**: Want to build firmware from multiple repositories? No problemo! Just separate each URL with a semicolon.

#### Example Usage:

```bash
docker run -it --rm --name pico-container \
-e PICO_FIRMWARE_REPOS="https://github.com/raspberrypi/pico-sdk.git;https://<source_control_url>/my-pico-project.git" \
-v ~/Code/proto-x-app/pico-firmware-generator/output:/output protoxapp/pico-firmware-generator
```

By setting the `PICO_FIRMWARE_REPOS` environment variable, you can tailor your firmware generation to meet your specific needs, whether it's for a personal project or for global domination (of the good kind, of course).

## Troubleshooting

Should you run into issues (although we doubt it, this thing is pretty slick), please check the logs for any errors during the cloning and build steps.

## Community & Support

Join us on [GitHub](https://github.com/proto-x-app/pico-firmware-generator) for source code, issues, and feature requests.

### Be a Firmware Magician Today! 🎩✨

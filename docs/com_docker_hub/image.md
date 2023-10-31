### 🚀 Proto-X-App's Pico Firmware Generator 🚀

Ever wanted to generate Raspberry Pi Pico firmware like a pro, but without all the manual labor? Your wish is our command! Introducing Proto-X-App's Pico Firmware Generator—where cutting-edge tech meets user-friendly design. 

#### 🌟 Key Features 🌟

- **Automated Builds**: Just set your desired repositories and watch the magic unfold!
- **Multi-Repo Support**: Clone and build firmware from multiple sources with a simple environment variable.
- **Dockerized Goodness**: Wrapped in a Docker container for ease of use and deployment.
  
#### 🛠️ How to Use 🛠️

1. **Pull the Image**: `docker pull protoxapp/pico-firmware-generator`
2. **Run the Container**: `docker run -it --rm --name pico-container -v ~/Code/proto-x-app/pico-firmware-generator/output:/output protoxapp/pico-firmware-generator`
3. **Custom Repos**: To add your own repositories, use the `PICO_FIRMWARE_REPOS` environment variable.

#### 🔗 Useful Links 🔗

- [GitHub Repository](https://github.com/Proto-X-App/pico-firmware-generator)
- [Official Documentation](https://docs.proto-x-app.com/pico-firmware-generator)

So go ahead, give it a whirl and experience firmware generation like never before!

import os
import subprocess
import shutil
import glob
import json

class PicoFirmwareGenerator:
    def __init__(self, repos):
        self.repos = repos
        self.firmware_output_dir = "/output/firmware"
        self.example_output_dir = "/output/examples"
        os.makedirs(self.firmware_output_dir, exist_ok=True)
        os.makedirs(self.example_output_dir, exist_ok=True)

    def clone_sdk_base(self):
        pico_sdk_path = os.getenv("PICO_SDK_PATH", "/workspace/sdk")
        pico_sdk_url = os.getenv("PICO_SDK_URL", "https://github.com/raspberrypi/pico-sdk.git")
        subprocess.run(["git", "clone", pico_sdk_url, pico_sdk_path])
        subprocess.run(["cd", pico_sdk_path, "&&", "git", "submodule", "update", "--init"])

    def log_output(self, message, status):
        log = {
            "message": message,
            "status": status
        }
        print(json.dumps(log))

    def clone_repo(self, repo_url):
        self.log_output(f"Cloning {repo_url}...", "STARTED")
        subprocess.run(["git", "clone", repo_url], check=True)
        self.log_output(f"Cloning {repo_url} completed.", "DONE")

    def copy_examples(self, repo_name):
        self.log_output(f"Copying examples from {repo_name}...", "STARTED")
        subprocess.run(["cp", "-r", f"{repo_name}", self.example_output_dir], check=True)
        self.log_output(f"Copying examples from {repo_name} completed.", "DONE")

    def build_firmware(self, repo_name):
        self.log_output(f"Building firmware for {repo_name}...", "STARTED")
        os.chdir(repo_name)
        subprocess.run(["git", "submodule", "update", "--init"], check=True)
        subprocess.run(["mkdir", "build"], check=True)
        os.chdir("build")
        subprocess.run(["cmake", ".."], check=True)
        subprocess.run(["make"], check=True)
        self.log_output(f"Building firmware for {repo_name} completed.", "DONE")

    def copy_firmware(self):
        self.log_output("Copying firmware...", "STARTED")
        for uf2_file in glob.iglob('**/*.uf2', recursive=True):
            shutil.copy(uf2_file, self.firmware_output_dir)
        self.log_output("Copying firmware completed.", "DONE")

    def clone_and_build(self):
        for repo_url in self.repos:
            repo_name = repo_url.split('/')[-1].replace('.git', '')
            try:
                self.clone_repo(repo_url)
                self.copy_examples(repo_name)
                self.build_firmware(repo_name)
                self.copy_firmware()
                os.chdir("../..")
            except subprocess.CalledProcessError as e:
                self.log_output(f"An error occurred while processing {repo_name}: {e}", "ERROR")
                continue

if __name__ == "__main__":
    # Instantieer de PicoFirmwareGenerator klasse
    repo_list = os.getenv("PICO_FIRMWARE_REPOS", "").split(";")
    if not repo_list or repo_list == ['']:
        print("No repositories specified. Using default Raspberry Pi Pico examples.")
        repo_list = ["https://github.com/raspberrypi/pico-examples.git"]

    generator = PicoFirmwareGenerator(repos=repo_list)

    # Kloon de basis SDK
    generator.clone_sdk_base()

    # Kloon en bouw de voorbeelden
    generator.clone_and_build()
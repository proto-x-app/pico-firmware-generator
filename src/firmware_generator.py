import os
import subprocess
import shutil
import glob

class PicoFirmwareGenerator:
    def __init__(self, repos):
        self.repos = repos
        self.firmware_output_dir = "/output/firmware"
        self.example_output_dir = "/output/examples"

        # Maak de nodige directories
        os.makedirs(self.firmware_output_dir, exist_ok=True)
        os.makedirs(self.example_output_dir, exist_ok=True)

    def clone_and_build(self):
        for repo_url in self.repos:
            repo_name = repo_url.split('/')[-1].replace('.git', '')
            try:
                # Clone de repository
                subprocess.run(["git", "clone", repo_url], check=True)
                # Kopieer de voorbeelden naar de output directory
                subprocess.run(["cp", "-r", f"{repo_name}", self.example_output_dir], check=True)
                # Verplaats naar de repository directory
                os.chdir(repo_name)
                # Initialiseer en update de submodules
                subprocess.run(["git", "submodule", "update", "--init"], check=True)
                # Voer CMake en make uit om het voorbeeld te compileren
                subprocess.run(["mkdir", "build"], check=True)
                os.chdir("build")
                subprocess.run(["cmake", ".."], check=True)
                subprocess.run(["make"], check=True)
                # Kopieer het .uf2 bestand naar de output directory
                for uf2_file in glob.iglob('**/*.uf2', recursive=True):
                    shutil.copy(uf2_file, self.firmware_output_dir)
                # Ga terug naar de oorspronkelijke werkmap
                os.chdir("../..")
            except subprocess.CalledProcessError as e:
                print(f"Er is een fout opgetreden tijdens het verwerken van {repo_name}: {e}")
                continue  # Ga verder met de volgende repository

if __name__ == "__main__":
    # Lees de omgevingsvariabele voor de repository URL's
    repo_list = os.getenv("PICO_FIRMWARE_REPOS", "").split(";")

    # Als er geen repositories zijn opgegeven, gebruik dan de standaard Raspberry Pi Pico voorbeelden
    if not repo_list or repo_list == ['']:
        print("Geen repositories opgegeven. Gebruik standaard Raspberry Pi Pico voorbeelden.")
        repo_list = ["https://github.com/raspberrypi/pico-examples.git"]

    # Instantieer de PicoFirmwareGenerator klasse
    generator = PicoFirmwareGenerator(repos=repo_list)

    # Kloon en bouw de voorbeelden
    generator.clone_and_build()

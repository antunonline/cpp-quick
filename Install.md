

### Installation

In the root of this project execute:

    sudo bash scripts/1-install-os-packages.sh
    sudo bash scripts/2-prepare-environment.sh
    sudo cp scripts/3-install-libraries.sh /opt/cpp/
    sudo cp scripts/4-verify.sh /opt/cpp/
    sudo -i -u cpp
    cd /opt/cpp
    bash 3-install-libraries.sh
    bash 4-verify.sh


### Installation

In the root of this project execute:

    sudo bash 1-install-os-packages.sh
    sudo bash 2-prepare-environment.sh
    sudo cp 3-install-libraries.sh /opt/cpp/
    sudo cp 4-verify.sh /opt/cpp/
    sudo -i -u cpp
    cd /opt/cpp
    bash 3-install-libraries.sh
    bash 4-verify.sh
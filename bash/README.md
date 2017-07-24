# Usage

use the following command to use it in bash

    for elem in $(ls -1 ~/.bashrc.d/*.sh); do dos2unix $elem; done
    sed -i "/\.bashrc\.d/d" .bashrc
    echo 'for elem in $(ls -1 ~/.bashrc.d/*.sh); do file $elem | grep -s -q "with CRLF line" && dos2unix $elem; done' >> ~/.bashrc
    echo 'for elem in $(ls -1 ~/.bashrc.d/*.sh); do if [ $(basename $elem) != "func.sh" ]; then source $elem; fi; done' >> ~/.bashrc
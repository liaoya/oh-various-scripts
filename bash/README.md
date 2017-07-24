# Usage

use the following command to use it in bash

    echo 'for elem in $(ls -1 ~/.bashrc.d/*.sh); do if [ $(basename $elem) != "func.sh" ]; then echo $elem; fi; done >> ~/.bashrc'
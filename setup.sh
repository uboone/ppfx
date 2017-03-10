#!/bin/bash


# source /grid/fermiapp/minerva/software_releases/v10r7p3/setup.sh
setup(){
    . "/grid/fermiapp/products/minerva/etc/setups.sh"
    local TOP=${PWD}

    setup -q debug -f Linux+2.6-2.5 root v5_30_00
    export M32=-m64
    export MODE="NUMI"
    # setup for jobsub client
    # according to the prescription in Mike Kirby's talk
    # minerva doc-10551, Dec 2014
    source /grid/fermiapp/products/common/etc/setups.sh
    setup jobsub_client
    setup ifdhc
    export IFDH_BASE_URI="http://samweb-minerva.fnal.gov:20004/sam/minerva/api"
    export MODE="NUMI"

    export BOOSTROOT=/nusoft/app/externals/boost/v1_55_0/source/boost_1_55_0
    # bash magic pulled off of stack exchange
    # gets the full path to the location of setup.sh
    export PPFX_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
    echo "setting PPFX_DIR=${PPFX_DIR}"
    export LD_LIBRARY_PATH=$PPFX_DIR/lib:$LD_LIBRARY_PATH
    echo "LD_LIBRARY_PATH=$LD_LIBRARY_PATH"

#    source /nusoft/app/externals/setup
#    setup -q debug:e5 -f Linux64bit+2.6-2.5 dk2nu v01_01_03

    source /grid/fermiapp/products/nova/externals/setup
    setup -q debug:e9:r5 -f Linux64bit+2.6-2.12 dk2nu v01_05_00

}
setup

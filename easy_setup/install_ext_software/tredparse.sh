#!/bin/bash

# INSTALLING TREDPARSE #####
# TREDPARSE: HLI Short Tandem Repeat (STR) caller
# Process a list of TRED (trinucleotide repeats disease) loci, and infer the most likely genotype.

# https://github.com/humanlongevity/tredparse
# only supported for python > 2.7, python 3 not yet supported
# if tral is saved within a root path one may use to run this script

# License:
# The STR Typing Software Code (the "Code") is made available by Human
# Longevity, Inc. ("HLI") on a non-exclusive, non-sublicensable,
# non-transferable basis solely for non-commercial academic research use.
# Commercial use of the Code is expressly prohibited.  If you would like to obtain
# a license to the Code for commercial use, please contact HLI at
# bizdev@humanlongevity.com.  HLI MAKES NO REPRESENTATIONS OR WARRANTIES
# WHATSOEVER, EITHER EXPRESS OR IMPLIED, WITH RESPECT TO THE CODE PROVIDED
# HEREUNDER. IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR
# PURPOSE WITH RESPECT TO CODE ARE EXPRESSLY DISCLAIMED. THE CODE IS FURNISHED
# "AS IS" AND "WITH ALL FAULTS" AND DOWNLOADING OR USING THE CODE
# IS UNDERTAKEN AT YOUR OWN RISK.  TO THE FULLEST EXTENT ALLOWED BY APPLICABLE
# LAW, IN NO EVENT SHALL HLI BE LIABLE, WHETHER IN CONTRACT, TORT, WARRANTY, OR
# UNDER ANY STATUTE OR ON ANY OTHER BASIS FOR SPECIAL, INCIDENTAL, INDIRECT,
# PUNITIVE, MULTIPLE OR CONSEQUENTIAL DAMAGES SUSTAINED BY YOU OR ANY OTHER PERSON
# OR ENTITY ON ACCOUNT OF USE OR POSSESSION OF THE CODE, WHETHER OR NOT
# FORESEEABLE AND WHETHER OR NOT HLI HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH
# DAMAGES, INCLUDING WITHOUT LIMITATION DAMAGES ARISING FROM OR RELATED TO LOSS OF
# USE, LOSS OF DATA, DOWNTIME, OR FOR LOSS OF REVENUE, PROFITS, GOODWILL, BUSINESS
# OR OTHER FINANCIAL LOSS.


######################
### Housekeeping

PARENT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; cd .. ; pwd -P )
# other files are located one directory above
. $PARENT_PATH/configTRAL_path.cfg # provide paths from config file


# install virtual environment called "tral2" with python2
virtualenv $TRAL_ENV/python2 -p python2

cd $TRAL_ENV/python2
. bin/activate


## -- TODO possible to use apt within virtenv?

apt-get install python-dev # install header files and static libraries for python2 dev
apt install ipython

######################
### Installation tredparse

pip install tredparse

# Wrapper, sourcing tral2, call tred.py with all arguments "$@"
# with the command "tred" tred.py can be started from everywhere

activateEnv=$TRAL_ENV/python2/bin/activate
echo -e '#!/bin/sh
# wrapper file to easily start tredparse

.' $activateEnv '
tred.py "$@"' > $TRAL_EXT_SOFTWARE/tred


chmod +x $TRAL_EXT_SOFTWARE/tred
cp $TRAL_EXT_SOFTWARE/tred /usr/local/bin # copy wrapper file to system path 
deactivate
cd $HOME

# ######################
# ### Uninstall tredparse

# # symply delete the virtenv in which tred is installed + wrapper file

# rm -rf $TRAL_ENV/python2
# rm $TRAL_EXT_SOFTWARE/tred
# rm /usr/local/bin/tred
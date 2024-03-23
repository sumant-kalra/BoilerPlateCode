#!/usr/bin/env python
from __future__ import print_function

# the above command includes the print function from the future versions
# it is possible that some systems have python2 while others have python3 set to the environment variable python
# the only difference it will make for the hpccm script is the print function which has different syntax in both
# So, we are considering both the situations: python2 as well as python3
# if python=python2 then we are asking it to use the print function from the new version of python and
# if python=python3 then it is already using the print from the new version of python

# importing argparse module for input to the script as command line arguments
import argparse 
# importing hpccm module
import hpccm
# importing specific building blocks from the hpccm module
from hpccm.building_blocks import packages, boost, gnu, python, pip
# importing specific primitives from the hpccm modules 
from hpccm.primitives import copy, shell, environment, workdir
from hpccm.primitives import baseimage, runscript

############ Code to parse the command line arguments ########################
parser = argparse.ArgumentParser(description='MigrationScripts with HPCCM')
parser.add_argument('--format', type=str, default='docker',
                    choices=['docker', 'singularity'],
                    help='Container specification format (default: docker)')

args, unknown = parser.parse_known_args()
#############################################################################

Stage0 = hpccm.Stage()

######################### Start "Recipe" ####################################
Stage0.name = 'build'
Stage0 += baseimage(image='centos/mysql-80-centos7')
Stage0 += python(python3=True).runtime()
Stage0 += copy(src='app', dest='/opt/MigrationScripts/', _mkdir=True)
Stage0 += copy(src='settings_sample', dest='/opt/MigrationScripts/', _mkdir=True)
Stage0 += copy(src='run.sh', dest='/opt/MigrationScripts/', _mkdir=True)
Stage0 += copy(src='.flaskenv', dest='/opt/MigrationScripts/', _mkdir=True)
Stage0 += copy(src='migrator.py', dest='/opt/MigrationScripts/', _mkdir=True)
Stage0 += shell(commands=['mkdir /opt/workspace /scratch /glb', 'rm -rf /etc/my.cnf.d /var/lib/mysql'])
Stage0 += shell(commands=['ln -sFf /opt/workspace/metadata/mysql/config /etc/my.cnf.d'])
Stage0 += shell(commands=['ln -sFf /opt/workspace/metadata/mysql /var/lib/'])
#Stage0 += shell(commands=['ln -sFf /opt/workspace/metadata/mysql/scratch /scratch'])
Stage0 += pip(requirements='requirements.txt', pip='pip3')
Stage0 += runscript(commands=['/opt/MigrationScripts/run.sh'])
######################## End "Recipe" #######################################

# setting the container format as obtained from the arguments
hpccm.config.set_container_format(args.format)

# All the building blocks and primitives return strings which is stored and appended in Stage0 variable
# Print the Stage0 variable as it contains the actual singularity definition
# We redirect the output of this script to a file Singularity.def
print(Stage0)
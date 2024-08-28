#!/bin/bash

build_version=$1
cobbler_version=$2
r_state=$3

# Set package version taken from integration pom in cobbler.spec file
perl -pi.bak -e "s/Version:.*/Version: ${build_version}/g" target/src/cobbler-${cobbler_version}/cobbler.spec

# Update provide section to make sure the original 3pp version is provided
perl -pi.bak -e "s/\<cobbler.version\>/${cobbler_version}/" target/src/cobbler-${cobbler_version}/cobbler.spec
perl -pi.bak -e "s/\<koan.version\>/${cobbler_version}/" target/src/cobbler-${cobbler_version}/cobbler.spec

# Update the packager section to add in the R state from the build
perl -pi.bak -e "s/\<ericsson.rstate\>/${r_state}/" target/src/cobbler-${cobbler_version}/cobbler.spec

# Set version in setup.py
perl -pi.bak -e "s/^VERSION =.*/VERSION = \"${build_version}\"/g" target/src/cobbler-${cobbler_version}/setup.py
perl -pi.bak -e "s/^VERSION_3PP =.*/VERSION_3PP = \"${cobbler_version}\"/g" target/src/cobbler-${cobbler_version}/setup.py

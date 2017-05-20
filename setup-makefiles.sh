#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -e

INITIAL_COPYRIGHT_YEAR=2015

# Required!
VENDOR=google
DEVICE=dragon

# Load extractutils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$MY_DIR" ]]; then MY_DIR="$PWD"; fi
REPO_ROOT="$MY_DIR"/../../..
ROM_ROOT=${REPO_ROOT}
HELPER=
for x in "${REPO_ROOT}"/vendor/*; do
  if [ -f "$x/build/tools/extract_utils.sh" ]; then
    HELPER="$x/build/tools/extract_utils.sh"
    break;
  fi
done
if [ ! -f "$HELPER" ]; then
  echo "Unable to find helper script at $HELPER"
  exit 1
fi
. "$HELPER"


# Initialize the helper
setup_vendor "$DEVICE" "$VENDOR" "$REPO_ROOT"

# Copyright headers and guards
write_headers

# The standard blobs
write_makefiles "$MY_DIR"/lineage-proprietary-blobs.txt

write_makefiles "$MY_DIR"/lineage-proprietary-blobs-vendorimg.txt

# We are done!
write_footers

cat "$MY_DIR"/proprietary-blobs-vendorimg.txt >> "$ROM_ROOT"/vendor/google/dragon/dragon-vendor.mk


#!/usr/bin/env bash
#
# RStudio Sentry Upload script (sentry-upload.sh)
# 
# Copyright (C) 2022 by Posit Software, PBC
#
# Unless you have received this program directly from Posit Software pursuant
# to the terms of a commercial license agreement with Posit Software, then
# this program is licensed to you under the terms of version 3 of the
# GNU Affero General Public License. This program is distributed WITHOUT
# ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING THOSE OF NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Please refer to the
# AGPL (http://www.gnu.org/licenses/agpl-3.0.txt) for more details.
#
# Uploads the build directory (presumed to be the current working directory) to
# Sentry.
#
# Usage: 
#
#    sentry-upload.sh API_KEY RETRY_LIMIT
#
# where API_KEY is the Sentry API key
# and RETRY_LIMIT is the number of retries to upload

export SENTRY_HTTP_MAX_RETRIES=$2

# Attempt upload
/usr/local/bin/sentry-cli --auth-token $1 upload-dif --org rstudio --project ide-backend -t elf .

# Was upload successful?
if [ $? -eq 0 ]; then
    echo "Sentry upload complete"
else
    echo "Sentry upload failed"
    exit 1
fi

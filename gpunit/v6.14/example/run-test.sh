#!/usr/bin/env bash

############################################################
# run-test.sh
#   Convenience script for running the gpunit tests for this module
#
# Alternative ...
# (1) launch GpUnit with server specific settings in genepattern-private repo
#
#     run-gpunit-gpbroad
#
#     # gpunit.testfolder: `pwd`/example.yml
#     # output_dir:        `pwd`/tmp
#
#     For details, see .profile, alias run-gpunit-gpbroad=
#       <genepattern-private>/deploy/broad/gpbroad/gpunit/run-gpunit-gpbroad.sh
############################################################

declare -r script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

gp_url_default=http://127.0.0.1:8080
gp_user_default=test
gp_password_default=not_set
gpunit_trustStore_default="${HOME}/gpunit_client/gpbroad/gpunit_keystore.jks"
gpunit_testfolder_default=`pwd`
# Note: for debugging, run ConvertLineEndings test ...
# gpunit_testfolder_default="${GPUNIT_HOME}/tests/testGpUnit/testStep/cle.yml"

read -p "gp_url (default=$gp_url_default): " gp_url
gp_url=${gp_url:-$gp_url_default}

# extract scheme from gp_url string
gp_scheme=${gp_url%%:*}
tmp1=${gp_url/*:\/\//}
gp_host=${tmp1/[:\/]*/}

read -p "gpunit.trustStore (default=${gpunit_trustStore_default}): " gpunit_trustStore
gpunit_trustStore=${gpunit_trustStore:-$gpunit_trustStore_default}

read -p "gp_user (default=$gp_user_default): " gp_user
gp_user=${gp_user:-$gp_user_default}
read -s -p "password: " gp_password
gp_password=${gp_password:-}

read -p "gpunit.testfolder (default=$gpunit_testfolder_default): " gpunit_testfolder
gpunit_testfolder=${gpunit_testfolder:-$gpunit_testfolder_default}

ant -f \
  "${GPUNIT_HOME}/build.xml" \
  "-Dgp.host=${gp_host}" \
  "-Dgpunit.trustStore=${gpunit_trustStore}" \
  "-Dgp.url=${gp_url}" \
  "-Dgp.user=${gp_user}" \
  "-Dgp.password=${gp_password}" \
  "-Dgpunit.outputdir=`pwd`/jobResults" \
  "-Dgpunit.save.downloads=true" \
  "-Dgpunit.localAssertions=true" \
  "-Dgpunit.jobCompletionTimeout=7000" \
  "-Dgpunit.testfolder=${gpunit_testfolder}" \
gpunit

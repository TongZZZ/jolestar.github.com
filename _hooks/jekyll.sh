#!/bin/bash

GIT_DIR=$1

send_email_and_exit() {
  recipient=$1
  message=$2

  echo "Sending email and exiting due to error"
  echo $message
  mail -s "Blog generation failure" "${recipient}" << EOF
${message}
EOF

  exit 1
}

echo "Running at "`date`

emailto="jolestar@gmail.com"

echo  $GIT_DIR
cd $GIT_DIR

jekyll --no-auto  --no-safe

exitCode=$?

if [ ${exitCode} != "0" ]; then
  send_email_and_exit "${emailto}" "Jekyll failed with exit code ${exitCode}"
fi


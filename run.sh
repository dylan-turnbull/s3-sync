#!/bin/sh -e

s3get () {
    echo "sync from s3"
    mkdir -p ${DEST_PATH}

    result=$(aws s3 sync --exact-timestamps s3://${AWS_BUCKET}/${KEY_PATH} ${DEST_PATH} --exclude "*.pyc" --delete 2>&1)
    result_code=$?

    if [[ $result_code != 0 ]]; then
      echo "###########"
      echo "Error! s3 sync failed"
      echo $result
      echo "Result Code: ${result_code}"
      echo "###########"
      continue
    fi

    echo "finished downloading from s3"
}

s3get

if [[ "${RUN_ONCE:-false}" = "true" ]]; then
  exit $result_code
fi

while true; do
  s3get
  sleep ${INTERVAL}
done

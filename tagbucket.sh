#!/bin/bash

#export AWS_DEFAULT_REGION=us-east-1
for i in `cat buckettags3.txt` 
do 
BUCKET_NAME=$(echo $i | awk -F'$' '{print $2}')
TAG=$(echo $i | awk -F'$' '{print $1}')
KEY=$(echo $TAG | awk -F'#' '{print $1}')
VALUE=$(echo $TAG | awk -F'#' '{print $2}')

#aws s3api put-bucket-tagging --bucket $BUCKET_NAME --tagging TagSet=[{Key=$KEY,Value=$VALUE}] --profile new_prod
done 

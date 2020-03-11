#!/bin/bash

export AWS_DEFAULT_REGION=us-east-1

for i in $(aws ec2 describe-volumes --query 'Volumes[*].Attachments[*].VolumeId' --output text --profile dev ); do
   echo $i
   for j in $(aws ec2 describe-volumes --volume-id $i --query 'Volumes[*].SnapshotId' --output text --profile dev ); do
      echo $j
        for k in $(aws ec2 describe-volumes --volume-ids $i --query 'Volumes[*].Tags[*]' --output text  --profile dev| awk '{print $1"#"$2}'); do
          echo $k
          KEY=$(echo $k | awk -F'#' '{print $1}')
          VALUE=$(echo $k | awk -F'#' '{print $2}')

          echo $KEY
          echo $VALUE
          aws ec2 create-tags --resources $j --tags Key=$KEY,Value=$VALUE  --profile dev
      done
  done
done


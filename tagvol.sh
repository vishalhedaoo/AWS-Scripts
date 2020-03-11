#!/bin/bash

export AWS_DEFAULT_REGION=us-east-1

for i in $(aws ec2 describe-instances --query 'Reservations[*].Instances[*].InstanceId' --output text --profile dev| tr "\t" "\n"); do
   echo $i
   for j in $(aws ec2 describe-volumes --filters Name=attachment.instance-id,Values=$i --query 'Volumes[*].{ID:VolumeId}' --output text --profile dev); do
      echo $j
        for k in $(aws ec2 describe-instances --instance-id=$i --query 'Reservations[].Instances[].{ID:Tags[*]}' --output text --profile dev | awk '{print $2"#"$3}'); do
          echo $k  
          KEY=$(echo $k | awk -F'#' '{print $1}')
          VALUE=$(echo $k | awk -F'#' '{print $2}')

          echo $KEY
          echo $VALUE
      aws ec2 create-tags --resources $j --tags Key=$KEY,Value=$VALUE  --profile dev
      done 
  done
done

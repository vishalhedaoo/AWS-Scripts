#!/bin/bash
export AWS_DEFAULT_REGION=us-east-1

for i in $(aws ec2 describe-instances --query 'Reservations[*].Instances[*].InstanceId' --output text | tr "\t" "\n"); do
   echo $i
   for j in $(aws ec2 describe-volumes --filters Name=attachment.instance-id,Values=$i --query 'Volumes[*].{ID:VolumeId}' --output text ); do
      echo $j
      aws ec2 create-tags --resources $i $j --tags Key=ENV,Value=STAGE
   done
done

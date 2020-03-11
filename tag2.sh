#!/bin/bash

export AWS_DEFAULT_REGION=us-east-1
for i in $(aws ec2 describe-instances --query 'Reservations[*].Instances[*].InstanceId' --output text | tr "\t" "\n"); do
   echo $i
   for j in $(aws ec2 describe-volumes --filters Name=attachment.instance-id,Values=$i --query 'Volumes[*].{ID:VolumeId}' --output text); do
     echo $j
      for k in $(aws ec2 describe-instances --query 'Reservations[].Instances[].SecurityGroups[*].GroupId' --output text | tr "\t" "\n"); do
          echo $k
            for l in $(aws ec2 describe-instances --query 'Reservations[].Instances[].ImageId' --output text | tr "\t" "\n"); do
              echo $l
              aws ec2 create-tags --resources $i $j $k $l --tags Key=ENV,Value=STAGE

             done
      done        
   done  
done


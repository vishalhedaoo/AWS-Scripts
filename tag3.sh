#!/bin/bash

export AWS_DEFAULT_REGION=us-east-1
INST=$(aws ec2 describe-instances --query 'Reservations[*].Instances[*].InstanceId' --output text | tr "\t" "\n")
VOL=$(aws ec2 describe-volumes --query 'Volumes[*].VolumeId' --output text | tr "\t" "\n" )
SG=$(aws ec2 describe-instances --query 'Reservations[*].Instances[*].SecurityGroups[*].GroupId' --output text | tr "\t" "\n")
AMI=$(aws ec2 describe-instances --query 'Reservations[*].Instances[*].ImageId' --output text | tr "\t" "\n")


for i in $INST  
do
      echo $i 
      aws ec2 create-tags --resources $i --tags Key=ENV,Value=STAGE
done

for j in $VOL
do
      echo $j
      aws ec2 create-tags --resources $j --tags Key=ENV,Value=STAGE
done

for k in $SG
do
      echo $k
      aws ec2 create-tags --resources $k --tags Key=ENV,Value=STAGE
done

for l in $AMI
do
      echo $l
      aws ec2 create-tags --resources $l --tags Key=ENV,Value=STAGE
done

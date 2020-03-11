#!/bin/bash

for i in $(aws ec2 describe-instances --query 'Reservations[*].Instances[*].InstanceId' --output text  | tr "\t" "\n"); do
   echo $i
   for j in $(aws ec2 describe-instances --instance-id $i --query 'Reservations[*].Instances[*].[ImageId,SecurityGroups[*].GroupId]' --output text  ); do
      echo $j
        for k in $(aws ec2 describe-instances --instance-id=$i --query 'Reservations[].Instances[].{ID:Tags[*]}' --output text   | awk '{print $2"#"$3}'); do
          echo $k 
               KEY=$(echo $k | awk -F'#' '{print $1}')
               VALUE=$(echo $k | awk -F'#' '{print $2}')
	  echo $KEY
          echo $VALUE
      aws ec2 create-tags --resources $j --tags Key="$KEY",Value="$VALUE"   
      done 
  done
done


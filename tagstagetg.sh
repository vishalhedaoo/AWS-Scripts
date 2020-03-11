#!/bin/bash

export AWS_DEFAULT_REGION=us-east-1
for i in $(aws elbv2 describe-load-balancers --query 'LoadBalancers[*].LoadBalancerArn' --output text  | tr "\t" "\n"); do
   echo $i
   for j in $(aws elbv2 describe-target-groups --load-balancer-arn $i --query 'TargetGroups[*].TargetGroupArn' --output text    | tr "\t" "\n"); do
      echo $j
        for k in $(aws elbv2 describe-tags --resource-arns $i --query 'TagDescriptions[*].Tags' --output text   | awk '{print $1"#"$2}'); do
          echo $k  
          KEY=$(echo $k | awk -F'#' '{print $1}')
          VALUE=$(echo $k | awk -F'#' '{print $2}')

          echo $KEY
          echo $VALUE
      aws elbv2 add-tags --resource-arns $j --tags Key=$KEY,Value=$VALUE   
      done 
  done
done


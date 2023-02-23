#!/bin/bash
set -e
basedir="/Users/yivantsov/projects/forks/my/data-center-helm-charts/src/main/charts"
readme="README.md"
products=(bamboo jira bitbucket confluence)

actions=("Add" "Update" "Remove" "Fix" "Refactor" "Optimize" "Merge" "Move" "Rework")
objects=("chart" "values" "templates" "dependencies" "tests" "documentation" "helmfile" "statefulset")
descriptions=("to improve performance" "for better readability" "to fix a bug" "for better maintainability" "to update dependencies" "to remove deprecated code" "to implement a new feature" "to optimize memory usage" "to enhance flexibility")

for i in {1..4}; do
  for product in ${products[@]}; do
    echo "Committing to ${product}/${readme}. Take $i"
    action_index=$((RANDOM % ${#actions[@]}))
    object_index=$((RANDOM % ${#objects[@]}))
    description_index=$((RANDOM % ${#descriptions[@]}))
    commit_message="${actions[$action_index]} ${product} ${objects[$object_index]} ${descriptions[$description_index]}"
    echo "$commit_message" >> $basedir/$product/$readme
    git add $basedir/${product}/$readme
    git commit -m "$commit_message"
    
    echo "****************************************************"
    echo "DUPLICATE COMMIT MESSAGE"
    echo "****************************************************"
    echo "Update ${products}" >> $basedir/$product/$readme
    git add $basedir/${product}/$readme
    git commit -m "Update appVersion in DC apps"
    
    echo "****************************************************"
    echo "COMMIT MESSAGE TO DROP"
    echo "****************************************************"
    echo "Update ${products}" >> $basedir/$product/$readme
    git add $basedir/${product}/$readme  
    git commit -m "Prepare release $((1 + RANDOM % 20)).$((1 + RANDOM % 20)).$((1 + RANDOM % 20)).$((1 + RANDOM % 20))"
  done
done
git push origin main

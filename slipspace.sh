function slipspace() {
  if [ $# -ne 2 ]; then
    echo "Usage: slipspace deploy [environment]"
  else
    if [ $1 = "deploy" ]; then
      if [ ! -f slipspace.json ]; then
        echo "No slipspace configuration file was found in the current directory. Please ensure you are in the proper directory and it contains a slipspace.json configuration file."
      else
        env=$2
        host=`cat slipspace.json | jq ".environments.$env.host"`
        host="${host//\"}"
        user=`cat slipspace.json | jq ".environments.$env.user"`
        user="${user//\"}"
        path=`cat slipspace.json | jq ".environments.$env.path"`
        path="${path//\"}"
        after=`cat slipspace.json | jq -c -r ".environments.$env.after[] + \";\" "`
        migrate=`cat slipspace.json | jq ".environments.$env.migrate // null"`
        if [ "$migrate" = "null" ]; then
          ssh -t $user@$host "echo 'Deploying to ${env}...'; cd ${path}; echo 'Fetching source...'; git reset --hard; git checkout ${env}; git pull origin ${env}; echo 'Running post-deploy tasks...'; ${after}exit; bash"
        else
          ssh -t $user@$host "echo 'Deploying to ${env}...'; cd ${path}; echo 'Fetching source...'; git reset --hard; git checkout ${env}; git pull origin ${env}; echo 'Running post-deploy tasks...'; ${after}echo 'Running migrations...'; ${migrate}; exit; bash"
        fi
        echo "Deployment to ${env} has finished."
      fi  
    else
      echo "Invalid command. Usage: slipspace deploy [environment]"
    fi  
  fi  
}
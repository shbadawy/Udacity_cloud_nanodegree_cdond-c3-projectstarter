flowID=$1
STACKS=$@
echo "flowID: $flowID"
echo "STACKS: $STACKS"

for stack in $STACKS[@]
do
if [[ $stack =~ "$flowID" ]]
then
  echo "Keeping $stack because equal"
elif [[ $stack =~ "production" ]]
then
  echo "Keeping $stack because production stack"
elif [[ $stack =~ "Initial" ]]
then
  echo "Keeping $stack because initial stack"
else
  echo "Deleting $stack"
  aws s3 rm "s3://$stack" --recursive
  aws cloudformation delete-stack --stack-name "udapeople-backend-$flowID"
  aws cloudformation delete-stack --stack-name "udapeople-frontend-$flowID"
fi
done

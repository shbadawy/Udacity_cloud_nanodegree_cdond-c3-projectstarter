flowID=$1
STACKS=$@
echo "flowID: $flowID"
echo "STACKS: $STACKS"

for stack in $STACKS[@]
do
BUCKETNAME=${stack: -7}
echo "BUCKETNAME: $BUCKETNAME"
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
  echo "URL: s3://udapeople-$BUCKETNAME"
  aws s3 rm "s3://udapeople-$BUCKETNAME" --recursive
  aws cloudformation delete-stack --stack-name "udapeople-backend-$flowID"
  aws cloudformation delete-stack --stack-name "udapeople-frontend-$flowID"
fi
done

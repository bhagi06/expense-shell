#!/bin/bash

#logging,validation,coloring are important for everu script

USERID=$(id -u)

#Timmestamp and logs
Timmestamp=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log

#colors
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\6[0m"
echo "Please enter db password  :"
read -s mysql_root_password
#root access
VALIDATE(){
    if [$1 -ne 0 ]
    then 
    echo -e "$2....$R FAILURE $N"
    exit 1
    else
    echo -e "$2-----$G sucess $N"
    fi
}
 if [ $USERID -ne 0 ]
then
echo " Please run this script with root access."
exit 1 #manually exit if error comes
else
 echo "You are super user."
 fi

 dnf module disable nodejs -y &>>LOGFILE
 VALIDATE $? "Disabling default node js"


 dnf module enable nodejs:20 -y &>>LOGFILE
VALIDATE $? "enabling default node js:20 versiom"


 dnf install nodejs -y &>>LOGFILE
VALIDATE $? "installing default node js"

useradd expense
VALIDATE $? "creatig expense user"

id expense  &>>LOGFILE
if [$? -ne 0]
then
  useradd expense &>>LOGFILE
VALIDATE  $? "Creating expense user"
else
echo -e "expense user alread created ....$Y SKIPPING $N"
fi
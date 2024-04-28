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

 dnf install mysql-server -y &>>$LOGFILE
 VALIDATE $? "Installing Mysql server"

 systemctl enable mysqld &>>$LOGFILE
 VALIDATE $? "Enabling mqsql server"

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "Starting my sql server"


mysql_secure_installation --set-root-pass ExpenseApp@1
VALIDATE $? "setting up root password"
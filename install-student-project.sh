#!/bin/sh

# Check parameters were passed in
if [ -z "$1" ]; then
    echo "Missing studentName parameter"
    exit
fi

if [ -z "$2" ]; then
    echo "Missing githubUrl parameter"
    exit
fi


# Variables
DESTINATION="students"
STUDENT_NAME=$1
REPO_URL=$2
REPO_NAME=$(echo $REPO_URL | awk -F/ '{print $NF}' | sed -e 's/.git$//')
LOCAL_REPO=$DESTINATION"/"$STUDENT_NAME"/"$REPO_NAME"/public"


# Report details
echo '---- DETAILS ---- '
echo "STUDENT_NAME: ${STUDENT_NAME}"
echo "REPO_URL: ${REPO_URL}"
echo "REPO_NAME: ${REPO_NAME}"
echo "DESTINATION: ${DESTINATION}"
echo "LOCAL REPO: ${LOCAL_REPO}"


# Make directory
echo '---- MAKE/REPlACE DIRECTORY ---- '
cd $DESTINATION
rm -rf $STUDENT_NAME # Remove the directory if it's already there
mkdir $STUDENT_NAME
cd $STUDENT_NAME


# Clone repo
echo '---- CLONE PROJECT ---- '
git clone $REPO_URL $REPO_NAME
cd $REPO_NAME


# Create database
echo '---- CREATE DATABASE ---- '
/Applications/MAMP/Library/bin/mysql -uroot -proot -e "drop database student_${STUDENT_NAME}"
/Applications/MAMP/Library/bin/mysql -uroot -proot -e "create database student_${STUDENT_NAME}"


# Create env file
echo '---- CREATE .env FILE ---- '
cat >.env <<EOL
APP_ENV=local
APP_DEBUG=true
APP_KEY=yourkeyhere

DB_HOST=localhost
DB_DATABASE=student_${STUDENT_NAME}
DB_USERNAME=root
DB_PASSWORD=root

CACHE_DRIVER=file
SESSION_DRIVER=file
QUEUE_DRIVER=sync

MAIL_DRIVER=smtp
MAIL_HOST=mailtrap.io
MAIL_PORT=2525
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
EOL


# Initialize project
echo '---- CHANGE PERMISSIONS ---- '
chmod -R 777 storage
chmod -R 777 bootstrap/cache


# Composer install
echo '---- COMPOSER INSTALL ---- '
composer install


# Generate key
echo '---- GENEREATE KEY ---- '
php artisan key:generate

# Migrations/seeds
echo '---- RUN MIGRATIONS & SEEDS ---- '
php artisan migrate:fresh --seed


echo '---- CONFIG VHOST ---- '
# Default location of the apache conf file for MAMP
CONF_FILE="/Applications/MAMP/conf/apache/extra/httpd-vhosts.conf"

# Fine the lines that contain the string `DocumentRoot`
OLD_LINE=$(cat $CONF_FILE | grep DocumentRoot)
echo "OLD_LINE:$OLD_LINE"

## Set new doc root to current directory
NEW_LINE="    DocumentRoot $(pwd)/public"
echo "NEW_LINE:$NEW_LINE"

## Replace doc root strings in conf file
sed -i.bak -e "s|${OLD_LINE}|${NEW_LINE}|g" $CONF_FILE

# Fine the lines that contain the string `DocumentRoot`
OLD_LINE=$(cat $CONF_FILE | grep \<Directory)
echo "OLD_LINE:$OLD_LINE"

### Set new doc root to current directory
NEW_LINE="    <Directory $(pwd)/public>"
echo "NEW_LINE:$NEW_LINE"

### Replace doc root strings in conf file
sed -i.bak -e "s|${OLD_LINE}|${NEW_LINE}|g" $CONF_FILE

## Restart server
sudo /Applications/MAMP/Library/bin/apachectl -k restart && sleep 2 && open "http://student.loc"


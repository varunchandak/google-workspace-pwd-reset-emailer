#!/bin/bash

echo "Please enter the OAUTH_TOKEN:"
read OAUTH_TOKEN

export DOMAIN="example.com"
export FROM_EMAIL="noreply@example.com"

cat gws-users.csv | cut -d, -f1 | while read EMAIL_ADDRESS; do
    echo "$EMAIL_ADDRESS"
    export PASSWORD="$(openssl rand -base64 14)"
    echo "$PASSWORD"
    cat password-reset-email.html | sed "s,XXXXXXXXXXXXX,$PASSWORD,g" > "$EMAIL_ADDRESS"-password-reset-email.html
    curl \
        --request PUT \
        --header "Authorization: Bearer $OAUTH_TOKEN" \
        --header 'Accept: application/json' \
        --header 'Content-Type: application/json' \
        --compressed \
        --data '{"changePasswordAtNextLogin":true,"password":"'$PASSWORD'"}' \
        "https://admin.googleapis.com/admin/directory/v1/users/$EMAIL_ADDRESS" && \
    sendemail \
        -t "$EMAIL_ADDRESS" \
        -u "IMPORTANT: Your $DOMAIN Google account password" \
        -xu "$SES_USERNAME" -xp "$SES_PASSWORD" \
        -o message-content-type=html \
        -o message-file="$EMAIL_ADDRESS"-password-reset-email.html \
        -o tls=auto \
        -s email-smtp.us-east-1.amazonaws.com:587 \
        -f "$FROM_EMAIL"
    sleep 5
done

#!/bin/bash

function init_session {

	TENANT_ID=''

	APP_ID=''

	TOKEN_SECRET=""

	MS_URL='https://login.microsoftonline.com/'$TENANT_ID'/oauth2/v2.0/token?Host=login.microsoftonline.com'

	MS_BODY=client_id=''$APP_ID'&scope=https%3A%2F%2Fgraph.microsoft.com%2F.default&client_secret='$TOKEN_SECRET'&grant_type=client_credentials'

	TOKEN=$(echo "Authorization: Bearer $(curl -sX POST "Content-Type=application/x-www-form-urlencoded" -d "$MS_BODY" "$MS_URL" | jq -r '.access_token')")

}

init_session

SERVICE_STATUS=$(curl -s --location --request GET "https://graph.microsoft.com/v1.0/admin/serviceAnnouncement/healthOverviews/$1" --header 'odata.maxpagesize: 1000' --header "$TOKEN" | jq -r .status)


case $SERVICE_STATUS in

	serviceOperational)

		echo "0"
	;;


	serviceDegradation)

		echo "1"
	;;


	serviceInvestigating)

		echo "2"
	;;

	serviceInterruption)

		echo "3"
	;;

	serviceRestoring)

		echo "4"
	;;

	extendedRecovery)

		echo "5"
	;;

	investigationSuspended)

		echo "6"
	;;

	serviceRestored)

		echo "7"
	;;

	falsePositive)

		echo "8"
	;;

	postIncidentReportPublished)

		echo "9"
	;;


	*)

		echo "$SERVICE_STATUS"

	;;

esac
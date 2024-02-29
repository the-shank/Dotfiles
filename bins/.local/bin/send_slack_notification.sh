#!/bin/bash

set -eu
set -o pipefail

# check if ~/.slack_notification_webhook exists
if [ ! -f ~/.slack_notification_webhook ]; then
	echo "Slack webhook URL not found. Please run 'setup_slack_notifications_webhook.sh' to set it up"
	exit 1
fi

# message to send is the argument to this script.
# ensure that it is not empty
if [ -z "$1" ]; then
	echo "No message to send. Please provide a message"
	exit 1
fi

msg="$1"
webhook=$(cat ~/.slack_notification_webhook)

# send the message to Slack
curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"${msg}\"}" "${webhook}" >/dev/null 2>&1

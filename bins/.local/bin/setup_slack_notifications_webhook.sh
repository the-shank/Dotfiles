#!/bin/bash

set -eu
set -o pipefail

setup_slack_webhook() {
	echo "Enter your Slack webhook URL: "
	read -r webhook
	echo "${webhook}" >~/.slack_notification_webhook
	echo "Slack webhook URL saved to ~/.slack_notification_webhook"
	echo "You can now use the slack_notification script to send notifications to Slack"
	exit 0
}

check_setup() {
	# if ~/.slack_notification_webhook exists then ask if user wants to overwrite
	if [ -f ~/.slack_notification_webhook ]; then
		echo "File ~/.slack_notification_webhook already exists. Do you want to overwrite it? (y/n)"
		read -r overwrite
		if [ "$overwrite" == "y" ]; then
			setup_slack_webhook
		else
			echo "Exiting..."
			exit 0
		fi
	else
		setup_slack_webhook
	fi
}
check_setup

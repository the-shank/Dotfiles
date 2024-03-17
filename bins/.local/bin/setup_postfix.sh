#!/bin/bash

set -eu
set -o pipefail

# ensure that postfix is installed
check_installed() {
	local binary=$1
	if ! command -v $binary &>/dev/null; then
		echo "Error: $binary is not installed"
		exit 1
	fi
}
check_installed postfix

setup_postfix() {
	# ask user for email and password
	read -p "Enter email: " email
	read -s -p "Enter password: " password
	echo

	! sudo postfix stop

	# Create file `/etc/postfix/sasl/sasl_password` with the content:
	# `[smtp.gmail.com]:587 shashanksharma21@gmail.com:qodjkozoaqdmyqll`
	# do this with sudo
	sudo mkdir -p /etc/postfix/sasl
	sudo bash -c "echo '[smtp.gmail.com]:587 ${email}:${password}' >/etc/postfix/sasl/sasl_password"
	sudo postmap /etc/postfix/sasl/sasl_password
	sudo chmod 600 /etc/postfix/sasl/sasl_password /etc/postfix/sasl/sasl_password.db

	# update the main.cf file
	# add the line `relayhost = [smtp.gmail.com]:587` if it doesn't exist
	# add the line `smtp_sasl_auth_enable = yes` if it doesn't exists
	# add the line smtp_sasl_auth_enable = yes
	# add the line smtp_sasl_security_options = noanonymous
	# add the line smtp_sasl_password_maps = hash:/etc/postfix/sasl/sasl_password
	# add the line smtp_tls_security_level = encrypt
	# add the line smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt
	# do this with sudo
	! sudo sed -i '/relayhost = \[smtp.gmail.com\]:587/d' /etc/postfix/main.cf
	! sudo sed -i '/smtp_sasl_auth_enable = yes/d' /etc/postfix/main.cf
	! sudo sed -i '/smtp_sasl_security_options = noanonymous/d' /etc/postfix/main.cf
	! sudo sed -i '/smtp_sasl_password_maps = hash:\/etc\/postfix\/sasl\/sasl_password/d' /etc/postfix/main.cf
	! sudo sed -i '/smtp_tls_security_level = encrypt/d' /etc/postfix/main.cf
	! sudo sed -i '/smtp_tls_CAfile = \/etc\/ssl\/certs\/ca-certificates.crt/d' /etc/postfix/main.cf

	sudo bash -c 'echo "relayhost = [smtp.gmail.com]:587" >>/etc/postfix/main.cf'
	sudo bash -c 'echo "smtp_sasl_auth_enable = yes" >>/etc/postfix/main.cf'
	sudo bash -c 'echo "smtp_sasl_security_options = noanonymous" >>/etc/postfix/main.cf'
	sudo bash -c 'echo "smtp_sasl_password_maps = hash:/etc/postfix/sasl/sasl_password" >>/etc/postfix/main.cf'
	sudo bash -c 'echo "smtp_tls_security_level = encrypt" >>/etc/postfix/main.cf'
	sudo bash -c 'echo "smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt" >>/etc/postfix/main.cf'

	# crate the file ~/.postfix_setup
	touch ~/.postfix_setup

	echo "Postfix setup complete"

	# start the postfix service
	sudo postfix start
}

# check if postfix is already setup
check_already_setup() {
	# if ~/.postfix_setup exists, then postfix is already setup
	if [ -f ~/.postfix_setup ]; then
		echo "Postfix is already setup"
		# if the user wants to setup again, then remove the file and run the setup
		# else exit
		read -p "Do you want to setup postfix again? [y/N] " response
		if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
			rm ~/.postfix_setup
			setup_postfix
		else
			exit 0
		fi
	else
		setup_postfix
	fi

}
check_already_setup

#!/bin/bash

echo
echo Initializing server configuration utility as user $(whoami) on $(uname)-$(uname -r)
echo
echo Press [1] to install webserver
echo Press [2] to install PHP
echo Press [3] to install DBMS
echo Press [4] to install WordPress
echo Press [5] to change LSWS password
echo
read -p 'Enter choice: ' varoption


if [ "$varoption" = "1" ]; then
    echo
    echo Press [1] to choose MySQL
    echo Press [2] to choose MariaDB
    echo
    read -p 'Enter choice: ' varDBMS
    echo
    echo Press [1] to install LSWS
    echo Press [1] to install LSWS
    echo Press [2] to install Apache
    echo Press [3] to install Nginx
    echo
    read -p 'Enter choice: ' varserver
    echo
    # Install LSWS
    if [ "$varserver" = "1" ]; then
        echo "\e[1;31mInstalling Litespeed Webserver...\e[0m"
        echo
        change_LSWS_password
        install_DBMS

    # Install Apache
    elif [ "$varserver" = "2" ]; then
        echo "\e[1;31mInstalling Apache Webserver...\e[0m"
        install_Apache
        install_DBMS

    # Install Nginx
    elif [ "$varserver" = "3" ]; then
        echo "\e[1;31mInstalling Nginx Webserver...\e[0m"

    else
        echo "Invalid input"
    fi



elif [ "$varoption" = "2" ]; then
    echo "Installing PHP"
elif [ "$varoption" = "3" ]; then
    echo "Installing DBMS"
elif [ "$varoption" = "4" ]; then
    echo "Installing WordPress"
elif [ "$varoption" = "5" ]; then
    sudo sh admpass.sh
else
    echo "Invalid input"
fi

install_LSWS () {
    wget -O - http://rpms.litespeedtech.com/debian/enable_lst_debian_repo.sh | sudo bash
    sudo apt update
    sudo apt install openlitespeed
}

install_Apache () {
    sudo apt-get update
    sudo apt-get install apache2 apache2-utils

    # Enable Apache to start at system boot time
    sudo systemctl enable apache2
    sudo systemctl start apache2
    sudo systemctl status apache2
}

install_DBMS () {
    if [ "$varDBMS" = "1" ]; then
        install_MySQL
    elif [ "$varserver" = "2" ]; then
        install_MariaDB
}

install_MySQL () {
    sudo apt-get install mysql-client mysql-server
}

install_MariaDB () {
    sudo apt-get install mariadb-server mariadb-client
}

change_LSWS_password () {
    sudo sh admpass.sh
}
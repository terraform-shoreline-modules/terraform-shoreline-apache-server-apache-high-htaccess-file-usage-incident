bash

#!/bin/bash



# Backup the original Apache configuration file

sudo cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bak



# Modify the Apache configuration file to disallow the use of .htaccess files

sudo sed -i 's/AllowOverride All/AllowOverride None/g' /etc/httpd/conf/httpd.conf



# Restart the Apache web server to apply the changes

sudo systemctl restart httpd.service
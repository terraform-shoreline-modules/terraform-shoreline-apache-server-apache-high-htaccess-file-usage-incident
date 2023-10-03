
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Apache High .htaccess File Usage Incident
---

This incident type likely refers to a situation where there is a high usage of .htaccess files in an Apache web server environment. .htaccess files are configuration files that can be used to control access to specific directories or files. A high usage of these files may indicate potential security risks or performance issues that need to be addressed. This type of incident may require investigation and remediation to ensure the stability and security of the web server environment.

### Parameters
```shell
export DOCUMENT_ROOT="PLACEHOLDER"

export SERVER_IP="PLACEHOLDER"
```

## Debug

### Check if Apache is running
```shell
systemctl status apache2
```

### Check Apache error logs
```shell
tail -n 50 /var/log/apache2/error.log
```

### Check Apache access logs for unusual activity
```shell
tail -n 50 /var/log/apache2/access.log
```

### Check for any recent changes to .htaccess files
```shell
find ${DOCUMENT_ROOT} -name ".htaccess" -type f -mtime -1 -ls
```

### Check if mod_rewrite module is enabled
```shell
apache2ctl -M | grep rewrite
```

### Check .htaccess syntax for errors
```shell
apachectl configtest
```

### Check Apache configuration for any overrides in .htaccess files
```shell
grep -r "AllowOverride" /etc/apache2/
```

### Check server load and resource usage
```shell
top
```

### Check network connectivity to the server
```shell
ping ${SERVER_IP}
```

### Check firewall rules for any blocks
```shell
iptables -L
```

## Repair

### Disable the .htaccess file globally: This can be done by modifying the Apache configuration to disallow the use of .htaccess files globally. This will help in reducing the attack surface for the web application.
```shell
bash

#!/bin/bash



# Backup the original Apache configuration file

sudo cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bak



# Modify the Apache configuration file to disallow the use of .htaccess files

sudo sed -i 's/AllowOverride All/AllowOverride None/g' /etc/httpd/conf/httpd.conf



# Restart the Apache web server to apply the changes

sudo systemctl restart httpd.service


```
__Automation:__<br>
`0  6  *  *  5  [ "$(date +\%d0" -gt 14 -a "$(date +\%d0" -lt 21 ] && /path/to/script &> /path/to/log/file`<br>
This will execute the script every third Friday of the month and it will send both the stdout and stderr output from the last execution to a file for logging/troubleshooting porposes.<br>
__Necessary Folder Structure:__<br>
/home/user<br>
--conatiners<br>
----folder with the name of the service of the container<br>
------docker-compose.yaml
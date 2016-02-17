now="$(date)"
printf "Current date and time %s\n" "$now"
 
now="$(date +'%d/%m/%Y')"
printf "Current date in dd/mm/yyyy format %s\n" "$now"
 
echo "Starting backup at $now, please wait..."

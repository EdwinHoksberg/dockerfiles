#!/bin/bash
MCS_DIR="/usr/local/mariadb/columnstore"

# capture getSystemStatus and remove first 9 lines and blank lines to just have status table contents
STATUS=$($MCS_DIR/bin/mcsadmin getSystemStatus | tail -n +9  | sed '/^$/d' )
# grab system status line
SYSTEM_STATUS=$(echo "$STATUS" | grep 'System' | awk '{ printf $2; }')
# combine module status lines
MODULE_STATUS=$(echo "$STATUS" | grep 'Module' | awk '{ printf $2 ":" $3 " "; }')

# if system status is ACTIVE, then all good otherwise consider critical failure
if [ "$SYSTEM_STATUS" == "ACTIVE" ]
then
  echo "OK - system: $SYSTEM_STATUS, modules: $MODULE_STATUS"
  exit 0
else
  echo "CRITICAL - system: $SYSTEM_STATUS, modules: $MODULE_STATUS"
  exit 1
fi

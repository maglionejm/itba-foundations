#!/bin/bash

echo 'Database structure creation starting'
psql -h $DB_HOST -U $DB_USER -d $DB_DATABASE -f tables_script.sql
echo 'Database structure creation finished'


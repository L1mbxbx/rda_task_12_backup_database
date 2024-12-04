#!/bin/bash

# Read database credentials from environment variables
DB_USER=${DB_USER}
DB_PASSWORD=${DB_PASSWORD}

# Define database names
SOURCE_DB="ShopDB"
RESERVE_DB="ShopDBReserve"
DEV_DB="ShopDBDevelopment"

# Define temporary backup files
FULL_BACKUP="/tmp/${SOURCE_DB}_full_backup.sql"
DATA_BACKUP="/tmp/${SOURCE_DB}_data_backup.sql"

# Create a full backup of ShopDB and restore it to ShopDBReserve
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --databases "$SOURCE_DB" > "$FULL_BACKUP"
mysql -u "$DB_USER" -p"$DB_PASSWORD" "$RESERVE_DB" < "$FULL_BACKUP"

# Create a data-only backup of ShopDB and restore it to ShopDBDevelopment
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-info "$SOURCE_DB" > "$DATA_BACKUP"
mysql -u "$DB_USER" -p"$DB_PASSWORD" "$DEV_DB" < "$DATA_BACKUP"

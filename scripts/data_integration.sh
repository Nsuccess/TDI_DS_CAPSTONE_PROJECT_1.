#!/usr/bin/env bash

# Create the db folder if it doesn't exist
mkdir -p db

# Define the data-hub folder path
data_hub=./data-hub 

# Check if the data-hub directory exists
if [ ! -d "$data_hub" ]; then
    echo "The '$data_hub' directory not found!"
    exit 1
fi

# Initialize the header flag as false
header_written=false

# Loop through all CSV files in the data-hub directory
for file in "$data_hub"/*.csv; do
    # If the file exists, process it
    if [ -f "$file" ]; then
        echo "Processing file: $file"

        # If the header hasn't been written yet, write it
        if [ "$header_written" = false ]; then
            head -n 1 "$file" > db/database.csv
            header_written=true
        fi

        # Append the content of the CSV file, excluding the header
        tail -n +2 "$file" >> db/database.csv
    fi
done

echo "Data integration complete"

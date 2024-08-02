#!/bin/bash

# Temporary file to store discovered URLs
DISCOVERED_URLS="discovered_urls.txt"
OUTPUT_FILE="filtered_emails.txt"
AI_SCRIPT="email_extraction.py"

# Clear or create the output file
> "$OUTPUT_FILE"

# Step 1: Find URLs (Example using Google search with a specific query)
echo "Finding websites..."
for query in "example query" "another query"; do
  python -c "
from googlesearch import search
for url in search('$query', num_results=10):
    print(url)
" >> "$DISCOVERED_URLS"
done

# Step 2: Remove duplicates and empty lines
sort -u "$DISCOVERED_URLS" | grep -v '^$' > "$DISCOVERED_URLS.tmp"
mv "$DISCOVERED_URLS.tmp" "$DISCOVERED_URLS"

# Step 3: Scrape emails from the discovered URLs using AI
echo "Scraping emails from discovered URLs..."
while IFS= read -r url; do
  if [[ -n "$url" ]]; then
    echo "Scraping $url..."
    python "$AI_SCRIPT" "$url" >> "$OUTPUT_FILE"
  fi
done < "$DISCOVERED_URLS"

echo "Scraping completed. Emails are saved in $OUTPUT_FILE."


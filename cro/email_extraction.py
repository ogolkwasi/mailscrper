import sys
import requests
from bs4 import BeautifulSoup
import re

def extract_emails(url):
    try:
        response = requests.get(url)
        response.raise_for_status()
    except requests.RequestException as e:
        print(f"Error fetching {url}: {e}")
        return []

    soup = BeautifulSoup(response.text, 'html.parser')
    text = soup.get_text()

    # Regex pattern for Gmail and Jotmail emails
    email_regex = r'[a-zA-Z0-9._%+-]+@(gmail\.com|hotmail\.com)'
    emails = re.findall(email_regex, text)
    
    return set(emails)

if __name__ == "__main__":
    url = sys.argv[1]
    emails = extract_emails(url)
    for email in emails:
        print(email)

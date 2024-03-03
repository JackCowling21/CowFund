import requests
from bs4 import BeautifulSoup
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import hashlib
import os

# Function to fetch and hash the table content
def fetch_and_hash(url):
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')
    table = soup.find('table', {'id': 'the_table_id'})  # Use the actual ID or a unique identifier
    hashed_content = hashlib.md5(table.encode()).hexdigest()
    return hashed_content

# Function to send an email
def send_email(subject, body):
    sender = 'your_email@example.com'
    receiver = 'receiver_email@example.com'
    msg = MIMEMultipart()
    msg['From'] = sender
    msg['To'] = receiver
    msg['Subject'] = subject
    msg.attach(MIMEText(body, 'plain'))
    
    server = smtplib.SMTP('smtp.example.com', 587)  # Use your SMTP server details
    server.starttls()
    server.login(sender, 'your_password')
    server.send_message(msg)
    server.quit()

# Main monitoring function
def monitor(url):
    current_hash = fetch_and_hash(url)
    previous_hash = ''

    # Check if we have a previous hash stored
    if os.path.exists('previous_hash.txt'):
        with open('previous_hash.txt', 'r') as file:
            previous_hash = file.read().strip()
    
    if current_hash != previous_hash:
        send_email('Website Updated', 'The monitored table has changed.')
        with open('previous_hash.txt', 'w') as file:
            file.write(current_hash)
    else:
        print("No changes detected.")

# URL to monitor
url_to_monitor = 'https://www.quiverquant.com/congresstrading/'
monitor(url_to_monitor)

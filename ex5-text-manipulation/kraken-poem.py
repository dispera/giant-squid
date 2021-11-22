# Used requests package to get the poem website,
# and BeautifulSoup to filter and print the paragraph with the poetry class,
# from the official docs:
# https://beautiful-soup-4.readthedocs.io/en/latest/

import requests
from bs4 import BeautifulSoup

url = "https://www.victorianweb.org/authors/tennyson/kraken.html"
response = requests.get(url)
html_doc = response.content

soup = BeautifulSoup(html_doc, 'html.parser')

for p in soup.find_all('p', {'class' : 'poetry'}):
    print(p.get_text())
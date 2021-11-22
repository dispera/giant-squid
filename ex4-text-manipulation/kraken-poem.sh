#!/bin/sh

# Let's get an inspiring poem for starting our workdays:
curl --silent https://www.victorianweb.org/authors/tennyson/kraken.html | tee | \
# I know from checking this page source, that they put the poem
# on a paragraph with 'poetry' css class, and that the kraken poem is 14 lines, 
# (I am sure you are familiar with it), so I grep for that:
grep '<p class="poetry">' -A14 | \
# I now remove that paragraph tag and class at the start:
sed 's/<p class="poetry">//' | \
# and I remove the html tag endings, as <br/>:
cut -d'<' -f1
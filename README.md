# Divvy Challenge 2013

Reporting for Divvy Bike usage in 2013

----

## Getting Started


```
# Install Meteor
curl https://install.meteor.com | /bin/sh

# Start the App
meteor
```

## Importing Data

The project deals with very large amounts of data stored as JSON. This JSON should be imported directly into the Mongo db using the following commands:

    cd /usr/local/bin && mongoimport -h localhost:3001 --db meteor --collection stations --jsonArray --type json --file ~/Code/divvy-data/stations.json && cd /usr/local/bin && mongoimport -h localhost:3001 --db meteor --collection trips --jsonArray --type json --file ~/Code/divvy-data/trips.json

## Deployment

### …on meteor.com

```
meteor deploy yourappname
```
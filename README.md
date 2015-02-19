# Divvy Challenge 2013

Reporting for Divvy Bike usage in 2013

----

## Getting Started


```
# Install Meteor
curl https://install.meteor.com | /bin/sh

# Install Meteorite
npm install -g meteorite

# Install Smart Packages
mrt install

# Start the App
meteor
```

## Importing Data

The project deals with very large amounts of data stored as JSON. This JSON should be imported directly into the Mongo db using the following commands:

    cd /usr/local/bin && mongoimport -h localhost:3001 --db meteor --collection stations --jsonArray --type json --file /Users/cmalven/Dropbox/Projects/Personal/Divvy\ Challenge/divvy-challenge-meteor/data/stations.json && cd /usr/local/bin && mongoimport -h localhost:3001 --db meteor --collection trips --jsonArray --type json --file /Users/cmalven/Dropbox/Projects/Personal/Divvy\ Challenge/divvy-challenge-meteor/data/trips.json

## Deployment

### …on meteor.com

```
meteor deploy yourappname
```

## Troubleshooting

### Permission woes?

It is *not* required that you run `sudo mrt`. If you do so, your home directory will pick up some root-owned files and you'll struggle to run `mrt` without `sudo` from then on. This isn't good.

To fix the problem, try cleaning up potentially "sudo-ed" files:

```bash
sudo mrt uninstall
sudo mrt uninstall --system
sudo chown -R `whoami` ~/.npm
```

If possible, try not to install Meteorite as root either. If you have permissions problems, make sure you install with `sudo -H npm install -g meteorite`. If you've installed without `-H`, your `~/.npm` directory will be owned by root and you should run the `chown` command above to fix it.

### If that fails, get rid of Meteorite and reinstall
```
mrt uninstall && mrt uninstall --system && npm install -g meteorite && mrt install
```

### Or uninstall and reinstall Meteor
```
rm -rf ~/.meteor/ && sudo rm /usr/local/bin/meteor

curl https://install.meteor.com | /bin/sh
```
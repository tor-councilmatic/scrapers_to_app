# Daily Toronto Scraper app

This repo is a barebones Heroku app that uses the Scheduler addon to run
Toronto's IncrementalEvent scraper daily. We are currently awaiting a
merge of [a change in the OpenCivicData
standard](https://github.com/opencivicdata/python-opencivicdata-django/pull/57),
and so are using a [custom
branch](https://github.com/patcon/scrapers-ca/tree/test/eventagendaitem-classification-scrape).

The app is hosted at https://scrapers-to.herokuapp.com, but since the
magic happens in the scheduled task, there's not much to look at.

For posterity, this is the setup that was required on Heroku to get this
working:

```
heroku config:set DATABASE_URL=<staging database url>
heroku config:set OCD_DIVISION_CSV=../country-ca-toronto.csv
heroku addons:create scheduler
heroku addons:open scheduler
# Add `cd scrapers && pupa update ca_on_toronto events-incremental`

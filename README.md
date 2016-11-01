# Daily Toronto Scraper app

This repo is a barebones Heroku app that uses the Scheduler addon to run
Toronto's IncrementalEvent scraper daily. We are currently awaiting a
merge of [a change in the OpenCivicData
standard](https://github.com/opencivicdata/python-opencivicdata-django/pull/57),
and so are using a [custom
branch](https://github.com/patcon/scrapers-ca/tree/test/eventagendaitem-classification-scrape).

The app is hosted at https://scrapers-to.herokuapp.com, but since the
magic happens in the scheduled task, there's not much to look at.

### Local

mkvirtualenv opencivicdata-ca --python=`python3`
workon opencivicdata-ca
cd scrapers && make pip-install
cd ..
make pupa-update people committees events-incremental
```

### Heroku

For posterity, this is the setup that was required on Heroku to get this
working:

```
heroku config:set DATABASE_URL=<staging database url>
heroku config:set OCD_DIVISION_CSV=../country-ca-toronto.csv
heroku addons:create scheduler
heroku addons:open scheduler
```

From the page openned above, we add this scheduled command to run
nightly during off-hours in Toronto:

    make pupa-update people committees events-incremental bills-incremental

If at any point we want to blow away the database and start from
scratch:

```
# Drop all tables in the database and repopulate divisions table
heroku run 'cd scrapers && pupa dbinit --reset ca'

# Manually re-run until scheduler takes over
heroku run make pupa-update people committees events-incremental bills-incremental
```

### Notes

* We can't auto-deploy this app from GitHub due to it's use of
  submodules, [which are not
supported](https://devcenter.heroku.com/articles/github-integration#git-submodules).
* Agendas (and therefore agenda items) are publicized throughout the day
  when they are ready. However, the agenda item search index, is run as
a scheduled task that should finish by 4am nightly. Since we use the
search results page as a central piece of our Bill scraper, we must run
this after 4am, or else the latest events will be scraped and have
agendas attached, but these agenda items won't have full Bills scraped
and available.

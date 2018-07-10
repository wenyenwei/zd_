# Overview
Zendesk Intern Challenge. Build on rails.
Up on heroku:
https://boiling-garden-33930.herokuapp.com/

* Note: You may find the last few commits confusing, it's because heroku doesn't support sqlite3 instead it uses postgres. Thus, some of the adjustments have to be done to deploy the webapp to heroku. See https://devcenter.heroku.com/articles/sqlite3 for more info.

# Setup

## Installation on Mac OS 

Git clone the repo, and cd into the folder.

Once you've got the required ruby installed, run the following commands:

* `gem install bundler`
* `bundle install`

This should download all the required project dependencies.

## Environment variables setup

Copy the file `.env.example` to a new file named `.env` and fill in your zendesk authentication info accordingly (replace the whole braces).

If you don't want to use your zendesk authentication info, you can simply view on heroku with my variables setup: https://boiling-garden-33930.herokuapp.com/

# Running the app
At this point you should be all good to go. In order to run the rails app, type the following:

* `rails server`


# Testing the app
To do unit testing to the app, simply follow below:

## Unit tests
These are written using rails testing. Find unit tests in the `test` folder. For this project, simple tests are mainly done in `test/controller/home_controller_test.rb`

To run unit tests, run:

* `rake`

* Note: If you didn't fill in your zendesk authentication info in step `Environment variables setup`, you will get errors in unit tests due to incomplete authentication info.

# Import Dataset
To import dataset through command to the app, simply follow below:

* `mongoimport --host=example.mlab.com:00000 -u my_username -p my_password --db example_db --collection example_collection --file example_file.json --jsonArray`

# WorkCheetah
WorkCheetah is a jobs website with the mission of reducing umemployment by connecting companies that need people with people looking for new opportunities.

## User Types

#### Employees

Has a resume but no account.
Can apply to jobs.

#### Freelancers

Has a resume and an account
Can send estimates
Can send invoices

#### Businesses

Has a resume and an account.
Resumes are termed Workprofiles in the application.
Accounts are more internal and store minimal business related data for that user.
Can send estimates
Can send invoices

## Activities Stream

### (done)

Client requests and activities stream for the each users dashboard. I've held off implementing this as we need the other stuff in first and these type of streams can be taxing on a database as they generate alot of queries. We'll definitely need some type of cache or use redis to help and keep the system performant.

## Chat System

### (To be re- done)

Currently Workcheetah has a in-app messaging system that is homegrown. They are nder "Conversations" and "Notifications". The client wishes to expand upon this. He wishes a central page where one recieves notifacations and messages and client wishes for an inbox setup approach with "inbox", "draft", "sent" etc, currently implementing this functionality may require more work than necassary and the interface to send a message currently is tedious and error prone. 

I've researched this and like the "https://github.com/ging/mailboxer" gem, it will give us all the functionality we desire and keep things cleaner, we'll have to remove a couple tables in a migration before installing this gem as existing tables would conflict with the gem. I recommend the following:

* Create this migration

* remove all chat and notification code (leave notes where you'd delete so we can come back and update with new messaging)

* Install the gem

* create the views for the gem

* hook up the new messaging code in old places

## Ad System

### (To be redone)

Workcheetah supports two type of Ads, images and text.
Advertisers create a Campaign that has any combination of the above ads. We target users by the campaign so all advertisements inherit
ad_targets from their campaign.

1/25/14 update: Currently watiing on new specs for this feature and the targeting system will need to be redone. Also, Im going to want to move the counters to redis backed for speed improvements.

### ON THE SERVER

This stuff does not need to be done in development.

Setup the daily stats aggregator as a rake task using either whenever gem or heroku's schedulur

    bundle exec rake ads:total_daily_stats

This will create an AdStat record with the days impression and click count for that ad and reset its daily counters to 0.

Setup the weekly advertisers billing task using the whenever gem or heroku's schedular

    bundle exec rake ads:generate_weekly_charges

This will go through each active Campaign and create an AdvertiserCharge record with the weeks charges. Charges are count * max_bid, count being either impression_count or click_count depending if that campaign is CPC or CPM, CPM count is divided by 100.
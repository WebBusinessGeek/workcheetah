# WorkCheetah
WorkCheetah is a jobs website with the mission of reducing umemployment by connecting companies that need people with people looking for new opportunities.


## Ad System

Workcheetah supports two type of Ads, images and text.
Advertisers create a Campaign that has any combination of the above ads. We target users by the campaign so all advertisements inherit
ad_targets from their campaign.

### ON THE SERVER

Setup the daily stats aggregator as a rake task using either whenever gem or heroku's schedulur

    bundle exec rake ads:total_daily_stats

This will create an AdStat record with the days impression and click count for that ad and reset its daily counters to 0.

Setup the weekly advertisers billing task using the whenever gem or heroku's schedular

    bundle exec rake ads:generate_weekly_charges

This will go through each active Campaign and create an AdvertiserCharge record with the weeks charges. Charges are count * max_bid, count being either impression_count or click_count depending if that campaign is CPC or CPM, CPM count is divided by 100.
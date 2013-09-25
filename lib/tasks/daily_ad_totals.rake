namespace :ads do
  desc "Seeds Ad Target Data"
  task :total_daily_stats => :environment do
    Campaign.where(active: true).each do |c|
      c.advertisements.each do |a|
        a.generate_daily_stats
      end
    end
  end

  task :generate_weekly_charges => :environment do
    AdvertiserAccount.all.each do |account|
      @campaigns = account.campaigns.where(active: true)
      @ad_invoice = account.advertiser_invoices.create
      @campaigns.each do |campaign|
        if campaign.cpc?
          quantity = campaign.advertisements.sum(&:total_click_count)
          description = "#{quantity} clicks accounted for #{campaign.name}"
        else
          quantity = campaign.advertisements.sum(&:total_impression_count)
          description = "#{quantity} clicks accounted for #{campaign.name}"
        end
        amount = campaign.max_bid
        @ad_invoice.advertiser_charges.create(
          amount: amount,
          description: description,
          quantity: quantity
        )
        @ad_invoice.amount = @ad_invoice.total_charge
        @ad_invoice.save!
      end
    end
  end
end
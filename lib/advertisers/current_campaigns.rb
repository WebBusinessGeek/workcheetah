module Advertisers
  class CurrentCampaigns
    def initialize(relation = AdvertiserAccount.scoped)
      @relation = relation
    end

    def active
      return @relation.campaigns.where(active: true)
    end

    def all
      return @relation.campaigns
    end
  end
end
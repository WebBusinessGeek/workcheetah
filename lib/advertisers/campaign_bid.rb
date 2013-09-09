#TODO: optimize for queries
module Advertisers
  class CampaignBid
    attr_reader :cpcPrice, :cpmPrice
    def initialize(campaign)
      @campaign = campaign
      @cpcPrice = 0
      @cpmPrice = 0
    end

    def getPrice
      if @campaign.cpc?
        calculateCPC
        @cpcPrice
      else
        calculateCPM
        @cpmPrice
      end
    end

    private
      def calculateCPC
        @cpcPrice += getBase(:cpc)
        @cpcPrice += getAudience(@campaign.audience_targets.map(&:name).first.to_s)
        @cpcPrice += getIndustry + getJob + getEmployee + getEducation + getAdvertiser
      end

      def calculateCPM
        @cpmPrice += getBase(:cpm)
        @cpmPrice += getAudience(@campaign.audience_targets.map(&:name).first.to_s)
        @cpmPrice += getIndustry + getJob + getEmployee + getEducation + getAdvertiser
      end

      def getBase(type)
        Campaign::BASE[type]
      end

      def getAudience(audience)
        Campaign::AUDIENCE[audience.to_sym]
      end

      def getIndustry
        Campaign::INDUSTRY * @campaign.industry_targets.size
      end

      def getJob
        Campaign::JOB * @campaign.industry_targets.size
      end

      def getEmployee
        Campaign::EMPLOYEE * @campaign.employee_targets.size
      end

      def getEducation
        Campaign::EDUCATION * @campaign.education_targets.size
      end

      def getAdvertiser
        Campaign::ADVERTISER * @campaign.advertiser_targets.size
      end
  end
end
#TODO: optimize for queries
module Advertisers
  class CampaignBid
    attr_reader :cpcPrice, :cpmPrice
    def initialize(campaign)
      @campaign = campaign
      @cpcPrice = 0
      @cpmPrice = 0
      @audience = @campaign.audience_targets.map(&:name).first.to_s
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
        @cpcPrice += getAudience(@audience)
        @cpcPrice += getIndustry + getJob + getEmployee + getEducation + getAdvertiser
      end

      def calculateCPM
        @cpmPrice += getBase(:cpm)
        @cpmPrice += getAudience(@audience)
        @cpmPrice += getIndustry + getJob + getEmployee + getEducation + getAdvertiser
      end

      def getBase(type)
        Campaign::BASE[type]
      end

      def getAudience(audience)
        Campaign::AUDIENCE.fetch(audience.to_sym, 0)
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
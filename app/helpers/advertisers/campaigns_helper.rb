module Advertisers::CampaignsHelper
  def format_target_audience(target_audience)
    target_audience.collect {|x| x.humanize } * ','
  end
end

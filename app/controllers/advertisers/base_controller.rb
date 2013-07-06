class Advertisers::BaseController < ApplicationController
  before_filter :authorize_advertiser!
end
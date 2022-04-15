class PagesController < ApplicationController
  skip_before_action :finish_profile
  def home
  end
end
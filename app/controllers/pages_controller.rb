class PagesController < ApplicationController
  skip_before_action :finish_profile
  layout 'pages'

  def home
  end
end
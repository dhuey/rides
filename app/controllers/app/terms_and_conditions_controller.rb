class App::TermsAndConditionsController < ApplicationController
  skip_before_action :finish_profile
  def index
  end
end

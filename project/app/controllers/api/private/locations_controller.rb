class Api::Private::LocationsController < ApplicationController
  before_action :set_panel_provider
  before_action :set_country

  def show
    @locations = @country.locations
  end
end

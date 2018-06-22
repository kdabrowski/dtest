class Api::Public::TargetGroupsController < ApplicationController
  before_action :set_panel_provider
  before_action :set_country

  def show
    @target_groups = @country.target_groups
  end
end

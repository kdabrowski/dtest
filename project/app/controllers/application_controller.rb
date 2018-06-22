class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :return_not_found
  rescue_from Net::OpenTimeout, with: :service_timed_out

  def set_panel_provider
    @current_panel = PanelProvider.find_by!(code: Settings.current_panel)
  end

  def set_country
    @country = @current_panel.countries.find_by!(code: params[:country_code])
  end

  def return_not_found
    render json: { error: "Resource not found" }, status: 404
  end

  def service_timed_out
    render json: { error: "Service timedout" }
  end
end

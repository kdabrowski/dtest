class Api::Private::PricingsController < ApplicationController
  def evaluate_target
    @form = EvaluateTargetForm.new(permitted_params)
    if @form.valid?
      render json: { price: @form.price }
    else
      render json: { message: "Invalid params" }, status: 422
    end
  end

  private

  def permitted_params
    params.permit(:country_code, :target_group_id, locations: [ :id, :panel_size])
  end
end

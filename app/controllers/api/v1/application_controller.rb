class Api::V1::ApplicationController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessible_entity_response

  def render_unprocessible_entity_response(exception)
    render json: {
      errors: exception.record.errors.map do |error|
        {
          status: "422",
          title: "Validation Failed",
          detail: error.full_message
        }
      end
    }, status: :unprocessable_entity
  end
end
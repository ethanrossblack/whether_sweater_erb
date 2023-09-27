class Api::V1::ApplicationController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessible_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

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

  def render_not_found_response(exception)
    render json: {
      errors: [
        {
          status: "404",
          title: "User Not Found",
          detail: "Couldn't find a User with the given email address"
        }
      ]
    }, status: :not_found
  end
end
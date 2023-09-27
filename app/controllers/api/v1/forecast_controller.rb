class Api::V1::ForecastController < Api::V1::ApplicationController
  def index
    facade = ForecastFacade.new(params).forecast
    render json: ForecastSerializer.new(facade)
  end
end

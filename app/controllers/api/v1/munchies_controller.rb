class Api::V1::MunchiesController < ApplicationController
  def index
    facade = MunchiesFacade.new(params).munchie
    render json: MunchieSerializer.new(facade)
  end
end

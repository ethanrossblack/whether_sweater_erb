class Api::V1::MunchiesController < ApplicationController
  def index
    facade = MunchiesFacade.new(params).munchie
    render json: MunchiesSerializer.new(facade)
  end
end

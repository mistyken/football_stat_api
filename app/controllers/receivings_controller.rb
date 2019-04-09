class ReceivingsController < ApplicationController
  before_action :set_player
  before_action :set_player_receiving, only: [:show, :update, :destroy]

  # GET /players/:player_id/receivings
  def index
    json_response(@player.Receiving)
  end

  # GET /players/:player_id/receivings/:id
  def show
    json_response(@receiving)
  end

  # POST /players/:player_id/receivings
  def create
    @player.Receiving.create!(receiving_params)
    json_response(@player, :created)
  end

  # PUT /players/:player_id/receivings/:id
  def update
    @receiving.update(receiving_params)
    head :no_content
  end

  # DELETE /players/:player_id/receivings/:id
  def destroy
    @receiving.destroy
    head :no_content
  end

  private

  def receiving_params
    params.permit(:yds, :tds, :rec, :eid)
  end

  def set_player
    @player = Player.find(params[:player_id])
  end

  def set_player_receiving
    @receiving = @player.Receiving.find_by!(id: params[:id]) if @player
  end
end

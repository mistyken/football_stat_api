class RushingsController < ApplicationController
  before_action :set_player
  before_action :set_player_rushing, only: [:show, :update, :destroy]

  # GET /players/:player_id/rushings
  def index
    json_response(@player.Rushing)
  end

  # GET /players/:player_id/rushings/:id
  def show
    json_response(@rushing)
  end

  # POST /players/:player_id/rushings
  def create
    @player.Rushing.create!(rushing_params)
    json_response(@player, :created)
  end

  # PUT /players/:player_id/rushings/:id
  def update
    @rushing.update(rushing_params)
    head :no_content
  end

  # DELETE /players/:player_id/rushings/:id
  def destroy
    @rushing.destroy
    head :no_content
  end

  private

  def rushing_params
    params.permit(:yds, :att, :tds, :fum)
  end

  def set_player
    @player = Player.find(params[:player_id])
  end

  def set_player_rushing
    @rushing = @player.Rushing.find_by!(id: params[:id]) if @player
  end
end

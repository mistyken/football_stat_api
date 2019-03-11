class PassingsController < ApplicationController
  before_action :set_player
  before_action :set_player_passing, only: [:show, :update, :destroy]

  # GET /players/:player_id/passings
  def index
    json_response(@player.Passing)
  end

  # GET /players/:player_id/passings/:id
  def show
    json_response(@passing)
  end

  # POST /players/:player_id/passings
  def create
    @player.Passing.create!(passing_params)
    json_response(@player, :created)
  end

  # PUT /players/:player_id/passings/:id
  def update
    @passing.update(passing_params)
    head :no_content
  end

  # DELETE /players/:player_id/passings/:id
  def destroy
    @passing.destroy
    head :no_content
  end

  private

  def passing_params
    params.permit(:yds, :att, :tds, :cmp, :int)
  end

  def set_player
    @player = Player.find(params[:player_id])
  end

  def set_player_passing
    @passing = @player.Passing.find_by!(id: params[:id]) if @player
  end
end

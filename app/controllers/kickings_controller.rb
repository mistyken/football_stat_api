class KickingsController < ApplicationController
  before_action :set_player
  before_action :set_player_kicking, only: [:show, :update, :destroy]

  # GET /players/:player_id/kickings
  def index
    json_response(@player.Kicking)
  end

  # GET /players/:player_id/kickings/:id
  def show
    json_response(@kicking)
  end

  # POST /players/:player_id/kickings
  def create
    @player.Kicking.where("entry_id = ?", kicking_params[:entry_id]).first_or_create!(kicking_params)
    json_response(@player, :created)
  end

  # PUT /players/:player_id/kickings/:id
  def update
    @kicking.update(kicking_params)
    head :no_content
  end

  # DELETE /players/:player_id/kickings/:id
  def destroy
    @kicking.destroy
    head :no_content
  end

  private

  def kicking_params
    params.permit(:fld_goals_made, :fld_goals_att, :extra_pt_made, :extra_pt_att, :entry_id)
  end

  def set_player
    @player = Player.find(params[:player_id])
  end

  def set_player_kicking
    @kicking = @player.Kicking.find_by!(id: params[:id]) if @player
  end
end

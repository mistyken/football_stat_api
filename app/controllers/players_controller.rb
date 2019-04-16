class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :update, :destroy]

  # GET /players
  def index
    if params[:name]
      @names = params[:name].split(',')
      @players = Player.by_player_name @names
      json_response_players(@players)
    else
      @players = Player.all
      json_response(@players)
    end
  end

  # POST /players
  def create
    @player = Player.where("pid = ?", player_params[:pid]).first_or_create!(player_params)
    if params[:cmp]
      @player.Passing.create!(passing_params)
    elsif params[:fld_goals_made]
      @player.Kicking.create!(kicking_params)
    elsif params[:rec]
      @player.Receiving.create!(receiving_params)
    elsif params[:fum]
      @player.Rushing.create!(rushing_params)
    end
    json_response(@player, :created)
  end

  # GET /players/:id
  def show
    json_response(@player)
  end

  # PUT /players/:id
  def update
    @player.update(player_params)
    head :no_content
  end

  # DELETE /players/:id
  def destroy
    @player.destroy
    head :no_content
  end

  private

  def player_params
    # whitelist params
    params.permit(:name, :position, :pid, kicking_params, passing_params, receiving_params, rushing_params)
  end

  def kicking_params
    params.permit(:fld_goals_made, :fld_goals_att, :extra_pt_made, :extra_pt_att, :eid)
  end

  def passing_params
    params.permit(:yds, :att, :tds, :cmp, :int, :eid)
  end

  def receiving_params
    params.permit(:yds, :tds, :rec, :eid)
  end

  def rushing_params
    params.permit(:yds, :att, :tds, :fum, :eid)
  end

  def set_player
    @player = Player.find(params[:id])
  end
end

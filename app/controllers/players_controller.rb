class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :update, :destroy]

  # GET /players
  def index
    @players = []
    if params[:name]
      params[:name].split(',').each do |name|
        @players.append Player.by_player_name(name)
      end
    else
      @players = Player.all
    end
    json_response_players(@players)
  end

  # POST /players
  def create
    @player = Player.where("name = ? OR pid = ? OR eid = ?",
                       player_params[:name], player_params[:pid], player_params[:eid]).first_or_create!(player_params)
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
    params.permit(:name, :position, :pid, :eid)
  end

  def set_player
    if params[:name]
      @player = Player.by_player_name(params[:name]) if params[:name]
    else
      @player = Player.find(params[:id])
    end
  end
end

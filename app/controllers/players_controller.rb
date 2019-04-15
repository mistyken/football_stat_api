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
    params.permit(:name, :position, :pid)
  end

  def set_player
    @player = Player.find(params[:id])
  end
end

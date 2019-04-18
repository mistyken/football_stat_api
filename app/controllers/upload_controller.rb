class UploadController < ApplicationController
  # POST /players
  def create
    if params[:rushing]
      params[:rushing].each do |rushing|
        @player = Player.where("player_id = ?", player_params(rushing)[:player_id]).first_or_create!(player_params rushing)
        @player.Rushing.where("entry_id = ?", rushing_params(rushing)[:entry_id]).first_or_create!(rushing_params rushing)
      end
    end
    if params[:receiving]
      params[:receiving].each do |receiving|
        @player = Player.where("player_id = ?", player_params(receiving)[:player_id]).first_or_create!(player_params receiving)
        @player.Receiving.where("entry_id = ?", receiving_params(receiving)[:entry_id]).first_or_create!(receiving_params receiving)
      end
    end
    if params[:passing]
      params[:passing].each do |passing|
        @player = Player.where("player_id = ?", player_params(passing)[:player_id]).first_or_create!(player_params passing)
        @player.Passing.where("entry_id = ?", passing_params(passing)[:entry_id]).first_or_create!(passing_params passing)
      end
    end
    if params[:kicking]
      params[:kicking].each do |kicking|
        @player = Player.where("player_id = ?", player_params(kicking)[:player_id]).first_or_create!(player_params kicking)
        @player.Kicking.where("entry_id = ?", kicking_params(kicking)[:entry_id]).first_or_create!(kicking_params kicking)
      end
    end
  end

  private

  def player_params(params)
    # whitelist params
    params.permit(:name, :position, :player_id, kicking_params(params), passing_params(params), receiving_params(params), rushing_params(params))
  end

  def kicking_params(params)
    params.permit(:fld_goals_made, :fld_goals_att, :extra_pt_made, :extra_pt_att, :entry_id)
  end

  def passing_params(params)
    params.permit(:yds, :att, :tds, :cmp, :int, :entry_id)
  end

  def receiving_params(params)
    params.permit(:yds, :tds, :rec, :entry_id)
  end

  def rushing_params(params)
    params.permit(:yds, :att, :tds, :fum, :entry_id)
  end
end

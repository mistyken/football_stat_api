# app/controllers/concerns/response.rb
module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def json_response_players(players, status = :ok)
    @rushing = []
    @kicking = []
    @passing = []
    @receiving = []

    players.each do |player|
      rushing = json_response_rushing(player)
      if rushing
        @rushing.append rushing
      end

      passing = json_response_passing(player)
      if passing
        @passing.append passing
      end

      kicking = json_response_kicking(player)
      if kicking
        @kicking.append kicking
      end

      receiving = json_response_receiving(player)
      if receiving
        @receiving.append receiving
      end
    end

    player_json = {
        rushing: @rushing,
        kicking: @kicking,
        passing: @passing,
        receiving: @receiving
    }
    render :json => player_json, status: status
  end

  private

  def json_response_rushing(player)
    rushing = player.Rushing.last
    if rushing
      {
          player_id: player.player_id,
          entry_id: rushing.entry_id,
          name: player.name,
          position: player.position,
          yds: rushing.yds,
          att: rushing.att,
          tds: rushing.tds,
          fum: rushing.fum
      }
    end
  end

  def json_response_kicking(player)
    kicking = player.Kicking.last
    if kicking
      {
          player_id: player.player_id,
          entry_id: kicking.entry_id,
          name: player.name,
          position: player.position,
          fld_goals_made: kicking.fld_goals_made,
          fld_goals_att: kicking.fld_goals_att,
          extra_pt_made: kicking.extra_pt_made,
          extra_pt_att: kicking.extra_pt_att
      }
    end
  end

  def json_response_passing(player)
    passing = player.Passing.last
    if passing
      {
          player_id: player.player_id,
          entry_id: passing.entry_id,
          name: player.name,
          position: player.position,
          yds: passing.yds,
          att: passing.att,
          tds: passing.tds,
          cmp: passing.cmp,
          int: passing.int
      }
    end
  end

  def json_response_receiving(player)
    receiving = player.Receiving.last
    if receiving
      {
          player_id: player.player_id,
          entry_id: receiving.entry_id,
          name: player.name,
          position: player.position,
          yds: receiving.yds,
          rec: receiving.rec,
          tds: receiving.tds
      }
    end
  end
end
# app/controllers/concerns/response.rb
module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def json_response_players(players)
    player = players.first  # TODO: support multiple players
    player_json = {
        rushing: json_response_rushing(player),
        kicking: json_response_kicking(player),
        passing: json_response_passing(player),
        receiving: json_response_receiving(player)
    }
    render :json => player_json
  end

  def json_response_rushing(player)
    player.Rushing.map do |rushing|
      {
          player_id: player.pid,
          entry_id: rushing.eid,
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
    player.Kicking.map do |kicking|
      {
          player_id: player.pid,
          entry_id: kicking.eid,
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
    player.Passing.map do |passing|
      {
          player_id: player.pid,
          entry_id: passing.eid,
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
    player.Receiving.map do |receiving|
      {
          player_id: player.pid,
          entry_id: receiving.eid,
          name: player.name,
          position: player.position,
          yds: receiving.yds,
          rec: receiving.rec,
          tds: receiving.tds
      }
    end
  end
end
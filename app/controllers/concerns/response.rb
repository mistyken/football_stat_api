# app/controllers/concerns/response.rb
module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def json_response_players(players)
    render :json => players.as_json(:only => [:pid, :eid, :name, :position],
                                    :include => {:Rushing => {:only => [:yds, :att, :fum, :tds]},
                                                 :Passing => {:only => [:yds, :att, :tds, :cmp, :int]},
                                                 :Receiving => {:only => [:yds, :rec, :tds]},
                                                 :Kicking => {:only => [:fld_goals_made, :fld_goals_att, :extra_pt_made, :extra_pt_att]}})
  end
end
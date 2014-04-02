module RPS
  def self.db
    @__db_instance ||= DB.new
  end

# @sessions = {
#   1 => { :user_id => 1},
#   2 => { :user_id => 2}
# }

  class DB
    def initialize
      @matches = {}
      @rounds = {}
      @players = {}
      @sessions = {}
    end

    def all_players
      @players.values
    end

    def all_rounds
      @rounds.values
    end

    def all_matches
      @matches.values
    end

    def all_sessions
      @sessions.values
    end

    #########################
    ## Player CRUD Methods ##
    #########################

    def create_player(name)
      player = RPS::Player.new(name)
      @players[player.id] = player
    end

    def get_player(pid)
      @players[pid]
    end

    def update_player(pid, new_name)
      @players[pid].name = new_name
    end

    def delete_player(pid)
      @players.delete(pid)
    end

    ########################
    ## Match CRUD Methods ##
    ########################

    def create_match(p1_id, p2_id)
      match = RPS::Match.new(p1_id, p2_id)
      @matches[match.id] = match
    end

    def get_match(mid)
      @matches[mid]
    end

    def update_match(mid, options)
      winner = options[:winner]
      @matches[mid].winner = winner
    end

    def delete_match(mid)
      @matches.delete(mid)
    end

    ########################
    ## Round CRUD Methods ##
    ########################

    def create_round(options)
      match_id = options[:match]
      winner_id = options[:winner]

      round = RPS::Round.new(match_id, winner_id)
      @rounds[round.id] = round
    end

    def get_round(rid)
      @rounds[rid]
    end

    ##########################
    ## Session CRUD Methods ##
    ##########################

    def create_session(uid)
      session = RPS::Session.new(uid)
      @sessions[session.id] = session
      session
    end

    def get_session(sid)
      @sessions[sid]
    end

    ####################
    ## Client Methods ##
    ####################

  end
end
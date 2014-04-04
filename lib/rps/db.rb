module RPS
  def self.db
    @__db_instance ||= DB.new
  end

# another way to implement sessions - no ruby class, just a hash
# # @sessions = {
# #   1 => { :user_id => 1},
# #   2 => { :user_id => 2}
# # }

  class DB
    def initialize
      @matches = {}
      @rounds = {}
      @players = {}
      @sessions = {}
      @invites = {}
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

    def all_invites
      @invites.values
    end

    #########################
    ## Player CRUD Methods ##
    #########################

    def create_player(name, pw)
      player = RPS::Player.new(name, pw)
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
      round = RPS::Round.new(options)
      @rounds[round.id] = round
    end

    def get_round(rid)
      @rounds[rid]
    end

    def update_round(rid, attrs = {})
      round = @rounds[rid]
      round.winner_id = attrs[:winner_id] if attrs[:winner_id]
      round.loser_id = attrs[:loser_id] if attrs[:winner_id]
      round.winning_player = attrs[:winning_player] if attrs[:winning_player]
      round.p1_choice = attrs[:p1_choice] if attrs[:p1_choice]
      round.p2_choice = attrs[:p2_choice] if attrs[:p2_choice]
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

    ##########################
    ## Invite CRUD Methods ##
    ##########################

    def create_invite(inviter_id, invitee_id)
      invite = RPS::Invite.new(inviter_id, invitee_id)
      @invites[invite.id] = invite
    end

    def get_invite(iid)
      @invites[iid]
    end

    def update_invite(iid, new_status)
      invite = @invites[iid]
      invite.pending = new_status
    end

    ####################
    ## Client Methods ##
    ####################

    # now in use case, left as example
    # def accept_invite(iid)
    #   invite = @invites[iid]
    #   update_invite(iid, false)
    #   match = create_match(invite.inviter_id, invite.invitee_id)
    #   create_round({ match_id: match.id })
    # end

    ####################
    ## Client Queries ##
    ####################

    def get_all_match_rounds(mid)
      all_rounds.select { |round| round.match_id == mid }
    end

    def find_player_by_username(name)
      all_players.find { |player| player.name == name}
    end

    def get_all_match_rounds_won(mid)
      match_rounds = get_all_match_rounds(mid)
      rounds_won = match_rounds.select { |round| round.winner_id != nil }
    end

    def get_current_match_round(mid)
      match_rounds = get_all_match_rounds(mid)
      current_match_round = match_rounds.find { |round| round.winner_id == nil}
    end

    def active_matches(uid)
      user_active_matches = @matches.values.select { |match| (match.p1_id == uid || match.p2_id == uid) && match.winner == nil }
    end

    # Not yet tested

    # old version that uses session key, now we get user id from session key in use case
    # and use that instead
    # def active_matches(session_key)
    #   session = @sessions[session_key]
    #   uid = session.user_id
    #   user_active_matches = @matches.values.select { |match| match.p1_id == uid || match.p2_id == uid && match.winner == nil }
    # end
  end
end
module RPS
  def self.db
    @__db_instance ||= DB.new
  end

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

    def accept_invite(iid)
      invite = @invites[iid]
      update_invite(iid, false)
      match = create_match(invite.inviter_id, invite.invitee_id)
      create_round({ match_id: match.id })
    end

    # Not yet tested

    def sign_up(username, pw)
      create_player(username, pw)
    end

    def sign_in(username, pw)
      player = @players.values.find { |player| player.name == username && player.password == pw }
      session = session_create(player.id)
      session_key = session.id
    end


    def start_round(mid, session_key, current_user_choice)
      match = get_match(mid)

      player = @players[sessions[session_key].user_id]

      if player = player
      end
      create_round(match_id: mid)
    end

    def end_round(mid, rid, other_user_choice)
      p1_choice = p1_choice.to_sym
      p2_choice = p2_choice.to_sym

      choice_map = {
        rock: {
          paper: "lose",
          scissors: "win"
        },

        paper: {
          scissors: "lose",
          rock: "win"
        },

        scissors: {
          rock: "lose",
          paper: "win"
        }
      }

      if choice_map[p1_choice][p2_choice] == "win"
        winner
        loser
      elsif choice_map[p1_choice][p2_choice] == "lose"
      end
    end

    ####################
    ## Client Queries ##
    ####################

    # Not yet tested

    def get_all_match_rounds(mid)
      all_rounds.select { |round| round.match_id == mid }
    end

    def active_matches(session_key)
      session = @sessions[session_key]
      uid = session.user_id
      user_active_matches = @matches.values.select { |match| match.p1_id == uid || match.p2_id == uid && match.winner == nil }
    end
  end
end
module RPS
  def self.db
    @__db_instance ||= DB.new
  end

  class DB
    def initialize
      @matches = {}
      @rounds = {}
      @players = {}
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
  end
end
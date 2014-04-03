module RPS
  class SignUp < UseCase
    def run(inputs)
      return failure(:username_taken) if RPS.db.find_player_by_username(inputs[:username]) != nil

      player = RPS.db.create_player(inputs[:username], inputs[:password])

      success(player: player)
    end
  end
end
module RPS
  class SignIn < UseCase
    def run(inputs)

      player = RPS.db.find_player_by_username(inputs[:username])
      return failure(:player_nonexistent) if player.nil?

      return failure(:incorrect_password) if inputs[:password] != player.password

      session = RPS.db.create_session(player.id)

      success({ session: session, session_key: session.id })
    end
  end
end
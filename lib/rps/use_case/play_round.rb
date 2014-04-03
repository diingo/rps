# TO DO:
# NOT TESTED
module RPS
  class PlayRound < UseCase
    # inputs are:
    # :choice (logged in player's choice), :session_key
    # :current_round, :match (match belonging to this round)

    def run(inputs)
      valid_choices = ["rock", "paper", "scissors"]
      return failure(:invalid_choice) if valid_choices.include?(inputs[:choice]) == nil

      update_round_with_move(inputs)

      if both_players_moved?(inputs)
        # will also need to check for tie
        determine_winner(inputs)
      else
      end

    end

    def both_players_moved?(inputs)
      if inputs[:current_round].p1_choice != nil && inputs[:current_round].p2_choice != nil
        return true
      else
        return false
      end
    end

    # TO DO: complete
    def determine_winner(inputs)
      round = inputs[:current_round]
      p1_choice = round.p1_choice.to_sym
      p2_choice = round.p2_choice.to_sym

      choice_map = {
        rock: {
          paper: "lose",
          scissors: "win",
          rock: "tie"
        },

        paper: {
          scissors: "lose",
          rock: "win",
          paper: "tie"
        },

        scissors: {
          rock: "lose",
          paper: "win",
          scissors: "tie"
        }
      }

      if choice_map[p1_choice][p2_choice] == "win"
        winning_player = "p1"
        winner_id = inputs[:match].p1_id
        loser_id = inputs[:match].p2_id
      elsif choice_map[p1_choice][p2_choice] == "lose"
        winning_player = "p2"
        winner_id = inputs[:match].p2_id
        loser_id = inputs[:match].p1_id
      end
    end

    def determine_if_player1_or_2_choice(match, player_id)
      type = "p1" if match.p1_id == player_id
      type = "p2" if match.p2_id == player_id

      return :p1_choice if type = "p1"
      return :p2_choice if type = "p2"
    end

    def update_round_with_move(inputs)
      choice = inputs[:choice]
      session_key = inputs[:session_key]
      match = inputs[:match]
      round = inputs[:current_round]

      current_user_id = RPS.db.get_session(session_key).user_id
      player = RPS.db.get_player(current_user_id)

      choice_type = determine_if_player1_or_2_choice(match, current_user_id)

      RPS.db.update_round(round.id, { choice_type => choice } )
    end
  end
end
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
        if players_tied?(inputs)
          tie = true
          clear_round(inputs)
        else
          tie = false
          determine_round_winner(inputs)
          if !match_won?
            round = RPS.db.create_round(inputs[:match].id)
          end
        end
      end

      success(round: round, tie: tie, winner: @winner, loser: @loser)
    end

    def players_tied?(inputs)
      round = inputs[:current_round]
      if round.p1_choice == round.p2_choice
        true
      else
        false
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
    def match_won?(inputs)
      match = inputs[:match]
      match_rounds_won = RPS.db.get_all_match_rounds_won(match.id)

      p1_id = match.p1_id
      p2_id = match.p2_id
      # match_rounds_won

      p1_wins = match_rounds_won.select { |round| round.winner_id == p1_id }.count
      p2_wins = match_rounds_won.select { |round| round.winner_id == p2_id }.count

      # TO DO
      if p1_wins.count == 3
        match.winner = p1_id
        true
      elsif p2_wins.count == 3
        match.winner = p2_id
        true
      else
        false
      end
    end

    def determine_round_winner(inputs)
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

      round.winning_player = winning_player
      @loser = RPS.db.get_player(loser_id)
      @winner = RPS.db.get_player(winner_id)
    end

    def clear_round(inputs)
      round = inputs[:current_round]
      round.p1_choice = nil
      round.p2_choice = nil
    end

    def update_round_with_move(inputs)
      current_user_id = RPS.db.get_session(inputs[:session_key]).user_id
      player = RPS.db.get_player(current_user_id)

      # choice_type will be either :p1_choice or :p1_choice
      choice_type = determine_if_player1_or_2_choice(inputs[:match], current_user_id)

      RPS.db.update_round(inputs[:current_round].id, { choice_type => inputs[:choice] } )
    end

    def determine_if_player1_or_2_choice(match, player_id)
      player_type = "p1" if match.p1_id == player_id
      player_type = "p2" if match.p2_id == player_id

      return :p1_choice if player_type = "p1"
      return :p2_choice if player_type = "p2"
    end
  end
end
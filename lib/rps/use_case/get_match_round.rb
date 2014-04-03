# TO DO:
# not yet tested
module RPS
  class GetMatchRound < UseCase
    def run(inputs)
      match = RPS.db.get_match(inputs[:match_id])
      return failure(:match_nonexistent) if match.nil?
      return failure(:match_over) if match.winner != nil

      current_round = get_current_match_round(inputs[:match_id])

      success(current_round: current_round, match: match)
    end

  end
end
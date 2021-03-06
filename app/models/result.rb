class Result < ApplicationRecord
  belongs_to :user
  belongs_to :round

  has_many :matches, through: :round

  def rebuild_total
    # SCORING
    #
    i = 0
    self.matches.each do |match|
      if match.has_goal?
        forecast = self.user.forecasts.where(match_id: match.id).last
        if forecast
          # check result score
          i+=1 if (match.team1goal == forecast.team1goal) && (match.team2goal == forecast.team2goal) && (match.check_win == forecast.check_winner)
          # check diff result score
          i+=1 if (match.team1goal - match.team2goal) == (forecast.team1goal - forecast.team2goal)
          # check winner result score
          # i+=1 if ((match.team1goal > match.team2goal) == (forecast.team1goal > forecast.team2goal)) && !match.winner_id?
          # i+=1 if ((match.winner == forecast.winner) && match.winner_id?)
          i+=1 if (match.check_win == forecast.check_winner)
          # check finalend result score
          i+=1 if (match.ending == forecast.ending) && !match.round.draw
        end
      end
    end
    i
  end
end

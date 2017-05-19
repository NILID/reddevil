class Forecast < ActiveRecord::Base
  belongs_to :tempuser
  belongs_to :match
  belongs_to :winner, class_name: "Team"
  has_one :round, through: :match
  attr_accessible :team1goal, :team2goal, :match_id, :tempuser_id, :winner_id, :ending

  before_update :remove_winner_forecast

  validates :team1goal, :team2goal, presence: true

  validates :winner_id, presence: true, if: :check_draw?
#  validates :match_id, presence: true, if: :check_draw?

  def remove_winner_forecast
    f = Forecast.find(self)
    if (f.team1goal > f.team2goal) != (team1goal > team2goal)
      self.match.round.matches.where('matches.desc is null or matches.desc <> ?', '').each do |match|
        match.forecasts.where('tempuser_id = ? ', self.tempuser_id).destroy_all
      end
    end
  end

  def check_draw?
    team1goal == team2goal
  end

  def check_deadline
    self.match.deadline > DateTime.now
  end

  def check_winner
    if team1goal.present? && team2goal.present?
      if team1goal > team2goal
        self.match.team1
      elsif team1goal < team2goal
        self.match.team2
      elsif winner_id
        winner
      else
        nil
      end
    else
      nil
    end
  end

  def check_second
    if team1goal.present? && team2goal.present?
      if team1goal < team2goal
        self.match.team1
      elsif team1goal > team2goal
        self.match.team2
      else
        nil
      end
    else
      nil
    end
  end


  validate :check_match, :on => :create
#  validate :check_deadline, :on => :create
  validate :check_ending
  validate :check_overtime

  private

  def check_match
    errors.add(:match_id, I18n.t('forecasts.already_voted')) if !Forecast.where("match_id =? and tempuser_id =?", match_id, tempuser_id).empty?
  end

  def check_deadline
    errors.add(:match_id, I18n.t('forecasts.already_end')) if Match.find(match_id).round.deadline < DateTime.now
  end

  def check_ending
    errors.add(:ending, I18n.t('forecasts.overtime_diff')) if ending == 'overtime' \
                                                         && !([1, -1].include? (team1goal - team2goal)) \
                                                         && Match.find(match_id).round.type_id == 2
    # type_id == hockey
  end

  def check_overtime
    errors.add(:ending, I18n.t('forecasts.hockey_bullit_equal')) if ending == 'penalty' && (team1goal != team2goal) \
                                                         && Match.find(match_id).round.type_id == 2
    # type_id == hockey
  end

end

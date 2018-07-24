class Match < ActiveRecord::Base
  after_update :check_guess

  belongs_to :team1,  class_name: 'Team'
  belongs_to :team2,  class_name: 'Team'
  belongs_to :winner, class_name: 'Team'
  belongs_to :round
  has_many :forecasts, dependent: :delete_all
  # has_one :team1, class_name: 'Team', foreign_key: 'team1_id'
  # has_one :team2, class_name: 'Team', foreign_key: 'team2_id'

  attr_accessible :team1goal, :team2goal, :team1_id, :team2_id, :winner_id, :ending, :desc

  validates :team1_id, :team2_id, presence: true

  ENDING = %w[basic overtime penalty]
  TYPES =  %w[final 3final]

  def has_goal?
    self.team1goal.present? && self.team2goal.present?
  end

  def check_win
    if team1goal.present? && team2goal.present?
      if team1goal > team2goal
        team1
      elsif team1goal < team2goal
        team2
      elsif winner_id
        winner
      else
        nil
      end
    else
      nil
    end
  end

  private

  def check_guess
    forecasts.each { |f| f.check_guess! }
  end
end

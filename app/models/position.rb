class Position < ApplicationRecord
  belongs_to :department
  belongs_to :member

  after_commit :add_current_info

  validates :position, :moved_at, presence: true

  def next
    member.positions.where("moved_at > ?", moved_at).first
  end

  def prev
    member.positions.where("moved_at < ?", moved_at).last
  end

  private

  def add_current_info
    last_position = self.member.positions.order(moved_at: :desc).first
    self.member.update_position(last_position&.position, last_position&.department_id)
  end
end

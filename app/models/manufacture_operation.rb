class ManufactureOperation < ApplicationRecord
  after_commit :refresh_last_operation

  belongs_to :manufacture
  belongs_to :operation
  belongs_to :member, optional: true

  validate :check_dates

  validates :operation_id, :member_id, :started_at, presence: true

  private

    def check_dates
      errors.add(:started_at, I18n.t('errors.date_cannot_be_less')) if started_at && finished_at && (started_at > finished_at)
    end

    def refresh_last_operation
      operations = self.manufacture.manufacture_operations
      self.manufacture.update_attributes(last_operation_id: operations.order(:started_at).last.id) if operations.any?
    end
end

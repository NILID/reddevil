class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :machine

  attr_accessible :complete, :end_time, :start_time, :title, :update_tasks_flag
  attr_writer :update_tasks_flag

  validates :title, presence: true
  validates :complete, numericality: { only_integer: true,
                                           less_than_or_equal_to: 100,
                                           greater_than_or_equal: 0 }

  validate :check_time
  validate :check_valid_time

  def update_tasks_flag
    @update_tasks_flag || false
  end

  def next_task
    self.machine.tasks.where('start_time > ?', self.start_time).order(:start_time).first
  end

  def update_next_tasks(old_end_time)
    end_days = (self.end_time.to_date - old_end_time.to_date).to_i

    unless end_days == 0
      self.machine.tasks.where('start_time > ?', self.start_time).each do |t|
        t.update_attributes!(start_time: (t.start_time + end_days.days), end_time: (t.end_time + end_days.days)) if end_days
      end
    end
  end

  private

    def check_time
      (Machine.where(id: machine_id).first.tasks -  [self]).each do |task|
        time_range = task.start_time..task.end_time
        if time_range.cover?(start_time) || time_range.cover?(end_time)
          return errors.add(:end_time, I18n.t('tasks.check_time_failed')) if (update_tasks_flag == '0')
        end
      end
    end

    def check_valid_time
      errors.add(:end_time, I18n.t('tasks.check_less_time_failed')) if start_time && end_time && (start_time > end_time)
    end
end

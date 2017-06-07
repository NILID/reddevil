class Substrate < ActiveRecord::Base
  belongs_to :user
  attr_accessible :desc, :drawing, :number, :state, :title

  STATES = %w(polishing coating defect aspart control depot).freeze
  def state_css
    if state?
      if %w(polishing coating control).include? state
        'warning'
      elsif state == 'defect'
        'error'
      elsif state == 'aspart'
        'info'
      elsif state == 'depot'
        'success'
      else
        nil
      end
    else
      nil
    end
  end
end

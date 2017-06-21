class Substrate < ActiveRecord::Base
  belongs_to :user
  attr_accessible :desc, :drawing, :number, :state, :title, :theme

  STATES = %w(polishing coating not_coating defect aspart control depot).freeze
  def state_css
    if state?
      if %w(polishing coating control).include? state
        'warning'
      elsif state == 'not_coating'
        'warning-orange'
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

  def self.to_xls(options = {})
    CSV.generate(options) do |csv|
      csv << ['#', Substrate.human_attribute_name(:title),
                    Substrate.human_attribute_name(:drawing),
                    Substrate.human_attribute_name(:number),
                    Substrate.human_attribute_name(:state),
                    Substrate.human_attribute_name(:theme),
                    Substrate.human_attribute_name(:desc),
                    Substrate.human_attribute_name(:user_id)]
      all.each_with_index do |substrate, index|
        csv << [index+1, substrate.title,
                         substrate.drawing,
                         substrate.number,
                         I18n.t("substrates.states.#{substrate.state}"),
                         substrate.theme,
                         substrate.desc,
                         (substrate.user.profile.surname if substrate.user)]
      end
    end
  end
end

class Substrate < ActiveRecord::Base
  attr_accessible :desc, :drawing, :number, :state, :title, :theme, :category, :substrate_id

  belongs_to :user
  belongs_to :mirror
  #has_one :substrate_child
  belongs_to :child, class_name: 'Substrate', foreign_key: :substrate_id

  STATES = %w(polishing coating not_coating defect aspart control depot).freeze
  MIRROR_STATES = %w(
                    mirror_defect
                    mirror_build_body
                    mirror_spring_install
                    mirror_spring_measure
                    mirror_actuator_install
                    mirror_tension_install
                    mirror_jolting
                    mirror_pushers_clue
                    mirror_optics_clue
                    mirror_finish_build
                    mirror_control
                    mirror_mirror_measure
                    mirror_depot
                    mirror_sent
                  ).freeze

  CATEGORIES = %w(substrate mirror).freeze
  def state_css
    if state?
      if %w(polishing coating control).include? state
        'warning'
      elsif state == 'not_coating'
        'not-coating'
      elsif state == 'defect'
        'defect'
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

  def child_title
    title+ ' ' + (number? ? '#'.to_s : '') + number + (drawing? ? (' (' + drawing + ')') : '')
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

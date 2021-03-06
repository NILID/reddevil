class Substrate < ApplicationRecord
  # has_paper_trail on: [:create, :update], ignore: [:updated_at, :lock_version]
  has_paper_trail on: [:create, :update], ignore: [:updated_at]

  before_destroy do
    self.versions.destroy_all
  end

  belongs_to :user
  has_many :subfiles
  has_and_belongs_to_many :users

  has_many :substrate_features
  has_many :substrate_features_a, -> {where(wave: 'A')}, inverse_of: :substrate, class_name: 'SubstrateFeature'
  has_many :substrate_features_b, -> {where(wave: 'B')}, inverse_of: :substrate, class_name: 'SubstrateFeature'

  has_many_attached :otk_documents

  before_save :init_finished_at

  STATUSES = %w[missing opened worked finished delayed canceled shipped].freeze
  #                0     1       2        3      4         5       6

  PRIORITIES = %w[normal high].freeze
  #                 0     1

  NEW_PRIORITIES = [1, 2, 3, 4].freeze

  SHAPES = %w[circle square border_style].freeze # play => other

  RAD_STRENGTHS = %w[нет непрерывная импульсная].freeze

  OTK_STATUSES = %w[empty failed passed approval].freeze

  COATINGS = %w[нет зеркальное просветляющее светоделительное поляризующее фильтрующее другое].freeze
  SIDES = %w[a b ab].freeze

  #accepts_nested_attributes_for :substrate_features, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :substrate_features_a,
                                :substrate_features_b,
                                reject_if: :all_blank,
                                allow_destroy: true
#  accepts_nested_attributes_for :substrate_features_b, reject_if: :all_blank, allow_destroy: true

  validates :title, :statuses_mask, :coating_type, :priorityx, presence: true
  validates :drawing, uniqueness: true, allow_blank: true
  validates_inclusion_of :rad_strength,   in: RAD_STRENGTHS
  validates_inclusion_of :otk_status,     in: OTK_STATUSES
  validates_inclusion_of :priorityx,      in: NEW_PRIORITIES
  validates_inclusion_of :shape,          in: SHAPES, allow_blank: true
  validates_inclusion_of :coating_type,
                         :coating_type_b, in: COATINGS
  validates_inclusion_of :sides,          in: SIDES, allow_blank: true

  validates :diameter,
            :width,
            :height,
            :thickness,
            numericality: { greater_than_or_equal_to: 0 },
            allow_nil: true

  scope :archive,     lambda { where(statuses_mask: 6) }
  scope :not_archive, lambda { where.not(statuses_mask: 6) }

  def author
    if user
      user.member ? user.surname : user.email
    end
  end

  def status=(status)
    self.statuses_mask = STATUSES.index(status)
  end

  def status
    Substrate::STATUSES[statuses_mask]
  end

  ransacker :created_at, type: :date do
    Arel.sql("date(created_at)")
  end

  def self.sort_column_names
    columns = %w[priority statuses_mask title]
    columns + (column_names - columns)
  end

  def get_attr(column)
    if try(column)
      case column
      when 'created_at', 'updated_at', 'future_shipping_at'
        I18n.l created_at, format: :long
      when 'shape'
        I18n.t("substrates.shapes.#{try(column)}")
      when 'frame'
        I18n.t("substrates.frame_#{try(column)}")
      when 'user_id'
        author
      when 'priority'
        I18n.t("substrates.priorities.#{try(column)}")
      when 'statuses_mask'
        I18n.t("substrates.statuses.#{try(:status)}")
      when 'sides'
        unless self.try(column).empty?
          I18n.t("substrates.sides.#{try(column)}")
        end
      else
        try(column)
      end
    end
  end

  private

  def init_finished_at
    self.finished_at = (status == 'finished') ? DateTime.now : nil
  end
end

class Feature < ApplicationRecord
  has_many :comments
  validates :external_id, uniqueness: { case_sensitive: false }
  validates :title, presence: true
  validates :url, presence: true
  validates :place, presence: true
  validates :mag_type, presence: true
  validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :magnitude, numericality: { greater_than_or_equal_to: -1.0, less_than_or_equal_to: 10 }
end

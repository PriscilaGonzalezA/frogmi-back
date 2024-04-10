class Comment < ApplicationRecord
  belongs_to :feature, foreign_key: 'feature_id'
  validates :feature_id, presence: true
  validates :body, presence: true
end

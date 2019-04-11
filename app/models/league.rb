class League < ApplicationRecord
  belongs_to :season
  has_many :teams
  has_many :matches
end

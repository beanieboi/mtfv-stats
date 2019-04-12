class Match < ApplicationRecord
  belongs_to :league
  has_many :results
end

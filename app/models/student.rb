class Student < ApplicationRecord
  belongs_to :team

  validates :name, presence: true
  validates :ra, presence: true
end

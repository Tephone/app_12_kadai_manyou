class Tag < ApplicationRecord
    has_many :tagging, dependent: :destroy
    has_many :tasks, through: :tagging, source: :task
end

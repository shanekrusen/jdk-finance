class Income < ApplicationRecord
    belongs_to :category
    belongs_to :user
end

class Category < ApplicationRecord
    has_many :incomes
    belongs_to :user
end

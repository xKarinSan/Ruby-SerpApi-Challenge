class Product < ApplicationRecord
    # similar to required = True in SQL
    validates :name, presence: true
end

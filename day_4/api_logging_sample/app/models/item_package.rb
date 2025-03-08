class ItemPackage < ApplicationRecord
    validates :name, presence: true
    validates :contents, presence: true
end

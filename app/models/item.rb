class Item < ApplicationRecord
    belongs_to :merchant


    def self.find_by_name(search) 
        where("name ILIKE ?",  "%#{search}%")
        .order(:name)
    end
end

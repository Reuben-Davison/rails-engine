class Item < ApplicationRecord
    belongs_to :merchant


    def self.find_by_name(search) 
        where("name ILIKE ?",  "%#{search}%")
        .order(:name)
    end

    def self.find_by_price(min, max)
        if min == nil 
            where("unit_price < ?", max)
            .order(:name)
        elsif max == nil 
            where("unit_price > ?", min)
            .order(:name)
        else
            where('unit_price BETWEEN ? AND ?', min, max)
            .order(:name)
        end 
    end
end

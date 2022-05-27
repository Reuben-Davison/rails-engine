class Merchant < ApplicationRecord
    has_many :items
    has_many :invoices
    has_many :invoice_items, through: :invoices 
    has_many :transactions, through: :invoices
    has_many :customers, through: :invoices


    def self.find_by_name(search) 
        where("name ILIKE ?",  "%#{search}%")
        .order(:name)
        .first
    end

    def self.find_best_selling_merchants(quantity)
        select("merchants.*, sum(invoice_items.quantity) as count" )
        .joins(invoices: [:invoice_items, :transactions])
        .group(:id)
        .where(transactions: {result: 'success'}, invoices: {status: 'shipped'})
        .order("count DESC")
        .limit(quantity)
    end
end

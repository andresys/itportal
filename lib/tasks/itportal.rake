require 'rake'
require 'open-uri'
require 'progress_bar'

namespace :itportal do
  desc "ITPORTAL database tools"
  task convert_assets: :environment do
    puts "Convert assets database:"
    ActiveRecord::Base.establish_connection

    bar = ProgressBar.new(AccountingItem.count)
    p "Clear data"
    Asset.delete_all

    p "Generate index data and write to database"
    indexes = []
    AccountingItem.all.each do |item|
      bar.increment!
      Asset.transaction do
        asset = Asset.new({uid: item.uid, name: item.name, date: item.date, total: item.total, status: item.status, inventory_number: item.inventory_number})
        asset.save
      end
    end
  end
end
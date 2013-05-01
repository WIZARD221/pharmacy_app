require 'active_record'
require 'open-uri'
require 'nokogiri'
require 'active_support/all'
require_relative 'drug'

class DrugGetter 
  
  def getDrugs
    doc = Nokogiri::HTML(open("http://www.target.com/pharmacy/generics-condition"))
    pharmTable = doc.css("td.pharmtable tr")
    
    condition = nil
    
    pharmTable.each do |row|
      condition = row.css("div.sectitle").text if !row.css("div.sectitle").text.blank?
      cols = row.css("td")
      
      if !condition.blank? && cols.length > 1
        newDrug = Drug.new
        puts "Drug name: #{cols[0].text}"
        newDrug.generic_name = cols[0].text
        
        puts "Condition: #{condition}"
        newDrug.conditions = condition
        
        puts "Form: #{cols[2].text}"
        newDrug.form = cols[2].text
        
        if cols[3].text.to_i != 0
         puts "30-day qty.$4: #{cols[3].text}"
         newDrug.thirty_day_quantity = cols[3].text
         newDrug.thirty_day_price = 4
        elsif cols[5].text.to_i != 0
         puts "30-day qty.$9: #{cols[5].text}"
         newDrug.thirty_day_quantity = cols[5].text
         newDrug.thirty_day_price = 9
        end
        
        if cols[4].text.to_i != 0
          puts "90-day qty.$10: #{cols[4].text}" 
          newDrug.ninety_day_quantity = cols[4].text
          newDrug.ninety_day_price = 10
        elsif cols[6].text.to_i != 0
          puts "90-day qty.$24: #{cols[6].text}"
          newDrug.ninety_day_quantity = cols[6].text
          newDrug.ninety_day_price = 24
        end
        
        newDrug.save
      end
    end
  end
end
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
  
  def getDrugsWalmart
    doc = Nokogiri::HTML(open("C:\\Users\\Yair\\Projects\\pharmacy_app_extras\\walmart_drug_list2.html"))
    drugList = doc.css("div")
    
    condition = nil
    drug = nil
    thirty_day_quantity = nil
    ninety_day_quantity = nil
    
    drugList.each do |row|
    
      unless row.text.blank?
        if (row["data-font-name"] == "g_font_p0_6") &&
           !(row.text =~ /\d/ )  && !(row.text == "$")
          
          condition = row.text
          puts "Condition is: #{row.text}"
        end
        
        
        
        unless condition.blank?
          if getStyleAttributes(row["style"])["font-size"] == "13.3333px" && row["data-font-name"] == "g_font_p0_1" &&
            !row.text.match(/ \. /) && !row.text.match(/^\.$/)  && row.text != "*"
            
            if drug == nil
              drug = row.text  
            elsif thirty_day_quantity == nil
              if row.text.length > 6
                drug += " " + row.text
              else
                thirty_day_quantity = row.text
              end
            elsif ninety_day_quantity == nil
              if row.text.length > 6
                ninety_day_quantity = thirty_day_quantity
                puts "Drug name: #{drug}"
                puts "Condition is #{condition}"
                puts "Form: #{getDrugFormWalmart(drug)}"
                puts "Thirty day quantity: NA"
                puts "Ninety day quantity: #{ninety_day_quantity}"
                
                drug = row.text
                thirty_day_quantity = nil
                ninety_day_quantity = nil
              else
                ninety_day_quantity = row.text
                puts "Drug name: #{drug}"
                puts "Condition is #{condition}"
                puts "Form: #{getDrugFormWalmart(drug)}"
                puts "Thirty day quantity: #{thirty_day_quantity}"
                puts "Ninety day quantity: #{ninety_day_quantity}"
                
                drug =nil
                thirty_day_quantity = nil
                ninety_day_quantity = nil
              end
            end
          end
        end
      end
    end
    
  end
  
  def getStyleAttributes(style)
   attributes = Hash.new
   unless style.blank?
      
      style.split(/;/).each do |attr|
        attrParts = attr.split(/:/)
        key = attrParts[0].strip
        value = attrParts[1].strip
        attributes[key] =  value
      end
    end
    return attributes
  end
  
  def getDrugFormWalmart(drugName)
    if drugName =~ / tab/
      return "Tablet"
    elsif drugName =~ / cap/
      return "Capsule"
    elsif drugName =~ / susp/
      return "Suspension"
    elsif drugName =~ / syrup/
      return "Syrup"
    elsif drugName =~ / soln/ || drugName =~ / solution/
      return "Solution"
    elsif drugName =~ / ointment/
      return "Ointment"
    elsif drugName =~ / otic/
      return "Otic Solution"
    elsif drugName =~ / cream/
      return "Cream"
    elsif drugName =~ / suppositories/
      return "Suppositories"
    end
    
    
  end
  
  
  
  dg = DrugGetter.new
  dg.getDrugsWalmart
  
  
end
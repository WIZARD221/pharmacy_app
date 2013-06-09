require 'active_record'
require 'open-uri'
require 'nokogiri'
require 'active_support/all'
require_relative 'drug'
require_relative 'store'

class DrugGetter 
    
  def getDrugsTarget
    doc = Nokogiri::HTML(open("http://www.target.com/pharmacy/generics-condition"))
    pharmTable = doc.css("td.pharmtable tr")
    store = Store.new
    store.name ="Target"
    store.save
    
    condition = nil
    
    pharmTable.each do |row|
      condition = row.css("div.sectitle").text if !row.css("div.sectitle").text.blank?
      cols = row.css("td")
      
      if !condition.blank? && cols.length > 1
        newDrug = Drug.new
        puts "Drug name: #{formatDrugName(cols[0].text)}"
        newDrug.generic_name = formatDrugName(cols[0].text)
        
        
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
        
        saveDrug(newDrug, store)

      end
    end
  end
  
  def getDrugsWalmart
    doc = Nokogiri::HTML(open("C:\\Users\\Yair\\Projects\\pharmacy_app_extras\\walmart_drug_list2.html"))
    drugList = doc.css("div")
    
    store = Store.new
    store.name ="Walmart"
    store.save
    
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
              newDrug = Drug.new
              
              if row.text.length > 6
                ninety_day_quantity = thirty_day_quantity
                puts "Drug name: #{formatDrugName(drug)}"
                newDrug.generic_name = formatDrugName(drug)
                puts "Condition is #{condition}"
                newDrug.conditions = condition
                puts "Form: #{getDrugForm(drug)}"
                newDrug.form = getDrugForm(drug)
                puts "Thirty day quantity: NA"
                puts "Ninety day quantity: #{ninety_day_quantity}"
                newDrug.ninety_day_quantity = ninety_day_quantity
                
                drug = row.text
                thirty_day_quantity = nil
                ninety_day_quantity = nil
              else
                ninety_day_quantity = row.text
                puts "Drug name: #{formatDrugName(drug)}"
                newDrug.generic_name = formatDrugName(drug)
                puts "Condition is #{condition}"
                newDrug.conditions = condition
                puts "Form: #{getDrugForm(drug)}"
                newDrug.form = getDrugForm(drug)
                puts "Thirty day quantity: #{thirty_day_quantity}"
                newDrug.thirty_day_quantity = thirty_day_quantity
                puts "Ninety day quantity: #{ninety_day_quantity}"
                newDrug.ninety_day_quantity = ninety_day_quantity
                
                drug =nil
                thirty_day_quantity = nil
                ninety_day_quantity = nil
              end
              
              newDrug.thirty_day_price = 4
              newDrug.ninety_day_price = 10
              saveDrug(newDrug, store)
              
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
  
  def getDrugForm(drugName)
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
    else
      return false
    end
  end
  
  def saveDrug(drug, store)
    isNew = true
      
    if Drug.exists?(:generic_name => drug.generic_name)
      dbDrugs = Drug.where(:generic_name => drug.generic_name)
      
      dbDrugs.each do |dbDrug|
        if  sameDrug?(drug, dbDrug)
          isNew = false
          if !dbDrug.conditions.match(drug.conditions)
            dbDrug.conditions += ", #{drug.conditions}"
            dbDrug.stores << store unless dbDrug.stores.include?(store) 
            dbDrug.save
          end
        end
      end
    end
      
    if isNew
      drug.stores << store
      drug.save
    end 
  end
  
  def formatDrugName(drugName)
    drugNameParts = drugName.split(/ /)
    
    name = ""
    isName = true
    quantity = ""
    unit = ""
    
    drugNameParts.length.times do |i|
      unless drugNameParts[i].blank?
        if drugNameParts[i].match(/\d/) || !isName
          isName = false
          
          unit = getQuantityUnit(drugNameParts[i])
          if unit
            if drugNameParts[i].match(/\d/) && quantity == ""
              quantity = drugNameParts[i].upcase.split(unit)[0]
              break
            end
          else
             quantity = drugNameParts[i]
          end
        end
        
        if isName
          name += drugNameParts[i].upcase + " "
        end
      end
    end
    
    name = name.strip unless name.blank? 
    quantity = quantity.strip unless quantity.blank?
    unit = unit.strip unless unit.blank?
    
    if unit
      return name + " " + quantity + unit
    else
      return name
    end
  end
  
  def getQuantityUnit(str)
    if str =~ /%/
      return "%"
    elsif str =~ /[Mm][Gg]/
      return "MG"
    elsif str =~ /[Mm][Cc][Gg]/
      return "MCG"
    elsif str =~ /[Mm][Ll]/
      return "ML"
    elsif str =~ /[Gg][Mm]/
      return "GM"
    else
      return false
    end
  end
  
  def sameDrug?(drug1, drug2)
    
    if drug1.generic_name != drug2.generic_name 
      return false
    end
    if drug1.form != drug2.form 
      return false
    end
    # if drug1.thirty_day_price != drug2.thirty_day_price 
      # return false
    # end
    if drug1.thirty_day_quantity != drug2.thirty_day_quantity 
      return false
    end
    # if drug1.ninety_day_price != drug2.ninety_day_price 
      # return false
    # end
    if drug1.ninety_day_quantity != drug2.ninety_day_quantity 
      return false
    end
    
    return true
    
  end
  
  def getDrugsAll
    getDrugsTarget
    getDrugsWalmart
  end
  
  
end

  dg = DrugGetter.new
  # dg.getDrugsTarget
  puts dg.yair
  





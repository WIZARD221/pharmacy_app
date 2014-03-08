# $(document).ready ->
#     $("header").hide()
#     sortDrugs()
#     addTotalPrice()
#     window.print()

# sortDrugs = ->
#   items = $ "table#temp_table .item"
  
#   for item in items
#     store = $(item).find(".store")[0].innerHTML
#     storeTable =  $ "table." + store
#     storeTable.append item

# addTotalPrice = ->
#   prices = $ "td.price"
#   total = 0
#   prices = (parseInt price.innerHTML.replace '$','' for price in prices)
#   total = total + price for price in prices
  
#   $("#total_price").text "#{total}$"
  

  
  

  window.addToCart = (name, quantity, price, store) ->
    itemList = $ "table.#{store}"
    item = "<tr class='cart-item'><td class='name'>#{name}</td><td class='quantity'>#{quantity}</td><td class='price'>#{price}</td><td display='none' class='store hidden'>#{store}</td><td class='options'><button class=' btn remove-button'" + 
           "onClick=\"removeFromCart(this,'#{store}',#{price})\"><i class='icon-remove'></i></button></td></tr>"
    $(itemList).append item
    incCartItems store
    $("p.#{store}").show()
    checkOutsum = $("p#checkout_sum").html()
    $("p#checkout_sum").html(parseInt(checkOutsum) + parseInt(price) + "$")
  
  window.removeFromCart = (cartItem, store, price) ->
    row = cartItem.parentNode.parentNode
    $(row).remove()
    decCartItems store
    checkOutsum = $("p#checkout_sum").html()
    $("p#checkout_sum").html(parseInt(checkOutsum) - price + "$")
  
  
  window.showBuyingOptions = (id, store) ->
    hideBuyingOptions()
    $("button##{id}.#{store}.show-options").hide()
    $("button##{id}.#{store}.duration").show()
  
  window.hideBuyingOptions = -> 
    $("button.show-options").show()
    $("button.duration").hide()
  
  window.incCartItems = (store) ->
    numItems = $ "#num-items"
    numItemsVal = numItems.html()
    if numItemsVal is "empty"
      numItems.html "1"
    else
      numItems.html(parseInt(numItemsVal) + 1)
    
    storeNumItems = $ ".num-items.#{store}"
    storeNumItemsVal = storeNumItems.html()
    
    if storeNumItemsVal is ""
      storeNumItems.html "1"
      $("table.#{store}").show() 
    else
      storeNumItems.html(parseInt(storeNumItemsVal) + 1)
  
  window.decCartItems = (store) ->
    numItems = $ "#num-items"
    numItemsVal = numItems.html()
    if numItemsVal is "1"
      numItems.html "empty"
    else
      numItems.html(parseInt(numItemsVal) - 1)
    
    storeNumItems = $ ".num-items.#{store}"
    storeNumItemsVal = storeNumItems.html()
    
    if storeNumItemsVal is "1"
      storeNumItems.html "" 
      $("table.#{store}").hide()
      $("p.#{store}").hide()
    else
      storeNumItems.html(parseInt(storeNumItemsVal) - 1)
  
  window.createShoppingCartJson = ->
    shoppingCartList = 
      "drugs":[] 
      "stores":[]
    cartItems = $ "div#shopping_cart tr.cart-item"
    
    for item in cartItems
      drugName = $(item).find(".name")[0].innerHTML
      quantity = $(item).find(".quantity")[0].innerHTML
      price = $(item).find(".price")[0].innerHTML
      store = $(item).find("td.store")[0].innerHTML
      
      shoppingCartList.drugs.push
        "name":drugName, 
        "quantity":quantity
        "price":price
        "store": store
    
    stores = $ "p.store"
    numStores = stores.length
    
    for store in stores
      storeName = store.innerHTML
      shoppingCartList.stores.push "name":storeName
    
    $("#shopping_cart input#drugList").val(JSON.stringify shoppingCartList )
  
  
  
  
  
  













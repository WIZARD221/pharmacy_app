(function(){window.addToCart=function(t,n,e,i){var r,s,o;return o=$("table."+i),s="<tr class='cart-item'><td class='name'>"+t+"</td><td class='quantity'>"+n+"</td><td class='price'>"+e+"</td><td display='none' class='store hidden'>"+i+"</td><td class='options'><button class=' btn remove-button'"+("onClick=\"removeFromCart(this,'"+i+"',"+e+")\"><i class='icon-remove'></i></button></td></tr>"),$(o).append(s),incCartItems(i),$("p."+i).show(),r=$("p#checkout_sum").html(),$("p#checkout_sum").html(parseInt(r)+parseInt(e)+"$")},window.removeFromCart=function(t,n,e){var i,r;return r=t.parentNode.parentNode,$(r).remove(),decCartItems(n),i=$("p#checkout_sum").html(),$("p#checkout_sum").html(parseInt(i)-e+"$")},window.showBuyingOptions=function(t,n){return hideBuyingOptions(),$("button#"+t+"."+n+".show-options").hide(),$("button#"+t+"."+n+".duration").show()},window.hideBuyingOptions=function(){return $("button.show-options").show(),$("button.duration").hide()},window.incCartItems=function(t){var n,e,i,r;return n=$("#num-items"),e=n.html(),"empty"===e?n.html("1"):n.html(parseInt(e)+1),i=$(".num-items."+t),r=i.html(),""===r?(i.html("1"),$("table."+t).show()):i.html(parseInt(r)+1)},window.decCartItems=function(t){var n,e,i,r;return n=$("#num-items"),e=n.html(),"1"===e?n.html("empty"):n.html(parseInt(e)-1),i=$(".num-items."+t),r=i.html(),"1"===r?(i.html(""),$("table."+t).hide(),$("p."+t).hide()):i.html(parseInt(r)-1)},window.createShoppingCartJson=function(){var t,n,e,i,r,s,o,a,u,m,d;if(i=$("p#num-items")[0].innerHTML,"empty"!==i){for(t=$("div#shopping_cart tr.cart-item"),o={drugs:[],stores:[]},u=[],m=0,d=t.length;d>m;m++)e=t[m],n=$(e).find(".name")[0].innerHTML,s=$(e).find(".quantity")[0].innerHTML,r=$(e).find(".price")[0].innerHTML,a=$(e).find("td.store")[0].innerHTML,o.drugs.push({name:n,quantity:s,price:r,store:a}),-1===u.indexOf(a)&&(u.push(a),o.stores.push({name:a}));return $("#shopping_cart input#drugList").val(JSON.stringify(o))}return!1}}).call(this);
(function(){var e,n;$(document).ready(function(){return $("header").hide(),n(),e(),window.print()}),n=function(){var e,n,t,r,i,a,o;for(n=$("table#temp_table .item"),o=[],i=0,a=n.length;a>i;i++)e=n[i],t=$(e).find(".store")[0].innerHTML,r=$("table."+t),o.push(r.append(e));return o},e=function(){var e,n,t,r,i;for(n=$("td.price"),t=0,n=function(){var t,r,i;for(i=[],t=0,r=n.length;r>t;t++)e=n[t],i.push(parseInt(e.innerHTML.replace("$","")));return i}(),r=0,i=n.length;i>r;r++)e=n[r],t+=e;return $("#total_price").text(""+t+"$")}}).call(this);
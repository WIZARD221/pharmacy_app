When(/^he selects a (\d+) Day item from a store$/) do |days|
  stores = Array.new
  Stores.all.each {|store| stores.push(store.name)}
  click_button(stores.first)
  click_button("#{days} Day")
end

When(/^he selects a (\d+) Day item from a different store$/) do |days|
  click_button(stores.last)
  click_button("#{days} Day")
end

Then(/^the items should appear in the shopping cart$/) do
  pending # express the regexp above with the code you wish you had
end
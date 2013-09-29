Given(/^a user visits the home page$/) do
  visit "/"
end

When(/^he searches for non existing information$/) do
  page.should have_css("div#drug_table_wrapper")
  fill_in 'Search', with: "xyxyxy"
end

Then(/^he should see no matching results$/) do
  expect(page).to have_selector('td.dataTables_empty', text: 'No matching records found')
end

When(/^he searches for existing information$/) do
  @drug = Drug.offset(rand(Drug.count)).first
  page.should have_css("div#drug_table_wrapper")
  fill_in 'Search', with: @drug.generic_name  
end

Then(/^he should see the matching result$/) do
  expect(page).to have_selector('td.name', text: @drug.generic_name)
end
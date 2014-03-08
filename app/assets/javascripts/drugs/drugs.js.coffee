$ ->
  $('#drug_search').typeahead
    name: "drug"
    remote: "/drugs/autocomplete?query=%QUERY"
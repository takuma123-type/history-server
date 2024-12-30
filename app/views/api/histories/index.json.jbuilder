json.array!(@output.histories) do |history|
  json.id history.id
  json.period history.period
  json.company_name history.company_name
  json.project_name history.project_name
  json.contents history.contents
  json.others history.others

  json.position do
    json.id history.position[:id]
    json.name history.position[:name]
  end

  json.scale do
    json.id history.scale[:id]
    json.people history.scale[:people]
  end

  json.core_stack do
    json.id history.core_stack[:id]
    json.name history.core_stack[:name]
  end

  json.infrastructure do
    json.id history.infrastructure[:id]
    json.name history.infrastructure[:name]
  end
end

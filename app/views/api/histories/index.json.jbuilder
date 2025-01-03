json.array!(@output.histories) do |history|
  json.id history.id
  json.company_name history.company_name
  json.created_at history.created_at
  json.updated_at history.updated_at
end

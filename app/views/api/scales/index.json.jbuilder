json.array!(@output.scales) do |scale|
  json.id scale.id
  json.name scale.name
end

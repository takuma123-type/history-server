json.array!(@output.infrastructures) do |infrastructure|
  json.id infrastructure.id
  json.name infrastructure.name
end

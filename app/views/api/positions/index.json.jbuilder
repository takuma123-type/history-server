json.array!(@output.positions) do |position|
  json.id position.id
  json.name position.name
end

json.array!(@output.corestacks) do |corestack|
  json.id corestack.id
  json.name corestack.name
end

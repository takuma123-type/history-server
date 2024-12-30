json.id @output.history.id
json.period @output.history.period
json.company_name @output.history.company_name
json.project_name @output.history.project_name
json.contents @output.history.contents
json.others @output.history.others
json.position do
  json.id @output.history.position.id
  json.name @output.history.position.name
end
json.scale do
  json.id @output.history.scale.id
  json.people @output.history.scale.people
end
json.core_stack do
  json.id @output.history.core_stack.id
  json.name @output.history.core_stack.name
end
json.infrastructure do
  json.id @output.history.infrastructure.id
  json.name @output.history.infrastructure.name
end

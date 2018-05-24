json.array!(@substrates) do |substrate|
  json.extract! substrate, :id
  json.title substrate.title
end
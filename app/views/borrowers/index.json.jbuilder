json.array!(@borrowers) do |borrower|
  json.extract! borrower, :name, :email
  json.url borrower_url(borrower, format: :json)
end

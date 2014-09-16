json.array!(@books) do |book|
  json.extract! book, :author, :title, :isbn, :onloan
  json.url book_url(book, format: :json)
end

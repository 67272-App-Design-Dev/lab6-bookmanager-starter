json.array!(@books) do |book|
  json.extract! book, :id, :title, :category_id, :units_sold, :proposal_date, :contract_date, :published_date, :notes
  json.url book_url(book, format: :json)
end

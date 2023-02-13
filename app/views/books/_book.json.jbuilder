json.extract! book, :id, :title, :category_id, :proposal_date, :contract_date, :published_date, :units_sold, :notes, :active, :created_at, :updated_at
json.url book_url(book, format: :json)

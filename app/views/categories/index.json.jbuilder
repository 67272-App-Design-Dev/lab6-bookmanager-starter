# json.array! @categories, partial: "categories/category", as: :category

json.array!(@categories) do |category|
    json.extract! category, :id, :name, :active
    json.url category_url(category, format: :json)
  end
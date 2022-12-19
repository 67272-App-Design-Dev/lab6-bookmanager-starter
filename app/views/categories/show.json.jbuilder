# json.partial! "categories/category", category: @category
json.extract! @category, :id, :name, :active, :created_at, :updated_at
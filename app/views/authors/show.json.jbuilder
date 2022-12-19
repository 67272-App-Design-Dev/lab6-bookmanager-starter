# json.partial! "authors/author", author: @author
json.extract! @author, :id, :first_name, :last_name, :active, :created_at, :updated_at

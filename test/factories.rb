FactoryGirl.define do
  # categories
  factory :category do
    name "Ruby"
    active true
  end

  # books
  factory :book do
    title "The Well-Grounded Rubyist"
    association :category
    proposal_date 1.year.ago.to_date
    contract_date 10.months.ago.to_date
    published_date 3.weeks.ago.to_date
    units_sold 1000
    notes "It is a very good book for learning Ruby."
  end

  # TODO: Add a factory for author below...
  # authors
  factory :author do |variable|
    first_name "David"
    last_name "Black"    
  end

  # book_authors
  factory :book_author do
    association :book
    association :author
  end
end
# require 'test_helper'

# class BookTest < ActiveSupport::TestCase
#   # Start by using Shoulda's ActiveRecord matchers
#   #
#   # TODO: Relationship macros


#   # TODO: Validation macros


#   # TODO: Test dates as much as you can with matchers...
  
  


#   context "With a proper context, " do
#     # I can create the objects I want with factories
#     setup do
#       # call the create_context method here
#     end

#     # and provide a teardown method as well
#     teardown do
#       # call the remove_context method here
#     end

#     # test one of each factory object (not really required, could be done in console)
#     should "show that all factory objects are properly created" do
#       # assert_equal "Ruby", @ruby.name
#       # assert_equal "Rails", @rails.name
#       # assert_equal "Testing", @testing.name
#       # assert_equal "Black, David", @dblack.name
#       # assert_equal "Hartl, Michael", @michael.name
#       # assert_equal "Hellesoy, Aslak", @aslak.name
#       # assert_equal "Chelimsky, David", @dchel.name
#       # assert_equal "The Well-Grounded Rubyist", @wgr.title
#       # assert_equal "Rails 3 Tutorial", @r3t.title
#       # assert_equal "Ruby for Masters", @rfm.title
#       # assert_equal "The RSpec Book", @rspec.title
#       # assert_equal "Black, David", @wgr.authors.first.name
#       # assert_equal "Hartl, Michael", @r3t.authors.first.name
#       # assert_equal 2, @rspec.authors.size
#       # assert_equal "Chelimsky, David", @rspec.authors.alphabetical.first.name
#       # assert_equal "Black, David", @rfm.authors.first.name
#       # assert_nil @agt.contract_date
#       # assert_nil @rfm.published_date
#     end


#     # TESTING SCOPES
#     #
#     # Avaliable book scopes (copied from book model for easy reference):
#     #   - by_title
#     #   - by_category
#     #   - published
#     #   - under_contract
#     #   - proposed
#     #   - for_category
    
#     should "have all the books listed alphabetically by title" do
#       # test code goes here...
#     end
    
#     should "have all the books listed alphabetically by category, then by title" do
#       # test code goes here...
#     end
    
#     should "have all the published books" do
#       # test code goes here...
#     end
    
#     should "have all the books under contract" do
#       # test code goes here...
#     end
    
#     should "have all the books that are only at proposal stage" do
#       # test code goes here...
#     end
    
#     should "have all the books for a particular category" do
#       # test code goes here...
#     end
    
#     # TESTING CONTRACT AND PUBLISHED DATES
#     # proposal_date was validated earlier with a matcher
#     #
#     # Validations (copied from book model for easy reference):
#     #   - validates_date :contract_date, after: :proposal_date, on_or_before: -> { Date.current }, allow_blank: true
#     #   - validates_date :published_date, after: :contract_date, on_or_before: -> { Date.current }, allow_blank: true
        
#     should "allow for a contract date in the past after the proposal date" do
#       # take advantage of the fact that the default proposal date is 1 year ago...
#       # test code goes here...
#     end
    
#     should "allow for contract and published dates to be nil" do
#       # make pub date also nil otherwise it will fail b/c default pub date is 3 weeks ago, which is before a nil contract date      big_ruby_book = FactoryGirl.build(:book, :contract_date => nil, :published_date => nil, :category => @ruby, :title => "The Big Book of Ruby")
#       # test code goes here...
#     end
    
#     should "not allow for a contract date in the past before the proposal date" do
#       # test code goes here...
#     end
    
#     should "not allow for a contract date in the future" do
#       # test code goes here...
#     end
    
#     should "allow for a published date in the past after the contract date" do
#       # take advantage of the fact that the default contract date is 10 months ago...
#       # test code goes here...
#     end
    
#     should "allow for just the published date to be nil" do
#       # test code goes here...
#     end
    
#     should "not allow for a published date in the past before the contract date" do
#       # test code goes here...
#     end
    
#     should "not allow for a published date in the future" do
#       # test code goes here...
#     end
    
    
#     # TESTING CUSTOM VALIDATIONS
#     # test the custom validation 'category_is_active_in_system'
#     should "identify an inactive category as invalid" do
#       # test code goes here...
#     end
#   end

# end

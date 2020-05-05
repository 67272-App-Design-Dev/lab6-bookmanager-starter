# TODO: SimpleCov required here...

ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
#require 'turn/autorun'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  # fixtures :all


  # ----------------------------------------------------
  # THIS HELPER METHOD IS NOT A DEFAULT METHOD IN RAILS
  # (added in by Prof. H; will have to include it if used in phase 2)
  def deny(condition)
    # a simple transformation to increase readability IMO
    assert !condition
  end
  
  
  # ----------------------------------------------------
  # CREATE_ & REMOVE_CONTEXT HELPER METHODS NOT DEFAULT METHODS IN RAILS (added in by Prof. H)
  def create_context
    # Create three categories
    @ruby    = FactoryGirl.create(:category)
    @rails   = FactoryGirl.create(:category, name: "Rails")
    @testing = FactoryGirl.create(:category, name: "Testing")

    # Create four authors
    @dblack  = FactoryGirl.create(:author)
    @michael = FactoryGirl.create(:author, first_name: "Michael", last_name: "Hartl")
    @aslak   = FactoryGirl.create(:author, first_name: "Aslak", last_name: "Hellesoy")
    @dchel   = FactoryGirl.create(:author, first_name: "David", last_name: "Chelimsky")

    # Create three published books, one in each category
    @wgr     = FactoryGirl.create(:book, category: @ruby)
    @r3t     = FactoryGirl.create(:book, title: "Rails 3 Tutorial", category: @rails)
    @rspec   = FactoryGirl.create(:book, title: "The RSpec Book", category: @testing)

    # Create a book that is under contract, but not yet published, in Ruby category (giving us count=2 for Ruby)
    @rfm     = FactoryGirl.create(:book, title: "Ruby for Masters", category: @ruby, published_date: nil)

    # Create a book that is only proposed, but not under contract, in Testing category (giving us count=2 for Testing)
    @agt     = FactoryGirl.create(:book, title: "Agile Testing", category: @testing, contract_date: nil, published_date: nil)

    # Connect books to their respective authors
    @ba1     = FactoryGirl.create(:book_author, book: @wgr, author: @dblack)
    @ba2     = FactoryGirl.create(:book_author, book: @r3t, author: @michael)
    @ba3     = FactoryGirl.create(:book_author, book: @rfm, author: @dblack)
    @ba4     = FactoryGirl.create(:book_author, book: @rspec, author: @aslak)
    @ba5     = FactoryGirl.create(:book_author, book: @rspec, author: @dchel)
    @ba6     = FactoryGirl.create(:book_author, book: @agt, author: @dchel)
  end
  
  def remove_context
    @ruby.destroy
    @rails.destroy
    @testing.destroy
    @dblack.destroy
    @michael.destroy
    @aslak.destroy
    @dchel.destroy
    @wgr.destroy
    @r3t.destroy
    @rfm.destroy
    @rspec.destroy
    @agt.destroy
    @ba1.destroy
    @ba2.destroy
    @ba3.destroy
    @ba4.destroy
    @ba5.destroy
    @ba6.destroy
  end

end

# Formatting test output a litte nicer
#Turn.config.format = :outline

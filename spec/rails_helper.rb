# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'database_cleaner'

module MyHelpers
  def user_with(overrides = {})
    attributes = {
      full_name: "John",
      email_address: 'admin@example.com',
      password: '1234',
      password_confirmation: "1234",
      role: 'admin'
    }.merge(overrides)
    User.new(attributes)
  end

  def create(user)
    user.save
    user
  end

  def login_as(user)
    visit "/"
    page.fill_in('Email address', with: user.email_address)
    page.fill_in('Password', with: '1234')
    page.click_button('Log In')
  end

  def create_item(overrides = {})
    attributes = {
      name: "Mountain Mud Pie",
      description: "yummy, yummy, yummy, yummy, yummy",
      price: 3.50,
      status: 'active'
    }.merge(overrides)
    Item.create(attributes)
  end

  def create_category(overrides = {})
    attributes = {
      name: "Desserts"
    }.merge(overrides)
    Category.create(attributes)
  end

  def create_item_associated_with_a_category
    appetizer = Category.create(name: 'Appetizers')
    attributes = {
      name: 'dandelion salad',
      description: 'yummyyummyyummyyummyyummyyummyyummy',
      price: 5.00,
      status: 'active',
      category_ids: [appetizer.id]}
    Item.create(attributes)
  end

  def create_order_with_order_item(user)
    create_item_associated_with_a_category
    order = Order.create(user_id: user.id, status: "paid")
    order.order_items.create(item_id: Item.last.id, quantity: 3)
  end

  def create_order(overrides = {})
    attributes = {
      user_id: 1,
      status: 'paid'
    }.merge(overrides)
    Order.create(attributes)
  end

end

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include(MyHelpers)

   config.before(:suite) do
     DatabaseCleaner.clean_with(:truncation)
   end

   config.before(:each) do
     DatabaseCleaner.strategy = :transaction
   end

   config.before(:each) do
     DatabaseCleaner.start
   end

   config.after(:each) do
     DatabaseCleaner.clean
   end

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!
end

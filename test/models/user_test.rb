require 'test_helper'

class UserTest < ActiveSupport::TestCase
	test "a user should enter a first name" do
		user = User.new
		assert !user.save
		assert !user.errors[:first_name].empty?
	end

	test "a user should enter a last name" do
		user = User.new
		assert !user.save
		assert !user.errors[:last_name].empty?
	end

	test "a user should enter a profile name" do
		user = User.new
		assert !user.save
		assert !user.errors[:profile_name].empty?
	end

	test "user should have a unique profile name" do 
		user = User.new
		user.profile_name = users(:dustin).profile_name

		assert !user.save
		assert !user.errors[:profile_name].empty?
	end

	test "profile_name should be without spaces" do
		user = User.new(first_name: 'Jason', last_name: 'Seifer', email: 'something@example.com')
		user.password = user.password_confirmation = "password"
		
		user.profile_name = "My profile with spaces"

		assert !user.save
		assert !user.errors[:profile_name].empty?
		assert user.errors[:profile_name].include?("Must be formatted correctly.")
	end

	test "a user can have a correctly formatted profile_namw" do 
		user = User.new(first_name: 'Jason', last_name: 'Seifer', email: 'something@example.com')
		user.password = user.password_confirmation = "password"

		user.profile_name = "scary_smile"
		assert user.valid?
	end
end
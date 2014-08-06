require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:activities)\




  context '#create_activity' do
  	should "increase the Activity account" do
  		asser_difference 'Activity.cound' do
  			users(:jason).create_activity
  		end
  	end	

  	should "set the targetable instance to the item passded in"
  end
end

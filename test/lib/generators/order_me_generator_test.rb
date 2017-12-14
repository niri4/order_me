require 'test_helper'
require 'generators/order_me/order_me_generator'

class OrderMeGeneratorTest < Rails::Generators::TestCase
  tests OrderMeGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end

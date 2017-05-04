require 'rails_helper'

class UserTest < ActiveSupport::TestCase
  context "associations" do
    should have_many(:restaurants)
  end

  # context "cp" do
  # end
end

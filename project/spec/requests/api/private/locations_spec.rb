require 'rails_helper'

describe "Locations", type: :request do
  it_behaves_like "a locations request", :private
end

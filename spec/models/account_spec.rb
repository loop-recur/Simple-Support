require 'spec_helper'

describe Account do
  
  context "associations" do
    it { should belong_to(:user) }
  end
  
end

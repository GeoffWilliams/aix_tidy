require 'spec_helper'
describe 'aix_tidy::dot_profile' do
  context "catalog compiles" do
    it { should compile}
  end
  
  context 'with default values for all parameters' do
    it { should contain_class('aix_tidy::dot_profile') }
  end
end

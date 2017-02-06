require 'spec_helper'
describe 'aix_tidy::dot_profile' do
  context 'with default values for all parameters' do
    it { should contain_class('aix_tidy::dot_profile') }
  end
end

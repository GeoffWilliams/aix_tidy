require 'spec_helper'
describe 'aix_tidy::mesg' do
  context 'with default values for all parameters' do
    it { should contain_class('aix_tidy::mesg') }
  end
end

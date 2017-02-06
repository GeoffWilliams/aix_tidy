require 'spec_helper'
describe 'aix_tidy' do
  context 'with default values for all parameters' do
    it { should contain_class('aix_tidy') }
  end
end

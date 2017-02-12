require 'spec_helper'
describe 'aix_tidy::snmp' do
  context 'with default values for all parameters' do
    it { should contain_class('aix_tidy::snmp') }
  end
end

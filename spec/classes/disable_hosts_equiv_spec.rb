require 'spec_helper'
describe 'aix_tidy::disable_hosts_equiv' do
  context 'with default values for all parameters' do
    it { should contain_class('aix_tidy::disable_hosts_equiv') }
  end
end

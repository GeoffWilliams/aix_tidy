require 'spec_helper'
describe 'aix_tidy::disable_inetd_service' do
  context "catalog compiles" do
    it { should compile}
  end
  
  context 'with default values for all parameters' do
    it { should contain_class('aix_tidy::disable_inetd_service') }
  end

  context 'processes passed in list of services correctly' do
    let :params do
      {
        :disable => ["foo->bar", "baz->bas"],
      }
    end
    it { should contain_class('aix_tidy::disable_inetd_service') }
  end
end

require 'spec_helper'
describe 'aix_tidy::user_attribute_lockdown' do
  context "catalog compiles" do
    it { should compile}
  end
  
  context 'with default values for all parameters' do
    it { should contain_class('aix_tidy::user_attribute_lockdown') }
  end

  context 'attributes are set' do
    it {
      should contain_user('daemon').with({
        :attributes => ['login=false','rlogin=false'],
      })
    }
  end
end

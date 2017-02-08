require 'spec_helper'
describe 'aix_tidy::user_attribute_lockdown' do
  context 'with default values for all parameters' do
    it { should contain_class('aix_tidy::user_attribute_lockdown') }
  end

  context 'attributes are set' do
    it {
      should contain_user('lpd').with({
        :attributes => ['login=false','rlogin=false'],
      })
    }
  end
end
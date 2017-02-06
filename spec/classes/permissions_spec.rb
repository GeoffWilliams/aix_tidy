require 'spec_helper'
describe 'aix_tidy::permissions' do
  # Required to allow compilation
  let :facts do
    {
      "os" => {
        "family" => "AIX"
      }
    }
  end
  context 'with default values for all parameters' do
    it { should contain_class('aix_tidy::permissions') }
  end
end

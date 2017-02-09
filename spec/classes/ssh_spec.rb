require 'spec_helper'
describe 'aix_tidy::ssh' do
  # Required to allow compilation
  let :facts do
    {
      "operatingsystem" => "AIX",
      "os" => {
        "family" => "AIX"
      }
    }
  end
  context 'with default values for all parameters' do
    it { should contain_class('aix_tidy::ssh') }
  end
end

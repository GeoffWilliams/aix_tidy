require 'spec_helper'
describe 'aix_tidy::chsec' do
  context "catalog compiles" do
    it { should compile}
  end
  
  context 'with default values for all parameters' do
    it { should contain_class('aix_tidy::chsec') }
  end

  context 'processes passed-in hash correctly' do
    let :params do
      {
        :values => {
          "default_minage" => {
            "file"      => "/etc/security/user",
            "attribute" => 'minage',
            "value"     => "4",
          }
        }
      }
    end
    it { should contain_class('aix_tidy::chsec') }
  end
end

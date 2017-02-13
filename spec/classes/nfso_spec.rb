require 'spec_helper'
describe 'aix_tidy::nfso' do
  context "catalog compiles" do
    it { should compile}
  end
  
  context 'with default values for all parameters' do
    it { should contain_class('aix_tidy::nfso') }
  end

  context 'compiles with settings to action' do
    let :params do
      {
        :settings => {
          "portcheck" => "0",
        }
      }
    end
    it { should contain_class('aix_tidy::nfso') }
  end
end

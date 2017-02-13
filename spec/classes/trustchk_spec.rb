require 'spec_helper'
describe 'aix_tidy::trustchk' do
  context "catalog compiles" do
    it { should compile}
  end
  
  context 'with default values for all parameters' do
    it { should contain_class('aix_tidy::trustchk') }
  end

  context 'compiles with settings to action' do
    let :params do
      {
        :settings => {
          "CHKEXEC" => "ON",
        }
      }
    end
    it { should contain_class('aix_tidy::trustchk') }
  end
end

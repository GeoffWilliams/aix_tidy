require 'spec_helper'
describe 'aix_tidy::no' do
  context 'with default values for all parameters' do
    it { should contain_class('aix_tidy::no') }
  end

  context 'compiles with settings to action' do
    let :params do
      {
        :settings => {
          "tcp_recvspace" => "262144",
          "tcp_mssdflt" => "1448",
        }
      }
    end
    it { should contain_class('aix_tidy::no') }
  end
end

require 'spec_helper'
describe 'aix_tidy::ftp' do
  context 'with default values for all parameters' do
    it { should contain_class('aix_tidy::ftp') }
  end

  context 'compiles when banner set' do
    let :params do
      {
        :banner_message => "hello, world",
      }
    end
    it { should contain_class('aix_tidy::ftp') }
  end
end

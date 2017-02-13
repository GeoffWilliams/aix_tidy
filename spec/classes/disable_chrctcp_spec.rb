require 'spec_helper'
describe 'aix_tidy::disable_chrctcp' do
  context "catalog compiles" do
    it { should compile}
  end
  
  context 'with default values for all parameters' do
    it { should contain_class('aix_tidy::disable_chrctcp') }
  end

  context 'compiles when list of services to disable set' do
    let :params do
      {
        :disable => ['a','b','c'],
      }
    end
    it { should contain_class('aix_tidy::disable_chrctcp') }
  end
end

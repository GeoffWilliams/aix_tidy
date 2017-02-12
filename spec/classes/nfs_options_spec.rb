require 'spec_helper'
describe 'aix_tidy::nfs_options' do
  context 'with default values for all parameters' do
    it { should contain_class('aix_tidy::nfs_options') }
  end

  context 'compiles when nfs mounts are present' do
    let :facts do
      {
        :mountpoints => {
          "/" => {
            "filesystem" => "foo",
          },
          "/data" => {
            "filesystem" => "nfs",
          },
          "/usr" => {
            "filesystem" => "foo",
          },
          "/data2" => {
            "filesystem" => "nfs",
          }
        }
      }
    end
    it { should contain_class('aix_tidy::nfs_options') }
    it { should contain_mount('/data') }
    it { should contain_mount('/data2') }
    it { should_not contain_mount('/') }
    it { should_not contain_mount('/usr') }
  end
end

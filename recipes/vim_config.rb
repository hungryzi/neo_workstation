# Acknowledgements: Some configuration source from
# https://github.com/Casecommons/casecommons_workstation

include_recipe "sprout-osx-apps::macvim"
include_recipe "sprout-osx-apps::ack"
include_recipe "pivotal_workstation::git"

ruby_block "ensure neo_workstation can manage #{node["vim_home"]}" do
  block do
    missing = "test ! -d #{node["vim_home"]}"
    present = "cd #{node["vim_home"]}"
    owned_by_pw = "test -d .git && (git remote -v show | grep -q #{node["vim_config_git"]})"

    unless system("#{missing} || (#{present} && #{owned_by_pw})")
      raise "Rename or delete #{node["vim_home"]} if you want to use this recipe"
    end
  end
end

git node["vim_home"] do
  repository node["vim_config_git"]
  branch "master"
  revision "HEAD"
  action :sync
  user node['current_user']
  enable_submodules true
end

%w{vimrc gvimrc}.each do |vimrc|
  link "#{node['sprout']['home']}/.#{vimrc}" do
    to "#{node["vim_home"]}/#{vimrc}"
    owner node['current_user']
    not_if { File.symlink?("#{node["vim_home"]}/#{vimrc}") }
  end
end

file "#{node['sprout']['home']}/.vimrc.local" do
  action :touch
  owner node['current_user']
  not_if { File.exists?("#{node['sprout']['home']}/.vimrc.local") }
end


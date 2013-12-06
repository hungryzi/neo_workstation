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

    vimrc = "test ! -e ~/.vimrc"
    gvimrc = "test ! -e ~/.gvimrc"

    #if system("#{vimrc} || #{gvimrc}")
    #  raise "Please remove or rename your ~/.vimrc, ~/.gvimrc"
    #end
  end
end

git "#{Chef::Config[:file_cache_path]}/vim-config" do
  repository node["vim_config_git"]
  branch "master"
  revision "HEAD"
  action :sync
  user node['current_user']
  enable_submodules true
end

execute "symlink the dotfiles" do
  cwd "#{Chef::Config[:file_cache_path]}/vim-config"
  command "rake"
end

execute "run BundleInstall" do
  command "vim +BundleInstall +qall"
end


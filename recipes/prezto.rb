include_recipe "pivotal_workstation::git"
include_recipe "sprout-osx-apps::zsh"

::PREZTO_DIR = ::File.expand_path(".zprezto", node['sprout']['home'])

git_clone   = git "#{Chef::Config[:file_cache_path]}/prezto" do
  repository 'https://github.com/sorin-ionescu/prezto.git'
  destination "#{Chef::Config[:file_cache_path]}/prezto"
  action :nothing
end

git_clone.run_action(:sync)

dotgit_copy = execute "Copying prezto's .git to #{PREZTO_DIR}" do
  command "rsync -axSH #{Chef::Config[:file_cache_path]}/prezto/ #{PREZTO_DIR}"
  user node['current_user']
  action :nothing
end

dotgit_copy.run_action(:run)

['zlogin', 'zlogout', 'zpreztorc', 'zprofile', 'zshenv', 'zshrc'].each do |zfile|
  file "#{node['sprout']['home']}/.#{zfile}" do
    owner node['current_user']
    mode 00755
    content IO.read "#{PREZTO_DIR}/runcoms/#{zfile}"
  end
end

change_shell = execute "Change the default shell to zsh" do
  command "chsh -s /bin/zsh #{node['current_user']}"
  action :nothing
end

change_shell.run_action(:run)

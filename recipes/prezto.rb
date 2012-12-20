include_recipe "pivotal_workstation::git"
include_recipe "pivotal_workstation::zsh"


::PREZTO_DIR = ::File.expand_path(".zprezto", WS_HOME)

g = git "#{Chef::Config[:file_cache_path]}/prezto" do
  repository 'https://github.com/sorin-ionescu/prezto.git'
  #revision bash_it_version
  destination "#{Chef::Config[:file_cache_path]}/prezto"
  action :nothing
end

g.run_action(:sync)

e = execute "Copying prezto's .git to #{PREZTO_DIR}" do
  command "rsync -axSH #{Chef::Config[:file_cache_path]}/prezto/ #{PREZTO_DIR}"
  user WS_USER
  action :nothing
end

e.run_action(:run)

['zlogin', 'zlogout', 'zpreztorc', 'zprofile', 'zshenv', 'zshrc'].each do |zfile|
  file "#{WS_HOME}/.#{zfile}" do
    owner WS_USER
    mode 00755
    content IO.read "#{PREZTO_DIR}/runcoms/#{zfile}"
  end
end

e = execute "Change the default shell to zsh" do
  command "chsh -s /bin/zsh #{WS_USER}"
  action :nothing
end

e.run_action(:run)

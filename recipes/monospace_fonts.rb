directory Chef::Config[:file_cache_path] do
  action :create
  recursive true
  mode "0775"
  owner "root"
  group "staff"
end

git "#{Chef::Config[:file_cache_path]}/monospace_fonts" do
  repository "git://github.com/mohangk/progging_fonts.git"
  destination "#{Chef::Config[:file_cache_path]}/monospace_fonts"
  action :sync
end

directory "/Users/#{node['current_user']}/Library/Fonts" do
  action :create
  recursive true
  mode "0755"
  owner node['current_user']
end

execute "Copying fonts to ~/Library/Fonts" do
  user node['current_user']
  command "cp -f #{Chef::Config[:file_cache_path]}/monospace_fonts/*.otf $HOME/Library/Fonts"
end

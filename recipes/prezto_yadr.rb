# We like what YADR does for ZSH, but we don't want everything else it does.
# This recipe applies some of the ZSH specific bits of YADR

include_recipe "neo_workstation::prezto"

::PREZTO_DIR = ::File.expand_path(".zprezto", node['sprout']['home'])

#overide the zpreztorc to enable more modules then default and set the skwp theme
cookbook_file "#{node['sprout']['home']}/.zpreztorc" do
  source "zpreztorc"
  mode "0644"
  owner node['current_user']
end

#copy in the skwp theme
cookbook_file "#{PREZTO_DIR}/modules/prompt/functions/prompt_skwp_setup" do 
  source "prompt_skwp_setup"
  mode "0644"
  owner node['current_user']
end

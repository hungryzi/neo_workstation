rubymine_pref_dir = "#{WS_HOME}/Library/Preferences/RubyMine50"
git_repo_location = "#{Chef::Config[:file_cache_path]}/rubymine-preferences"

git git_repo_location do
  repository "https://github.com/neo/rubymine-preferences.git"
  action :sync
  user WS_USER
end

[
    [rubymine_pref_dir, "keymaps"],
    [rubymine_pref_dir, "templates"],
    [rubymine_pref_dir, "colors"]
].each do |dirs|
  recursive_directories dirs do
    owner WS_USER
    mode "0755"
    recursive true
  end
end

[ 
  "keymaps/neo.xml",
  "templates/Ruby.xml", 
  "templates/jasmine.xml",
  "colors/RailsCasts-Upsize.xml"
].each do |file|
  link "#{rubymine_pref_dir}/#{file}" do
    to "#{git_repo_location}/#{file}"
  end
end

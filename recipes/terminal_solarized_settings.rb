git "#{Chef::Config[:file_cache_path]}/solarized_terminal" do
  repository "git://github.com/tomislav/osx-lion-terminal.app-colors-solarized.git"
  destination "#{Chef::Config[:file_cache_path]}/solarized_terminal"
  action :sync
end

ruby_block "Load settings into Terminal" do
  block do
    system(
    "osascript -e '
      tell application \"Finder\"
         open posix file \"#{Chef::Config[:file_cache_path]}/solarized_terminal/Solarized Dark.terminal\"
         open posix file \"#{Chef::Config[:file_cache_path]}/solarized_terminal/Solarized Light.terminal\"
      end tell'"
    )
  end
end

node.default["rvm"] ||= {}
node.default["rvm"]["rubies"] = {
  "ruby-2.0.0-p353" => { :command_line_options => "--verify-downloads 1" }
}

node.default["rvm"]["default_ruby"] = "ruby-2.0.0-p353"

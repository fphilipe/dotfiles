begin
  require 'spring/commands/rspec'
rescue LoadError
end

begin
  require 'listen'
  Spring.watch_method = :listen
rescue LoadError
end

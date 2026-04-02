IRB.conf[:COMMAND_ALIASES].merge!(
  c: :continue,
  h: :help,
  n: :next,
  s: :step,
)

# Quick IPS benchmarking:
def ips(&blk)
  require 'benchmark/ips'
  Benchmark.ips do |b|
    b.singleton_class.send(:alias_method, :r, :report)
    b.instance_eval(&blk)
    b.compare!
  end
  nil
end

# Output SQL statements in Rails:
if defined? Logger and not ENV['NO_LOG']
  ActiveRecord::Base.logger = Logger.new STDOUT if defined? ActiveRecord
end

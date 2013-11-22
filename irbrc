require 'rubygems'
require 'brice/init' rescue nil

# Quick benchmarking:
def quick(repetitions=100, &block)
  require 'benchmark'

  Benchmark.bmbm do |b|
    b.report { repetitions.times(&block) }
  end

  nil
end

# Output SQL statements in Rails:
if defined? Logger and not ENV['NO_LOG']
  ActiveRecord::Base.logger = Logger.new STDOUT if defined? ActiveRecord
end

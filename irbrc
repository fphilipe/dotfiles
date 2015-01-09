require 'rubygems'
require 'irb'
require 'irb/completion'
require 'irb/ext/save-history'

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

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

if Dir.pwd != Dir.home and File.exists?('.irbrc')
  load('.irbrc')
end

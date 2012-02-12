require 'simplecov'
SimpleCov.start

require 'rspec'

Dir[File.dirname(__FILE__) + '/../lib/stashhouse/*.rb'].each { |file| require file }
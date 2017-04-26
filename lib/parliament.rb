require 'json'
require 'dotenv'

GC::Profiler.enable

module Parliament
  autoload :VERSION,        'parliament/version'
  autoload :APIv1,          'parliament/api_v1'

  class << self
    def init(environment)
      Bundler.setup(:default, environment)
      Dotenv.load
    end
  end
end

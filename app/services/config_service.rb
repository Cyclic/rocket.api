require 'yaml'
require 'erb'

#
# NOTE - this module needs to work before rails is booted (and because of this
# maybe i should move it into /lib/ to signifiy this?). this means no Rails.root,
# Rails.env, #try, etc. this code is actually used by spec/support/mocks so it'll
# be very clear if you violate this (tests will blow up). for this reason if
# you need to pull any external libraries in explicitly require them above.
module ConfigService
  class << self
    # for a given config file (config/foo.yml) we respond to two methods:
    #
    # ConfigService.foo_config - returns the entire yml file as a Hashie::Mash
    # ConfigService.foo - shorthand for ConfigService.foo_config[ENV['RACK_ENV'].to_sym]
    def method_missing(method, *arguments, &block)
      if _method = match_full_method(method)
        return load_config_file(_method) if configs.include?(_method)
      elsif configs.include?(method)
        return load_config(method, *arguments)
      end
      super
    end

    def respond_to?(method, *arguments, &block)
      configs.include?(method) || configs.include?(match_full_method(method)) || super
    end

    private

    def match_full_method(method)
      /\A(.+)_config\z/.match(method).to_a.dig(1)&.to_sym
    end

    def config_dir
      # no rails so no Rails.root
      @config_dir ||= File.expand_path('../../../config', __FILE__)
    end

    def configs
      @configs ||= Dir.glob(config_dir + '/*.yml').map {|f| f.match(/^\A.*\/(.+)\.yml/)[1].to_sym}
    end

    def load_config_file(name)
      name = name.to_sym
      @config_file_cache ||= {}
      @config_file_cache[name] ||= begin
        yaml = config_dir + "/#{name}.yml"
        if File.exists? yaml
          YAML.load(ERB.new(File.read(yaml)).result)
        else
          raise "Could not load configuration. No such file - #{yaml}"
        end
      end
    end

    # no rails so no Rails.env and maybe not even RAILS_ENV, hence RACK_ENV
    def load_config(name, env = (ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'development'))
      name = name.to_sym
      env = env.to_sym
      @config_cache ||= {}
      @config_cache[name] ||= {}
      @config_cache[name].to_hash.deep_symbolize_keys[env] ||= load_config_file(name).to_hash.deep_symbolize_keys[env]
    end
  end
end

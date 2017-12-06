require "active_support/core_ext/module/delegation"
require "active_support/core_ext/module/attribute_accessors"
require "active_support/core_ext/logger"
require "active_support/tagged_logging"

class Object
  # Returns the receiver if it's included in the argument otherwise returns +nil+.
  # Argument must be any object which responds to +#include?+. Usage:
  #
  #   params[:bucket_type].presence_in %w( project calendar )
  #
  # This will throw an ArgumentError if the argument doesn't respond to +#include?+.
  #
  # @return [Object]
  def presence_in(another_object)
    self.in?(another_object) ? self : nil
  end
end

module Webpacker
  extend self

  def instance=(instance)
    @instance = instance
  end

  def instance
    @instance ||= Webpacker::Instance.new
  end

  delegate :logger, :logger=, :env, to: :instance
  delegate :config, :compiler, :manifest, :commands, :dev_server, to: :instance
  delegate :bootstrap, :clobber, :compile, to: :commands
end

require "webpacker/instance"
require "webpacker/configuration"
require "webpacker/manifest"
require "webpacker/compiler"
require "webpacker/commands"
require "webpacker/dev_server"

require "webpacker/railtie" if defined?(Rails)

require 'livescript'
require 'livescript/rails/version'
require 'livescript/rails/processor'
require 'livescript/rails/railtie' if defined?(::Rails)

module Livescript
  module Rails
    def self.register!
      Sprockets.register_mime_type 'text/livescript', extensions: ['.ls', '.js.ls']
      Sprockets.register_transformer 'text/livescript', 'application/javascript', LiveScript::Rails::SprocketsProcessor
    end
  end
end

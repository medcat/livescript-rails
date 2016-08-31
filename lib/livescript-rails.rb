require 'livescript'
require 'livescript/rails/version'
require 'livescript/rails/processor'
require 'livescript/rails/railtie' if defined?(::Rails)

module LiveScript
  module Rails
    def self.register!
      Sprockets.register_mime_type 'text/livescript', extensions: ['.ls', '.js.ls']
      Sprockets.register_transformer 'text/livescript', 'application/javascript', LiveScript::Rails::SprocketsProcessor
      Sprockets.register_preprocessor 'text/livescript',
        Sprockets::DirectiveProcessor.new(comments: ["#", ["###", "###"]])
    end
  end
end

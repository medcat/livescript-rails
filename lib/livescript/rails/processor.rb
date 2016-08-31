require 'sprockets'

module LiveScript
  module Rails
    module SprocketsProcessor
      # only enable source map when sprockets >= 4.0
      ENABLE_SOURCE_MAP = Sprockets::VERSION >= '4.0'

      def self.cache_key
        @cache_key ||= "#{name}:#{LiveScript::Source::VERSION}:#{LiveScript::VERSION}:#{LiveScript::Rails::VERSION}".freeze
      end
      
      def self.rails_config
        (::Rails.application.config.assets.livescript if defined?(::Rails)) || {}
      end

      def self.call(input)
        data = input[:data]
        options = {
          bare: true,
          header: true,
        }.merge(rails_config)

        options.merge!({
          filename: input[:source_path] || input[:filename],
          map: ENABLE_SOURCE_MAP ? 'linked-src' : 'none',
        })

        result = input[:cache].fetch([self.cache_key, data]) do
          LiveScript.compile(data, options)
        end

        if ENABLE_SOURCE_MAP
          map = Sprockets::SourceMapUtils.decode_vlq_mappings(result['map']['mappings'], sources: result['map']['sources'], names: result['map']['names'])
          {
            data: result['code'],
            map: Sprockets::SourceMapUtils.combine_source_maps(input[:metadata][:map], map),
          }
        else
          result
        end
      end
    end
  end
end

# LiveScript-Rails

LiveScript adapter for the Rails asset pipeline.

Depends on [Roonin-mx/livescript-ruby](https://github.com/Roonin-mx/livescript-ruby) to compile LiveScript to javascript.

Source map is available if `Sprockets` >= 4.0.

## Installation

Add the following lines to your `Gemfile`:

```
gem 'livescript-rails'
```

If you are precompiling your assets (with rake assets:precompile) before run your application in production, you might want add it to the assets group to prevent the gem being required in the production environment.

```
group :assets do
  gem 'livescript-rails'
end
```

## Configuration

You can set compile options in `config/initializers/assets.rb`:

```
Rails.application.config.assets.livescript = {
  header: false,
}
```

See [Roonin-mx/livescript-ruby](https://github.com/Roonin-mx/livescript-ruby) for more options.

Default options:

* bare: true (for backward compatibility)
* header: true

`filename` and `map` options are set internally and not allowed to change.

## License

MIT

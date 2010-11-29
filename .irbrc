%w{rubygems wirble interactive_editor}.each { |lib| require lib}

if ENV.include?('RAILS_ENV')
  require 'logger'
  Object.const_set(:RAILS_DEFAULT_LOGGER, Logger.new(STDOUT))
end

wirble_opts = {
  :skip_shortcuts => true,
  :skip_prompt    => true,
  :init_color     => true,
}

# initialize wirble with options above
Wirble.init(wirble_opts)
Wirble.colorize

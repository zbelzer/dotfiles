%w{rubygems wirble}.each { |lib| require lib rescue nil }

wirble_opts = {
  :skip_shortcuts => true,

    # don't set the prompt
    :skip_prompt    => true,

    # override some of the default colors
    # :colors => {
    # :open_hash    => :green.
    # :close_hash   => :green.
    # :string       => :blue,
  # },

  # enable color
  :init_color     => true,
}

# initialize wirble with options above
Wirble.init(wirble_opts)
Wirble.colorize

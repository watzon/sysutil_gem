module Config
  # Configuration defaults
  @config = {
    log_level: 'verbose', # print all the things
    root_password: '', # not necessary if your running this as root
  }

  @valid_config_keys = @config.keys
  
  # Configure through hash
  def self.configure(opts = {})
    opts.each { |k,v| @config[k.to_sym] = v if @valid_config_keys.include? k.to_sym }
  end

  # Configure through yaml file
  def self.configure_with(config_file_path)
    begin
      config = YAML::load(IO.read(config_file_path))
    rescue Errno::ENOENT
      log(:warning, "YAML configuration file couldn't be found. Using defaults."); return
    rescue Psych::SyntaxError
      log(:warning, "YAML configuration file contains invalid syntax. Using defaults."); return
    end

    configure(config)
  end

  def self.config
    @config
  end
end

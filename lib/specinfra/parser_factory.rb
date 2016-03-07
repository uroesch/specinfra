class Specinfra::ParserFactory
  @@types = nil

  def self.instance
    self.new(os)
  end

  def initialize(os_info)
    @os_info = os_info
  end

  def get(meth, *args)
    action, resource_type, subaction = breakdown(meth)
    method =  action
    method += "_#{subaction}" if subaction
    command_class = create_command_class(resource_type)
    if command_class.respond_to?(method)
      command_class.send(method, *args)
    else
      raise NotImplementedError.new("#{method} is not implemented in #{command_class}")
    end
  end

  private
  def create_command_class(resource_type)
    family  = @os_info[:family]
    version = @os_info[:release] ? "V#{@os_info[:release].to_i}" : nil

    common_class = Specinfra::Parser
    base_class   = common_class.const_get('Base')
    os_class     = family.nil? ? base_class : common_class.const_get(family.capitalize)

    if family && version
      begin
        version_class = os_class.const_get(version)
      rescue
        version_class = os_class.const_get('Base')
      end
    elsif family.nil?
      version_class = os_class
    elsif family != 'base' && version.nil?
      version_class = os_class.const_get('Base')
    end

    begin
      command_class = version_class.const_get(resource_type.to_camel_case)
    rescue
    end

    if command_class.nil? ||( (command_class < Specinfra::Parser::Base).nil? && (command_class < Specinfra::Parser::Windows::Base).nil? )
      command_class = base_class.const_get(resource_type.to_camel_case)
    end

    command_class.create
  end

  def breakdown(meth)
    # Somtimes `selinux_module' type matches `selinux' and error occurs.
    # Reverse sorting is needed to avoid this problem.
    types = resource_types.map {|t| t.to_snake_case }.sort.reverse.join('|')
    md = meth.to_s.match(/^([^_]+)_(#{types})_?(.+)?$/)
    if md.nil?
      message =  "Could not break down `#{meth}' to appropriate type and method.\n"
      message += "The method name shoud be in the form of `action_type_subaction'."
      raise message
    end
    return md[1], md[2], md[3]
  end

  def resource_types
    if @@types.nil?
      @@types = []
      Specinfra::Parser::Base.subclasses.each do |s|
        @@types << s.to_s.split(':')[-1]
      end
      Specinfra::Parser::Windows::Base.subclasses.each do |s|
        @@types << s.to_s.split(':')[-1]
      end
      @@types.uniq!
    end
    @@types
  end
end

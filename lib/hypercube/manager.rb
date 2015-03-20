module Hypercube
  class Manager
    def initialize backend = :virtual_box
      @backend = backend
    end

    def backend
      get_backend @backend
    end

    def run args
      help if args.first.nil? || args.first == "--help"
      backend.run *args
    end

    def help
      puts <<-HELP
HYPERCUBE: A virtual machine manager that doesn't suck!
Available Backends: #{
  backend_path('.').children(false).map{|f|f.basename '.*'}.join(', ')
}
Basic Commands: #{
  backend.commands.join ', '
}
      HELP
      exit 0
    end

    private

    def get_backend name
      if name.is_a? Module then
        name
      else
        require backend_path(name)
        constantize camelize name
      end
    end

    def constantize name, constant = Hypercube::Backend
      constant.const_defined?(name) ? constant.const_get(name) : constant.const_missing(name)
    end

    def camelize name
      capitalized = name.to_s.sub(/^[a-z\d]*/) { $&.capitalize }
      capitalized.gsub(/(?:_|(\/))([a-z\d]*)/) { "#{$1}#{$2.capitalize}" }.gsub('/', '::')
    end

    def backend_path name
      Pathname.new(__FILE__).dirname.join('backends', name.to_s)
    end
  end
end

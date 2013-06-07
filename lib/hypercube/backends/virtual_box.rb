module Hypercube
  module Backend
    module VirtualBox
      def run command
        systemu [executable, Commands.send(command)].join(' ')
      end

      protected

      def executable
        'VBoxManage'
      end

      module Commands
        #include CommandTemplate

        def create name
          "createvm --name #{name}"
        end
      end
    end
  end
end

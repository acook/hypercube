module Hypercube
  module Backend
    module VirtualBox
      module_function

      def run command
        if command.first == 'set' then
          _, vm, attribute, value = command
          command = ["#{attribute}=", vm, value]
        end

        method = command.first.to_sym

        raise NotImplementedError unless commands.include? method

        status, stdout, stderr = systemu [executable, Commands.send(*command)].join(' ')

        raise stderr unless status.exitstatus == 0

        $last_status = status.exitstatus
        $last_out    = stdout
        $last_error  = stderr

        stdout
      end

      def executable
        'VBoxManage'
      end

      def commands
        Commands.methods false
      end

      module Commands
        #include CommandTemplate
        module_function

        def list
          "list vms"
        end

        def create vm
          "createvm --name #{vm} --register"
        end

        def destroy vm
          "unregistervm #{vm} --delete"
        end

        def hd= vm, path
          "modifyvm #{vm} --sataport1 \"#{path}\""
        end

        def info vm, attribute = nil
          output = "showvminfo #{vm} #{ attribute && '-machinereadable' }"

          if attribute then
            local_name = attribute_map[attribute]
            output.split("\n").detect{|line| line =~ /#{local_name}/}
          else
            output
          end
        end

        def attribute_map
          {
            'hd' => 'SATA-0-0'
          }
        end

        def add_drive vm
          "storagectl #{vm} --name SATA --add SATA --controller IntelAhci"
        end
      end
    end
  end
end

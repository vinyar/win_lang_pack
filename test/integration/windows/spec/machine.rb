require "mixlib/shellout"

module VirtualBox
	class Machine 
		# This class will simulate one Virtual Box Machine
		# It will give us the latest Forwarded Ports list
		# where we can check if the port has changed 
		#
		# Supported Virtual Box version 4.2.x
		
        # The UUID of the virtual machine 
		attr_reader :uuid
		
		# The forwarded_ports of the virtual machine 
		attr_reader :forwarded_ports

		# Convenience method for executing a method.
		def self.host_port(guest_port, uuid=nil)
			new(uuid).host_port(guest_port)
		end

		def initialize(uuid=nil)
			@uuid = uuid
			
			# The VBoxID that Vagrant spun up  
			id = File.expand_path(File.join(File.dirname(__FILE__), %w{.. .. .. .. .vagrant machines lang_pack virtualbox id}))
				
			# If UUID was not given but the VBoxID exist. 
			@uuid = File.read(id) if File.exists?(id) && @uuid.nil?

			# Report that the VM is missing.
			vm_notfound unless exists?
		end

		def execute(*command)
			# Easy shellout method to execute something! :D
			command.insert(0, vboxmanage)
			c = Mixlib::ShellOut.new(*command.join(" "), :timeout => 10800)
			c.run_command
			c.error! 
			c
		end

		def get_vboxmanage_path
			# Set the path to VBoxManage
			vboxmanage_path = "VBoxManage"

			if RUBY_PLATFORM =~ /cygwin|mswin|mingw|bccwin|wince|emx/ 
				# On Windows, search for VBOX_INSTALL_PATH environmental
				# variable to find VBoxManage.
				if ENV.has_key?("VBOX_INSTALL_PATH")
					# Get the path.
					path = ENV["VBOX_INSTALL_PATH"]

					# There can actually be multiple paths in here, so we need to
					# split by the separator ";" and see which is a good one.
					path.split(";").each do |single|
						# Make sure it ends with a \
						single += "\\" if !single.end_with?("\\")

						# If the executable exists, then set it as the main path
						# and break out
						vboxmanage = "#{path}VBoxManage.exe"
						if File.file?(vboxmanage)
							vboxmanage_path = "\"#{vboxmanage}\""
							break
						end
					end
				end
			end
			@vboxmanage = vboxmanage_path
		end

		def read_forwarded_ports(uuid=nil)
		  uuid ||= @uuid

		  results = []
		  current_nic = nil

		  info = execute("showvminfo", uuid, "--machinereadable")
		  info.stdout.split("\n").each do |line|
		    # This is how we find the nic that a FP is attached to,
		    # since this comes first.
		    current_nic = $1.to_i if line =~ /^nic(\d+)=".+?"/

		    # Parse out the forwarded port information
		    if line =~ /^Forwarding.+?="(.+?),.+?,.*?,(.+?),.*?,(.+?)"/
		      result = [current_nic, $1.to_s, $2.to_i, $3.to_i]
		      results << result
		    end
		  end
		  @forwarded_ports = results
		end

		def host_port(guest_port)
			port=nil
			# Verify forwarded_ports
			read_forwarded_ports.each do |forwarded_port|
				# Checking that this is the WinRM port
				if forwarded_port.include?(guest_port)
					# For Virtual Box 4.2 the host port position is (2)
					port=forwarded_port[2]
					break
				end
			end
			# This is the actual port that the VM is using.
			port
		end

		def exists?(uuid=nil)
			uuid ||= @uuid
        	execute("showvminfo", uuid).exitstatus == 0
        end

        # Command to manage Virtual Box `vboxmanage`
		def vboxmanage
			get_vboxmanage_path if @vboxmanage.nil?
			@vboxmanage
		end

		def vm_notfound
			raise 'Missing Virtual Box Machine. Run `vagrant up` and retry.'
		end
	end
end
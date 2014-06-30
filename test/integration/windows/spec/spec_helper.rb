# 
# Integration Tests for Windows 
# Cookbook Name:: lang_pack
# File:: spec_helper.rb
#
require 'serverspec'
require 'winrm'
require 'logger'

# Useful VBox Machine Class
require_relative 'machine'

# Default port for WinRM Comunication
@port = 5985

# Getting WinRM forwarded_port 
host = VirtualBox::Machine.host_port(5985)

# Lets see if the host port has changed, if so take it!
if host != @port
	logger = Logger.new(STDOUT)
	logger.info("Overwrote WinRM Port:")
	logger.info(" => Old: #{@port}")
	logger.info(" => New: #{host}")
	@port = host 
end

@user 		= 'vagrant'
@pass 		= 'vagrant'
@endpoint 	= "http://localhost:#{@port}/wsman"

include Serverspec::Helper::WinRM
include Serverspec::Helper::Windows

RSpec.configure do |c|
  c.winrm = ::WinRM::WinRMWebService.new(@endpoint, :ssl, :user => @user, :pass => @pass, :basic_auth_only => true)
  c.winrm.set_timeout 300 
end

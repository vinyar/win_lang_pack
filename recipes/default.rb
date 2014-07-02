#
# Cookbook Name:: lang_pack
# Recipe:: default
#

reboot_switch = node['win_lang_pack']['post_install_reboot'] || 'yes'.downcase ? '/f' : '/r'

#converting space delimited string into array.
node['win_lang_pack']['language_list'].split(" ").each do | language |
  # installing each language if it's not installed.
  powershell_script "install #{language} language pack" do
    puts "running #{language}"
    code "lpksetup.exe /i #{language} #{reboot_switch} /s /p #{node['win_lang_pack']['lang_pack_location']}"
    guard_interpreter :powershell_script
    not_if "dism /online /Get-Intl |  Select-String \'ja-Jp\'"
  end
end


powershell_script "set default ui language to #{node['win_lang_pack']['default_ui_language']} via some magical command which seems to be missing from interweb" do
  code 'write-host "magical command goes here"'
end

  #debug shortcut        lpksetup.exe /i ja-Jp /r /s /p 'c:\binaries\Japan\langpacks'

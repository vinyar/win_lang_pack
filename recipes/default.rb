#
# Cookbook Name:: lang_pack
# Recipe:: default
#
# Copyright 2014, GE Capital
#
# All rights reserved - Do Not Redistribute
#

reboot_switch = node['win_lang_pack']['post_install_reboot'] || 'yes' ? '/f' : '/r'

cmd 'install language pack' do
  code "lpksetup.exe /i #{node['win_lang_pack']['language_list']} #{reboot_switch} /s /p #{node['win_lang_pack']['lang_pack_location']}"
end

# notes:
# help file: http://technet.microsoft.com/en-us/library/cc766010%28WS.10%29.aspx (or just lpksetup /?)
# geo id: http://msdn.microsoft.com/en-us/library/ms912389%28WinEmbedded.11%29.aspx

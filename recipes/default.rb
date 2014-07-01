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


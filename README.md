win_lang_pack Cookbook
==================
Cookbook to install Language Packs on windows


Requirements
------------
Built on Windows 2008.


Attributes
----------

# space-delimited list
default['win_lang_pack']['language_list'] = 'en-US'

# location of languages
default['win_lang_pack']['lang_pack_location'] = '//some/share/name'

# automatically reboot after install
default['win_lang_pack']['post_install_reboot'] = true


Documentation
-------------

http://technet.microsoft.com/en-us/library/cc766010%28WS.10%29.aspx (or just lpksetup /?)



Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Alex Vinyar

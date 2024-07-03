## Make sure you download the files below before packaging for .intune:
* Get the office Preparation Tool from https://www.microsoft.com/en-us/download/details.aspx?id=49117 and extract only the setup.exe file
* Create a config file. You can use https://config.office.com
* For the uninistal you can keep the same uninstall.xml


## Desription:
* version **2308 16731.20716**
* No Visio
* No Project
* No Aditional products ( such as languages)
* Semi annual update Channel
* No background MS Bing services

## install commands
* Install command: setup.exe /configure install.xml
* Uninstall command: setup.exe /configure uinstall.xml

## Detection rules
Manually detection using the registry because it seems to work better
* rule type: registry
* Key path: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\O365ProPlusRetail - fr-fr
* value: can remain empty
* detection method: Key exists

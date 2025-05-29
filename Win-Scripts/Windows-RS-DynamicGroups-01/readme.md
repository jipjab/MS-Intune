This remediation scripts detects a state and then add a value on an Windows Attribute. The same attribute can then be used to create an Entra Dynamic groupe.

It uses an enterprise registerd App with the following API **Application permissions** permissions:
- Device.ReadWrite.All
- User.Read

![alt text](<CleanShot 2025-05-29 at 14.18.05@2x.png>)

In the example below a **Dynymic group** is created based on the content of the *extensionAttribute 7*
``(device.extensionAttribute7 -eq "XXXX")``
![alt text](<CleanShot 2025-05-29 at 14.19.37@2x.png>)
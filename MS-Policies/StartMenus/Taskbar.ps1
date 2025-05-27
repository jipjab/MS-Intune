# Policy:
Device restriction

# Start menu layout:
<LayoutModificationTemplate xmlns:defaultlayout="http://schemas.microsoft.com/Start/2014/FullDefaultLayout" xmlns:start="http://schemas.microsoft.com/Start/2014/StartLayout" Version="1" xmlns="http://schemas.microsoft.com/Start/2014/LayoutModification" xmlns:taskbar="http://schemas.microsoft.com/Start/2014/TaskbarLayout">
<LayoutOptions StartTileGroupCellWidth="6" />
<DefaultLayoutOverride>
<StartLayoutCollection>
<defaultlayout:StartLayout GroupCellWidth="6">
<start:Group Name="Browser">
<start:DesktopApplicationTile Size="2x2" Column="0" Row="0" DesktopApplicationID="Chrome" />
</start:Group>
<start:Group Name="Microsoft 365">
<start:DesktopApplicationTile Size="2x2" Column="0" Row="0" DesktopApplicationID="Microsoft.Office.OUTLOOK.EXE.15" />
<start:DesktopApplicationTile Size="2x2" Column="0" Row="2" DesktopApplicationID="Microsoft.Office.WINWORD.EXE.15" />
<start:DesktopApplicationTile Size="2x2" Column="0" Row="4" DesktopApplicationID="Microsoft.Office.EXCEL.EXE.15" />
<start:DesktopApplicationTile Size="2x2" Column="2" Row="0" DesktopApplicationID="Microsoft.Office.POWERPNT.EXE.15" />
<start:DesktopApplicationTile Size="2x2" Column="2" Row="2" DesktopApplicationID="Microsoft.Office.ONENOTE.EXE.15" />
</start:Group>
</defaultlayout:StartLayout>
</StartLayoutCollection>
</DefaultLayoutOverride>
<CustomTaskbarLayoutCollection PinListPlacement="Replace">
<defaultlayout:TaskbarLayout>
<taskbar:TaskbarPinList>
<taskbar:DesktopApp DesktopApplicationID="Microsoft.Windows.Explorer"/>
<taskbar:DesktopApp DesktopApplicationID="MSEdge"/>
<taskbar:DesktopApp DesktopApplicationID="Microsoft.Office.OUTLOOK.EXE.15" />
<taskbar:DesktopApp DesktopApplicationID="Microsoft.Office.WINWORD.EXE.15" />
<taskbar:DesktopApp DesktopApplicationID="Microsoft.Office.EXCEL.EXE.15" />
<taskbar:DesktopApp DesktopApplicationID="Microsoft.Office.POWERPNT.EXE.15" />
<taskbar:UWA AppUserModelID="MSTeams_8wekyb3d8bbwe!MSTeams" />
</taskbar:TaskbarPinList>
</defaultlayout:TaskbarLayout>
</CustomTaskbarLayoutCollection>
</LayoutModificationTemplate>
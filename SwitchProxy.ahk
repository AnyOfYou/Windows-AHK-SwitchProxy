#NoTrayIcon
SetProxy()

SetProxy(address = "",state = ""){
if (address = "") and (state = "")
	state = TOGGLE
if address
	RegWrite,REG_SZ,HKCU,Software\Microsoft\Windows\CurrentVersion\Internet Settings,ProxyServer,%address%
if (state ="ON")
{
	flag = 1
	RegWrite,REG_DWORD,HKCU,Software\Microsoft\Windows\CurrentVersion\Internet Settings,Proxyenable,1
	ToolTip,Set proxy ON done
}
else if (state="OFF")
{
	flag = 1
	RegWrite,REG_DWORD,HKCU,Software\Microsoft\Windows\CurrentVersion\Internet Settings,Proxyenable,0
	ToolTip,Set proxy OFF done
}
else if (state = "TOGGLE")
{
	if RegRead("HKCU","Software\Microsoft\Windows\CurrentVersion\Internet Settings","Proxyenable") = 1
	{
		MsgBox,1,Proxy is ON,Switch setting to OFF
		IfMsgBox OK
		{
			flag = 1
			RegWrite,REG_DWORD,HKCU,Software\Microsoft\Windows\CurrentVersion\Internet Settings,Proxyenable,0
			ToolTip,Set proxy OFF done
		}
	}
	else if RegRead("HKCU","Software\Microsoft\Windows\CurrentVersion\Internet Settings","Proxyenable") = 0
	{
		MsgBox,1,Proxy is OFF,Switch setting to ON
		IfMsgBox OK
		{
			flag = 1
			RegWrite,REG_DWORD,HKCU,Software\Microsoft\Windows\CurrentVersion\Internet Settings,Proxyenable,1
			ToolTip,Set proxy ON done
		}
	}
}
if (flag == 1)
{
	dllcall("wininet\InternetSetOptionW","int","0","int","39","int","0","int","0")
	dllcall("wininet\InternetSetOptionW","int","0","int","37","int","0","int","0")
	Sleep,2000
	ToolTip
}
Return
}
RegRead(RootKey, SubKey, ValueName = "")
{
RegRead, v, %RootKey%, %SubKey%, %ValueName%
Return, v
}
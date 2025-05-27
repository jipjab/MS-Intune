@echo off

:: Map network drives
net use G: "\\10.0.20.240\travail" /USER:sierra-mees\Maintenance pass4MEES /PERSISTENT:YES
net use I: "\\10.0.20.240\WinEUR" /USER:sierra-mees\Maintenance pass4MEES /PERSISTENT:YES
net use T: "\\10.0.20.240\echanges" /USER:sierra-mees\Maintenance pass4MEES /PERSISTENT:YES

echo Network drives mapped.
pause
# Execute this makefile with the following command lines
#
# nmake /f SyncSlopeRiseRunAngle.mak 
#
# Raghu Veeramreddy April 27 '99  Creation

all:	unreg.bld delete.bld SyncSlopeRiseRunAngle.bld

unreg.bld:
	r:\rad2d\bin\unregdlls.exe s:\SmartPid\bin\SyncSlopeRiseRunAngle.dll

delete.bld:
	if exist "s:\SmartPid\bin\SyncSlopeRiseRunAngle.dll" del /f /q "s:\SmartPid\bin\SyncSlopeRiseRunAngle.dll"

SyncSlopeRiseRunAngle.bld:
!ifdef SMARTPLANTUPDATEBCDLLS
	s:\smartpid\bldtools\spBuildDRV.exe S:\SmartPid\Projects\AutomationClients\Validation\SyncSlopeRiseRunAngle\SyncSlopeRiseRunAngle.vbp
!else
	vb6.exe /m S:\SmartPid\Projects\AutomationClients\Validation\SyncSlopeRiseRunAngle\SyncSlopeRiseRunAngle.vbp
!endif

#include <Windows.h>
#include <WinBase.h>
#include <powrprof.h>

int grantPrivileges() {
  HANDLE hToken;
  TOKEN_PRIVILEGES tkp;
  if (!OpenProcessToken(GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES | TOKEN_QUERY, &hToken))
    return -1;

  LookupPrivilegeValue(NULL, SE_SHUTDOWN_NAME,&tkp.Privileges[0].Luid);

  tkp.PrivilegeCount = 1;
  tkp.Privileges[0].Attributes = SE_PRIVILEGE_ENABLED;

  AdjustTokenPrivileges(hToken, FALSE, &tkp, 0, (PTOKEN_PRIVILEGES)NULL, 0);

  if (GetLastError() != ERROR_SUCCESS)
    return -1;
  return 0;
}


int system_shutdown() {
  grantPrivileges();
  if (!ExitWindowsEx(EWX_SHUTDOWN | EWX_FORCE, 0))
    return -1;

  return 0;
}

int system_hibernate() {
/*     grantPrivileges(); */
/*     if (!SetSuspendState(TRUE, FALSE, FALSE)) */
/*         return -1; */
  return 0;
}

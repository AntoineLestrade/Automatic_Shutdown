with Interfaces.C;

package body Shutdown_Windows is

   ---------------------
   -- System_Shutdown --
   ---------------------

   procedure System_Shutdown is
      Res : Interfaces.C.int;
   begin
      Res := System_Shutdown;
   end System_Shutdown;

end Shutdown_Windows;

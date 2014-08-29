with Interfaces.C;

package Shutdown_Windows is
   function System_Shutdown return Interfaces.C.int;
   pragma Import (C, System_Shutdown, "system_shutdown");

--     procedure System_Shutdown is
--        Res : Interfaces.C.int;
--     begin
--        Res := System_Shutdown;
--     end System_Shutdown;

   procedure System_Shutdown;


   function System_Hibernate return Interfaces.C.int;
   pragma Import(C, System_Hibernate, "system_hibernate");
end Shutdown_Windows;

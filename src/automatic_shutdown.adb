with Ada.Calendar; use Ada.Calendar;

--with GNATCOLL.Traces;

with Glib.Object;         use Glib.Object;
with Glib.Properties;
with Glib;
with Glib.Main;

with Gtk.Box;         use Gtk.Box;
with Gtk.Button;      use Gtk.Button;
with Gtk.Label;       use Gtk.Label;
with Gtk.Main;
with Gtk.Settings;    use Gtk.Settings;
with Gtk.Style_COntext;
with Gtk.Style_Provider;
with Gtk.Widget;      use Gtk.Widget;
with Gtk.Window;      use Gtk.Window;
with Gtkada.Handlers; use Gtkada.Handlers;

with Shutdown_Windows;

with Unchecked_Deallocation;

with Widgets.Edit_Widget; use Widgets.Edit_Widget;
with Widgets.Countdown_Widget; use Widgets.Countdown_Widget;

procedure Automatic_Shutdown is
--     Logger : constant GNATCOLL.Traces.Trace_Handle := GNATCOLL.Traces.Create("Main_Procedure");

   Win      : Gtk_Window;
   Wdg_Edit : Edit_Widget_Acc_Class;
   Wdg_Countdown : Countdown_Widget_Acc;
   Target_Time : Ada.Calendar.Time;



   function On_Idle return Boolean is
      Remaining : Duration := Target_Time - Ada.Calendar.Clock;
   begin
      Wdg_Countdown.Set_Label(Time_To_Action => Remaining);
      if Remaining <= Duration(0)
      then
         Shutdown_Windows.System_Shutdown;
      end if;
      return Remaining >= Duration(0);
   end On_Idle;


   procedure On_Quit_Window (Window : access Gobject_Record'Class) is
   begin
      Gtk.Main.Main_Quit;
   end On_Quit_Window;

   procedure On_Quit_Edit_Widget (Window : access Gtk_Widget_Record'Class) is
   begin
      Gtk.Main.Main_Quit;
   end On_Quit_Edit_Widget;

   procedure On_Start (Self : access Gtk_Widget_Record'Class) is
      Idle_Event_Id : Glib.Main.G_Source_Id;
   begin
      Target_Time := Clock + Wdg_Edit.Get_Delay;
      Gtk_New(Wdg_Countdown);
      Win.Remove(Wdg_Edit);
      Win.Add(Wdg_Countdown);
      Win.Show_All;
      Idle_Event_Id := Glib.Main.Idle_Add(On_Idle'Unrestricted_Access);
      --Idle_Event_Id := Glib.Main.Timeout_Add(1, On_Idle'Unrestricted_Access);
      --Wdg_Edit.Destroy;
   end On_Start;

begin
--     GNATCOLL.Traces.Parse_Config_File("traces.cfg");
--     GNATCOLL.Traces.Trace(Logger, "Start application");

   Gtk.Main.Init;

   -- "Adwaita"
   -- "gtk-win32"
   -- "gtk-win32-xp"
   Glib.Properties.Set_Property
     (Gtk.Settings.Get_Default,
      Gtk.Settings.Gtk_Theme_Name_Property,
      "Adwaita");
   Glib.Properties.Set_Property
     (Gtk.Settings.Get_Default,
      Gtk.Settings.Gtk_Font_Name_Property,
      "Tahoma 8");

   --  Create a window with a size of 400x400
   Gtk_New (Win);
   --Win.Set_Default_Size (400, 400);

   --  Add a label
   Gtk_New (Wdg_Edit);
   Win.Add (Wdg_Edit);

   --  Show the window
   Win.Show_All;

   Wdg_Edit.On_Submit (On_Start'Unrestricted_Access);

   Win.On_Destroy (On_Quit_Window'Unrestricted_Access, Slot => Win);
   Wdg_Edit.On_Exit (On_Quit_Edit_Widget'Unrestricted_Access);

   --  Start the Gtk+ main loop
   Gtk.Main.Main;
end Automatic_Shutdown;

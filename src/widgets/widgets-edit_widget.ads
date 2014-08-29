with Gtk.Box;     use Gtk.Box;
with Gtk.Combo_Box_Text;
with Gtk.Widget;  use Gtk.Widget;
with Glib;
with Glib.Object; use Glib.Object;

package Widgets.Edit_Widget is
   type Edit_Widget_Record is new Gtk_Widget_Record with private;
   type Edit_Widget_Acc_Class is access all Edit_Widget_Record'Class;

   type Cb_Edit_Widget_Target is not null access procedure
     (Self : access Gtk_Widget_Record'Class);

   procedure Gtk_New (Self : out Edit_Widget_Acc_Class);
   procedure Initialize (Self : access Edit_Widget_Record'Class);

   function Get_Type return Glib.Gtype;

   procedure On_Submit
     (Self  : not null access Edit_Widget_Record;
      Call  : Cb_Edit_Widget_Target;
      After : Boolean := False);

   procedure On_Exit
     (Self  : not null access Edit_Widget_Record;
      Call  : Cb_Edit_Widget_Target;
      After : Boolean := False);

   function Get_Delay (Self : not null access Edit_Widget_Record'Class) return Duration;

private
   Signal_Submit : constant Glib.Signal_Name := "launch_countdown";
   Signal_Exit   : constant Glib.Signal_Name := "exit";

   type Edit_Widget_Record is new Gtk_Vbox_Record with record
      Cb_Hours   : Gtk.Combo_Box_Text.Gtk_Combo_Box_Text;
      Cb_Minutes : Gtk.Combo_Box_Text.Gtk_Combo_Box_Text;
   end record;

   procedure On_Bt_Launch_Click (Self : access Gobject_Record'Class);
   procedure On_Bt_Exit_Click (Self : access Gobject_Record'Class);

end Widgets.Edit_Widget;

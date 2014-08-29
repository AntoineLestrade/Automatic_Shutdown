with Ada.Calendar;

with Glib;
with Glib.Object; use GLib.Object;

with Gtk.Box;    use Gtk.Box;
with Gtk.Label;  use Gtk.Label;
with Gtk.Widget; use Gtk.Widget;

package Widgets.Countdown_Widget is
   type Countdown_Widget_Record is new Gtk_Widget_Record with private;
   type Countdown_Widget_Acc is access all Countdown_Widget_Record'Class;

   procedure Gtk_New (Self : out Countdown_Widget_Acc);
   procedure Initialize (Self : access Countdown_Widget_Record'Class);

   function Get_Type return Glib.Gtype;

   procedure Set_Label(Self : access Countdown_Widget_Record'Class; Time_To_Action : Duration);

private
   Klass : aliased Ada_GObject_Class := Uninitialized_Class;
   Signal_Exit : constant Glib.Signal_Name := "exit";

   type Countdown_Widget_Record is new Gtk_Vbox_Record with record
      Lbl_Countdown : Gtk_Label;
   end record;

end Widgets.Countdown_Widget;

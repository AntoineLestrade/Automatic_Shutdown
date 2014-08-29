with Interfaces.C.Strings;
with System;
with Gtkada.Types; use Gtkada.Types;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package body Widgets.Countdown_Widget is

   -------------
   -- Gtk_New --
   -------------

   procedure Gtk_New (Self : out Countdown_Widget_Acc) is
   begin
      Self := new Countdown_Widget_Record;
      Widgets.Countdown_Widget.Initialize(Self);
   end Gtk_New;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize (Self : access Countdown_Widget_Record'Class) is
   begin
      G_New(Self, Get_Type);
      Gtk.Box.Initialize_Vbox(Self);

      Gtk.Label.Gtk_New(Self.Lbl_Countdown, "");
      Self.Pack_Start(Self.Lbl_Countdown);
   end Initialize;

   --------------
   -- Get_Type --
   --------------

   function Get_Type return Glib.Gtype is
      Signals : chars_ptr_array := String(Signal_Exit) + "dummy_signal";
   begin
      if Initialize_Class_Record(Ancestor     => Gtk.Box.Get_Vbox_Type,
                                 Class_Record => Klass'Access,
                                 Type_Name    => "Countdown_Widget",
                                 Signals      => Signals)
      then
         null;
      end if;
      return Klass.The_Type;
   end Get_Type;

   procedure Set_Label(Self : access Countdown_Widget_Record'Class; Time_To_Action : Duration) is
      Text : Ada.Strings.Unbounded.Unbounded_String;
      Dur  : Integer := Integer(Time_To_Action);
      Duration_Part : Integer;
   begin
      Text := To_Unbounded_String("The computer will shut down in ");
      if Dur >= 3600 then
         Duration_Part := Dur / 3600;
         Append(Text, Integer'Image(Duration_Part));
         Append(Text, " hour");
         if Dur > 1 then Append(Text, "s"); end if;
      end if;
      -- minutes
      Duration_Part := (Dur mod 3600) / 60;
      Append(Text, " ");
      Append (Text, Integer'Image(Duration_Part));
      Append(Text, " minute");
      if Duration_Part > 1 then Append(Text, "s"); end if;

      --seconds
      Duration_Part := Dur mod 60;
      Append(Text, " ");
      Append(Text, Integer'Image(Duration_Part));
      Append(Text, " second");
      if Duration_Part > 1 then Append(Text, "s"); end if;
      Append(Text, ".");
      Self.Lbl_Countdown.Set_Text(To_String(Text));
   end Set_Label;


end Widgets.Countdown_Widget;

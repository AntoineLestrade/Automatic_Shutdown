with Ada.Unchecked_Conversion;

with Glib;        use Glib;
with Glib.Object; use Glib.Object;
with Glib.Values;

with Gtk.Arguments; use Gtk.Arguments;
with Gtk.Box;       use Gtk.Box;
with Gtk.Button;
with Gtk.Button_Box;
with Gtk.Cell_Renderer_Text;
with Gtk.Combo_Box_Text;
with Gtk.Enums;
with Gtk.Handlers;
with Gtk.Label;     use Gtk.Label;
with Gtk.Stock;
with Gtk.List_Store;use Gtk.List_Store;
with Gtk.Tree_Model;

with Gtkada.Bindings; use Gtkada.Bindings;
with Gtkada.Types;    use Gtkada.Types;

with System;

with Widgets.Edit_Widget; use Widgets.Edit_Widget;

package body Widgets.Edit_Widget is

   Klass   : aliased Ada_Gobject_Class := Uninitialized_Class;
   Signals : Chars_Ptr_Array := String (Signal_Submit) + String (Signal_Exit);

   procedure Class_Init (Self : Gobject_Class);
   pragma Convention (C, Class_Init);

   procedure Class_Init (Self : Gobject_Class) is
   begin
      -- Set properties handler

      null;
   end Class_Init;

   function Get_Type return Gtype is
   begin
      if Initialize_Class_Record
          (Ancestor     => Gtk.Box.Get_Vbox_Type,
           Class_Record => Klass'Access,
           Type_Name    => "Edit_Widget",
           Signals      => Signals)
      then
         --Info := new GInterface_Info'(nul, null, System.Address);
         --Add_Interface(Klass, Gtk.Box.Get_Vbox_Type, Info);
         null;
      end if;
      return Klass.The_Type;
   end Get_Type;

   -------------
   -- Gtk_New --
   -------------

   procedure Gtk_New (Self : out Edit_Widget_Acc_Class) is
   begin
      Self := new Edit_Widget_Record;
      Widgets.Edit_Widget.Initialize (Self);
   end Gtk_New;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize (Self : access Edit_Widget_Record'Class) is
      Bx_Labels : Gtk.Box.Gtk_Hbox;
      Bx_Buttons : Gtk.Button_Box.Gtk_Button_Box;
      Btn : Gtk.Button.Gtk_Button;
      Dummy_Bool : Boolean;
      --List : Gtk_List_Store;
      --List_Item : Gtk.Tree_Model.Gtk_Tree_Iter;
      --Render : Gtk.Cell_Renderer_Text.Gtk_Cell_Renderer_Text;
   begin
      G_New(Object => Self,
            Typ    => Get_Type);
      Gtk.Box.Initialize_Vbox (Box => Self);

      --Gtk.Cell_Renderer_Text.Gtk_New(Render);
      Gtk.Box.Gtk_New_Hbox(Box => Bx_Labels);

      Bx_Labels.Pack_Start(Gtk.Label.Gtk_Label_New("Turn computer off in"), Expand => False);

      -- Hours cb
--        Gtk.List_Store.Gtk_New(List, (0 => GType_String, 1 => GType_Int));
--        List.Append(List_Item);
--        List.Set(List_Item, 0, "0"); List.Set(List_Item, 1, 0);
--        List.Append(List_Item);
--        List.Set(List_Item, 0, "1"); List.Set(List_Item, 1, 1);
--        List.Append(List_Item);
--        List.Set(List_Item, 0, "2"); List.Set(List_Item, 1, 2);
--        List.Append(List_Item);
--        List.Set(List_Item, 0, "3"); List.Set(List_Item, 1, 3);
--        List.Append(List_Item);
--        List.Set(List_Item, 0, "4"); List.Set(List_Item, 1, 4);
--        List.Append(List_Item);
--        List.Set(List_Item, 0, "5"); List.Set(List_Item, 1, 5);
--
--        Gtk.Combo_Box.Gtk_New_With_Model(Cb, +List);
--           Cb.Pack_Start(Render, Expand=>True);
--           Cb.Add_Attribute(Render, "text", 0);
--           Cb.Add_Attribute(Render, "sensitive", 1);
--           Cb.Set_Id_Column(Id_Column => 1);
      Gtk.Combo_Box_Text.Gtk_New(Self.Cb_Hours);
      Self.Cb_Hours.Append_Text("0");
      Self.Cb_Hours.Append_Text("1");
      Self.Cb_Hours.Append_Text("2");
      Self.Cb_Hours.Append_Text("3");
      Self.Cb_Hours.Append_Text("5");
      Dummy_Bool := Self.Cb_Hours.Set_Active_Id("2");
      Bx_Labels.Pack_Start(Self.Cb_Hours);
      Bx_Labels.Pack_Start(Gtk_Label_New("hours"));


--        Gtk.List_Store.Gtk_New(List, (0 => GType_String, 1 => GType_Int));
--        List.Append(List_Item);
--        List.Set(List_Item, 0, "0"); List.Set(List_Item, 1, 0);
--        List.Append(List_Item);
--        List.Set(List_Item, 0, "10"); List.Set(List_Item, 1, 10);
--        List.Append(List_Item);
--        List.Set(List_Item, 0, "20"); List.Set(List_Item, 1, 20);
--        List.Append(List_Item);
--        List.Set(List_Item, 0, "30"); List.Set(List_Item, 1, 30);
--        List.Append(List_Item);
--        List.Set(List_Item, 0, "40"); List.Set(List_Item, 1, 40);
--        List.Append(List_Item);
--        List.Set(List_Item, 0, "50"); List.Set(List_Item, 1, 50);
--
--        Gtk.Combo_Box.Gtk_New_With_Model(Cb, +List);
--           Cb.Pack_Start(Render, Expand=>True);
--           Cb.Add_Attribute(Render, "text", 0);
--           Cb.Add_Attribute(Render, "sensitive", 1);
--           Cb.Set_Id_Column(Id_Column => 1);
      Gtk.Combo_Box_Text.Gtk_New(Self.Cb_Minutes);
      Self.Cb_Minutes.Append_Text("0");
      Self.Cb_Minutes.Append_Text("10");
      Self.Cb_Minutes.Append_Text("20");
      Self.Cb_Minutes.Append_Text("30");
      Self.Cb_Minutes.Append_Text("40");
      Self.Cb_Minutes.Append_Text("50");
      Dummy_Bool := Self.Cb_Minutes.Set_Active_Id("0");
      Bx_Labels.Pack_Start(Self.Cb_Minutes);
      Bx_Labels.Pack_Start(Gtk_Label_New("minutes."));

      Gtk.Button_Box.Gtk_New(Widget      => Bx_Buttons,
                             Orientation => Gtk.Enums.Orientation_Horizontal);
      Bx_Buttons.Set_Layout(Layout_Style => Gtk.Enums.Buttonbox_Spread);

      Gtk.Button.Gtk_New(Btn, "Launch");
      Bx_Buttons.Add(Btn);
      Btn.On_Clicked(On_Bt_Launch_Click'Unrestricted_Access, Self);
      Gtk.Button.Gtk_New_From_Stock(Btn, Gtk.Stock.Stock_Close);
      Bx_Buttons.Add(Btn);
      Btn.On_CLicked(On_Bt_Exit_Click'Unrestricted_Access, Self);
      Self.Pack_Start (Bx_Labels);
      Self.Pack_Start (Bx_Buttons);

--        Self.Bt_Test.On_Clicked
--        (On_Bt_Test_Click'Unrestricted_Access, Slot => Self);

   end Initialize;

   function Get_Delay(Self : not null access Edit_Widget_Record'Class) return Duration is
   begin
      return Duration(Integer'Value(Self.Cb_Hours.Get_Active_Text) * 3600 + Integer'Value(Self.Cb_Minutes.Get_Active_Text) * 60);
   end Get_Delay;


-----------------------------------------------------------------------------
   --- Callbacks
-----------------------------------------------------------------------------
   function Address_To_Cb is new Ada.Unchecked_Conversion
     (System.Address,
      Cb_Edit_Widget_Target);

   function Cb_To_Address is new Ada.Unchecked_Conversion
     (Cb_Edit_Widget_Target,
      System.Address);

   package Internal_Cb is new Gtk.Handlers.Callback (Edit_Widget_Record);

   procedure Marsh_Cb_Edit_Widget_Target
     (Closure         : Gclosure;
      Return_Value    : Glib.Values.Gvalue;
      N_Params        : Glib.Guint;
      Params          : Glib.Values.C_Gvalues;
      Invocation_Hint : System.Address;
      User_Data       : System.Address);
   pragma Convention (C, Marsh_Cb_Edit_Widget_Target);

   procedure Marsh_Cb_Edit_Widget_Target
     (Closure         : Gclosure;
      Return_Value    : Glib.Values.Gvalue;
      N_Params        : Glib.Guint;
      Params          : Glib.Values.C_Gvalues;
      Invocation_Hint : System.Address;
      User_Data       : System.Address)
   is
      pragma Unreferenced (Return_Value, N_Params, Invocation_Hint, User_Data);
      H : constant Cb_Edit_Widget_Target :=
        Address_To_Cb (Get_Callback (Closure));
      Obj : constant Edit_Widget_Acc_Class :=
        Edit_Widget_Acc_Class (Unchecked_To_Object (Params, 0));
   begin
      H (Obj);
   exception
      when E : others =>
         Process_Exception (E);
   end Marsh_Cb_Edit_Widget_Target;

   PROCEDURE Connect
     (Object  : ACCESS Edit_Widget_Record'Class;
      C_Name  : Glib.Signal_Name;
      Handler : Cb_Edit_Widget_Target;
      After   : Boolean) IS
   BEGIN
      Unchecked_Do_Signal_Connect
        (Object     => Object,
         C_Name     => C_Name & ASCII.NUL,
         Marshaller => Marsh_Cb_Edit_Widget_Target'Access,
         Handler    => Cb_To_Address (Handler),
         After      => After);
   END Connect;

   procedure On_Submit
     (Self  : not null access Edit_Widget_Record;
      Call  : Cb_Edit_Widget_Target;
      After : Boolean := False)
   is
   begin
      Connect(Self, Signal_Submit, Call, After);
   end On_Submit;

   procedure On_Exit(Self  : not null access Edit_Widget_Record;
                     Call  : Cb_Edit_Widget_Target;
                     After : Boolean := False) is
   begin
      Connect(Self, Signal_Exit, Call, After);
   end On_Exit;



   procedure On_Bt_Launch_Click (Self : access Gobject_Record'Class) is
   begin
      Internal_Cb.Emit_By_Name (Edit_Widget_Acc_Class (Self), Signal_Submit);
   end On_Bt_Launch_Click;

   procedure On_Bt_Exit_Click(Self: access GObject_Record'Class) is
   begin
      Internal_Cb.Emit_By_Name(Edit_Widget_Acc_Class(Self), Signal_Exit);
   end On_Bt_Exit_Click;


end Widgets.Edit_Widget;




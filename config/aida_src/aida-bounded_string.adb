package body Aida.Bounded_String is

   use all type Aida.Types.String_T;

   procedure Initialize (This : in out T;
                         Text : Standard.String) is
   begin
      for I in Integer range 1..Text'Length loop
         This.Text (I) := Text (Text'First - 1 + I);
         pragma Loop_Invariant (for all J in Integer range 1..I => This.Text (J) = Text (Text'First - 1 + J));
         pragma Loop_Variant (Increases => I);
      end loop;

      This.Text_Length := Text'Length;
   end Initialize;

   procedure Append (Target : in out T;
                     Source : Standard.String) is
   begin
      for I in Integer range Source'First..Source'Last loop
         Target.Text (Target.Text_Length + 1 + (I - Source'First)) := Source (I);
      end loop;
      Target.Text_Length := Target.Text_Length + Source'Length;
   end Append;

   function Hash32 (This : T) return Aida.Types.Hash32_T is
   begin
      return Hash32 (Aida.Types.String_T (This.Text (1..Length (This))));
   end Hash32;

   procedure Act_On_Immutable_Text (This : in T) is
   begin
      Do_Something (This.Text (Index_T'First..This.Text_Length));
   end Act_On_Immutable_Text;

   function Equals (This   : T;
                    Object : Standard.String) return Boolean
   is
      Result : Boolean := True;
   begin
      if Length (This) = Object'Length then
         if Object'Length > 0 then
            Result := This.Text (Index_T'First..This.Text_Length) = Object (Object'Range);
         end if;
      end if;

      return Result;
   end Equals;

end Aida.Bounded_String;

-- generated by pyha 0.0.11
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.fixed_float_types.all;
    use ieee.fixed_pkg.all;
    use ieee.math_real.all;

library work;
    use work.complex_pkg.all;
    use work.PyhaUtil.all;
    use work.Typedefs.all;
    use work.all;
    use work.DataValid_0.all;
    use work.DataValid_1.all;


package DataValid_2 is
    type self_t is record
        data: sfixed(-7 downto -42);
        valid: boolean;
    end record;
    type DataValid_2_self_t_list_t is array (natural range <>) of DataValid_2.self_t;

    type self_t_const is record
        DUMMY: integer;
    end record;
    type DataValid_2_self_t_const_list_t_const is array (natural range <>) of DataValid_2.self_t_const;


    function DataValid(data: sfixed(-7 downto -42); valid: boolean) return self_t;
end package;

package body DataValid_2 is


    function DataValid(data: sfixed(-7 downto -42); valid: boolean) return self_t is
        -- constructor
        variable self: self_t;
    begin
        self.data := data;
        self.valid := valid;
        return self;
    end function;
end package body;
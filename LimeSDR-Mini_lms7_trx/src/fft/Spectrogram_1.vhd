-- generated by pyha 0.0.7
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
    use work.DataWithIndex_3.all;
    use work.DataWithIndex_0.all;
    use work.Packager_0.all;
    use work.Windower_1.all;
    use work.ShiftRegister_0.all;
    use work.StageR2SDF_0.all;
    use work.ShiftRegister_1.all;
    use work.StageR2SDF_1.all;
    use work.ShiftRegister_2.all;
    use work.StageR2SDF_2.all;
    use work.ShiftRegister_3.all;
    use work.StageR2SDF_3.all;
    use work.ShiftRegister_4.all;
    use work.StageR2SDF_4.all;
    use work.ShiftRegister_5.all;
    use work.StageR2SDF_5.all;
    use work.ShiftRegister_6.all;
    use work.StageR2SDF_6.all;
    use work.ShiftRegister_7.all;
    use work.StageR2SDF_7.all;
    use work.ShiftRegister_8.all;
    use work.StageR2SDF_8.all;
    use work.R2SDF_1.all;
    use work.ConjMult_0.all;
    use work.RAM_0.all;
    use work.BitreversalFFTshiftDecimate_0.all;

-- The gain of main/model_main wont match
package Spectrogram_1 is
    type self_t is record
        pack: Packager_0.self_t;
        windower: Windower_1.self_t;
        fft: R2SDF_1.self_t;
        \abs\: ConjMult_0.self_t;
        dec: BitreversalFFTshiftDecimate_0.self_t;
    end record;
    type Spectrogram_1_self_t_list_t is array (natural range <>) of Spectrogram_1.self_t;

    type self_t_const is record
        DECIMATE_BY: integer;
        NFFT: integer;
        pack: Packager_0.self_t_const;
        windower: Windower_1.self_t_const;
        fft: R2SDF_1.self_t_const;
        \abs\: ConjMult_0.self_t_const;
        dec: BitreversalFFTshiftDecimate_0.self_t_const;
        DELAY: integer;
    end record;
    type Spectrogram_1_self_t_const_list_t_const is array (natural range <>) of Spectrogram_1.self_t_const;

    procedure main(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; x: complex_t(1 downto -34); ret_0:out DataWithIndex_3.self_t);
    function Spectrogram(pack: Packager_0.self_t; windower: Windower_1.self_t; fft: R2SDF_1.self_t; \abs\: ConjMult_0.self_t; dec: BitreversalFFTshiftDecimate_0.self_t) return self_t;
end package;

package body Spectrogram_1 is
    procedure main(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; x: complex_t(1 downto -34); ret_0:out DataWithIndex_3.self_t) is

        variable dec_out: DataWithIndex_3.self_t;
        variable mag_out: DataWithIndex_3.self_t;
        variable fft_out: DataWithIndex_0.self_t;
        variable window_out: DataWithIndex_0.self_t;
        variable pack_out: DataWithIndex_0.self_t;
        variable pyha_ret_0: DataWithIndex_0.self_t;
        variable pyha_ret_1: DataWithIndex_0.self_t;
        variable pyha_ret_2: DataWithIndex_0.self_t;
        variable pyha_ret_3: DataWithIndex_3.self_t;
        variable pyha_ret_4: DataWithIndex_3.self_t;
    begin
        Packager_0.main(self.pack, self_next.pack, self_const.pack, x, pyha_ret_0);
        pack_out := pyha_ret_0;
        Windower_1.main(self.windower, self_next.windower, self_const.windower, pack_out, pyha_ret_1);
        window_out := pyha_ret_1;
        R2SDF_1.main(self.fft, self_next.fft, self_const.fft, window_out, pyha_ret_2);
        fft_out := pyha_ret_2;
        ConjMult_0.main(self.\abs\, self_next.\abs\, self_const.\abs\, fft_out, pyha_ret_3);
        mag_out := pyha_ret_3;
        BitreversalFFTshiftDecimate_0.main(self.dec, self_next.dec, self_const.dec, mag_out, pyha_ret_4);
        dec_out := pyha_ret_4;
        ret_0 := dec_out;
        return;
    end procedure;

    function Spectrogram(pack: Packager_0.self_t; windower: Windower_1.self_t; fft: R2SDF_1.self_t; \abs\: ConjMult_0.self_t; dec: BitreversalFFTshiftDecimate_0.self_t) return self_t is
        -- limited constructor
        variable self: self_t;
    begin
        self.pack := pack;
        self.windower := windower;
        self.fft := fft;
        self.\abs\ := \abs\;
        self.dec := dec;
        return self;
    end function;
end package body;

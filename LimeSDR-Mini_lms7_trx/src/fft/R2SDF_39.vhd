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
    use work.DataValid_2.all;
    use work.DataValid_3.all;
    use work.DataValid_4.all;
    use work.ShiftRegister_5.all;
    use work.DownCounter_6.all;
    use work.MovingAverage_7.all;
    use work.ShiftRegister_8.all;
    use work.MovingAverage_9.all;
    use work.ShiftRegister_10.all;
    use work.DCRemoval_11.all;
    use work.Windower_12.all;
    use work.ShiftRegister_13.all;
    use work.DownCounter_14.all;
    use work.StageR2SDF_15.all;
    use work.ShiftRegister_16.all;
    use work.DownCounter_17.all;
    use work.StageR2SDF_18.all;
    use work.ShiftRegister_19.all;
    use work.DownCounter_20.all;
    use work.StageR2SDF_21.all;
    use work.ShiftRegister_22.all;
    use work.DownCounter_23.all;
    use work.StageR2SDF_24.all;
    use work.ShiftRegister_25.all;
    use work.DownCounter_26.all;
    use work.StageR2SDF_27.all;
    use work.ShiftRegister_28.all;
    use work.DownCounter_29.all;
    use work.StageR2SDF_30.all;
    use work.ShiftRegister_31.all;
    use work.DownCounter_32.all;
    use work.StageR2SDF_33.all;
    use work.ShiftRegister_34.all;
    use work.DownCounter_35.all;
    use work.StageR2SDF_36.all;
    use work.ShiftRegister_37.all;
    use work.StageR2SDF_38.all;

-- FFT core
-- --------
-- Uses the R2SDR structure with 18bit data-width and rounded logic - no DC-bias introduced.
-- Scaling is opposite to Numpy i.e. "fft *= FFT_SIZE" and "ifft /= FFT_SIZE", this way values always stay
-- in -1 ... 1 range.
-- Args:
-- fft_size: Transform size, must be power of 2.
-- twiddle_bits: Stored as constants in LUTS. For big transforms you should try ~9 bits.
-- inverse (bool): True to perform inverse transform.
-- input_ordering (str): 'natural' or 'bitreversed'.
-- Output order is inverse of this - Natural(in) -> Bitreversed(out) or Bitreversed(in) -> Natural(out).
package R2SDF_39 is
    type self_t is record
        stages: StageR2SDF_18.StageR2SDF_18_self_t_list_t(0 to 8);
        stages_0: StageR2SDF_18.self_t;
        stages_1: StageR2SDF_21.self_t;
        stages_2: StageR2SDF_24.self_t;
        stages_3: StageR2SDF_27.self_t;
        stages_4: StageR2SDF_30.self_t;
        stages_5: StageR2SDF_33.self_t;
        stages_6: StageR2SDF_36.self_t;
        stages_7: StageR2SDF_38.self_t;
        stages_8: StageR2SDF_15.self_t;
        output: DataValid_3.self_t;
    end record;
    type R2SDF_39_self_t_list_t is array (natural range <>) of R2SDF_39.self_t;

    type self_t_const is record
        INVERSE: boolean;
        FFT_SIZE: integer;
        N_STAGES: integer;
        POST_GAIN_CONTROL: integer;
        stages: StageR2SDF_18.StageR2SDF_18_self_t_const_list_t_const(0 to 8);
        stages_0: StageR2SDF_18.self_t_const;
        stages_1: StageR2SDF_21.self_t_const;
        stages_2: StageR2SDF_24.self_t_const;
        stages_3: StageR2SDF_27.self_t_const;
        stages_4: StageR2SDF_30.self_t_const;
        stages_5: StageR2SDF_33.self_t_const;
        stages_6: StageR2SDF_36.self_t_const;
        stages_7: StageR2SDF_38.self_t_const;
        stages_8: StageR2SDF_15.self_t_const;
        output: DataValid_3.self_t_const;
    end record;
    type R2SDF_39_self_t_const_list_t_const is array (natural range <>) of R2SDF_39.self_t_const;

    procedure main(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; input: DataValid_3.self_t; ret_0:out DataValid_3.self_t);
    function R2SDF(stages_0: StageR2SDF_18.self_t;stages_1: StageR2SDF_21.self_t;stages_2: StageR2SDF_24.self_t;stages_3: StageR2SDF_27.self_t;stages_4: StageR2SDF_30.self_t;stages_5: StageR2SDF_33.self_t;stages_6: StageR2SDF_36.self_t;stages_7: StageR2SDF_38.self_t;stages_8: StageR2SDF_15.self_t; output: DataValid_3.self_t) return self_t;
end package;

package body R2SDF_39 is
    procedure main(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; input: DataValid_3.self_t; ret_0:out DataValid_3.self_t) is
    -- Args:
    -- input (DataValid): -1.0 ... 1.0 range, up to 18 bits
    -- Returns:
    -- DataValid: 18 bits(-1.0 ... 1.0 range) if transform size is up to 1024 points.
    -- Transforms over 1024 points start emphasizing smaller numbers e.g. 2048 would return a result with 18 bits
    -- but in -0.5 ... 0.5 range (one extra bit for smaller numbers) etc...
        variable var: DataValid_3.self_t;
        variable stage: StageR2SDF_15.self_t;
        variable pyha_ret_0: DataValid_3.self_t;
        variable pyha_ret_1: DataValid_3.self_t;
        variable pyha_ret_2: DataValid_3.self_t;
        variable pyha_ret_3: DataValid_3.self_t;
        variable pyha_ret_4: DataValid_3.self_t;
        variable pyha_ret_5: DataValid_3.self_t;
        variable pyha_ret_6: DataValid_3.self_t;
        variable pyha_ret_7: DataValid_3.self_t;
        variable pyha_ret_8: DataValid_3.self_t;
    begin
        var := input;
        if self_const.INVERSE then
            if True then
                var.data := resize(Complex(get_imag(input.data), get_real(input.data)), 0, -17, fixed_wrap, fixed_round);
                var.valid := input.valid;
            end if;

            -- execute stages
        end if;
        for \_i_\ in self.stages'range loop
            if True then
                if \_i_\ = 0 then
                    StageR2SDF_18.main(self.stages_0, self_next.stages_0, self_const.stages_0, var, pyha_ret_0);
                    var := pyha_ret_0;
                elsif \_i_\ = 1 then
                    StageR2SDF_21.main(self.stages_1, self_next.stages_1, self_const.stages_1, var, pyha_ret_1);
                    var := pyha_ret_1;
                elsif \_i_\ = 2 then
                    StageR2SDF_24.main(self.stages_2, self_next.stages_2, self_const.stages_2, var, pyha_ret_2);
                    var := pyha_ret_2;
                elsif \_i_\ = 3 then
                    StageR2SDF_27.main(self.stages_3, self_next.stages_3, self_const.stages_3, var, pyha_ret_3);
                    var := pyha_ret_3;
                elsif \_i_\ = 4 then
                    StageR2SDF_30.main(self.stages_4, self_next.stages_4, self_const.stages_4, var, pyha_ret_4);
                    var := pyha_ret_4;
                elsif \_i_\ = 5 then
                    StageR2SDF_33.main(self.stages_5, self_next.stages_5, self_const.stages_5, var, pyha_ret_5);
                    var := pyha_ret_5;
                elsif \_i_\ = 6 then
                    StageR2SDF_36.main(self.stages_6, self_next.stages_6, self_const.stages_6, var, pyha_ret_6);
                    var := pyha_ret_6;
                elsif \_i_\ = 7 then
                    StageR2SDF_38.main(self.stages_7, self_next.stages_7, self_const.stages_7, var, pyha_ret_7);
                    var := pyha_ret_7;
                elsif \_i_\ = 8 then
                    StageR2SDF_15.main(self.stages_8, self_next.stages_8, self_const.stages_8, var, pyha_ret_8);
                    var := pyha_ret_8;
                end if;
            end if;

        end loop;
        if self_const.INVERSE then
            if True then
                var.data := resize(Complex(get_imag(var.data), get_real(var.data)), 0, -17, fixed_wrap, fixed_round);
                var.valid := var.valid;
            end if;

            -- this part is active if transform is larger than 10 stages
        end if;
        if self_const.POST_GAIN_CONTROL /= 0 then
            self_next.output.data := resize(scalb(var.data, -self_const.POST_GAIN_CONTROL), 0, -17, fixed_wrap, fixed_truncate);
        else
            self_next.output.data := resize(var.data, 0, -17, fixed_wrap, fixed_truncate);

        end if;
        self_next.output.valid := var.valid;
        ret_0 := self.output;
        return;
    end procedure;

    function R2SDF(stages_0: StageR2SDF_18.self_t;stages_1: StageR2SDF_21.self_t;stages_2: StageR2SDF_24.self_t;stages_3: StageR2SDF_27.self_t;stages_4: StageR2SDF_30.self_t;stages_5: StageR2SDF_33.self_t;stages_6: StageR2SDF_36.self_t;stages_7: StageR2SDF_38.self_t;stages_8: StageR2SDF_15.self_t; output: DataValid_3.self_t) return self_t is
        -- constructor
        variable self: self_t;
    begin
        self.stages_0 := stages_0;
        self.stages_1 := stages_1;
        self.stages_2 := stages_2;
        self.stages_3 := stages_3;
        self.stages_4 := stages_4;
        self.stages_5 := stages_5;
        self.stages_6 := stages_6;
        self.stages_7 := stages_7;
        self.stages_8 := stages_8;
        self.output := output;
        return self;
    end function;
end package body;
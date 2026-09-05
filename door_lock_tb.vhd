
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity door_lock_tb is
end door_lock_tb;

architecture Behavioral of door_lock_tb is

    signal clk         : STD_LOGIC := '0';
    signal reset       : STD_LOGIC := '0';
    signal enter       : STD_LOGIC := '0';
    signal password_in : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal unlock      : STD_LOGIC;
    signal lock_out    : STD_LOGIC;
    signal alarm       : STD_LOGIC;

begin

    uut: entity work.door_lock
        port map (
            clk => clk,
            reset => reset,
            enter => enter,
            password_in => password_in,
            unlock => unlock,
            lock_out => lock_out,
            alarm => alarm
        );

    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

    stim_process: process
    begin

        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        password_in <= "1010";
        enter <= '1';
        wait for 10 ns;
        enter <= '0';
        wait for 30 ns;

        password_in <= "1001";
        enter <= '1';
        wait for 10 ns;
        enter <= '0';
        wait for 30 ns;

        password_in <= "0011";
        enter <= '1';
        wait for 10 ns;
        enter <= '0';
        wait for 30 ns;

        password_in <= "1111";
enter <= '1';
wait for 10 ns;
enter <= '0';
wait for 100 ns;

wait;

        wait;
    end process;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity door_lock is
    Port (
        clk         : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        enter       : in  STD_LOGIC;
        password_in : in  STD_LOGIC_VECTOR(3 downto 0);
        unlock      : out STD_LOGIC;
        lock_out    : out STD_LOGIC;
        alarm       : out STD_LOGIC
    );
end door_lock;

architecture Behavioral of door_lock is

    type state_type is (IDLE, CHECK_PASSWORD, UNLOCK_STATE, WRONG_STATE, ALARM_STATE);
    signal state : state_type := IDLE;

    constant correct_password : STD_LOGIC_VECTOR(3 downto 0) := "1010";
    signal wrong_count : integer range 0 to 3 := 0;

begin

    process(clk, reset)
    begin
        if reset = '1' then
            state <= IDLE;
            wrong_count <= 0;
            unlock <= '0';
            lock_out <= '1';
            alarm <= '0';

        elsif rising_edge(clk) then

            case state is

                when IDLE =>
                    unlock <= '0';
                    lock_out <= '1';
                    alarm <= '0';

                    if enter = '1' then
                        state <= CHECK_PASSWORD;
                    else
                        state <= IDLE;
                    end if;

                when CHECK_PASSWORD =>
                    if password_in = correct_password then
                        state <= UNLOCK_STATE;
                        wrong_count <= 0;
                    else
                        state <= WRONG_STATE;
                    end if;

                when UNLOCK_STATE =>
                    unlock <= '1';
                    lock_out <= '0';
                    alarm <= '0';
                    state <= IDLE;

                when WRONG_STATE =>
                    unlock <= '0';
                    lock_out <= '1';

                    if wrong_count = 2 then
                        wrong_count <= 3;
                        state <= ALARM_STATE;
                    else
                        wrong_count <= wrong_count + 1;
                        state <= IDLE;
                    end if;

                when ALARM_STATE =>
                    unlock <= '0';
                    lock_out <= '1';
                    alarm <= '1';
                    state <= ALARM_STATE;

            end case;
        end if;
    end process;

end Behavioral;

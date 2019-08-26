library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity Module is
Port (
	clk: in std_logic;
	sync_signal: in std_logic;
	input_ref: in std_logic;
	count1_op: out std_logic_vector(3 downto 0);
	count2_op: out std_logic_vector(3 downto 0);
	count3_op: out std_logic_vector(3 downto 0)
	);

end Module;

architecture Behavioral of Module is
                                             
signal count1,count2,count3: std_logic_vector(3 downto 0):= "0000" ;
signal state: std_logic_vector(4 downto 0):="00000";                                
signal count_ref: std_logic;                                               
constant initial: std_logic_vector(4 downto 0):="00001";
constant check1 : std_logic_vector(4 downto 0):="00010";                  
constant check2: std_logic_vector(4 downto 0):="00100";                    
constant check3: std_logic_vector(4 downto 0):="01000";                    
constant done: std_logic_vector(4 downto 0):="10000";

begin

process(sync_signal,input_ref,clk)

begin

	if(sync_signal='1') then
	  count1<=(others=>'0');
	  count2<=(others=>'0');                 
	  count3<=(others=>'0');                 
	  state<=initial;
	else
	  if(rising_edge(clk) and sync_signal='0') then
		case state is
			when initial => if(input_ref='0') then
								count_ref<='0';
								count1<=count1+1;
								state<=check1;
							elsif(input_ref='1') then
								count_ref<='1';
								count2<=count2+1;
								state<=check2;
							else
								state<=initial;
							end if;                                                                                                                
				
			when check1 =>                                                      
							if(input_ref=count_ref) then
								count1<=count1+1;
								state<=check1;
							elsif(input_ref/=count_ref) then
								count_ref<= not count_ref;
								count2<=count2+1;
								state<=check2;
							else
								state<=done;
							end if;
				
			when check2 => 
							if(input_ref=count_ref) then
								count2<=count2+1;
								state<=check2;
							elsif(input_ref/=count_ref) then
								count_ref<= not count_ref;
								count3<=count3+1;
								state<=check3;
							else 
								state<=done;
							end if;                                                      
						
			when check3 => 
							if(input_ref=count_ref) then
								count3<=count3+1;
								state<=check3;
							end if;
				
			when done =>    count1<=(others=>'0');
                            count2<=(others=>'0');                  
                            count3<=(others=>'0');                 
			                state<=initial;                                                                           
																
			when others =>  state<= initial;		
				
		end case;
 end if;
 end if;

end process;
    count1_op<=count1;                                                  
	count2_op<=count2;
	count3_op<=count3;
end Behavioral;
module tb_Module;
  reg clk; 
  reg sync_signal;
  reg input_ref;
  wire [3:0] count1_op;
  wire [3:0] count2_op;
  wire [3:0] count3_op;              

  Module   a ( .clk (clk),
                 .sync_signal (sync_signal),
				 .input_ref(input_ref),
				 .count1_op(count1_op),
				 .count2_op(count2_op),
				 .count3_op(count3_op)
				 );

 
  
  always #5 clk = ~clk;

  initial begin
    $monitor ("[%0tns] clk=%0b sync_signal=%0b input_ref=%b count1_op=0x%0h count2_op=0x%0h count3_op=0x%0h", $time, clk,sync_signal,input_ref,count1_op,count2_op,count3_op);
    
    
    clk <= 0;
    input_ref <= 0;
    sync_signal<=0; 

    
    #10 sync_signal <= 1;
    input_ref<=1;
    
    #10 sync_signal <= 0;
    #40 input_ref<=0;
    
    #70 input_ref<=1;
    sync_signal<=1;
    #10 sync_signal<=0; 
    
    
    #40 sync_signal <= 1;
    input_ref<=0;
    
    #10 sync_signal <= 0;
    #50 input_ref<=1;
    
    #40 input_ref<=0;
    #50 sync_signal<=1;
    
    #10 sync_signal<=0;
    

    #50 sync_signal <= 1;
    input_ref<=0;
    
    #10 sync_signal <= 0;
    #40 input_ref<=1;
    
    #50 sync_signal<=1;
    #10 sync_signal<=0;
    
    input_ref<=0;
    #40 input_ref<=1;
    
    #70 input_ref<=0;
    
    #30 sync_signal<=1;
    #50  $finish;
end  
  initial begin
    $dumpvars;
    $dumpfile("dump.vcd");
  end
endmodule
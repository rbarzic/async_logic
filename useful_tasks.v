task check_8bits;
  input [7:0] value;
  input [7:0] expected;     
  begin
    if(value !== expected) begin
      $display("-E- Expected : %x, got %x",expected,value);
      #10;
      $finish;
      
    end
    else begin
      $display("-I- Read : %x, got %x - OK",expected,value);
    end      
  end
endtask // check_8bits

`timescale 1ns / 1ps

module tb_veriyolu();
    reg clk=0,rst=0;
    reg [2:0] alux_sel;
    reg ax_yukle, bx_yukle, arx_yukle;
    reg [7:0] ax_yolla=0, arx_yolla=0, s1x_yolla=0, s2x_yolla=0, s1x=8'h18, s2x=8'h03, bx_yolla=0;
    wire [7:0] tox_memory, mx_address;
    reg [3:0] sayac=0;
    //test verileri
    wire [7:0] reg_a, reg_b, reg_alu;

     veriyolu yol_uut(
          .aclk(clk), //in
          .arst(rst), //in
          .alu_sel(alux_sel), //in
          .a_yolla(ax_yolla), //in 
          .ar_yolla(arx_yolla), //in
          .s1_yolla(s1x_yolla), //in
          .s2_yolla(s2x_yolla), //in 
          .b_yolla(bx_yolla), //in
          .s1(s1x), //in
          .s2(s2x), //in
          .a_yukle(ax_yukle), //in
          .b_yukle(bx_yukle), //in
          .ar_yukle(arx_yukle), //in
          .to_memory(tox_memory),
          .m_address(mx_address),
          .a_tb(reg_a),
          .b_tb(reg_b),
          .alu_result_tb(reg_alu)
      );

      initial begin
            #20
            rst = 1'b1;
            #200; $finish;
      end
      
      always #10 clk = ~clk;
      
      always @(posedge clk)
      begin
            case(sayac)
                    //s1 girdisi a kaydedicisine aktarýlýyor
                    4'h0, 4'h1: begin 
                            s1x_yolla=8'hff;
                            ax_yukle=1'b1;
                            sayac=sayac+1; //1
                    end
                    
                    //s2 girdisi bus'a aktarýlýyor
                    4'h2, 4'h3: begin
                            ax_yukle=1'b0;
                            s1x_yolla=8'h00;
                            s2x_yolla=8'hff;  
                            alux_sel=0;
                            bx_yukle=1'b1;                     
                            sayac=sayac+1; //2
                    end
                    
                    4'h4, 4'h5: begin                            
                            s2x_yolla=8'h00;                             
                            bx_yukle=1'b0;
                            bx_yolla=8'hff;                        
                            sayac=sayac+1;                            
                    end
                    
                    4'h6, 4'h7: begin
                            bx_yolla=8'h00; 
                            sayac=sayac+1;
                    end                  
                    
            endcase
      end
endmodule

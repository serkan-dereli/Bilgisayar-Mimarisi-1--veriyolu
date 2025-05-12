`timescale 1ns / 1ps

module veriyolu (
        input aclk,arst,
        input [2:0] alu_sel,
        input [7:0] a_yolla, ar_yolla, s1_yolla, s2_yolla, s1, s2, b_yolla,
        input a_yukle, b_yukle, ar_yukle,
        output [7:0] to_memory, m_address,
        //register deðerlerini test ekranýnda gösterir
        output [7:0] a_tb, b_tb, alu_result_tb 
    );
    
    reg [7:0] a, ar, b;
    wire [7:0] alu_result, bus;
    //reg [2:0] state=0;
    
    //kaydedici içerigini BUS a aktarýr
    assign bus=(a&a_yolla) | (ar&ar_yolla) | 
                         (s1&s1_yolla) | (s2&s2_yolla) | (b&b_yolla);
                         
    assign to_memory=bus;
    assign m_address=ar;
    
    //test ekranýna gönder
    assign a_tb=a;
    assign b_tb=b;
    assign alu_result_tb=alu_result;
    
    //a kaydedici yükleme
    always @(posedge aclk)
    begin
        if(arst==1'b0) begin
            a<=8'h00;
        end
        else begin
            if(a_yukle==1'b1) begin
                a<=bus;
            end
        end    
    end
    
    //b kaydedici yükleme
    always @(posedge aclk)
    begin
        if(arst==1'b0) begin
            b<=8'h00;
        end
        else begin
            if(b_yukle==1'b1) begin
                b<=alu_result;
            end
        end    
    end
    
    //ar kaydedici yükleme
    always @(posedge aclk)
    begin
        if(arst==1'b0) begin
            ar<=8'h00;
        end
        else begin
            if(ar_yukle==1'b1) begin
                ar<=bus;
            end
        end    
    end  
    
    alu alu_uut (        
        .islem_in(alu_sel),
        .s1_in(a),
        .s2_in(bus),
        .s_out(alu_result)
    );
endmodule

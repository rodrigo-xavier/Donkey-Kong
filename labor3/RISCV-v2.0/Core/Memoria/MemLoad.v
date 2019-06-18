`ifndef PARAM
	`include "../Parametros.v"
`endif

/* Controlador da memoria de leitura */
/* define a partir do funct3 qual a forma de acesso a memoria lb, lh, lw */

module MemLoad(
	input [1:0] 		   iAlignment,
	input [2:0] 		   iFunct3,
	input [31:0] 		   iData,
	output logic [31:0]  oData,
	output 					oException
);




// Alignment exception
assign oException =  (iFunct3 == FUNCT3_LW  && iAlignment    != 2'b00)
                  || (iFunct3 == FUNCT3_LH  && iAlignment[0] != 1'b0 )
                  || (iFunct3 == FUNCT3_LHU && iAlignment[0] != 1'b0 );

logic [15:0] Halfword;
logic [ 7:0] Byte;

always @(*) begin
	case (iAlignment)
		2'b00: Halfword <= iData[15: 0];
		2'b10: Halfword <= iData[31:16];
		default: Halfword = 16'b0;
	endcase
end

always @(*) begin
	case (iAlignment)
		2'b00: Byte <= iData[ 7: 0];
		2'b01: Byte <= iData[15: 8];
		2'b10: Byte <= iData[23:16];
		2'b11: Byte <= iData[31:24];
		default: Byte <= 8'b0;
	endcase
end

always @(*) begin
	case (iFunct3)
		FUNCT3_LW:  oData <= iData;
		FUNCT3_LH:  oData <= {{16{Halfword[15]}}, Halfword};
		FUNCT3_LHU: oData <= {16'b0, Halfword};
		FUNCT3_LB:  oData <= {{24{Byte[7]}}, Byte};
		FUNCT3_LBU: oData <= {24'b0, Byte};
		default:    oData <= 32'b0;
	endcase
end

endmodule

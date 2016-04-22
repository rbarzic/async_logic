//****************************************************************************/
//
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Fri Apr 22 13:25:26 2016
//
//  This program is free software; you can redistribute it and/or
//  modify it under the terms of the GNU General Public License
//  as published by the Free Software Foundation; either version 2
//  of the License, or (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,MA 02110-1301,USA.
//
//
//  Filename        :  two_phase_slave.v
//
//  Description     :
//           A simple module that handles request and provides an acknowledge
//            after some time
//
//
//
//
//****************************************************************************/



`timescale 1ns/1ps
module two_phase_slave (/*AUTOARG*/
   // Outputs
   ack,
   // Inputs
   req
   );
   input req;
   output ack;


   parameter spread=200;

   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/

   reg    ack;
   event  evt_dbg_1;
   event  evt_dbg_2;

   always @(posedge req) begin
      if(ack == 1'b1) begin
         $display("-E- Protocol violation (posedge req while ack == 1)");
         $finish(1);
      end
      else begin
         #($unsigned($random) % 200);
         ack <= 1'b1;
      end
   end

   always @(negedge req) begin
      if(ack == 1'b0) begin
         $display("-E- Protocol violation (negedge req while ack == 0)");
         $finish(1);
      end
      else begin
         #($unsigned($random) % 200);
         ack <= 1'b0;
      end
   end



endmodule // two_phase_slave

/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */

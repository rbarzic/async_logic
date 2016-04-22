//****************************************************************************/
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Fri Apr 22 09:40:43 2016
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
//  Filename        :  two_phase_event_gen.v
//
//  Description     :  A random 2-phase event generator
//
//
//
//****************************************************************************/
`timescale 1ns/1ps

module two_phase_event_gen (/*AUTOARG*/
   // Outputs
   req,
   // Inputs
   run, ack
   );
   input run;
   output req;
   input ack;

   parameter spread=200;


   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/

   reg   req;

   task handshake_2ph_rise;
      begin
         wait(ack === 1'b0);
         req <= 1'b1;
         wait(ack === 1'b1);
      end
   endtask


   task handshake_2ph_fall;
      begin
         wait(ack === 1'b1);
         req = 1'b0;
         wait(ack === 1'b0);
      end
   endtask


   initial begin
      req <= 0;
      #1;
      while(1) begin
         wait(run===1'b1);
         #($unsigned($random) % spread);
         handshake_2ph_rise();
         #($unsigned($random) % spread);
         handshake_2ph_fall();

      end
   end



endmodule // two_phase_event_gen
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */

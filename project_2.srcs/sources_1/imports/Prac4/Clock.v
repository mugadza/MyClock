`timescale 1ns / 1ps



module WallClock(
input CLK100MHZ,
input button,
input MButton,
input HButton,
output [7:0] SevenSegment,
output [3:0] SegementDrivers
	//inputs - these will depend on your board's constraint files

	//outputs - these will depend on your board's constraint files
	
);

	//Add the reset

	//Add and debounce the buttons
	

    
	
	// Instantiate Debounce modules here
	//debounce and listen to buttons
	
	// registers for storing the time
    reg [3:0]hours1=4'd0;
	reg [3:0]hours2=4'd0;
	reg [3:0]mins1=4'd0;
	reg [3:0]mins2=4'd0;
	
    
	//Initialize seven segment
	// You will need to change some signals depending on you constraints
	SS_Driver SS_Driver1(
		CLK100MHZ, button,
		hours1, hours2, mins1, mins2, // Use temporary test values before adding hours2, hours1, mins2, mins1
		SegementDrivers, SevenSegment
	);
	
	

	//The main logic
	integer minCount;
	integer hourCount;
	integer hourVal;
	integer minVal;
	wire minsUp;
	wire hoursUp;
    reg minutesPrevState;
    reg hoursPrevState;
	
	
	initial begin
	   minCount = 0;
	   hourCount = 0; 
	   minVal = 0;
	   hourVal = 0;
	   minutesPrevState=0;
	   hoursPrevState =0;
	  
	end
	Debounce debouncer1(CLK100MHZ,MButton,minsUp);//listen for minutes
	Debounce debouncer2(CLK100MHZ,HButton,hoursUp);//listen for hours
	
	always @(posedge CLK100MHZ) begin
        if (minsUp ==1 && minutesPrevState == 0)begin
            minutesPrevState = 1;
            minVal = minVal+1;
          //-------
          if(minVal > 59)begin
               hourVal = hourVal+1;
               if(hourVal>=24)begin
                   hourVal =0;
               end
               minVal = 0;
               mins1 = 0;//minutes tens
               mins2 = 0;//minutes units
               hours1 = (hourVal - (hourVal%10))/10;//hours tens
               hours2 = hourVal%10;//hours units
           end
           else begin
               mins1 = (minVal-(minVal%10))/10;//minutes tens
               mins2 = minVal%10;//minutes units
           end
        end
        if (minsUp ==0) begin
            minutesPrevState = minsUp;
        end
    
        if (hoursUp == 1 && hoursPrevState == 0) begin
            hoursPrevState = 1;
            hourVal = hourVal+1;
            if(hourVal>=24)begin
               hourVal =0;
            end
            hours1 = (hourVal - (hourVal%10))/10;//hours tens
            hours2 = hourVal%10;//hours units
        end
        if (hoursUp ==0) begin
            hoursPrevState = hoursUp;
        end
    end
    
	//increament minutes and  hours
//always@(posedge CLK100MHZ) begin	
//	 if (minCount==250000000)begin
//	  if(minVal >= 59)begin
//	       hourVal = hourVal+1;
//	       if(hourVal>=24)begin
//	           hourVal =0;
//	       end
//	       minVal = 0;
//	       mins1 = 0;//minutes tens
//           mins2 = 0;//minutes units
//           hours1 = (hourVal - (hourVal%10))/10;//hours tens
//           hours2 = hourVal%10;//hours units
//           minCount =0;
//	   end
//	   else begin
//           minVal = minVal+1;
//           mins1 = (minVal-(minVal%10))/10;//minutes tens
//           mins2 = minVal%10;//minutes units
//           hours1 = (hourVal - (hourVal%10))/10;//hours tens
//           hours2 = hourVal%10;//hours units
//           minCount =0;
//       end
//	 end
//	 else begin
//	   minCount = minCount+1;
//	 end
//		 //implement your logic here
//	end
endmodule  

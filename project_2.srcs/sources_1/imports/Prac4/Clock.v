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
	wire minsUp = 0;
	wire hoursUp = 0;

    
	
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
	integer minCount = 0;
	integer hourCount = 0;
	integer hourVal = 0;
	integer minVal = 0;
	
	reg MbuttPrev ;
	reg HbuttPrev;
	
	initial begin
	   MbuttPrev = minsUp;
	   HbuttPrev = hoursUp; 
	end
	Debounce debouncer1(CLK100MHZ,MButton,minsUp);//listen for minutes
	Debounce debouncer2(CLK100MHZ,HButton,hoursUp);//listen for hours
	
	always @(posedge CLK100MHZ) begin
    if (minsUp != MbuttPrev )begin
        minVal = minVal+1;
    end
    
    if (hoursUp !=  HbuttPrev)begin
        hourVal = hourVal+1;
    end
    
	//increament minutes and  hours
	 if (minCount==250000000)begin
	  if(minVal >= 59)begin
	       hourVal = hourVal+1;
	       if(hourVal>=24)begin
	           hourVal =0;
	       end
	       minVal = 0;
	       mins1 = 0;//minutes tens
           mins2 = 0;//minutes units
           hours1 = (hourVal - (hourVal%10))/10;//hours tens
           hours2 = hourVal%10;//hours units
           minCount =0;
	   end
	   else begin
           minVal = minVal+1;
           mins1 = (minVal-(minVal%10))/10;//minutes tens
           mins2 = minVal%10;//minutes units
           hours1 = (hourVal - (hourVal%10))/10;//hours tens
           hours2 = hourVal%10;//hours units
           minCount =0;
       end
	 end
	 else begin
	   minCount = minCount+1;
	 end
		// implement your logic here
	end
endmodule  

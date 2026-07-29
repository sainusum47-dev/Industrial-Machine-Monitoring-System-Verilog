module temp_alarm(
    input wire [7:0] temperature,
    input wire [7:0] limit,
    output wire alarm
);

assign alarm = (temperature > limit);

endmodule
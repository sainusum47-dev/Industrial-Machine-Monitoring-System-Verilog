module vibration_alarm(
    input wire [7:0] vibration,
    input wire [7:0] limit,
    output wire vibration_alarm
);

assign vibration_alarm = (vibration > limit);

endmodule
module gas_alarm(
    input wire [7:0] gas,
    input wire [7:0] limit,
    output wire gas_alarm
);

assign gas_alarm = (gas > limit);

endmodule
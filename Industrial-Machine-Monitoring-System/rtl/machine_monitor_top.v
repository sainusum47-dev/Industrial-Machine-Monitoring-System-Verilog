// ============================================================================
// Module Name: machine_monitor_top
// Project: Industrial Machine Monitoring System
// Target Device: AMD Artix-7 (xc7a35tcpg236-1)
// Description: Top-level module integrating temperature, vibration, and gas 
//              threshold monitoring with immediate safety alarm logic.
// ============================================================================
module machine_monitor_top (

    // Inputs
    input wire [7:0] temperature,
    input wire [7:0] temp_limit,

    input wire [7:0] vibration,
    input wire [7:0] vibration_limit,

    input wire [7:0] gas,
    input wire [7:0] gas_limit,

    input wire machine_on,

    // Outputs
    output wire temp_alarm,
    output wire vibration_alarm,
    output wire gas_alarm,
    output wire status
);

    // Temperature Alarm
    temp_alarm temp_inst (
        .temperature(temperature),
        .limit(temp_limit),
        .alarm(temp_alarm)
    );

    // Vibration Alarm
    vibration_alarm vib_inst (
        .vibration(vibration),
        .limit(vibration_limit),
        .vibration_alarm(vibration_alarm)
    );

    // Gas Alarm
    gas_alarm gas_inst (
        .gas(gas),
        .limit(gas_limit),
        .gas_alarm(gas_alarm)
    );

    // Machine Status
    machine_status status_inst (
        .machine_on(machine_on),
        .status(status)
    );

endmodule

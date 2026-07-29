`timescale 1ns / 1ps

module machine_monitor_top_tb;

    // =========================================================
    // INPUT SIGNALS
    // =========================================================
    reg [7:0] temperature;
    reg [7:0] temp_limit;

    reg [7:0] vibration;
    reg [7:0] vibration_limit;

    reg [7:0] gas;
    reg [7:0] gas_limit;

    reg machine_on;

    // Test case number - used only for simulation
    reg [2:0] test_case;


    // =========================================================
    // OUTPUT SIGNALS
    // =========================================================
    wire temp_alarm;
    wire vibration_alarm;
    wire gas_alarm;
    wire status;


    // =========================================================
    // TEST COUNTERS
    // =========================================================
    integer pass_count;
    integer fail_count;


    // =========================================================
    // INSTANTIATE DESIGN UNDER TEST
    // =========================================================
    machine_monitor_top uut (

        .temperature      (temperature),
        .temp_limit       (temp_limit),

        .vibration        (vibration),
        .vibration_limit  (vibration_limit),

        .gas              (gas),
        .gas_limit        (gas_limit),

        .machine_on       (machine_on),

        .temp_alarm       (temp_alarm),
        .vibration_alarm  (vibration_alarm),
        .gas_alarm        (gas_alarm),
        .status           (status)

    );


    // =========================================================
    // SIMULATION
    // =========================================================
    initial begin

        // Initialize counters
        pass_count = 0;
        fail_count = 0;


        // =====================================================
        // HEADER
        // =====================================================
        $display("");
        $display("====================================================");
        $display("     INDUSTRIAL MACHINE MONITORING SYSTEM");
        $display("              SIMULATION STARTED");
        $display("====================================================");
        $display("");


        // =====================================================
        // TEST 1: NORMAL OPERATION
        // =====================================================
        test_case = 3'd1;

        temperature     = 8'd50;
        temp_limit      = 8'd80;

        vibration       = 8'd20;
        vibration_limit = 8'd50;

        gas             = 8'd10;
        gas_limit       = 8'd30;

        machine_on      = 1'b1;

        #10;

        if ((temp_alarm == 1'b0) &&
            (vibration_alarm == 1'b0) &&
            (gas_alarm == 1'b0) &&
            (status == 1'b1)) begin

            $display("TEST 1 | NORMAL OPERATION");
            $display("       Temperature = %0d | Vibration = %0d | Gas = %0d",
                     temperature, vibration, gas);
            $display("       Machine = ON");
            $display("       Result = PASS");
            $display("");

            pass_count = pass_count + 1;

        end
        else begin

            $display("TEST 1 | NORMAL OPERATION");
            $display("       Result = FAIL");
            $display("");

            fail_count = fail_count + 1;

        end


        // =====================================================
        // TEST 2: HIGH TEMPERATURE
        // =====================================================
        test_case = 3'd2;

        temperature = 8'd100;

        #10;

        if (temp_alarm == 1'b1) begin

            $display("TEST 2 | HIGH TEMPERATURE");
            $display("       Temperature = %0d | Limit = %0d",
                     temperature, temp_limit);
            $display("       Temperature Alarm = ACTIVE");
            $display("       Result = PASS");
            $display("");

            pass_count = pass_count + 1;

        end
        else begin

            $display("TEST 2 | HIGH TEMPERATURE");
            $display("       Result = FAIL");
            $display("");

            fail_count = fail_count + 1;

        end


        // =====================================================
        // TEST 3: HIGH VIBRATION
        // =====================================================
        test_case = 3'd3;

        temperature = 8'd50;
        vibration   = 8'd70;

        #10;

        if (vibration_alarm == 1'b1) begin

            $display("TEST 3 | HIGH VIBRATION");
            $display("       Vibration = %0d | Limit = %0d",
                     vibration, vibration_limit);
            $display("       Vibration Alarm = ACTIVE");
            $display("       Result = PASS");
            $display("");

            pass_count = pass_count + 1;

        end
        else begin

            $display("TEST 3 | HIGH VIBRATION");
            $display("       Result = FAIL");
            $display("");

            fail_count = fail_count + 1;

        end


        // =====================================================
        // TEST 4: HIGH GAS
        // =====================================================
        test_case = 3'd4;

        vibration = 8'd20;
        gas       = 8'd50;

        #10;

        if (gas_alarm == 1'b1) begin

            $display("TEST 4 | HIGH GAS");
            $display("       Gas = %0d | Limit = %0d",
                     gas, gas_limit);
            $display("       Gas Alarm = ACTIVE");
            $display("       Result = PASS");
            $display("");

            pass_count = pass_count + 1;

        end
        else begin

            $display("TEST 4 | HIGH GAS");
            $display("       Result = FAIL");
            $display("");

            fail_count = fail_count + 1;

        end


        // =====================================================
        // TEST 5: MULTIPLE FAULTS
        // =====================================================
        test_case = 3'd5;

        temperature = 8'd100;
        vibration   = 8'd70;
        gas         = 8'd50;

        #10;

        if ((temp_alarm == 1'b1) &&
            (vibration_alarm == 1'b1) &&
            (gas_alarm == 1'b1)) begin

            $display("TEST 5 | MULTIPLE FAULTS");
            $display("       Temperature Alarm = ACTIVE");
            $display("       Vibration Alarm   = ACTIVE");
            $display("       Gas Alarm         = ACTIVE");
            $display("       Result = PASS");
            $display("");

            pass_count = pass_count + 1;

        end
        else begin

            $display("TEST 5 | MULTIPLE FAULTS");
            $display("       Result = FAIL");
            $display("");

            fail_count = fail_count + 1;

        end


        // =====================================================
        // TEST 6: MACHINE OFF
        // =====================================================
        test_case = 3'd6;

        machine_on = 1'b0;

        #10;

        if (status == 1'b0) begin

            $display("TEST 6 | MACHINE OFF");
            $display("       Machine = OFF");
            $display("       Status = STOPPED");
            $display("       Result = PASS");
            $display("");

            pass_count = pass_count + 1;

        end
        else begin

            $display("TEST 6 | MACHINE OFF");
            $display("       Result = FAIL");
            $display("");

            fail_count = fail_count + 1;

        end


        // =====================================================
        // FINAL SIMULATION SUMMARY
        // =====================================================
        $display("====================================================");
        $display("              SIMULATION SUMMARY");
        $display("====================================================");
        $display("Total Tests Passed : %0d", pass_count);
        $display("Total Tests Failed : %0d", fail_count);
        $display("====================================================");


        if (fail_count == 0) begin

            $display("FINAL RESULT : ALL TESTS PASSED");
            $display("SIMULATION STATUS : SUCCESS");
            $display("====================================================");

        end
        else begin

            $display("FINAL RESULT : SOME TESTS FAILED");
            $display("SIMULATION STATUS : CHECK DESIGN");
            $display("====================================================");

        end


        // End simulation
        #10;
        $finish;

    end

endmodule
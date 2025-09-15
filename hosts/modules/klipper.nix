{
  services.klipper = {
    user = "root";
    group = "root";
    enable = true;
    firmwares = {
      mcu = {
        enable = true;
        # Generate this config by running klipper-genconf
        # Currently broken = https =//github.com/NixOS/nixpkgs/pull/200228
        # Workaround = Run nix-shell -p python3 --command klipper-genconf instead
        configFile = ./avr.cfg;
        serial = "/dev/serial/by-id/usb-1a86_USB_Serial-if00-port0";
      };
    };
    settings = {
      stepper_x = {
        step_pin = "PC2";
        dir_pin = "PB9";
        enable_pin = "!PC3";
        microsteps = 16;
        rotation_distance = 40;
        endstop_pin = "!PA5"; #tmc2130_stepper_x =virtual_endstop
        position_min = -15;
        position_endstop = -10;
        position_max = 235;
        homing_speed = 50;
      };
      stepper_y = {
        step_pin = "PB8";
        dir_pin = "PB7";
        enable_pin = "!PC3";
        microsteps = 16;
        rotation_distance = 40;
        endstop_pin = "!PA6";
        position_endstop = -8;
        position_max = 238;
        position_min = -13;
        homing_speed = 50;
      };
      stepper_z = {
        step_pin = "PB6";
        dir_pin = "!PB5";
        enable_pin = "!PC3";
        microsteps = 16;
        rotation_distance = 8;
        endstop_pin = "probe:z_virtual_endstop";
        position_max = 270;
        position_min = -4;
      };
      extruder = {
        step_pin = "PB4";
        dir_pin = "PB3";
        enable_pin = "!PC3";
        microsteps = 16;
        gear_ratio = "42:12";
        rotation_distance = 26.359;
        nozzle_diameter = 0.400;
        filament_diameter = 1.750;
        heater_pin = "PA1";
        sensor_type = "EPCOS 100K B57560G104F";
        sensor_pin = "PC5";
        control = "pid";
        pid_Kp = 23.561;
        pid_Ki = 1.208;
        pid_Kd = 114.859;
        min_temp = 0;
        max_temp = 300;
      };
      heater_bed = {
        heater_pin = "PA7";
        sensor_type = "EPCOS 100K B57560G104F";
        sensor_pin = "PC4";
        control = "pid";
        pid_Kp = 71.867;
        pid_Ki = 1.536;
        pid_Kd = 840.843;
        min_temp = 0;
        max_temp = 110;
      };
      "heater_fan hotend_fan" = {
        pin = "PC0";
      };
      fan = {
        pin = "PA0";
      };
      mcu = {
        serial = "/dev/serial/by-id/usb-1a86_USB_Serial-if00-port0";
      };
      printer = {
        kinematics = "cartesian";
        max_velocity = 300;
        max_accel = 2000;
        max_z_velocity = 5;
        max_z_accel = 100;
      };
      bltouch = {
        sensor_pin = "^PC14";
        control_pin = "PC13";
        x_offset = -31.8;
        y_offset = -40.5;
        z_offset = 0;
        probe_with_touch_mode = true;
        stow_on_each_sample = false;
      };
      bed_mesh = {
        speed = 120;
        mesh_min = "10, 10";
        mesh_max = "200, 194";
        probe_count = "4,4";
        algorithm = "bicubic";
      };
      safe_z_home = {
        home_xy_position = "147, 154";
        speed = 75;
        z_hop = 10;
        z_hop_speed = 5;
      };
      "filament_switch_sensor e0_sensor" = {
        switch_pin = "!PC15";
        pause_on_runout = true;
        runout_gcode = "PAUSE";
      };
      bed_screws = {
        screw1 = "20, 29";
        screw2 = "195, 29";
        screw3 = "195, 198";
        screw4 = "20, 198";
      };
      pause_resume = {
        recover_velocity = 25;
      };
    };
  };
}

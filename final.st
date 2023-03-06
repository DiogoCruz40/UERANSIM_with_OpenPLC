PROGRAM program0
  VAR
    SWITCH AT %QX0.0 : BOOL;
    SLAVE1 AT %QW0 : INT;
  END_VAR
  VAR
    setpoint : INT := 10;
    GT2_OUT : BOOL;
  END_VAR

  GT2_OUT := GT(SLAVE1, setpoint);
  SWITCH := GT2_OUT;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : program0;
  END_RESOURCE
END_CONFIGURATION

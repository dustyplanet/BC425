*"* components of interface IF_EX_BC425_26FLIGHT2
interface IF_EX_BC425_26FLIGHT2
  public .


  data WA type SFLIGHT26 .

  methods GET_DATA
    exporting
      value(E_FLIGHT) type SFLIGHT26 .
  methods PUT_DATA
    importing
      value(I_FLIGHT) type SFLIGHT26 .
endinterface.

*"* components of interface IF_EX_BC425_30FLIGHT2
interface IF_EX_BC425_30FLIGHT2
  public .


  data WA type SFLIGHT30 .

  methods GET_DATA
    exporting
      value(E_FLIGHT) type SFLIGHT30 .
  methods PUT_DATA
    importing
      value(I_FLIGHT) type SFLIGHT30 .
endinterface.

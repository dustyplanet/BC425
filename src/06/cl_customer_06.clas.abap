class CL_CUSTOMER_06 definition
  public
  final
  create public .

public section.
  type-pools ICON .

  methods CONSTRUCTOR
    importing
      !IV_ID type SCUSTOM-ID .
  methods DISPLAY .
protected section.
private section.

  data MV_ID type SCUSTOM-ID .
ENDCLASS.



CLASS CL_CUSTOMER_06 IMPLEMENTATION.


  METHOD CONSTRUCTOR.
    mv_id = iv_id.
  ENDMETHOD.


  METHOD DISPLAY.
    WRITE: / icon_customer AS ICON, 'ID', mv_id.
  ENDMETHOD.
ENDCLASS.

class CL_CUSTOMER_00 definition
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



CLASS CL_CUSTOMER_00 IMPLEMENTATION.


  METHOD constructor.
    mv_id = iv_id.
  ENDMETHOD.


  METHOD display.
    WRITE: / icon_customer AS ICON, 'ID', mv_id.
  ENDMETHOD.
ENDCLASS.

class CL_EX_BADI_05_MX definition
  public
  final
  create public .

public section.

  interfaces IF_EX_BADI_05_MX .

  constants VERSION type VERSION value 000001. "#EC NOTEXT
  type-pools SXRT .
protected section.
private section.

  data INSTANCE_BADI_TABLE type SXRT_EXIT_TAB .
  data INSTANCE_FLT_CACHE type SXRT_FLT_CACHE_TAB .
ENDCLASS.



CLASS CL_EX_BADI_05_MX IMPLEMENTATION.


  method IF_EX_BADI_05_MX~EXIT_MENU_BOOK.
  CLASS CL_EXIT_MASTER DEFINITION LOAD.
  DATA: EXIT_OBJ_TAB TYPE SXRT_EXIT_TAB.

  DATA: exitintf TYPE REF TO IF_EX_BADI_05_MX,
        wa_flt_cache_line TYPE REF TO sxrt_flt_cache_struct,
        flt_name TYPE FILTNAME.


  FIELD-SYMBOLS:
    <exit_obj>       TYPE SXRT_EXIT_TAB_STRUCT,
    <flt_cache_line> TYPE sxrt_flt_cache_struct.

  READ TABLE INSTANCE_FLT_CACHE ASSIGNING <flt_cache_line>
         WITH KEY flt_name    = flt_name
                  method_name = 'EXIT_MENU_BOOK'
         .
  IF sy-subrc NE 0.

    CREATE DATA wa_flt_cache_line TYPE sxrt_flt_cache_struct.
    ASSIGN wa_flt_cache_line->* TO <flt_cache_line>.
    <flt_cache_line>-flt_name    = flt_name.
    <flt_cache_line>-method_name = 'EXIT_MENU_BOOK'.



        CALL METHOD CL_EXIT_MASTER=>CREATE_OBJ_BY_INTERFACE_FILTER
           EXPORTING
              CALLER       = me
              INTER_NAME   = 'IF_EX_BADI_05_MX'
              METHOD_NAME  = 'EXIT_MENU_BOOK'

              delayed_instance_creation    = sxrt_true
           IMPORTING
               exit_obj_tab = exit_obj_tab.

        APPEND LINES OF exit_obj_tab TO INSTANCE_BADI_TABLE.


      <flt_cache_line>-valid = sxrt_false.

      LOOP at exit_obj_tab ASSIGNING <exit_obj>
          WHERE ACTIVE   = SXRT_TRUE.

        <flt_cache_line>-valid = sxrt_true.


          <flt_cache_line>-obj =
               CL_EXIT_MASTER=>instantiate_imp_class(
                        CALLER       = me
                        imp_name  = <exit_obj>-imp_name
                        imp_class = <exit_obj>-imp_class ).
          MOVE <exit_obj>-imp_class to <flt_cache_line>-imp_class.
          MOVE <exit_obj>-imp_switch to <flt_cache_line>-imp_switch.
          MOVE <exit_obj>-order_num to <flt_cache_line>-order_num.
          EXIT.

      ENDLOOP.



    INSERT <flt_cache_line> INTO TABLE INSTANCE_FLT_CACHE.


  ENDIF.


  IF <flt_cache_line>-valid = sxrt_true.


    CALL FUNCTION 'PF_ASTAT_OPEN'
       EXPORTING
           OPENKEY = '051MXWHr7jI1q4}zufzHX0'
           TYP     = 'UE'.

    CASE <flt_cache_line>-imp_switch.
      WHEN 'VSR'.
        DATA: exc        TYPE sfbm_xcptn,                  "#EC NEEDED
              data_ref   TYPE REF TO DATA.

        IF <flt_cache_line>-eo_object is initial.
          CALL METHOD ('CL_FOBU_METHOD_EVALUATION')=>load
               EXPORTING
                  im_class_name     = <flt_cache_line>-imp_class
                  im_interface_name = 'IF_EX_BADI_05_MX'
                  im_method_name    = 'EXIT_MENU_BOOK'
               RECEIVING
                  re_fobu_method    = <flt_cache_line>-eo_object
               EXCEPTIONS
                  not_found         = 1
                  OTHERS            = 2.
          IF sy-subrc = 2.
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                       WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
          ENDIF.
          CHECK sy-subrc = 0.
        ENDIF.


        CLEAR data_ref.
        GET REFERENCE OF IS_BOOK INTO data_ref.
        CALL METHOD <flt_cache_line>-eo_object->set_parameter(
            im_parmname = 'IS_BOOK'
            im_value    = data_ref ).

        CALL METHOD <flt_cache_line>-eo_object->evaluate
             IMPORTING
                ex_exception    = exc
             EXCEPTIONS
                raise_exception = 1
                OTHERS          = 2.
        IF sy-subrc = 2.
          MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                     WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.

        ENDIF.
      WHEN OTHERS.
        EXITINTF ?= <flt_cache_line>-OBJ.
        CALL METHOD EXITINTF->EXIT_MENU_BOOK
           EXPORTING
             IS_BOOK = IS_BOOK.


    ENDCASE.

    CALL FUNCTION 'PF_ASTAT_CLOSE'
       EXPORTING
           OPENKEY = '051MXWHr7jI1q4}zufzHX0'
           TYP     = 'UE'.
  ENDIF.


  endmethod.
ENDCLASS.

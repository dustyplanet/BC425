*&---------------------------------------------------------------------*
*& Report  SAPBC425_BADI_TEMPLATE                                           *
*&---------------------------------------------------------------------*
*& Demo on ALV-Grid event-processing of double_click                   *
*&---------------------------------------------------------------------*

REPORT  sapbc425_badi_template.
************** Types and Data Definitions ************************
TYPES: ty_spfli TYPE STANDARD TABLE OF spfli
                     WITH NON-UNIQUE KEY carrid connid.

DATA: ok_code TYPE sy-ucomm.

DATA: gr_container TYPE REF TO cl_gui_custom_container,
      gr_grid  TYPE REF TO cl_gui_alv_grid.

DATA: gt_spfli TYPE ty_spfli,
      gs_spfli LIKE LINE OF gt_spfli.

*** << NEW CODING HERE: Define BAdI reference >>


*---------------------------------------------------------------------*
*       CLASS lcl_event_handler DEFINITION
*---------------------------------------------------------------------*
CLASS lcl_event_handler DEFINITION.
  PUBLIC SECTION.

    METHODS on_double_click FOR EVENT double_click
                                   OF cl_gui_alv_grid
                            IMPORTING es_row_no e_column.
ENDCLASS.                    "lcl_event_handler DEFINITION

*---------------------------------------------------------------------*
*       CLASS lcl_event_handler IMPLEMENTATION
*---------------------------------------------------------------------*
CLASS lcl_event_handler IMPLEMENTATION.

  METHOD on_double_click.
    READ TABLE gt_spfli INTO gs_spfli INDEX es_row_no-row_id.

*** << NEW CODING HERE: Call BAdI Method >>




    SET HANDLER me->on_double_click FOR gr_grid ACTIVATION space.
  ENDMETHOD.                    "handler_method
ENDCLASS.                    "lcl_event_handler IMPLEMENTATION

* Event handler
DATA: gr_handler TYPE REF TO lcl_event_handler.


START-OF-SELECTION.
********************

  SELECT * FROM spfli INTO TABLE gt_spfli.

  CALL SCREEN '0100'.

*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'DYNPROSTATUS'.
  SET TITLEBAR  'TITLE1'.
ENDMODULE.                 " STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  ALV_GRID  OUTPUT
*&---------------------------------------------------------------------*
MODULE alv_grid OUTPUT.
*** Create object of class CL_GUI_CUSTOM_CAONTAINER to manage data !
  IF gr_container IS NOT BOUND.
    CREATE OBJECT gr_container
      EXPORTING
        container_name = 'CONTAINER_1'
      EXCEPTIONS
        OTHERS         = 6.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
               WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

*** create object of class cl_gui_alv_grid to visualize data !
    CREATE OBJECT gr_grid
      EXPORTING
        i_parent = gr_container
      EXCEPTIONS
        OTHERS   = 5.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

*** create handler instance and register handler method *******
    CREATE OBJECT gr_handler.

*** << NEW CODING HERE: Get BAdI Handle >>




  ENDIF.

  SET HANDLER   gr_handler->on_double_click FOR gr_grid.

*** Call method to visualize data of internal table ************
  CALL METHOD gr_grid->set_table_for_first_display
    EXPORTING
      i_structure_name = 'SPFLI'
    CHANGING
      it_outtab        = gt_spfli
    EXCEPTIONS
      OTHERS           = 4.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

ENDMODULE.                 " ALV_GRID  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE ok_code.
    WHEN 'BACK'.
      SET SCREEN 0.
    WHEN 'EXIT'.
      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.                 " USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*
*&  Include           BC425_BOOK_LIST_03E01
*&---------------------------------------------------------------------*
*----------------------------------------------------------------------*
*  START-OF-SELECTION
*----------------------------------------------------------------------*
START-OF-SELECTION.
  SET PF-STATUS 'LIST'.
* create object of adapter class:
  CALL METHOD cl_exithandler=>get_instance
    CHANGING
      instance = exit_menu.

* Select Data from Table SBOOK:
  SELECT * FROM sbook
    INTO CORRESPONDING FIELDS OF TABLE gt_bookings
      WHERE carrid IN so_car AND
            connid IN so_con AND
            fldate IN so_fld.
  IF sy-subrc <> 0.
    WRITE: 'Keine Buchungsdaten vorhanden'(003).
  ENDIF.

  PERFORM data_output.

AT USER-COMMAND.
  CASE sy-ucomm.
    WHEN '+FUNC'.
      CLEAR: gv_line, gs_book.
      GET CURSOR LINE gv_line.
      SUBTRACT 8 FROM gv_line.
      IF gv_line IS NOT INITIAL.
        READ TABLE gt_bookings INTO gs_booking INDEX gv_line.
        MOVE-CORRESPONDING gs_booking TO gs_book.
        CALL METHOD exit_menu->exit_menu_book
          EXPORTING
            is_book = gs_book.
      ENDIF.
  ENDCASE.

*----------------------------------------------------------------------*
***INCLUDE MBC425_BOOK_DETAIL_USER_COMI02.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
CASE save_ok.
    WHEN 'MORE' OR 'ENTER'.
      SELECT SINGLE * FROM sbook INTO gs_sbook
           WHERE carrid = sdyn_book-carrid
           AND   connid = sdyn_book-connid
           AND   fldate = sdyn_book-fldate
           AND   bookid = sdyn_book-bookid.
      IF sy-subrc = 0.
        SELECT SINGLE name FROM scustom INTO sdyn_book-name
             WHERE id = gs_sbook-customid.
        MOVE-CORRESPONDING gs_sbook TO sdyn_book.
        SET SCREEN 0200.
      ELSE.
        MESSAGE e007(bc400).
*   Tabelleneintrag zum eingegebenen Schlüssel ist nicht vorhanden
      ENDIF.
    WHEN 'BACK'.
      SET SCREEN 0.
    WHEN 'EXIT' OR 'ENDE'.
      LEAVE PROGRAM.
    WHEN OTHERS.
      SET SCREEN 0100.
  ENDCASE.
ENDMODULE.                 " USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*&      Module  CLEAR_OKCODE  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE clear_okcode INPUT.
  save_ok = ok_code.
  CLEAR ok_code.
ENDMODULE.                 " CLEAR_OKCODE  INPUT
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.
  CASE save_ok.
    WHEN 'BACK'.
      SET SCREEN 0100.
    WHEN 'EXIT' OR 'ENDE'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.                 " USER_COMMAND_0200  INPUT

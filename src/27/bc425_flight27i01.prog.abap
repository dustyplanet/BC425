*&---------------------------------------------------------------------*
*&      Module  READ_SFLIGHT  INPUT
*&---------------------------------------------------------------------*
*       Read table SFLIGHT, message if not found                       *
*----------------------------------------------------------------------*
MODULE read_sflight INPUT.
  SELECT SINGLE * FROM  SFLIGHT27
         WHERE  carrid      = SFLIGHT27-carrid
         AND    connid      = SFLIGHT27-connid
         AND    fldate      = SFLIGHT27-fldate .
  IF sy-subrc NE 0.
    CLEAR ok_code.
    MESSAGE e007.
*D:  Tabelleneintrag zum eingegebenen Schlüssel nicht vorhanden
*E:  No table entry for selected key
  ENDIF.
ENDMODULE.                             " READ_SFLIGHT  INPUT

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       Set next screen                                                *
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE save_ok.

    WHEN 'MORE'.
      SET SCREEN 200.

    WHEN 'BACK'.
      SET SCREEN 0.

  ENDCASE.

ENDMODULE.                             " USER_COMMAND  INPUT
*&---------------------------------------------------------------------*
*&      Module  CUST_CHECK  INPUT
*&---------------------------------------------------------------------*
*       Program Exit for customers                                     *
*----------------------------------------------------------------------*
MODULE cust_check INPUT.
  CALL CUSTOMER-FUNCTION '001'
  EXPORTING
    flight     = SFLIGHT27
  EXCEPTIONS
    not_found  = 01
    reserved1  = 01.
ENDMODULE.                             " CUST_CHECK  INPUT
*&---------------------------------------------------------------------*
*&      Module  CANCEL_EXIT  INPUT
*&---------------------------------------------------------------------*
*       Set next screen for cancel and exit command of user            *
*----------------------------------------------------------------------*
MODULE cancel_exit INPUT.

  save_ok = ok_code.
  CLEAR ok_code.

  CASE sy-dynnr.

    WHEN 100.
      SET SCREEN 0.

    WHEN 200.

      CASE save_ok.

        WHEN 'CANC'.
          SET SCREEN 100.

        WHEN 'EXIT'.
          SET SCREEN 0.

      ENDCASE.

  ENDCASE.

  LEAVE SCREEN.

ENDMODULE.                             " CANCEL_EXIT  INPUT
*&---------------------------------------------------------------------*
*&      Module  SAVE_OK_CODE  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE save_ok_code INPUT.

  save_ok = ok_code.
  CLEAR ok_code.

ENDMODULE.                             " SAVE_OK_CODE  INPUT

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.

  CASE save_ok.

    WHEN 'BACK'.
      SET SCREEN 100.

    when 'SAVE'.
      perform save_flights.

    WHEN '+EXT'.
      CALL CUSTOMER-FUNCTION '002'
        EXPORTING
           flight     = SFLIGHT27
        EXCEPTIONS
           not_found  = 01
           reserved1  = 02.

  ENDCASE.

ENDMODULE.                             " USER_COMMAND_0200  INPUT

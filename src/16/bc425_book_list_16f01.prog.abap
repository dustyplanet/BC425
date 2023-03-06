*----------------------------------------------------------------------*
***INCLUDE BC425_BOOK_LIST_16F01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  DATA_OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM data_output .

  ULINE AT /(pos).

  SORT gt_bookings BY carrid connid fldate.

* Display list using group levels
  LOOP AT gt_bookings INTO gs_booking.

    AT NEW connid.
      FORMAT COLOR COL_HEADING INTENSIFIED ON.
      WRITE: /         sy-vline,
                       gs_booking-carrid,
                       gs_booking-connid,
                AT pos sy-vline.
    ENDAT.

    AT NEW fldate.
      FORMAT COLOR COL_HEADING INTENSIFIED OFF.
      WRITE: /        sy-vline,
                      gs_booking-fldate,
               AT pos sy-vline.
    ENDAT.

    FORMAT COLOR COL_NORMAL INTENSIFIED OFF.

    WRITE: /    sy-vline,
                gs_booking-bookid,
             13 gs_booking-order_date,
             25 gs_booking-customid,
             36 gs_booking-agencynum,
             48 gs_booking-cancelled.



    WRITE AT pos sy-vline.

  ENDLOOP.
  ULINE AT /(pos).

ENDFORM.                    " DATA_OUTPUT

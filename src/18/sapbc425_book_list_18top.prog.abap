*&---------------------------------------------------------------------*
*& Include SAPBC425_BOOK_LIST_18TOP                          Modulpool        SAPBC425_BOOK_LIST_00
*&
*&---------------------------------------------------------------------*

REPORT sapbc425_book_list_18.
DATA:
* Itab and workarea for bookings
      gt_bookings TYPE TABLE OF sdyn_book,
      gs_booking  LIKE LINE OF gt_bookings,

* Position of vertical line:
      pos TYPE i VALUE 55,

* Reference variable for instance of BAdI service class:
      exit_menu TYPE REF TO if_ex_badi_18_mx.

DATA gv_line TYPE i.
* Selection Screen
DATA gs_book TYPE sbook.
SELECTION-SCREEN: BEGIN OF BLOCK flight WITH FRAME TITLE text-aaa.
SELECT-OPTIONS: so_car FOR gs_booking-carrid,
                so_con FOR gs_booking-connid,
                so_fld FOR gs_booking-fldate.
SELECTION-SCREEN: END OF BLOCK flight.

*&---------------------------------------------------------------------*
*& Include MBC425_BOOK_DETAIL_TOP                            Modulpool        SAPMBC425_BOOK_DETAIL
*&
*&---------------------------------------------------------------------*

PROGRAM sapmbc425_book_detail.
DATA:  ok_code LIKE sy-ucomm,
       save_ok LIKE ok_code.
DATA  gs_sbook TYPE sbook.
TABLES sdyn_book.

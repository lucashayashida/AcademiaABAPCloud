CLASS zcl_fabap_jul2025_exer05_lih DEFINITION
                                   PUBLIC
                                   FINAL
                                   CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    TYPES gty_conn TYPE STANDARD TABLE OF zi_fabap_jul2025_exer05_lih WITH EMPTY KEY.

    CLASS-METHODS get_data
        FOR TABLE FUNCTION zi_fabap_jul2025_exer05_lih .


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXER05_LIH IMPLEMENTATION.


    METHOD get_data BY DATABASE FUNCTION
        FOR HDB LANGUAGE SQLSCRIPT
        USING /dmo/booking.

        RETURN SELECT * FROM "/DMO/BOOKING"
        WHERE client = session_context( 'CLIENT' );
    ENDMETHOD.
ENDCLASS.

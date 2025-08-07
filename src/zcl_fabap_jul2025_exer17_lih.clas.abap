CLASS zcl_fabap_jul2025_exer17_lih DEFINITION
                                   PUBLIC
                                   FINAL
                                   CREATE PUBLIC .

  PUBLIC SECTION.
   interfaces if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_fabap_jul2025_exer17_lih IMPLEMENTATION.

METHOD if_oo_adt_classrun~main.

   TYPES: BEGIN OF ty_flight,
                      carrier_id    TYPE /dmo/flight-carrier_id,
                      connection_id TYPE /dmo/flight-connection_id,
           END OF ty_flight.

    TYPES : BEGIN OF ty_booking,
                     carrier_id    TYPE /dmo/booking-carrier_id,
                     connection_id TYPE /dmo/booking-connection_id,
                     flight_date   TYPE /dmo/booking-flight_date,
            END OF ty_booking.

    DATA lt_flights  TYPE SORTED TABLE OF ty_flight
                    WITH NON-UNIQUE KEY carrier_id connection_id.

    DATA lt_bookings TYPE SORTED TABLE OF ty_booking
                     WITH NON-UNIQUE KEY carrier_id connection_id.

    SELECT carrier_id, connection_id
      FROM /dmo/flight
      INTO TABLE @lt_flights.

    IF sy-subrc = 0.
      SELECT carrier_id, connection_id, flight_date
        FROM /dmo/booking
        FOR ALL ENTRIES IN @lt_flights
        WHERE carrier_id    = @lt_flights-carrier_id
          AND connection_id = @lt_flights-connection_id
        INTO TABLE @lt_bookings.
    ENDIF.

    LOOP AT lt_flights INTO DATA(ls_flight).
      READ TABLE lt_bookings WITH KEY carrier_id    = ls_flight-carrier_id
                                      connection_id = ls_flight-connection_id
           TRANSPORTING NO FIELDS
           BINARY SEARCH.

      IF sy-subrc = 0.
      DATA(lv_tabix) = sy-tabix.
       LOOP AT lt_bookings FROM lv_tabix INTO DATA(ls_booking).
        IF    ls_booking-carrier_id    <> ls_flight-carrier_id
             OR ls_booking-connection_id <> ls_flight-connection_id.
            EXIT.
        ENDIF.
    out->write( |Voo { ls_booking-carrier_id } { ls_booking-connection_id }: { ls_booking-flight_date }| ).
       ENDLOOP.
      ENDIF.
    ENDLOOP.
ENDMETHOD.


ENDCLASS.

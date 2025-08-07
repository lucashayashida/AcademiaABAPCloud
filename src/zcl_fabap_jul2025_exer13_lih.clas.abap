CLASS zcl_fabap_jul2025_exer13_lih DEFINITION
                                   PUBLIC
                                   FINAL
                                   CREATE PUBLIC .

PUBLIC SECTION.
 INTERFACES if_oo_adt_classrun.
PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS zcl_fabap_jul2025_exer13_lih IMPLEMENTATION.

 METHOD if_oo_adt_classrun~main.

* Inline Declarations

    DATA(lv_carrid) = 'AA'.
    ##NO_TEXT
    out->write( |New Version - Carrier ID: { lv_carrid } | ).

    TYPES: BEGIN OF ty_flight_new,
         carrid      TYPE /dmo/carrier_id,
         connid      TYPE /dmo/connection_id,
         flight_date TYPE /dmo/flight_date,
           END OF ty_flight_new.


    DATA lt_flights_new TYPE STANDARD TABLE OF ty_flight_new WITH EMPTY KEY.

    lt_flights_new = VALUE #(
  ( carrid = 'LH' connid = '0400' flight_date = '20250725' ) ).


    LOOP AT lt_flights_new INTO DATA(ls_flight_new).
    ##NO_TEXT
     DATA(lv_version) = |New Version - Flight: { ls_flight_new-carrid }-{ ls_flight_new-connid }|.
     out->write( lv_version ).
    ENDLOOP.

     SELECT * FROM /dmo/flight
      INTO TABLE @DATA(lt_flights_select_new)
     UP TO 2 ROWS.

    ##NO_TEXT
    out->write( |New Version - Flights found (SELECT): { lines( lt_flights_select_new ) }| ).

**********************************************************************
* Table Expressions

    DATA(ls_flight_expr_new) = lt_flights_new[ 1 ].

    ##NO_TEXT
    DATA(lv_first_flight) = |New Version - First Flight: { ls_flight_expr_new-carrid }-{ ls_flight_expr_new-connid }|.

    IF line_exists( lt_flights_new[ 1 ] ).
     out->write( lv_first_flight ).
    ENDIF.


    DATA(ls_flight_key_new) = lt_flights_new[ carrid = 'LH'
                                              connid = '0400' ].

    IF line_exists( lt_flights_new[ carrid = 'LH'
                                    connid = '0400' ]  ).

     ##NO_TEXT
     DATA(lv_flight) = |New Version - Flight LH-0400: { ls_flight_key_new-carrid }-{ ls_flight_key_new-connid }|.
     out->write( lv_flight ).
    ENDIF.

**********************************************************************
* CONV
    DATA(lv_char_new) = '12345'.

    DATA(lv_int_new) = CONV i( lv_char_new ).

    ##NO_TEXT
    DATA(lv_conv) = |New Version - Converted to INT: { lv_int_new }|.

    out->write( lv_conv ).

**********************************************************************
* VALUE Operator


    DATA(ls_connection_new) = VALUE /dmo/connection( airport_from_id = 'FRA'
                                                     airport_to_id   = 'JFK' ).

    ##NO_TEXT
    DATA(lv_conn) = |New Version - Connection:{ ls_connection_new-airport_from_id }-{ ls_connection_new-airport_to_id }|.
    out->write( lv_conn ).

    DATA lt_flights_value_new TYPE STANDARD TABLE OF ty_flight_new.

    TYPES ty_flight_new_tt TYPE STANDARD TABLE OF ty_flight_new WITH EMPTY KEY.

    lt_flights_value_new = VALUE ty_flight_new_tt(
  ( carrid = 'UA' connid = '0001' flight_date = '20250725' )
  ( carrid = 'DL' connid = '0002' flight_date = '20250726' ) ).


    ##NO_TEXT
    out->write( |New Version - Flights count (VALUE): { lines( lt_flights_value_new ) }| ).
**********************************************************************
* FOR Operator

    DATA(lt_flights_for_new) = VALUE ty_flight_new_tt(
        FOR ls_flight IN lt_flights_value_new WHERE ( carrid = 'UA' )
                                            ( carrid = ls_flight-carrid
                                                       connid = ls_flight-connid
                                                       flight_date = ls_flight-flight_date ) ).


    out->write( |New Version - Flights for UA (FOR): { lines( lt_flights_for_new ) }| ).


**********************************************************************
* REDUCE
    TYPES int_table TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    TYPES ty_char1 TYPE c LENGTH 1.

    DATA(lt_numbers) = VALUE int_table( ( 1 ) ( 2 ) ( 3 ) ).
    DATA(lv_sum) = REDUCE i( INIT x = 0 FOR number IN lt_numbers NEXT x = x + number ).
    DATA(lv_number_conv) = CONV ty_char1( lv_sum ).
    ##NO_TEXT
    DATA(lv_output) = |New Version - Sum: { lv_number_conv }|.

    out->write( lv_output ).
**********************************************************************
* COND and SWITCH
    DATA(lv_code_cond) = 1.
    DATA(lv_status_cond) = COND string(
     WHEN lv_code_cond = 1 THEN 'Success'
     WHEN lv_code_cond = 2 THEN 'Warning'
    ELSE 'Error' ).
    out->write( |New Version - Status (COND): { lv_status_cond }| ).

    DATA(lv_code_switch) = 2.
    DATA(lv_status_switch) = SWITCH string( lv_code_switch
     WHEN 1 THEN 'Success'
     WHEN 2 THEN 'Warning'
    ELSE 'Error' ).

    out->write( |New Version - Status (SWITCH): { lv_status_switch }| ).


**********************************************************************
* CORRESPONDING OP
    TYPES: BEGIN OF ty_s1,
                    field1 TYPE string,
                    field2 TYPE string,
           END OF ty_s1.

    TYPES: BEGIN OF ty_s2,
                    field1 TYPE string,
                    field3 TYPE string,
           END OF ty_s2.

    DATA: ls_s1 TYPE ty_s1.

    ls_s1-field1 = 'Value1'.
    ls_s1-field2 = 'Value2'.

    DATA(ls_s2) = CORRESPONDING ty_s2( ls_s1 ).

    out->write( |New Version - S2 Field1 (CORRESPONDING): { ls_s2-field1 }| ).


**********************************************************************
* strings
    DATA(lv_var1_str_new) = 'Hello'.
    DATA(lv_var2_str_new) = 'World'.
    DATA(lv_result_str_new) = lv_var1_str_new && ' ' && lv_var2_str_new.
    out->write( |New Version - Chaining Operator (Strings): { lv_result_str_new }| ).

    DATA(lv_name_str) = 'ABAP'.
    DATA(lv_version_str) = '7.40'.
    DATA(lv_template_string) = |Welcome to { lv_name_str } { lv_version_str }!|.
    out->write( |New Version - String Template (Strings): { lv_template_string }| ).

    DATA(lv_delivery_number) = '0080003371'.
    DATA(lv_formatted_delivery) = |{ lv_delivery_number ALPHA = OUT }|.
    out->write( |New Version - Embedded Expression (ALPHA) (Strings): { lv_formatted_delivery }| ).


**********************************************************************
*    GROUP By - loop
    TYPES: BEGIN OF ty_flight_group,
                    carrid TYPE /dmo/carrier_id,
                    connid TYPE /dmo/connection_id,
                    price  TYPE /dmo/flight_price,
           END OF ty_flight_group.

    DATA lt_flights_group TYPE STANDARD TABLE OF ty_flight_group WITH EMPTY KEY.

    lt_flights_group = VALUE #(
  ( carrid = 'LH' connid = '0400' price = '100' )
  ( carrid = 'LH' connid = '0401' price = '150' )
  ( carrid = 'UA' connid = '0001' price = '200' ) ).

    LOOP AT lt_flights_group INTO DATA(ls_flight_group) GROUP BY ls_flight_group-carrid.

   DATA(lv_total) = REDUCE /dmo/flight_price( INIT s = 0 FOR f IN GROUP ls_flight_group NEXT s = s + f-price ).

   out->write( |New Version - Carrier { ls_flight_group-carrid } Total Price: { lv_total }| ).

    ENDLOOP.
**********************************************************************
* FILTER
    DATA lt_flights_new2 TYPE SORTED TABLE OF ty_flight_new WITH UNIQUE KEY carrid connid.

    DATA(lt_flights_filter_new) = FILTER #( lt_flights_new2 WHERE carrid = CONV /dmo/carrier_id( 'AA' ) ).

    out->write( |New Version - Filtered flights (LH): { lines( lt_flights_filter_new ) }| ).



 ENDMETHOD.
ENDCLASS.

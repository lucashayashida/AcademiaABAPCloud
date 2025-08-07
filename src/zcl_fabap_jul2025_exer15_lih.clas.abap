CLASS zcl_fabap_jul2025_exer15_lih DEFINITION
                                   PUBLIC
                                   FINAL
                                   CREATE PUBLIC .

  PUBLIC SECTION.
   interfaces if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_fabap_jul2025_exer15_lih IMPLEMENTATION.

 METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF ty_voo,
         companhia    TYPE /dmo/carrier_id,
         conexao      TYPE /dmo/connection_id,
         data_voo     TYPE /dmo/flight_date,
         preco        TYPE /dmo/flight-price,
         distancia    TYPE /dmo/connection-distance,
       END OF ty_voo.

    TYPES ty_voo_tab TYPE STANDARD TABLE OF ty_voo WITH EMPTY KEY.

    DATA voos_para_atualizar TYPE ty_voo_tab.

    SELECT f~carrier_id    AS companhia,
           f~connection_id AS conexao,
           f~flight_date   AS data_voo,
           f~price         AS preco,
           c~distance      AS distancia

    FROM /dmo/flight AS f
    INNER JOIN /dmo/connection AS c ON f~carrier_id    = c~carrier_id
                                    AND f~connection_id = c~connection_id
    WHERE f~carrier_id = 'UA'
    AND c~distance > 1000

    INTO TABLE @voos_para_atualizar.

    LOOP AT voos_para_atualizar ASSIGNING FIELD-SYMBOL(<fs_flight>).
      <fs_flight>-preco = <fs_flight>-preco * '1.10'.
      out->write( |Preço atualizado para voo { <fs_flight>-companhia }-{ <fs_flight>-conexao }| ).
    ENDLOOP.


 ENDMETHOD.
ENDCLASS.

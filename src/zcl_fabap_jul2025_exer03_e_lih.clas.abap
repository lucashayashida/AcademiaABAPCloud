CLASS zcl_fabap_jul2025_exer03_e_lih DEFINITION
                                     PUBLIC
                                     FINAL
                                     CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXER03_E_LIH IMPLEMENTATION.


    METHOD if_oo_adt_classrun~main.
        SELECT *
        FROM zi_fabap_jul2025_exer01_lih
        INTO TABLE @DATA(lt_view1).

        out->write( lt_view1 ).

        out->write( | | ). " Imprime uma linha em branco
        out->write( '========================================================================' ).
        out->write( | | ). " Imprime outra linha em branco

        SELECT *
        FROM zi_fabap_jul2025_exer02_lih
        INTO TABLE @DATA(lt_view2).

        out->write( lt_view2 ).


         out->write( | | ). " Imprime uma linha em branco
         out->write( '========================================================================' ).
         out->write( | | ). " Imprime outra linha em branco


        SELECT *
        FROM zi_fabap_jul2025_exer03_lih
        INTO TABLE @DATA(lt_view3).

        out->write( lt_view3 ).



    ENDMETHOD.
ENDCLASS.

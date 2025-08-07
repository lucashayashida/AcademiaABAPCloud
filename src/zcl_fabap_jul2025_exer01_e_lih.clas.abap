CLASS zcl_fabap_jul2025_exer01_e_lih DEFINITION
                                     PUBLIC
                                     FINAL
                                     CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXER01_E_LIH IMPLEMENTATION.


    METHOD if_oo_adt_classrun~main.

        out->write( |--- Apple Celular ---| ).

        DATA(lo_produto) = NEW zcl_fabap_jul2025_exer01_lih( iv_codigo = 'PROD-001'
                                                             iv_nome = 'Iphone 15'
                                                             iv_preco = '4800.00' ).

        lo_produto->adicionar_estoque( 10 ).

        out->write( |Produto:        { lo_produto->get_nome( ) }| ).

        out->write( |Código:         { lo_produto->get_codigo( ) }| ).

        out->write( |Preço unitário: { lo_produto->get_preco( ) }| ).

        out->write( |Estoque atual:  { lo_produto->get_estoque( ) }| ).



        IF lo_produto->remover_estoque( 7 ) = abap_true.
            out->write( |Estoque removido!| ).
            out->write( |Novo estoque: { lo_produto->get_estoque( ) }| ).
        ELSE.
            out->write( |Estoque insuficiente!| ).
        ENDIF.


        IF lo_produto->remover_estoque( 10 ) = abap_true.
            out->write( |Estoque removido!| ).
            out->write( |Novo estoque: { lo_produto->get_estoque( ) }| ).
        ELSE.
            out->write( |Estoque insuficiente!| ).
        ENDIF.


        DATA(lv_valor_total) = lo_produto->calcular_valor_total( ).
            out->write( |Valor total no estoque: { lv_valor_total }| ).



    ENDMETHOD.
ENDCLASS.

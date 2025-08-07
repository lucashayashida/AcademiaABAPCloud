CLASS zcl_fabap_jul2025_exer01_lih DEFINITION
                                   PUBLIC
                                   FINAL
                                   CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor IMPORTING iv_codigo TYPE string
                                  iv_nome   TYPE string
                                  iv_preco  TYPE decfloat16.

    METHODS adicionar_estoque IMPORTING iv_quantidade TYPE i.

    METHODS remover_estoque IMPORTING iv_quantidade   TYPE i
                          RETURNING VALUE(rv_sucesso) TYPE abap_bool.

    METHODS calcular_valor_total RETURNING VALUE(rv_valor_total) TYPE decfloat16.

    METHODS get_nome RETURNING VALUE(rv_nome) TYPE string.

    METHODS get_codigo RETURNING VALUE(rv_codigo) TYPE string.

    METHODS get_preco RETURNING VALUE(rv_preco) TYPE decfloat16.

    METHODS get_estoque RETURNING VALUE(rv_estoque) TYPE i.

  PROTECTED SECTION.

  PRIVATE SECTION.

       DATA mv_codigo TYPE string.
       DATA mv_nome TYPE string.
       DATA mv_preco TYPE decfloat16.
       DATA mv_estoque TYPE i.


ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXER01_LIH IMPLEMENTATION.


    METHOD adicionar_estoque.

        mv_estoque += iv_quantidade.

    ENDMETHOD.


    METHOD calcular_valor_total.

        rv_valor_total = mv_preco * mv_estoque.
    ENDMETHOD.


    METHOD constructor.

        mv_codigo = iv_codigo.
        mv_nome = iv_nome.
        mv_preco = iv_preco.
        mv_estoque = 0.

    ENDMETHOD.


    METHOD get_codigo.
        rv_codigo = mv_codigo.
    ENDMETHOD.


    METHOD get_estoque.
        rv_estoque = mv_estoque.
    ENDMETHOD.


    METHOD get_nome.
        rv_nome = mv_nome.
    ENDMETHOD.


    METHOD get_preco.
        rv_preco = mv_preco.
    ENDMETHOD.


    METHOD remover_estoque.

        IF iv_quantidade >= mv_estoque.
           mv_estoque = mv_estoque - iv_quantidade.
           rv_sucesso = abap_true.
        ELSE.
           rv_sucesso = abap_false.
        ENDIF.
    ENDMETHOD.
ENDCLASS.

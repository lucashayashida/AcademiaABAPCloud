CLASS zcl_fabap_jul2025_exer03_lih DEFINITION
                                   PUBLIC
                                   FINAL
                                   CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXER03_LIH IMPLEMENTATION.


    METHOD if_oo_adt_classrun~main.
        DATA lt_funcionarios TYPE TABLE OF REF TO lcl_funcionario.
        DATA lo_funcionario TYPE REF TO lcl_funcionario.


        lo_funcionario = lcl_factory=>create_funcionario(
          iv_tipo = 'INTEGRAL'
          iv_nome = 'Livia'
          iv_id = 'FUN-001'
          iv_salario_base = '3600.00'
          iv_bonus = '400.00' ).

    APPEND lo_funcionario TO lt_funcionarios.

        lo_funcionario = lcl_factory=>create_funcionario(
          iv_tipo = 'HORISTA'
          iv_nome = 'Apolo'
          iv_id = 'FUN-002'
          iv_salario_base = '50.00'
          iv_horas = 180 ).

    APPEND lo_funcionario TO lt_funcionarios.

        LOOP AT lt_funcionarios INTO lo_funcionario.
          out->write( lo_funcionario->exibir_dados( ) ).
          out->write( |Salário calculado: { lo_funcionario->calcular_salario( ) }| ).
          out->write( '--------------------------------' ).
        ENDLOOP.
    ENDMETHOD.
ENDCLASS.

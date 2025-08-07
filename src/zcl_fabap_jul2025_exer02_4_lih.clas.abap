CLASS zcl_fabap_jul2025_exer02_4_lih DEFINITION
                                     PUBLIC
                                     FINAL
                                     CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXER02_4_LIH IMPLEMENTATION.


    METHOD if_oo_adt_classrun~main.

        DATA lt_funcionarios TYPE TABLE OF REF TO zcl_fabap_jul2025_exer02_lih.

        DATA(lo_integral) = NEW zcl_fabap_jul2025_exer02_2_lih( iv_nome = 'Livia'
                                                                iv_id = 'FUN-001'
                                                                iv_salario_base = '3600.00'
                                                                iv_bonus = '400' ).

        DATA(lo_horista) = NEW zcl_fabap_jul2025_exer02_3_lih( iv_nome = 'Apolo'
                                                               iv_id = 'FUN-002'
                                                               iv_salario_base = '50'
                                                               iv_horas = 180 ).

        APPEND lo_integral TO lt_funcionarios.
        APPEND lo_horista TO lt_funcionarios.

        LOOP AT lt_funcionarios INTO DATA(lo_funcionario).
            out->write( lo_funcionario->exibir_dados(  ) ).
            out->write( |Salário Calculado: { lo_funcionario->calcular_salario(  ) }| ).
            out->write( | ______________________ | ).
        ENDLOOP.

    ENDMETHOD.
ENDCLASS.

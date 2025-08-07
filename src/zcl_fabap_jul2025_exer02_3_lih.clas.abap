CLASS zcl_fabap_jul2025_exer02_3_lih DEFINITION
                                     PUBLIC
                                      INHERITING FROM zcl_fabap_jul2025_exer02_lih
                                     FINAL
                                     CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor IMPORTING iv_nome         TYPE string
                                  iv_id           TYPE string
                                  iv_salario_base TYPE decfloat16
                                  iv_horas        TYPE decfloat16 OPTIONAL.

    METHODS calcular_salario REDEFINITION.

  PROTECTED SECTION.

  PRIVATE SECTION.
  DATA mv_horas TYPE i.
ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXER02_3_LIH IMPLEMENTATION.


    METHOD calcular_salario.
        rv_salario = mv_salario_base * mv_horas.
    ENDMETHOD.


    METHOD constructor.
        super->constructor( iv_nome = iv_nome
                            iv_id = iv_id
                            iv_salario_base = iv_salario_base ).
        mv_horas = iv_horas.
    ENDMETHOD.
ENDCLASS.

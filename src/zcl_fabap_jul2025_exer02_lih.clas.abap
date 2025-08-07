CLASS zcl_fabap_jul2025_exer02_lih DEFINITION
                                   PUBLIC

                                   CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor IMPORTING iv_nome TYPE string
                                  iv_id TYPE string
                                  iv_salario_base TYPE decfloat16.

    METHODS calcular_salario RETURNING VALUE(rv_salario) TYPE decfloat16.

    METHODS exibir_dados RETURNING VALUE(rv_dados)   TYPE string.
  PROTECTED SECTION.
    DATA mv_nome         TYPE string.
    DATA mv_id           TYPE string.
    DATA mv_salario_base TYPE decfloat16.

  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXER02_LIH IMPLEMENTATION.


    METHOD calcular_salario.

        rv_salario = mv_salario_base.

    ENDMETHOD.


    METHOD constructor.

        mv_nome = iv_nome.
        mv_id = iv_id.
        mv_salario_base = iv_salario_base.

    ENDMETHOD.


    METHOD exibir_dados.

        rv_dados = |ID: { mv_id }, Nome { mv_nome }, Salário Base { mv_salario_base }|.

    ENDMETHOD.
ENDCLASS.

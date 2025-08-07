*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_funcionario DEFINITION
                       CREATE PUBLIC.

 PUBLIC SECTION.
    METHODS constructor IMPORTING iv_nome         TYPE string
                                  iv_id           TYPE string
                                  iv_salario_base TYPE decfloat16.

    METHODS exibir_dados RETURNING VALUE(rv_dados) TYPE string.

    METHODS calcular_salario RETURNING VALUE(rv_salario) TYPE decfloat16.

 PROTECTED SECTION.
    DATA mv_nome TYPE string.
    DATA mv_id TYPE string.
    DATA mv_salario_base TYPE decfloat16.

 PRIVATE SECTION.

ENDCLASS.

CLASS lcl_funcionario IMPLEMENTATION.

    METHOD calcular_salario.
    rv_salario = mv_salario_base.
    ENDMETHOD.

    METHOD exibir_dados.
    rv_dados = |Nome: { mv_nome }, ID: { mv_id }, Salário Base: { mv_salario_base }|.
    ENDMETHOD.

    METHOD constructor.
        mv_nome = iv_nome.
        mv_id = iv_id.
        mv_salario_base = iv_salario_base.
    ENDMETHOD.

 ENDCLASS.

***********************************************************************

CLASS lcl_funcionario_integral DEFINITION

  INHERITING FROM lcl_funcionario
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor IMPORTING iv_nome         TYPE string
                                  iv_id           TYPE string
                                  iv_salario_base TYPE decfloat16
                                  iv_bonus        TYPE decfloat16 OPTIONAL.
    METHODS calcular_salario REDEFINITION.
  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: mv_bonus TYPE decfloat16.
ENDCLASS.




CLASS lcl_funcionario_integral IMPLEMENTATION.
    METHOD constructor.

    super->constructor( iv_nome = iv_nome
                        iv_id = iv_id
                        iv_salario_base = iv_salario_base ).
    mv_bonus = iv_bonus.

    ENDMETHOD.

    METHOD calcular_salario.

        rv_salario = mv_salario_base + mv_bonus.

    ENDMETHOD.

ENDCLASS.

**********************************************************************

CLASS lcl_funcionario_horista DEFINITION
  INHERITING FROM lcl_funcionario FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS constructor IMPORTING iv_nome         TYPE string
                                  iv_id           TYPE string
                                  iv_salario_base TYPE decfloat16
                                  iv_horas        TYPE i OPTIONAL.

    METHODS calcular_salario REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: mv_horas TYPE i.
ENDCLASS.


CLASS lcl_funcionario_horista IMPLEMENTATION.
  METHOD constructor.

    super->constructor( iv_nome = iv_nome
    iv_id = iv_id
    iv_salario_base = iv_salario_base ).
    mv_horas = iv_horas.

  ENDMETHOD.

  METHOD calcular_salario.

    rv_salario = mv_salario_base * mv_horas.

  ENDMETHOD.

ENDCLASS.

**********************************************************************

CLASS lcl_factory DEFINITION CREATE PRIVATE.
  PUBLIC SECTION.
    CLASS-METHODS create_funcionario
      IMPORTING
                iv_tipo               TYPE string
                iv_nome               TYPE string
                iv_id                 TYPE string
                iv_salario_base       TYPE decfloat16
                iv_bonus              TYPE decfloat16   OPTIONAL
                iv_horas              TYPE i            OPTIONAL

      RETURNING VALUE(ro_funcionario) TYPE REF TO lcl_funcionario.
ENDCLASS.

CLASS lcl_factory IMPLEMENTATION.
  METHOD create_funcionario.

    CASE iv_tipo.
      WHEN 'INTEGRAL'.
        ro_funcionario = NEW lcl_funcionario_integral(
          iv_nome = iv_nome
          iv_id = iv_id
          iv_salario_base = iv_salario_base
          iv_bonus = iv_bonus ).
      WHEN 'HORISTA'.
        ro_funcionario = NEW lcl_funcionario_horista(
                                                      iv_nome = iv_nome
                                                      iv_id = iv_id
                                                      iv_salario_base = iv_salario_base
                                                      iv_horas = iv_horas ).
      WHEN OTHERS.
        ro_funcionario = NEW lcl_funcionario( iv_nome = iv_nome
                                                        iv_id = iv_id
                                                        iv_salario_base = iv_salario_base ).
    ENDCASE.

  ENDMETHOD.

ENDCLASS.

CLASS zcl_aj_demo_sideeffect DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_sd_determination .
    INTERFACES if_sd_feature_control .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_AJ_DEMO_SIDEEFFECT IMPLEMENTATION.


  METHOD if_sd_determination~run.

    DATA input TYPE zcl_aj_demo_input=>input.

    IF determination_kind <> if_sd_determination=>kind-after_update.
      RETURN.
    ENDIF.

    model->get_as_structure(
      IMPORTING
        result = input
    ).
*    CATCH cx_sd_invalid_data.

    CASE    determination_kind.
     WHEN if_sd_determination=>kind-after_update.

        input-se_output = |{ input-output_format }:{ strlen( input-se_input ) }|.
     WHEN if_sd_determination=>kind-after_create.
        DATA(actual_index) = lines( input-table_input ).

        LOOP AT input-table_input REFERENCE INTO DATA(line).
            line->int_number = actual_index.
            actual_index -= 1.
        ENDLOOP.

  ENDCASE.

*    input-se_output = strlen( input-se_input ).

    result = input.

  ENDMETHOD.


  METHOD if_sd_feature_control~run.
  ENDMETHOD.
ENDCLASS.

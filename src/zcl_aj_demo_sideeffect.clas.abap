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



CLASS zcl_aj_demo_sideeffect IMPLEMENTATION.


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
    input-se_output = strlen( input-se_input ).

    result = input.

  ENDMETHOD.


  METHOD if_sd_feature_control~run.
  ENDMETHOD.
ENDCLASS.

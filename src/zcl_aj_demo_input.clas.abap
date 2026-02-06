CLASS zcl_aj_demo_input DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_aia_sd_action_input .

    CONSTANTS : BEGIN OF output_enum,
                  "! <p class="shorttext"> Plain text </p>
                  text TYPE string VALUE 'TEXT',

                  "! <p class="shorttext">HTML</p>
                  html TYPE string VALUE 'HTML',

                  "! <p class="shorttext">CODE</p>
                  code TYPE string VALUE 'CODE',
                END OF output_enum.

    "! @values { @link zcl_aj_demo_input.data:output_enum }
    "! @default { @link zcl_aj_demo_input.data:output_enum.text }
    TYPES output_format TYPE string.

    TYPES :
      "! <p class="shorttext">Choose your action</p>
      BEGIN OF input,

        "! <p class="shorttext"> Output of the IDE Action<p>
        output_format     TYPE output_format,

        "! <p class="shorttext"> VH: Core Data Service<p>
        code_data_service TYPE string,

        "! <p class="shorttext">VH: Custom<p>
        custom            TYPE string,

        "! <p class="shorttext">Side-Effect: Input<p>
        se_input          TYPE string,

        "! <p class="shorttext">Side-Effect: Output<p>
        se_output         TYPE string,

      END OF input.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_aj_demo_input IMPLEMENTATION.


  METHOD if_aia_sd_action_input~create_input_config.

    DATA : input TYPE input.

    DATA(configuration) = ui_information_factory->get_configuration_factory( )->create_for_data( data = input ).

    configuration->get_element( 'CODE_DATA_SERVICE' )->set_types(
      EXPORTING
        types  = VALUE #( ( `DDLS/DF` ) )
*      RECEIVING
*        result =
    ).

    configuration->get_element( 'CUSTOM' )->set_values( if_sd_config_element=>values_kind-domain_specific_named_items ).

    configuration->get_element( 'SE_INPUT' )->set_sideeffect( after_update = abap_true ).

    configuration->get_element( 'SE_OUTPUT' )->set_read_only(  ).

    RETURN ui_information_factory->for_abap_type(
             abap_type     = input
             configuration = configuration
           ).



  ENDMETHOD.


  METHOD if_aia_sd_action_input~get_action_provider.
  ENDMETHOD.


  METHOD if_aia_sd_action_input~get_side_effect_provider.

    result = cl_sd_sideeffect_provider=>create( determination = NEW zcl_aj_demo_sideeffect( ) feature_control = NEW zcl_aj_demo_sideeffect( ) ).

  ENDMETHOD.


  METHOD if_aia_sd_action_input~get_value_help_provider.

    result = cl_sd_value_help_provider=>create( NEW zcl_aj_demo_value_provider(  ) ).

  ENDMETHOD.
ENDCLASS.

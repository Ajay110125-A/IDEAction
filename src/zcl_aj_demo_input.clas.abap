CLASS zcl_aj_demo_input DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_aia_sd_action_input .

    CONSTANTS : BEGIN OF output_enum,

                  "! <p class="shorttext">Plain text</p>
                  text TYPE string VALUE 'TEXT',

                  "! <p class="shorttext">HTML</p>
                  html TYPE string VALUE 'HTML',

                  "! <p class="shorttext">Code Change</p>
                  code TYPE string VALUE 'CODE',

                END OF output_enum.

    "! $values { @link zcl_aj_demo_input.data:output_enum }
    "! $default { @link zcl_aj_demo_input.data:output_enum.text }
    TYPES output_format TYPE string.

    TYPES : BEGIN OF tab_line,

              "! <p class="shorttext">Key</p>
              key_field  TYPE c LENGTH 15,

              "! <p class="shorttext">Number</p>
              int_number TYPE i,

              "! <p class="shorttext">Long text</p>
              long_text  TYPE string,

            END OF tab_line.

    TYPES table_body TYPE STANDARD TABLE OF tab_line WITH EMPTY KEY.

    TYPES :
      "! <p class="shorttext">Choose your action</p>
      BEGIN OF input,

        "! <p class="shorttext">Choose an output</p>
        output_format     TYPE output_format,

        "! <p class="shorttext"> VH: Class<p>
        vh_class TYPE string,

        "! <p class="shorttext">VH: Method<p>
        vh_method            TYPE string,

        "! <p class="shorttext">VH: Parameter<p>
        vh_parameter            TYPE string,

        "! <p class="shorttext">Side-Effect: Input<p>
        se_input          TYPE string,

        "! <p class="shorttext">Side-Effect: Output<p>
        se_output         TYPE string,

        table_input       TYPE table_body,


      END OF input.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_AJ_DEMO_INPUT IMPLEMENTATION.


  METHOD if_aia_sd_action_input~create_input_config.

    DATA : input TYPE input.

    DATA(configuration) = ui_information_factory->get_configuration_factory( )->create_for_data( data = input ).
    configuration->set_layout(  if_sd_config_element=>layout-grid  ).

    configuration->get_element( `OUTPUT_FORMAT` )->set_sideeffect( after_update = abap_true ).

    configuration->get_element( 'VH_CLASS' )->set_types( types  = VALUE #( ( `CLAS/OC` ) ) ).

    configuration->get_element( 'VH_METHOD' )->set_values( if_sd_config_element=>values_kind-domain_specific_named_items ).

    configuration->get_element( 'VH_PARAMETER' )->set_values(  if_sd_config_element=>values_kind-domain_specific_named_items  ).

    configuration->get_element( 'SE_INPUT' )->set_sideeffect( after_update = abap_true ).

    configuration->get_element( 'SE_OUTPUT' )->set_read_only(  ).

    DATA(table) = configuration->get_structured_table( 'TABLE_INPUT' ).

    table->set_layout(
                       type = if_sd_config_element=>layout-table
                       collapsed = if_sd_config_element=>true
                     ).

    DATA(structure) = table->get_line_structure(  ).

    structure->get_element( 'LONG_TEXT' )->set_multiline( height = if_sd_config_element=>height-medium ).
    structure->get_element( 'INT_NUMBER' )->set_read_only(  ).

    structure->set_sideeffect( after_create = abap_true ).

    INSERT VALUE #( key_field = 'ABC' long_text = 'This is a longer text' ) INTO TABLE input-table_input.

    RETURN ui_information_factory->for_abap_type(
             abap_type     = input
             configuration = configuration
           ).



  ENDMETHOD.


  METHOD if_aia_sd_action_input~get_action_provider.
  ENDMETHOD.


  METHOD if_aia_sd_action_input~get_side_effect_provider.

    result = cl_sd_sideeffect_provider=>create(
                                                determination = NEW zcl_aj_demo_sideeffect( )
                                                feature_control = NEW zcl_aj_demo_sideeffect( )
                                              ).

  ENDMETHOD.


  METHOD if_aia_sd_action_input~get_value_help_provider.

    result = cl_sd_value_help_provider=>create( NEW zcl_aj_demo_value_provider(  ) ).

  ENDMETHOD.
ENDCLASS.

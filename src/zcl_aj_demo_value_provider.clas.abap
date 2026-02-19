CLASS zcl_aj_demo_value_provider DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_sd_value_help_dsni .
  PROTECTED SECTION.

    TYPES : items TYPE STANDARD TABLE OF if_sd_value_help_dsni=>ty_named_item WITH EMPTY KEY.

    METHODS get_method
      IMPORTING input         TYPE zcl_aj_demo_input=>input
      RETURNING VALUE(result) TYPE items.

    METHODS get_parameter
      IMPORTING input        TYPE zcl_aj_demo_input=>input
      RETURNING VALUE(result) TYPE items.


  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_AJ_DEMO_VALUE_PROVIDER IMPLEMENTATION.


  METHOD if_sd_value_help_dsni~get_value_help_items.

    DATA : items TYPE items,
           input TYPE zcl_aj_demo_input=>input.

    IF  value_help_id = 'VH_METHOD'.

      items = get_method( input ).

    ELSEIF value_help_id = 'VH_PARAMETER'.

      items = get_parameter( input ).

    ENDIF.

*    items = VALUE #(
*                    ( name = 'ZABC' description = 'Small Value' )
*                    ( name = 'ZDEF' description = 'Middle Value' )
*                    ( name = 'ZGHI' description = 'High Value' )
*                   ).

    result = VALUE #( items = items total_item_count = lines( items ) ).




  ENDMETHOD.


  METHOD get_method.

    IF input-vh_class IS INITIAL.
      RETURN.
    ENDIF.

    DATA(class) = xco_cp_abap=>class( CONV #( input-vh_class ) ).

    DATA(public_records) = class->definition->section-public->components->method->all->get(  ).

    LOOP AT public_records INTO DATA(method).

      INSERT VALUE #(  ) INTO TABLE result REFERENCE INTO DATA(result_entry).

      result_entry->name = method->name.
      result_entry->description = method->content(  )->get(  )-short_description.

    ENDLOOP.

  ENDMETHOD.


  METHOD get_parameter.

    IF input-vh_parameter IS INITIAL.
        RETURN.
    ENDIF.

    DATA(class) = xco_cp_abap=>class( CONV #( input-vh_class ) ).

    DATA(method) = class->definition->section-public->component->method( CONV #( input-vh_method ) ).

    LOOP AT method->importing_parameters->all->get(  ) INTO DATA(parameter).

        INSERT VALUE #(  ) INTO TABLE result REFERENCE INTO DATA(result_entry).

        result_entry->name = parameter->name.
        result_entry->description = parameter->content(  )->get(  )-typing_definition->get_value( ).

    ENDLOOP.

  ENDMETHOD.
ENDCLASS.

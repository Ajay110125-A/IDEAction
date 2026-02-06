CLASS zcl_aj_demo_value_provider DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_sd_value_help_dsni .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_aj_demo_value_provider IMPLEMENTATION.


  METHOD if_sd_value_help_dsni~get_value_help_items.

    DATA : items TYPE STANDARD TABLE OF if_sd_value_help_dsni=>ty_named_item.

    items = VALUE #(
                    ( name = 'ZABC' description = 'Small Value' )
                    ( name = 'ZDEF' description = 'Middle Value' )
                    ( name = 'ZGHI' description = 'High Value' )
                   ).

    result = VALUE #( items = items total_item_count = lines( items ) ).




  ENDMETHOD.
ENDCLASS.

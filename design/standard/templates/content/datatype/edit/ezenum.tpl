{* DO NOT EDIT THIS FILE! Use an override template instead. *}
{default attribute_base=ContentObjectAttribute}
{switch match=$attribute.content.enum_ismultiple}
  {case match=1}
      {switch match=$attribute.content.enum_isoption}
        {case match=0}
          {section name=EnumList loop=$attribute.content.enum_list}
            <input type="hidden" name="{$attribute_base}_data_enumid_{$attribute.id}[]" value="{$EnumList:item.id}" />
            <input type="hidden" name="{$attribute_base}_data_enumvalue_{$attribute.id}[]" value="{$EnumList:item.enumvalue|wash}" />
        <input type="hidden" name="{$attribute_base}_data_enumelement_{$attribute.id}[]" value="{$EnumList:item.enumelement|wash}" />
    <p><label>
     <input id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}_{$EnumList:index}" class="ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="checkbox" name="{$attribute_base}_select_data_enumelement_{$attribute.id}[]" value="{$EnumList:item.enumelement|wash}"
      {section name=EnumObjectList loop=$attribute.content.enumobject_list}
        {if $EnumList:item.enumelement|eq($EnumList:EnumObjectList:item.enumelement)}
           checked="checked"
        {/if}
      {/section}
        />&nbsp;{$EnumList:item.enumelement|wash}</label></p>
      {/section}
       {/case}
       {case match=1}
          {section name=EnumList loop=$attribute.content.enum_list}
      <input type="hidden" name="{$attribute_base}_data_enumid_{$attribute.id}[]" value="{$EnumList:item.id}" />
      <input type="hidden" name="{$attribute_base}_data_enumvalue_{$attribute.id}[]" value="{$EnumList:item.enumvalue|wash}" />
      <input type="hidden" name="{$attribute_base}_data_enumelement_{$attribute.id}[]" value="{$EnumList:item.enumelement|wash}" />
      {/section}
      <select id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}" class="ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" name="{$attribute_base}_select_data_enumelement_{$attribute.id}[]" size="4" multiple >
      {section name=EnumList loop=$attribute.content.enum_list}
        <option name="{$attribute_base}_data_enumelement_{$attribute.id}[]" value="{$EnumList:item.enumelement|wash}" {section name=ObjectList loop=$attribute.content.enumobject_list show=$attribute.content.enumobject_list}
{if eq($EnumList:item.enumelement,$EnumList:ObjectList:item.enumelement)}selected="selected"{/if} {/section}>{$EnumList:item.enumelement}</option>
          {/section}
      </select>
       {/case}
       {case}{/case}
     {/switch}
  {/case}
  {case match=0}

      {switch match=$attribute.content.enum_isoption}

        {case match=0}
          {section name=EnumList loop=$attribute.content.enum_list}
        <input type="hidden" name="{$attribute_base}_data_enumid_{$attribute.id}[]" value="{$EnumList:item.id}" />
        <input type="hidden" name="{$attribute_base}_data_enumvalue_{$attribute.id}[]" value="{$EnumList:item.enumvalue|wash}" />
        <input type="hidden" name="{$attribute_base}_data_enumelement_{$attribute.id}[]" value="{$EnumList:item.enumelement|wash}" />
        <p><label>
        <input id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}_{$EnumList:index}" class="ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="radio" name="{$attribute_base}_select_data_enumelement_{$attribute.id}[]" value="{$EnumList:item.enumelement|wash}"
          {section name=EnumObjectList loop=$attribute.content.enumobject_list}

            {if $EnumList:item.enumelement|eq($EnumList:EnumObjectList:item.enumelement)}
           checked="checked"
            {/if}

          {/section}
            />&nbsp;{$EnumList:item.enumelement}</label></p>
          {/section}
        {/case}
        {case match=1}

      {section name=EnumList loop=$attribute.content.enum_list}
        <input type="hidden" name="{$attribute_base}_data_enumid_{$attribute.id}[]" value="{$EnumList:item.id}" />
            <input type="hidden" name="{$attribute_base}_data_enumvalue_{$attribute.id}[]" value="{$EnumList:item.enumvalue|wash}" />
        <input type="hidden" name="{$attribute_base}_data_enumelement_{$attribute.id}[]" value="{$EnumList:item.enumelement|wash}" />
      {/section}

          <select id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}" class="ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" name="{$attribute_base}_select_data_enumelement_{$attribute.id}[]">
      {section name=EnumList loop=$attribute.content.enum_list}
         {section name=ObjectList loop=$attribute.content.enumobject_list show=$attribute.content.enumobject_list}
         <option name="{$attribute_base}_data_enumelement_{$attribute.id}[]" value="{$EnumList:item.enumelement|wash}" {if eq($EnumList:item.enumelement,$EnumList:ObjectList:item.enumelement)}selected="selected"{/if}>{$EnumList:item.enumelement}</option>
         {section-else}
         <option name="{$attribute_base}_data_enumelement_{$attribute.id}[]" value="{$EnumList:item.enumelement|wash}">{$EnumList:item.enumelement}</option>
         {/section}

      {/section}
      </select>
        {/case}
    {case}{/case}
      {/switch}
   {/case}
   {case}{/case}
{/switch}
{/default}

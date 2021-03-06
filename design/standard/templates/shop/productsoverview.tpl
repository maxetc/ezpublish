{* DO NOT EDIT THIS FILE! Use an override template instead. *}
<form name="productsoverview" action={'shop/productsoverview'|ezurl} method="post">

<div class="maincontentheader">
    <h1>{'Products overview'|i18n( 'design/standard/shop/productsoverview' )}</h1>
</div>


{def $sort_by = array()
     $product_list = false()
     $product_list_count = 0
     $product_class_list_valid = and( is_array( $product_class_list ), count( $product_class_list ) )
     $sorting_field_list = hash( 'none', 'None'|i18n( 'design/standard/shop/productsoverview' ),
                                 'name', 'Name'|i18n( 'design/standard/shop/productsoverview' ),
                                 'price', 'Price'|i18n( 'design/standard/shop/productsoverview' ) )}

{* fetch products of $product_class class *}
{if $product_class}
    {if eq( $sorting_field, 'name' )}
        {set sort_by = array( 'name', $sorting_order )}
    {elseif eq( $sorting_field, 'price' ) }
        {set sort_by = array( 'attribute', $sorting_order, concat( $product_class.identifier, '/', $price_attribute_identifier ) )}
    {/if}

    {set product_list_count = fetch( 'content', 'tree_count', hash( 'parent_node_id', 2,
                                                'main_node_only', true(),
                                                'class_filter_type', 'include',
                                                'class_filter_array', array( $product_class.id ) ) ) }
{/if}

{* show list of products *}
{if $product_list_count}

{set product_list = fetch( 'content', 'tree', hash( 'parent_node_id', 2,
                                                    'sort_by', $sort_by,
                                                    'main_node_only', true(),
                                                    'offset', $view_parameters.offset,
                                                    'limit', $limit,
                                                    'class_filter_type', 'include',
                                                    'class_filter_array', array( $product_class.id ) ) )}

{def $currency_code = $product_list[0].data_map[$price_attribute_identifier].content.currency
     $currency = false()
     $locale = false()
     $symbol = false()}

{if $currency_code}
    {set currency = fetch( 'shop', 'currency', hash( 'code', $currency_code ) )}
{/if}

{if $currency}
    {set symbol = $currency.symbol
         locale = $currency.locale}
{/if}

{* Items per page selector. *}
    <p>
    {switch match=$limit}

        {case match=25}
        <a href={'/user/preferences/set/productsoverview_list_limit/1'|ezurl} title="{'Show 10 items per page.'|i18n( 'design/standard/shop/productsoverview' )}">10</a>
        <span class="current">25</span>
        <a href={'/user/preferences/set/productsoverview_list_limit/3'|ezurl} title="{'Show 50 items per page.'|i18n( 'design/standard/shop/productsoverview' )}">50</a>
        {/case}

        {case match=50}
        <a href={'/user/preferences/set/productsoverview_list_limit/1'|ezurl} title="{'Show 10 items per page.'|i18n( 'design/standard/shop/productsoverview' )}">10</a>
        <a href={'/user/preferences/set/productsoverview_list_limit/2'|ezurl} title="{'Show 25 items per page.'|i18n( 'design/standard/shop/productsoverview' )}">25</a>
        <span class="current">50</span>
        {/case}

        {case}
        <span class="current">10</span>
        <a href={'/user/preferences/set/productsoverview_list_limit/2'|ezurl} title="{'Show 25 items per page.'|i18n( 'design/standard/shop/productsoverview' )}">25</a>
        <a href={'/user/preferences/set/productsoverview_list_limit/3'|ezurl} title="{'Show 50 items per page.'|i18n( 'design/standard/shop/productsoverview' )}">50</a>
        {/case}

        {/switch}
    </p>

<table class="list" cellspacing="0">
<tr>
    <th>{'Name'|i18n( 'design/standard/shop/productsoverview' )}</th>
    <th>{'Price'|i18n( 'design/standard/shop/productsoverview' )}</th>
</tr>

{foreach $product_list as $product sequence array( bglight, bgdark ) as $bg_class_style}
    <tr class="{$bg_class_style}">
        <td><a href={$product.path_identification_string|ezurl}>{$product.object.name|wash()}</a></td>
        <td>{$product.data_map[$price_attribute_identifier].content.inc_vat_price|l10n('currency', $locale, $symbol )}</td>
    </tr>
{/foreach}

</table>

{include name=navigator
         uri='design:navigator/google.tpl'
         page_uri=concat( '/shop/productsoverview/(product_class)/', $product_class.identifier)
         item_count=$product_list_count
         view_parameters=$view_parameters
         item_limit=$limit}

{else}
    <div class="block">
    <p>{'The product list is empty.'|i18n( 'design/standard/shop/productsoverview' )}</p>
    </div>
{/if}

{* Button bar for filter and sorting. *}
<div class="block">
    {if $product_class_list_valid}
        <div class="left">
            <select name="ProductClass" title="{'Select product class.'|i18n( 'design/standard/shop/productsoverview' )}">
                {foreach $product_class_list as $class}
                    <option value="{$class.identifier}" {if and( $product_class, eq( $class.identifier, $product_class.identifier ))}selected="selected"{/if}>{$class.name|wash()}</option>
                {/foreach}
            </select>
            {* Show button *}
            <input class="button" type="submit" name="ShowProductsButton" value="{'Show products'|i18n( 'design/standard/shop/productsoverview' )}" title="{'Show products of selected class.'|i18n( 'design/standard/shop/productsoverview' )}" />
        </div>
        <div class="right">
            <select name="SortingField" title="{'Select sorting field.'|i18n( 'design/standard/shop/productsoverview' )}">
                {foreach $sorting_field_list as $field => $fieldTitle}
                    <option value="{$field}" {if eq( $sorting_field, $field)}selected="selected"{/if}>{$fieldTitle}</option>
                {/foreach}
            </select>

            <select name="SortingOrder" title="{'Select sorting order.'|i18n( 'design/standard/shop/productsoverview' )}">
                <option value="0" {if eq( $sorting_order, 0)}selected="selected"{/if}>{'Descending'|i18n( 'design/standard/shop/productsoverview' )}</option>
                <option value="1" {if eq( $sorting_order, 1)}selected="selected"{/if}>{'Ascending'|i18n( 'design/standard/shop/productsoverview' )}</option>
            </select>

            {* Sort button *}
            <input class="button" type="submit" name="SortButton" value="{'Sort products'|i18n( 'design/standard/shop/productsoverview' )}" title="{'Sort products.'|i18n( 'design/standard/shop/productsoverview' )}" />
        </div>
    {/if}

</div>


<input type="hidden" name="Offset" value="{$view_parameters.offset}" />

</form>


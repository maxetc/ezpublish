{* Relations windows. *}
<div class="context-block">

{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">

<h2 class="context-title">{'Relations [%relation_count]'|i18n( 'design/admin/node/view/full',, hash( '%relation_count', sum( $node.object.related_contentobject_count, $node.object.reverse_related_contentobject_count ) ) )}</h2>

{* DESIGN: Subline *}<div class="header-subline"></div>

{* DESIGN: Header END *}</div></div></div></div></div></div>

{* DESIGN: Content START *}<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-bl"><div class="box-br"><div class="box-content">

{* Related objects list. *}
<table class="list" cellspacing="0">
<tr>
    <th>{'Related objects [%related_objects_count]'|i18n( 'design/admin/node/view/full',, hash( '%related_objects_count', $node.object.related_contentobject_count ) )}</th>
    {section show=$node.object.related_contentobject_count}
    <th>{'Type'|i18n( 'design/admin/node/view/full' )}</th>
    {/section}
</tr>
{section show=$node.object.related_contentobject_count}
    {section var=RelatedObjects loop=$node.object.related_contentobject_array sequence=array( bglight, bgdark )}
        <tr class="{$RelatedObjects.sequence}">

        {* Name. *}
        <td>{$RelatedObjects.item.content_class.identifier|class_icon( small, $RelatedObjects.item.content_class.name )}&nbsp;{content_view_gui view=text_linked content_object=$RelatedObjects.item}</td>

        {* Type. *}
        {section show=$node.object.related_contentobject_count}
        <td>{$RelatedObjects.content_class.name|wash}</td>
        {/section}

        </tr>
{/section}
{section-else}
<tr><td>{'The item being viewed does not make use of any other objects.'|i18n( 'design/admin/node/view/full' )}</td></tr>
{/section}
</table>

{* Reverse related objects list. *}
<table class="list" cellspacing="0">
<tr>
    <th>{'Reverse related objects'|i18n( 'design/admin/node/view/full' )} [{$node.object.reverse_related_contentobject_count}]</th>
    {section show=$node.object.reverse_related_contentobject_count}
    <th>{'Type'|i18n( 'design/admin/node/view/full' )}</th>
    {/section}
</tr>
{section show=$node.object.reverse_related_contentobject_count}
    {section var=ReverseRelatedObjects loop=$node.object.reverse_related_contentobject_array sequence=array( bglight, bgdark )}
        <tr class="{$ReverseRelatedObjects.sequence}">

        {* Name. *}
        <td>{$ReverseRelatedObjects.content_class.identifier|class_icon( small, $ReverseRelatedObjects.item.content_class.name )}&nbsp;{content_view_gui view=text_linked content_object=$ReverseRelatedObjects.item}</td>

        {* Type. *}
        {section show=$node.object.reverse_related_contentobject_count}
        <td>{$ReverseRelatedObjects.content_class.name|wash}</td>
        {/section}

        </tr>
    {/section}
{section-else}
<tr><td>{'The item being viewed is not in use by any other objects.'|i18n( 'design/admin/node/view/full' )}</td></tr>
{/section}
</table>

{* DESIGN: Content END *}</div></div></div></div></div></div>

</div>

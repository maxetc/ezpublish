{* DO NOT EDIT THIS FILE! Use an override template instead. *}
{section name=Author loop=$attribute.content.author_list }
{$Author:item.name|wash(xhtml)} - ( {**REMOVE**}{$Author:item.email|wash(email)}{**/REMOVE**}{**ADD**{raw escape_email(tc_access('design/standard/templates/content/datatype/view/plain/ezauthor.tpl:manual0', $Author_item, 'email'))}**/ADD**} )
{delimiter},{/delimiter}
{/section}

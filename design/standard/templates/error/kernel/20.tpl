<div class="warning">
<h2>{"Module not found"|i18n("design/standard/error/kernel")}</h2>
<p>{"The requested module '%1' could not be found."|i18n("design/standard/error/kernel",,array($parameters.module|wash))}</p>
<p>{"Possible reasons for this is."|i18n("design/standard/error/kernel")}</p>
<ul>
    <li>{"The module name was misspelled, try changing the url."|i18n("design/standard/error/kernel")}</li>
    <li>{"The module does not exist on this site."|i18n("design/standard/error/kernel")}</li>
    <li>{"This site uses siteaccess matching in the url and you didn't supply one, try inserting a siteaccess name before the module in the url ."|i18n("design/standard/error/kernel")}</li>
</ul>
</div>

{section show=$embed_content}

{$embed_content}
{/section}

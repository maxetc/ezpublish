<form method="post" action={concat("/section/edit/",$section.id,"/")|ezurl}>

<div class="maincontentheader">
<h1>Section edit</h1>
</div>

<input type="hidden" name="SectionID" value="{$section.id}" />

<div class="block">
<label>Name:</label><div class="labelbreak"></div>
<input class="box" type="text" name="Name" value="{$section.name}" />
</div>

{*
<div class="block">
<label>Locale:</label><div class="labelbreak"></div>
<input class="box" type="text" name="Locale" value="{$section.locale}" />
</div>
*}
<div class="buttonblock">
<input class="button" type="submit" name="StoreButton" value="Store" />
</div>

</form>
{* DO NOT EDIT THIS FILE! Use an override template instead. *}
<form action={concat($module.functions.process.uri,"/",$process.id)|ezurl} method="post" name="WorkflowProcess">

<h1>{"Workflow process"|i18n("design/standard/workflow")} {$process.id}</h1>

<p>
{"Workflow process was created at %creation and modified at %modification."|i18n("design/standard/workflow",,hash('%creation',$process.created|l10n(shortdatetime),'%modification',$process.modified|l10n(shortdatetime)))}
</p>

<h2>{"Workflow"|i18n("design/standard/workflow")}</h2>
<p>
{"Using workflow"|i18n("design/standard/workflow")} <b><a href={concat($module.functions.edit.uri,"/",$process.workflow_id)|ezurl}>{$current_workflow.name} ({$process.workflow_id})</a></b> {"for processing."|i18n("design/standard/workflow")}
</p>

<h2>{"User"|i18n("design/standard/workflow")}</h2>
<p>
{"This workflow is running for user"|i18n("design/standard/workflow")} <b>{$process.user.login}</b>.
</p>

<h2>{"Content object"|i18n("design/standard/workflow")}</h2>
<p>
{"Workflow was created for content"|i18n("design/standard/workflow")} <b><a href={concat("/content/view/",$process.content_id)|ezurl}>{$process.content.name}</a></b>
{"using version"|i18n("design/standard/workflow")} <b><a href={concat("/content/view/",$process.content_id,"/",$process.content_version)|ezurl}>{$process.content_version}</a></b>
{"in parent"|i18n("design/standard/workflow")} <b><a href={concat("/content/view/",$process.node_id)|ezurl}>{$process.node.name|wash}</a></b>
</p>

<h2>{"Workflow event"|i18n("design/standard/workflow")}</h2>
{if $current_event|not}
<p>
{"Workflow has not started yet, number of main events in workflow is"|i18n("design/standard/workflow")} <b>{$current_workflow.event_count}</b>.
</p>
{/if}
{if $current_event}
<p>
{"Current event position is"|i18n("design/standard/workflow")} <b>{$process.event_position}</b>.
{"Event to be run is"|i18n("design/standard/workflow")} <i>{$current_event.workflow_type.name}</i> {"event"|i18n("design/standard/workflow")} <b>{$current_event.description} ({$process.event_id})</b>.
</p>
{/if}

{if $event_status}
<p>
{"Last event returned status"|i18n("design/standard/workflow")} <b>{$event_status}.
</p>
{/if}

<h3>{"Workflow event list"|i18n("design/standard/workflow")}</h3>
{section name=Workflow loop=$current_workflow.ordered_event_list}
  {if eq($Workflow:number, $process.event_position)}
      <b>{$Workflow:number}: {$Workflow:item.workflow_type.name} - {$Workflow:item.description}</b><br/>
  {elseif eq($Workflow:number, $process.last_event_position)}
      <i>{$Workflow:number}: {$Workflow:item.workflow_type.name} - {$Workflow:item.description}</i><br/>
  {else}
      {$Workflow:number}: {$Workflow:item.workflow_type.name} - {$Workflow:item.description}<br/>
  {/if}
{/section}

<br/>

<table width="100%">
<tr>
<td>{include uri="design:gui/button.tpl" name=new id_name=Reset value="Reset"|i18n("design/standard/workflow")}</td>
<td>{include uri="design:gui/button.tpl" name=new id_name=RunProcess value="Next step"|i18n("design/standard/workflow")}</td>
<td width="99%" />
</tr>
</table>

</form>

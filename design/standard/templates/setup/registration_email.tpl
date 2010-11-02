{* DO NOT EDIT THIS FILE! Use an override template instead. *}
{set-block variable=subject}
eZ Publish {$version.text} site registration - {$site_type.title}
{/set-block}
Comments:
{$comments}

Site info:

  Site package  - {$site_type.identifier}
  Title         - {$site_type.title}
  URL           - {$site_type.url}
  Admin URL     - {$site_type.admin_url}
  Access type   - {$site_type.access_type}
  Access value  - {$site_type.access_type_value}
{*  Functionality - {$site_type.extra_functionality|implode( ', ' )*}


{if $webserver}
Web server info:
Version - {$webserver.version}
{/if}


PHP info:
Version - {$phpversion.found}

OS info
Name - {$os.name}

{if $system.is_valid}
CPU Type - {$system.cpu_type}
CPU Speed - {$system.cpu_speed} {$system.cpu_unit}
Memory Size - {$system.memory_size} ({$system.memory_size|si( byte )})

{/if}

Database info:
Type - {$database_info.info.name}
Driver - {$database_info.info.driver}


Email info:
Transport - {if eq($email_info.type,1)}sendmail{else}SMTP{/if}


Image conversion:

{if $imagemagick_program.result}
ImageMagick was found and used.
Path - {$imagemagick_program.path}
Executable - {$imagemagick_program.program}
{/if}


{if $imagegd_extension.result}
ImageGD extension was found and used.
{/if}


Regional info:
Primary - {$regional_info.primary_language}

{section show=$regional_info.languages}
Additional - {section name=Language loop=$regional_info.languages}{$:item}{delimiter}, {/delimiter}{/section}
{/section}


Critical tests

{section name=Critical loop=$tests_run}

{$:key} - {if $:item}Success{else}Failure{/if}

{/section}


Other tests:

{section name=Other loop=$optional_tests}

{$:item[1]} - {if eq($:item[0],1)}Success{else}Failure{/if}

{/section}
{**ADD**{return $subject}**/ADD**}

<?php
//
// Definition of eZWorkflowType class
//
// Created on: <16-Apr-2002 11:08:14 amos>
//
// Copyright (C) 1999-2002 eZ systems as. All rights reserved.
//
// This source file is part of the eZ publish (tm) Open Source Content
// Management System.
//
// This file may be distributed and/or modified under the terms of the
// "GNU General Public License" version 2 as published by the Free
// Software Foundation and appearing in the file LICENSE.GPL included in
// the packaging of this file.
//
// Licencees holding valid "eZ publish professional licences" may use this
// file in accordance with the "eZ publish professional licence" Agreement
// provided with the Software.
//
// This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING
// THE WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
// PURPOSE.
//
// The "eZ publish professional licence" is available at
// http://ez.no/home/licences/professional/. For pricing of this licence
// please contact us via e-mail to licence@ez.no. Further contact
// information is available at http://ez.no/home/contact/.
//
// The "GNU General Public License" (GPL) is available at
// http://www.gnu.org/copyleft/gpl.html.
//
// Contact licence@ez.no if any conditions of this licencing isn't clear to
// you.
//

//!! eZKernel
//! The class eZWorkflowType does
/*!

*/

include_once( "kernel/classes/ezworkflow.php" );
include_once( "lib/ezutils/classes/ezdebug.php" );

define( "EZ_WORKFLOW_TYPE_STATUS_NONE", 0 );
define( "EZ_WORKFLOW_TYPE_STATUS_ACCEPTED", 1 );
define( "EZ_WORKFLOW_TYPE_STATUS_REJECTED", 2 );
define( "EZ_WORKFLOW_TYPE_STATUS_DEFERRED_TO_CRON", 3 );
define( "EZ_WORKFLOW_TYPE_STATUS_DEFERRED_TO_CRON_REPEAT", 4 );
define( "EZ_WORKFLOW_TYPE_STATUS_RUN_SUB_EVENT", 5 );
define( "EZ_WORKFLOW_TYPE_STATUS_WORKFLOW_CANCELLED", 6 );
define( "EZ_WORKFLOW_TYPE_STATUS_FETCH_TEMPLATE", 7 );
define( "EZ_WORKFLOW_TYPE_STATUS_WORKFLOW_DONE", 8 );

// include defined datatypes

$ini =& eZINI::instance();
$workflowTypes =& $GLOBALS["eZWorkflowTypes"];
$types = $ini->variableArray( "WorkflowSettings", "AvailableEventTypes" );

// foreach ( $availableTypes as $type )
// {
//     list( $group, $type ) = explode( "_", $type );
//     $includeFile = "kernel/classes/workflowtypes/$group/$type/" . $type . "type.php";
//     if ( file_exists( $includeFile ) )
//     {
//         include_once( $includeFile );
//     }
//     else
//     {
//         eZDebug::writeError( "Workflow type: $includeFile not found", "eZWorkflowType" );
//     }
// }

class eZWorkflowType
{
    function eZWorkflowType( $group, $type,
                             $groupName, $name )
    {
        $this->TypeGroup = $group;
        $this->TypeString = $type;
        $this->TypeString = $group . "_" . $type;
        $this->GroupName = $groupName;
        $this->Name = $name;
        $this->Information = "";
        $this->ActivationDate = null;
        $this->Attributes = array();
        $this->Attributes["group"] =& $this->Group;
        $this->Attributes["type"] =& $this->Type;
        $this->Attributes["type_string"] =& $this->TypeString;
        $this->Attributes["group_name"] =& $this->GroupName;
        $this->Attributes["name"] =& $this->Name;
        $this->Attributes["information"] =& $this->Information;
        $this->Attributes["activation_date"] =& $this->ActivationDate;
    }

    function statusName( $status )
    {
        $statusNames =& $GLOBAL["eZWorkflowTypeStatusNames"];
        if ( !is_array( $statusNames ) )
        {
            $statusNames = array( EZ_WORKFLOW_TYPE_STATUS_NONE => "No state yet",
                                  EZ_WORKFLOW_TYPE_STATUS_ACCEPTED => "Accepted event",
                                  EZ_WORKFLOW_TYPE_STATUS_REJECTED => "Rejected event",
                                  EZ_WORKFLOW_TYPE_STATUS_DEFERRED_TO_CRON => "Event deferred to cron job",
                                  EZ_WORKFLOW_TYPE_STATUS_DEFERRED_TO_CRON_REPEAT => "Event deferred to cron job, event will be rerun",
                                  EZ_WORKFLOW_TYPE_STATUS_RUN_SUB_EVENT => "Event runs a sub event",
                                  EZ_WORKFLOW_TYPE_STATUS_WORKFLOW_CANCELLED => "Cancelled whole workflow" );
        }
        if ( isset( $statusNames[$status] ) )
            return $statusNames[$status];
        return false;
    }

    function &createType( $typeString )
    {
        $types =& $GLOBALS["eZWorkflowTypes"];
//        print( '<br>' );
//        var_dump( $types );
//        print( '<br>' );
//        var_dump( $typeString );
        
        $def = null;
        if ( !isset( $types[$typeString] ) )
        {
            $result = eZWorkflowType::loadAndRegisterType( $typeString );
            if ( $result === false )
                return null;
        }
        if ( isset( $types[$typeString] ) )
        {
            $type_def =& $types[$typeString];
            $class_name = $type_def["class_name"];

            $def =& $GLOBALS["eZWorkflowTypeObjects"][$typeString];
            if ( get_class( $def ) != $class_name )
            {
                eZDebug::writeNotice( "Created type: $typeString", "eZWorkflowType::createType" );
                if ( class_exists( $class_name ) )
                    $def = new $class_name();
                else
                    eZDebug::writeError( "Undefined event type class: $class_name", "eZWorkflowType::createType" );
            }
        }
        else
            eZDebug::writeError( "Undefined type: $typeString", "eZWorkflowType::createType" );
        return $def;
    }

    function &fetchRegisteredTypes()
    {
        eZWorkflowType::loadAndRegisterAllTypes();
        $definition_objects =& $GLOBALS["eZWorkflowTypeObjects"];
        $types =& $GLOBALS["eZWorkflowTypes"];
        if ( is_array( $types ) )
        {
            foreach ( $types as $typeString => $type_def )
            {
                $class_name = $type_def["class_name"];
                $def =& $definition_objects[$typeString];
                if ( get_class( $def ) != $class_name )
                {
                    eZDebug::writeNotice( "Created list type: $typeString", "eZWorkflowType::fetchRegisteredTypes" );
                    if ( class_exists( $class_name ) )
                        $def = new $class_name();
                    else
                        eZDebug::writeError( "Undefined event type class: $class_name", "eZWorkflowType::fetchRegisteredTypes" );
                }
            }
        }
        return $definition_objects;
    }

    function allowedTypes()
    {
        $allowedTypes =& $GLOBALS["eZWorkflowAllowedTypes"];
        if ( !is_array( $allowedTypes ) )
        {
            $ini =& eZINI::instance();
            $eventTypes = $ini->variableArray( "WorkflowSettings", "AvailableEventTypes" );
            $workflowTypes = $ini->variableArray( "WorkflowSettings", "AvailableWorkflowTypes" );
            $allowedTypes = array_unique( array_merge( $eventTypes, $workflowTypes ) );
        }
        return $allowedTypes;
    }

    function loadAndRegisterAllTypes()
    {
        $allowedTypes =& eZWorkflowType::allowedTypes();
        foreach( $allowedTypes as $type )
        {
            eZWorkflowType::loadAndRegisterType( $type );
        }
    }

    function registerType( $group, $type, $class_name )
    {
        $typeString = $group . "_" . $type;
        $types =& $GLOBALS["eZWorkflowTypes"];
        if ( !is_array( $types ) )
            $types = array();
        if ( isset( $types[$typeString] ) )
        {
            eZDebug::writeError( "Type already registered: $typeString", "eZWorkflowType::registerType" );
        }
        else
        {
            eZDebug::writeNotice( "Registered type: $typeString", "eZWorkflowType::registerType" );
            $types[$typeString] = array( "class_name" => $class_name );
        }
    }

    function loadAndRegisterType( $typeString )
    {
        $types =& $GLOBALS["eZWorkflowTypes"];
        if ( isset( $types[$typeString] ) )
            return null;
        list( $group, $type ) = explode( "_", $typeString );
        $includeFile = "kernel/classes/workflowtypes/$group/$type/" . $type . "type.php";
        if ( !file_exists( $includeFile ) )
        {
            eZDebug::writeError( "Workflow type not found: $typeString, include file $includeFile could not be found", "eZWorkflowType::loadAndRegisterType" );
            return false;
        }
        include_once( $includeFile );
        return true;
    }


    function &attributes()
    {
        return array_merge( array_keys( $this->Attributes ), "description" );
    }

    function hasAttribute( $attr )
    {
        return ( $attr == "description" or
                 isset( $this->Attributes[$attr] ) );
    }

    function &attribute( $attr )
    {
        if ( $attr == "description" )
            return $this->eventDescription();
        if ( isset( $this->Attributes[$attr] ) )
            return $this->Attributes[$attr];
        else
            return null;
    }

    function &eventDescription()
    {
        return $this->Attributes["name"];
    }

    function execute( &$process, &$event )
    {
        return EZ_WORKFLOW_TYPE_STATUS_NONE;
    }

    function initializeEvent( &$event )
    {
    }

    function validateHTTPInput( &$http, $base, &$event )
    {
        return EZ_INPUT_VALIDATOR_STATE_ACCEPTED;
    }

    function fixupHTTPInput( &$http, $base, &$event )
    {
        return true;
    }

    function fetchHTTPInput( &$http, $base, &$event )
    {
    }

    function setActivationDate( $date )
    {
        $this->ActivationDate = $date;
    }

    function setInformation( $inf )
    {
        $this->Information = $inf;
    }

    /// \privatesection
    var $Group;
    var $Type;
    var $TypeString;
    var $GroupName;
    var $Name;
    var $ActivationDate;
    var $Information;
}

class eZWorkflowEventType extends eZWorkflowType
{
    function eZWorkflowEventType( $typeString, $name )
    {
        $this->eZWorkflowType( "event", $typeString, "Event", $name );
    }

    function registerType( $typeString, $class_name )
    {
        eZWorkflowType::registerType( "event", $typeString, $class_name );
    }
}

class eZWorkflowGroupType extends eZWorkflowType
{
    function eZWorkflowGroupType( $typeString, $name )
    {
        $this->eZWorkflowType( "group", $typeString, "Group", $name );
    }

    function registerType( $typeString, $class_name )
    {
        eZWorkflowType::registerType( "group", $typeString, $class_name );
    }
}

?>

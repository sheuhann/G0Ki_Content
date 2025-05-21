{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.1",
  "parameters": {
    "workspaceName": {
      "type": "string",
      "metadata": {
        "description": "soc-azure"
      }
    }
  },
  "resources": [
    {
      "type": "Microsoft.OperationalInsights/workspaces/providers/scheduledQueryRules",
      "apiVersion": "2021-08-01",
      "name": "[concat(parameters('workspaceName'), '/Microsoft.SecurityInsights/nrtSecurityEventLogCleared')]",
      "location": "[resourceGroup().location]",
      "properties": {
        "description": "Detects when a security event log is cleared in Windows, indicating potential DefenseEvasion.",
        "displayName": "CodeBasedAR - NRT Security Event log cleared",
        "enabled": true,
        "query": "SecurityEvent | where EventID == 1102 | where EventData contains \"log cleared\"",
        "severity": "Medium",
        "tactics": ["DefenseEvasion"],
        "techniques": ["T1070"],
        "entityMappings": [
          {
            "entityType": "Account",
            "fieldMappings": [
              {
                "identifier": "FullName",
                "columnName": "Account"
              }
            ]
          },
          {
            "entityType": "Host",
            "fieldMappings": [
              {
                "identifier": "FullName",
                "columnName": "Computer"
              }
            ]
          }
        ],
        "queryFrequency": "PT5M",
        "queryPeriod": "PT5M",
        "triggerOperator": "GreaterThan",
        "triggerThreshold": 0,
        "kind": "Scheduled",
        "customDetails": null,
        "templateName": "NRT Security Event log cleared",
        "templateVersion": "1.0.1",
        "sourceName": "Windows Security Events"
      }
    }
  ]
}
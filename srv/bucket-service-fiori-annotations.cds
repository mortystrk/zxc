using BucketService from './portfolio-service';

annotate BucketService.Buckets with @(
	UI : {
		HeaderInfo: {
			TypeName: 'Buckets',
			TypeNamePlural: 'Bucket',
			Title: { Value: 'Buckets' }
		},
		
		SelectionFields: [
			type,
			status,
			startDate,
			endDate,
			owner
		],
		
		LineItem: [
			{ $Type: 'UI.DataField', Value: name },
			{ $Type: 'UI.DataField', Value: referenceNumber },
			//{ $Type: 'UI.DataField', Value: portfolio.name, Label: 'Parent Portfolio' },
			{ $Type: 'UI.DataField', Value: type },
			//{ $Type: 'UI.DataField', Value: requestor },
			{ $Type: 'UI.DataField', Value: startDate },
			{ $Type: 'UI.DataField', Value: endDate },
			{ $Type: 'UI.DataField', Value: owner },
			{ $Type: 'UI.DataField', Value: status }
		],
		
		PresentationVariant: {
			SortOrder: [ 
				{ $Type: 'Common.SortOrderType', Property: name, Descending: false }
			]
		}
	},
	
	UI: {
		HeaderFacets: [
			{ $Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#HeaderInfo', "@UI.Importance": #High }
		],
		FieldGroup#HeaderInfo: {
			Data: [
				{ $Type: 'UI.DataField', Value: budget },
				{ $Type: 'UI.DataField', Value: plannedCosts },
				{ $Type: 'UI.DataField', Value: actualCosts }
			]
		}
	},
	
	UI: {
		Facets: [
			{ $Type: 'UI.ReferenceFacet', Label: 'General Info', Target: '@UI.FieldGroup#GeneralInfo' },
			{ $Type: 'UI.ReferenceFacet', Label: 'Info', Target: '@UI.FieldGroup#Info' },
			{ $Type: 'UI.ReferenceFacet', Label: 'Financial Info', Target: '@UI.FieldGroup#FinancialInfo' }
		],
		
		FieldGroup#GeneralInfo: {
			Data: [
				{ $Type: 'UI.DataField', Value: name },
				{ $Type: 'UI.DataField', Value: referenceNumber },
				{ $Type: 'UI.DataField', Value: description },
				{ $Type: 'UI.DataField', Value: projectManager },
				{ $Type: 'UI.DataField', Value: startDate },
				{ $Type: 'UI.DataField', Value: plannedEndDate }
			]
		},
		
		FieldGroup#Info: {
			Data: [
				{ $Type: 'UI.DataField', Value: createdAt/*, Label: 'Created On:' */},
				{ $Type: 'UI.DataField', Value: createdBy/*, Label: 'Created By:' */},
				{ $Type: 'UI.DataField', Value: modifiedAt/*, Label: 'Changed On:' */},
				{ $Type: 'UI.DataField', Value: modifiedBy/*, Label: 'Changed By:' */}
			]
		},
		
		FieldGroup#FinancialInfo: {
			Data: [
				{ $Type: 'UI.DataField', Value: budget/*, Label: 'Budget:' */},
				{ $Type: 'UI.DataField', Value: plannedCosts/*, Label: 'Planned Cost:' */},
				{ $Type: 'UI.DataField', Value: actualCosts/*, Label: 'Actual Cost:' */}
			]
		}
	}
)
{
	name
	@title: 'Name';
	referenceNumber
	@title: 'Reference Number';
	type
	@title: 'Type';
	priority
	@title: 'Priority';
	status
	@title: 'Status';
	stage
	@title: 'Stage';
	projectManager
	@title: 'Project Manager';
	budget
	@title: 'Budget';
	plannedCosts
	@title: 'Planned Cost';
	actualCosts
	@title: 'Actual Cost';
	createdAt
	@title: 'Created On';
	createdBy
	@title: 'Created By';
	modifiedAt
	@title: 'Changed On';
	modifiedBy
	@title: 'Changed By';
	description
	@title: 'Description';
	startDate
	@title: 'Start Date';
	endDate
	@title: 'End Date';
};

/*annotate PfmService.Buckets with @(
// ---------------------------------------------------------------------------
// List Report
// ---------------------------------------------------------------------------
		UI: {
		HeaderInfo: {
			TypeName: '{i18n>portfolios}',
			TypeNamePlural: '{i18n>portfolios}',
			Title: { Value: '{i18n>portfolios}' }
		},
		// Filter Bar
		SelectionFields: [
			name,
			referenceNumber
		],
		
		enableBasicSearch: false,
		// columns in list
		LineItem: [
			{ $Type: 'UI.DataField', Value: name },
			{ $Type: 'UI.DataField', Value: referenceNumber },
			{ $Type: 'UI.DataField', Value: type },
			{ $Type: 'UI.DataField', Value: status },
			{ $Type: 'UI.DataField', Value: owner },
			{ $Type: 'UI.DataField', Value: startDate },
			{ $Type: 'UI.DataField', Value: endDate },
			{ $Type: 'UI.DataField', Value: createdAt },
			{ $Type: 'UI.DataField', Value: createdBy },
			{ $Type: 'UI.DataField', Value: modifiedAt },
			{ $Type: 'UI.DataField', Value: modifiedBy },
		],
		// definition of default sort column
		PresentationVariant: {
			SortOrder: [ 
				{ $Type: 'Common.SortOrderType', Property: name, Descending: false },
				{ $Type: 'Common.SortOrderType', Property: owner, Descending: false }
			]
		}
	},
	
	UI: {
		
		HeaderFacets: [
			{ $Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#SystemAdministration', "@UI.Importance": #High }
		],
		FieldGroup#SystemAdministration: {
			Data: [
				{ $Type: 'UI.DataField', Value: createdAt },
				{ $Type: 'UI.DataField', Value: createdBy },
				{ $Type: 'UI.DataField', Value: modifiedAt },
				{ $Type: 'UI.DataField', Value: modifiedBy }
			],
			Label: 'System Administration'
		}
	},
	
	// Page Facets
	UI: {
		Facets: [
			{ $Type: 'UI.ReferenceFacet', Label: 'Details', Target: '@UI.FieldGroup#Details' },
			{ $Type: 'UI.ReferenceFacet', Label: 'Projects', Target: 'projects/@UI.LineItem' }
		],
		FieldGroup#Details: {
			Data: [
				{ $Type: 'UI.DataField', Value: name },
				{ $Type: 'UI.DataField', Value: referenceNumber },
				{ $Type: 'UI.DataField', Value: type },
				{ $Type: 'UI.DataField', Value: status },
				{ $Type: 'UI.DataField', Value: owner }
			],
			Label: 'Details'
		},
		
		FieldGroup#Projects: {
			Data: [
				{ $Type: 'UI.ReferenceFacet', Label: 'Projects', Target: 'Buckets/projects/@UI.LineItem'}
			],
			Label: 'Projects'
		}
	}
)
{

	projects @(
		UI.LineItem: [
			{ $Type: 'UI.DataField', Value: name },
			{ $Type: 'UI.DataField', Value: referenceNumber },
			{ $Type: 'UI.DataField', Value: owner }
		]
	);
	
	name
		@title: 'Name'
		@Common.FieldControl: #ReadOnly;
	owner
		@title: 'Owner'
		@Common.FieldControl: #ReadOnly;
	description
		@title: 'Description'
		@Common.FieldControl: #ReadOnly;
	type
		@title: 'Type'
		@Common.FieldControl: #ReadOnly;
	budget
		@title: 'Budget'
		@Common.FieldControl: #ReadOnly;
	plannedCosts
		@title: 'Planned Costs'
		@Common.FieldControl: #ReadOnly;
	actualCosts
		@title: 'Actual Costs'
		@Common.FieldControl: #ReadOnly;
	startDate
		@title: 'Start Date'
		@Common.FieldControl: #ReadOnly;
	endDate
		@title: 'End Date'
		@Common.FieldControl: #ReadOnly;
	referenceNumber
		@title: 'Reference Number'
		@Common.FieldControl: #ReadOnly;
	status
		@title: 'Status'
		@Common.FieldControl: #ReadOnly
}*/
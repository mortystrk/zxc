using BucketService from './portfolio-service';

annotate BucketService.Projects with @(
){
	portfolio @(
		Common.Text: {
            $value:"portfolio/name",
            "@UI.TextArrangement": #TextOnly
        },
        Common.ValueList: {
        	CollectionPath: 'Portfolios',
        	SearchSupported: true,
        	Parameters: [
        		{ $Type: 'Common.ValueListParameterInOut', LocalDataProperty: 'portfolio_ID', ValueListProperty: 'ID' },
        		{ $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'name'}
        	]
        },
        Common.ValueListWithFixedValues : 'true'
	)
};

annotate BucketService.Projects with @(
){
	parent @(
		Common.Text: {
            $value:"parent/name",
            "@UI.TextArrangement": #TextOnly
        },
		Common.ValueList: {
			CollectionPath: 'Buckets',
			SearchSupported: true,
			Parameters: [
				{ $Type: 'Common.ValueListParameterInOut', LocalDataProperty: 'parent_ID', ValueListProperty: 'ID' },
				{ $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'name'}
			]
		},
        Common.ValueListWithFixedValues : 'true'
	)
}

annotate BucketService.Projects with @(
	UI : {
		HeaderInfo: {
			TypeName: 'Project',
			TypeNamePlural: 'Projects',
			Title: { Value: name }
		},
		
		SelectionFields: [
			type,
			priority,
			status,
			stage,
			projectManager
		],
		
		LineItem: {
			"@UI.Criticality": criticaly,
			$value: [
				{ $Type: 'UI.DataField', Value: name },
				{ $Type: 'UI.DataField', Value: referenceNumber },
				{ $Type: 'UI.DataFieldWithUrl', Value: name, Url: 'https://www.google.com' },
				{ $Type: 'UI.DataField', Value: portfolio.name, Label: 'Portfolio' },
				{ $Type: 'UI.DataField', Value: parent.name, Label: 'Parent Object' },
				{ $Type: 'UI.DataField', Value: type },
			//{ $Type: 'UI.DataField', Value: requestor },
				{ $Type: 'UI.DataField', Value: priority },
				{ $Type: 'UI.DataField', Value: status },
				{ $Type: 'UI.DataField', Value: stage },
				{ $Type: 'UI.DataField', Value: projectManager }
			]
		} ,
		
		PresentationVariant: {
			SortOrder: [ 
				{ $Type: 'Common.SortOrderType', Property: name, Descending: false }
			]
		}
	},
	
	UI: {
		HeaderFacets: [
			//{ $Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#HeaderInfo', "@UI.Importance": #High }
			{
				$Type: 'UI.CollectionFacet',
				isSummary: true,
				Facets: [
					{ $Type: 'UI.ReferenceFacet', Label: 'Info1', Target: '@UI.FieldGroup#Header1' },
					{ $Type: 'UI.ReferenceFacet', Label: 'Info2', Target: '@UI.FieldGroup#Header2' }
				],
				ID: 'CollFacetTest',
				Label: 'Header'
			},
			{ $Type: 'UI.ReferenceFacet', Target: '@UI.DataPoint#TestDataPoint' }
		],
			FieldGroup#Header1: {
			Data: [
				{ $Type: 'UI.DataField', Value: budget }
			]
			},
			FieldGroup#Header2: {
			Data: [
				{ $Type: 'UI.DataField', Value: plannedCosts },
				{ $Type: 'UI.DataField', Value: actualCosts }
			]
			},
			DataPoint#TestDataPoint: {
			Value: budget,
			Title: 'Budget',
			Criticality: criticaly
		}
		/*FieldGroup#HeaderInfo: {
			Data: [
				{ $Type: 'UI.DataField', Value: budget },
				{ $Type: 'UI.DataField', Value: plannedCosts },
				{ $Type: 'UI.DataField', Value: actualCosts }
			]
		}*/
	},
	
	UI: {
		Facets: [
			{
				$Type: 'UI.CollectionFacet',
				Facets: [
					{ $Type: 'UI.ReferenceFacet', Label: 'Info1', Target: '@UI.FieldGroup#Info1' },
					{ $Type: 'UI.ReferenceFacet', Label: 'Info2', Target: '@UI.FieldGroup#Info2' }
				],
				ID: 'CollFacetTest',
				Label: 'General Info2'
			},
			{ $Type: 'UI.ReferenceFacet', Label: 'General Info', Target: '@UI.FieldGroup#GeneralInfo' },
			{ $Type: 'UI.ReferenceFacet', Label: 'Info', Target: '@UI.FieldGroup#Info' },
			{ $Type: 'UI.ReferenceFacet', Label: 'Financial Info', Target: '@UI.FieldGroup#FinancialInfo' }
		],
		
		FieldGroup#GeneralInfo: {
			Data: [
				{ $Type: 'UI.DataField', Value: name },
				{ $Type: 'UI.DataField', Value: referenceNumber },
				{ $Type: 'UI.DataField', Value: description },
				{ $Type: 'UI.DataField', Value: projectManager, DefaultValue: 'Margarita' },
				{ $Type: 'UI.DataField', Value: plannedStartDate },
				{ $Type: 'UI.DataField', Value: plannedEndDate },
				{ $Type: 'UI.DataField', Value: portfolio_ID, Label: 'Portfolio' },
				{ $Type: 'UI.DataField', Value: parent_ID, Label: 'Parent Object' }
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
		
		FieldGroup#Info1: {
			Data: [
				{ $Type: 'UI.DataField', Value: createdAt/*, Label: 'Created On:' */},
				{ $Type: 'UI.DataField', Value: createdBy/*, Label: 'Created By:' */},
				{ $Type: 'UI.DataField', Value: modifiedAt/*, Label: 'Changed On:' */},
				{ $Type: 'UI.DataField', Value: modifiedBy/*, Label: 'Changed By:' */}
			]
		},
		
		FieldGroup#Info2: {
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
	@title: 'Description'
	@UI.MultiLineText: true;
	plannedStartDate
	@title: 'Start Date';
	plannedEndDate
	@title: 'End Date';
	portfolio
	@title: 'Portfolio'
	@Common.FieldControl: #Mandatory;
	parent
	@title: 'Parent Object'
	@Common.FieldControl: #Mandatory;
};
/*annotate PfmService.Project with @(
// ---------------------------------------------------------------------------
// List Report
// ---------------------------------------------------------------------------
	UI: {
		HeaderInfo: {
			TypeName: 'Projects',
			TypeNamePlural: 'Projects',
			Title: { Value: 'Projects' }
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
			{ $Type: 'UI.DataField', Value: parent.name, Label: 'Parent object' },
			{ $Type: 'UI.DataField', Value: referenceNumber },
			{ $Type: 'UI.DataField', Value: type },
			{ $Type: 'UI.DataField', Value: status },
			{ $Type: 'UI.DataField', Value: owner },
			{ $Type: 'UI.DataField', Value: plannedStartDate },
			{ $Type: 'UI.DataField', Value: plannedEndDate },
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
	}
)
{
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
	plannedStartDate
		@title: 'Start Date'
		@Common.FieldControl: #ReadOnly;
	plannedEndDate
		@title: 'End Date'
		@Common.FieldControl: #ReadOnly;
	referenceNumber
		@title: 'Reference Number'
		@Common.FieldControl: #ReadOnly;
	status
		@title: 'Status'
		@Common.FieldControl: #ReadOnly
}*/
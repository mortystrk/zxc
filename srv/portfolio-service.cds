using { com.sap.pfm, sap.common } from '../db/data-model';
using com.sap.pfm as hierarchy from '../db/hierarchy-model';

service PfmService {

  	entity Portfolio as 
  		select from pfm.PortfolioObject[ wasRemoved = false ];
  		
  	entity Buck @readonly as 
  		projection on pfm.PortfolioObject;
	
	entity Portfolios as
  		select from pfm.PortfolioObject[ objectType = 'Portfolio' and wasRemoved = false ];
  		
	entity Buckets as
  		select from pfm.PortfolioObject[ objectType = 'Bucket' and wasRemoved = false ];

	entity PortfolioHierarchy @(title: 'Portfolio Hierarchy', readonly)
		as select from hierarchy.Hierarchy {
			@sap.hierarchy.node.for: 'ID'
			key ID,
			@sap.hierarchy.parent.node.for: 'ID'
			parentID,
			objectType,
			name,
			budget,
			plannedCosts,
			actualCosts,
			currency,
			@sap.hierarchy.level.for: 'ID'
			hierarchyLevel,
			@sap.hierarchy.drill.state.for: 'ID'
			drillState,
			createdAt
		} order by createdAt asc;
		
	entity PH @(title: 'Portfolio Hierarchy', readonly)
		as select from hierarchy.Hierarchy { key ID, parentID, objectType, createdAt };

    entity Project @( title: 'Project', Insertable, Updatable, Deletable ) 
            as select from pfm.Project[ wasRemoved = false ];
}

service SuperService {
	entity Super @readonly as projection on pfm.SuperEntity;
}

service BucketService {

	entity Portfolio as 
		select from pfm.PortfolioObject[ wasRemoved = false ] { *, parent: redirected to Portfolio, portfolio: redirected to Portfolio, children: redirected to Portfolio, projects: redirected to Projects };
	entity Portfolios as 
  		select from pfm.PortfolioObject[ objectType = 'Portfolio' and wasRemoved = false ] { *, parent: redirected to Portfolios, portfolio: redirected to Portfolios, children: redirected to Portfolios, projects: redirected to Projects };
	
	entity Buckets as 
  		select from pfm.PortfolioObject[ objectType = 'Bucket' and wasRemoved = false ] { *, parent: redirected to Buckets, portfolio: redirected to Buckets, children: redirected to Buckets, projects: redirected to Projects };
  		
  	entity Projects as
  		select from pfm.Project[ wasRemoved = false ] { *, parent: redirected to Portfolio, portfolio: redirected to Portfolios };
  		
}

annotate SuperService.Super with @(
	// ---------------------------------------------------------------------------
// List Report
// ---------------------------------------------------------------------------
	UI: {
		// Filter Bar
		SelectionFields: [
			entityInteger
		],
		// columns in list
		LineItem: [
			{ $Type: 'UI.DataField', Value: ID, Label:'ID' },
			{ $Type: 'UI.DataField', Value: enityName, Label:'Name' },
			{ $Type: 'UI.DataField', Value: parent.entityInteger, Label:'Parent Entity Integer' }
		],
		// definition of default sort column
		PresentationVariant: {
			SortOrder: [ 
				{ $Type: 'Common.SortOrderType', Property: entityInteger, Descending: false }
			]
		}
	}
);

/*annotate PfmService.Buck with @(
	
	UI: {
		// Filter Bar
		SelectionFields: [
			referenceNumber,
			type,
			startDate,
			owner,
			status
		],

		// columns in list
		LineItem: [
			{ $Type: 'UI.DataField', Value: name, Label: 'Name' },
			{ $Type: 'UI.DataField', Value: referenceNumber, Label: 'Reference Number' },
			{ $Type: 'UI.DataField', Value: parent.owner, Label: 'Parent' },
			{ $Type: 'UI.DataField', Value: type, Label: 'Type' },
			{ $Type: 'UI.DataField', Value: startDate, Label: 'Start Date' },
			{ $Type: 'UI.DataField', Value: endDate, Label: 'End Date' },
			{ $Type: 'UI.DataField', Value: owner, Label: 'Owner' },
			{ $Type: 'UI.DataField', Value: status, Label: 'Status' }
		],
		// definition of default sort column
		PresentationVariant: {
			SortOrder: [ 
				{ $Type: 'Common.SortOrderType', Property: name, Descending: false },
				{ $Type: 'Common.SortOrderType', Property: owner, Descending: false }
			]
		}
	}
);*/
/*annotate PfmService.Buckets with @(
// ---------------------------------------------------------------------------
// List Report
// ---------------------------------------------------------------------------
	UI: {
		HeaderInfo: {
			TypeName: 'Buckets', // i18n
			TypeNamePlural: 'Buckets',
			Title: { Value: 'Buckets' }
		},
		// Filter Bar
		SelectionFields: [
			referenceNumber,
			portfolio.name,
			type,
			startDate,
			owner,
			status
		],

		// columns in list
		LineItem: [
			{ $Type: 'UI.DataField', Value: name, Label: 'Name' },
			{ $Type: 'UI.DataField', Value: referenceNumber, Label: 'Reference Number' },
			{ $Type: 'UI.DataField', Value: parent.name, Label: 'Parent' },
			{ $Type: 'UI.DataField', Value: type, Label: 'Type' },
			{ $Type: 'UI.DataField', Value: startDate, Label: 'Start Date' },
			{ $Type: 'UI.DataField', Value: endDate, Label: 'End Date' },
			{ $Type: 'UI.DataField', Value: owner, Label: 'Owner' },
			{ $Type: 'UI.DataField', Value: status, Label: 'Status' }
		],
		// definition of default sort column
		PresentationVariant: {
			SortOrder: [ 
				{ $Type: 'Common.SortOrderType', Property: name, Descending: false },
				{ $Type: 'Common.SortOrderType', Property: owner, Descending: false }
			]
		}
	}/*,
	
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
			{ $Type: 'UI.ReferenceFacet', Label: 'Details', Target: '@UI.FieldGroup#Details' }
		],
		FieldGroup#Details: {
			Data: [
				{ $Type: 'UI.DataField', Value: name },
				{ $Type: 'UI.DataField', Value: referenceNumber },
				{ $Type: 'UI.DataField', Value: type },
				{ $Type: 'UI.DataField', Value: status },
				{ $Type: 'UI.DataField', Value: owner },
				{ $Type: 'UI.DataField', Value: objectType }
			],
			Label: 'Details'
		}
	}
);*/
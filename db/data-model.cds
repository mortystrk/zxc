namespace com.sap.pfm;

using { Currency, managed } from '@sap/cds/common';

type PortfolioObjectType : String(10) enum {
    Portfolio;
    Bucket;
}

type PortfolioObjectStatus : String(10) enum {
    Approved;
    Cancelled;
    Created;
    Deleted;
    InReview;
    OnHold;
}

type ProjectStatus : String(10) enum {
    Approved;
    Cancelled;
    Created;
    Deleted;
    InReview;
    OnHold;
}

entity PortfolioObject : managed {
	@sap.text: 'name'
    key ID              : UUID;
	name			    : String(256) not null;
    referenceNumber     : String(256);
    owner			    : String(256);
    description 	    : String(2000);
    budget			    : Decimal(12,2);//(23,3);
	type			    : String; // IT (default), Investment/Capital and so on
	@assert.enum
	objectType			: PortfolioObjectType not null;
	@assert.enum
	status			    : PortfolioObjectStatus default 'Created'; // 'Created', if no value is given
	startDate		    : Date; // The date when the portfolio object 'starts'
	endDate 		    : Date; // The date when the portfolio object 'ends'
	plannedCosts        : Decimal(12,2);//(23,3);
    actualCosts         : Decimal(12,2);//(23,3);
    currency			: Currency;
	hierarchyLevel      : Integer;
    hierarchyOrder      : Integer;
    wasRemoved			: Boolean default false; // mark entity as deleted (default false)
	parent			    : Association to PortfolioObject; // The parent portfolio object
	portfolio			: Association to PortfolioObject; // The portfolio object
	children			: Association to many PortfolioObject on children.parent = $self;
	projects		    : Association to many Project on projects.parent = $self; // The projects available within the portfolio objects
}

entity Project : managed {
    key ID              	: UUID;
    parent 					: Association to PortfolioObject not null; // The parent portfolio object
    portfolio				: Association to PortfolioObject not null; // The portfolio object
    type					: String; // The type of the project
    name			    	: String(256) not null;
    description 	    	: String(2000);
    @assert.enum
    status					: ProjectStatus default 'Created'; // 'Created', if no value is given
    referenceNumber     	: String(256);
    owner			    	: String(256);
    priority				: String;
    stage					: String;
    projectManager			: String;
    
    criticaly				: Integer;
    
    plannedStartDate		: Date; // The date when the project is planned to start
	plannedEndDate	    	: Date; // The date when the project is planned to finish
	actualStartDate			: Date; // The date when the project is planned to start
	actualEndDate	    	: Date; // The date when the project is planned to finish
//	@sap.unit: 'currency'
	budget			    	: Decimal(12,2);//(23,3);
//	@sap.unit: 'currency'
	plannedCosts        	: Decimal(12,2);//(23,3);
//	@sap.unit: 'currency'
    actualCosts     		: Decimal(12,2);//(23,3);
//    @sap.semantics: 'currency-code'
    currency				: Currency; //not null;
	wasRemoved				: Boolean default false; // mark entity as deleted (default false)
	virtual plannedDuration	: Integer; // The number of days the project will last
	virtual actualDuration	: Integer; // The number of days the project lasted
}


entity SuperEntity {
	key ID: Integer;
	enityName: String(20);
	entityInteger: Integer;
	entityDecimal: Decimal(20,0);
	parent: Association to SuperEntity;
}
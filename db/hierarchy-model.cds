namespace com.sap.pfm;

using com.sap.pfm as pfm from '../db/data-model';

// base view for portfolio
entity BasePortfolioObjectView as select from pfm.PortfolioObject[ wasRemoved = false ] {
	ID,
	parent.ID parentID,
	objectType,
    name,
    budget,
    plannedCosts,
    actualCosts,
    currency.code currency,
    hierarchyLevel,
    createdAt,
};

// workaround for joins: unmanaged associations are not supported
entity ProjectIDs as select from pfm.Project {
	ID,
	parent.ID parentID,
};

// base view for project
entity BaseProjectView as 
	select from pfm.Project[ wasRemoved = false ] prj
		inner join ProjectIDs pid on pid.ID = prj.ID
			left outer join BasePortfolioObjectView prt on prt.ID = pid.parentID {
	prj.ID ID,
	prj.parent.ID parentID,
	'Project' objectType: String(10),
	prj.name,
    prj.budget budget,
    prj.plannedCosts plannedCosts,
    prj.actualCosts actualCosts,
    prj.currency.code currency,
	case
		when prt.ID is null then null
        else prt.hierarchyLevel + 1
        end hierarchyLevel: Integer,
    prj.createdAt,
};

entity AllObjects as
	select from BasePortfolioObjectView
		union
	select from BaseProjectView;
	
entity ObjectsWithChildren as
	select from AllObjects p
		inner join AllObjects c on c.parentID = p.ID
	distinct { 
	p.ID ID
};
	
entity Hierarchy as
	select from AllObjects src
		left outer join ObjectsWithChildren chl on chl.ID = src.ID {
	src.ID ID,
	src.parentID parentID,
	src.objectType objectType,
	src.name name,
	src.budget budget,
	src.plannedCosts plannedCosts,
	src.actualCosts actualCosts,
	src.currency currency,
	src.hierarchyLevel hierarchyLevel,
	case
		when chl.ID is null then 'leaf'
        else 'expanded'
        end drillState: String(10),
    src.createdAt createdAt,
};
-- Logistics & Supply Chain Data Warehouse

-- Carrier Dimension
CREATE TABLE dwh.DimCarrier (
    CarrierKey BIGINT IDENTITY(1,1) PRIMARY KEY,
    CarrierID VARCHAR(50),
    CarrierName VARCHAR(200),
    CarrierType VARCHAR(50), -- LTL, FTL, Parcel, Air
    ServiceLevel VARCHAR(50),
    IsActive BIT
) WITH (DISTRIBUTION = REPLICATE);

-- Location Dimension
CREATE TABLE dwh.DimLocation (
    LocationKey BIGINT IDENTITY(1,1) PRIMARY KEY,
    LocationID VARCHAR(50),
    LocationName VARCHAR(200),
    LocationType VARCHAR(50), -- Warehouse, DC, Store
    Address VARCHAR(500),
    City VARCHAR(100),
    State VARCHAR(50),
    Country VARCHAR(100),
    ZipCode VARCHAR(20),
    Latitude DECIMAL(10,6),
    Longitude DECIMAL(10,6)
) WITH (DISTRIBUTION = REPLICATE);

-- Shipment Fact
CREATE TABLE dwh.FactShipment (
    ShipmentKey BIGINT IDENTITY(1,1),
    ShipmentID VARCHAR(100),
    OrderID VARCHAR(100),
    CarrierKey BIGINT,
    OriginLocationKey BIGINT,
    DestinationLocationKey BIGINT,
    ShipDate DATE,
    ScheduledDeliveryDate DATE,
    ActualDeliveryDate DATE,
    Weight DECIMAL(18,2),
    Volume DECIMAL(18,2),
    PackageCount INT,
    FreightCost DECIMAL(18,2),
    FuelSurcharge DECIMAL(18,2),
    TotalCost DECIMAL(18,2),
    Status VARCHAR(50),
    DeliveryDays INT,
    IsOnTime BIT,
    IsDelayed BIT,
    DelayReason VARCHAR(200)
) WITH (
    DISTRIBUTION = HASH(ShipmentID),
    CLUSTERED COLUMNSTORE INDEX
);

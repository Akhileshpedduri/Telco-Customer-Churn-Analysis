CREATE TABLE Customers (
    CustomerID      VARCHAR(50) PRIMARY KEY,
    Gender          VARCHAR(20),
    SeniorCitizen   BIT,
    Partner         VARCHAR(10),
    Dependents      VARCHAR(10)
);

CREATE TABLE Services (
    CustomerID          VARCHAR(50) PRIMARY KEY,
    Tenure              INT,
    PhoneService        VARCHAR(20),
    MultipleLines       VARCHAR(50),
    InternetService     VARCHAR(50),
    OnlineSecurity      VARCHAR(50),
    OnlineBackup        VARCHAR(50),
    DeviceProtection    VARCHAR(50),
    TechSupport         VARCHAR(50),
    StreamingTV         VARCHAR(50),
    StreamingMovies     VARCHAR(50),
    Contract            VARCHAR(50),
    PaperlessBilling    VARCHAR(10),
    PaymentMethod       VARCHAR(50),
    CONSTRAINT FK_Services_Customers FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
);

CREATE TABLE Billing_and_Churn (
    CustomerID        VARCHAR(50) PRIMARY KEY,
    MonthlyCharges    DECIMAL(10,2),
    TotalCharges      DECIMAL(10,2),
    Churn             VARCHAR(10),
    CONSTRAINT FK_Billing_Customers FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
);

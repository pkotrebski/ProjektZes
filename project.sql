/** 
	Still need to clarify the geo co-ordinates as the types given by Adrian are a bit ambigious i.e 
	INT when the co ordinates are divided into d - degrees(int),m - minutes(int) and s - seconds(float) with 
	the following format: dd:mm:s.sss
 	That is according to Google's definition of how the geo co ordinates are used.

	NOTE: 
	I think that it would be wise to send as much information as possible in one interaction. 
	This then negates the need to constantly query the database. The user can for example 
	download the information from the server's database in go, receive the data in a pre arranged 
	format i.e XML or JSON and then store this file and then use one of the XML parsers on the 
	client side to access the information that the user wants. Alternately the user can store this 
	information on the "local" database(this I think would be more expensive then simply parsing a file 
	at a given time).   
**/

/**
	Standard table with information about the locations that a user wishes to view.
	The table is subject to modification, this is only a first step. The table still needs to
	be normalised into 3NF or BCNF. 
	The character set also has to be added as we will be using Polish symbols such as 
	ą,ć,ę,ł,ó,ś,ź,ż
	The table below will be subject to many anomalies when updating a location, for 
	example: If a place at address 'x' changes to address 'y', updating the table could 
	be tedious due to the vast amount of dependencies in one table. A plan could be to partition
	the table into more arrays and references the information through foreign key contraints. This 
	could be helpful if we choose to implement an auto update scheme where by we can find a location
	and compare the current address of the location to the one in the database and if there is a difference
	we simply update a table in the database.

	Description:
	ID: This is the primary key of the LOCATION table
	LAT_DEG: lattitude degree
	LAT_MIN: lattitude minute 
	LAT_SEC: lattitude seconds
	LON_DEG: longitude degree
	LON_MIN: longitude minute
	LON_SEC: longitude seconds
	NAME: the name of a given location(i.e Piotr i Paweł)
	ADDRESS: The physical address(i.e 50-371 ulica Ignacego Łukasiewicza, Wrocław, Polska)
	OPEN_TIME: Times that a location is operational
	ADD_INFO: Additional info regarding the location, i.e the description
	RATING: The rating of the location by visitors(This is updated and an average will be calculated)
	CATEGORY_ID: A reference to the available categories(The user will be forced to select a category)
**/
CREATE TABLE IF NOT EXISTS LOCATION(
	ID INT AUTO_INCREMENT NOT NULL,
	LAT_DEG INT DEFAULT NULL,
	LAT_MIN INT DEFAULT NULL,
	LAT_SEC FLOAT DEFAULT NULL,
	LON_DEG INT DEFAULT NULL,
	LON_MIN INT DEFAULT NULL,
	LON_SEC FLOAT DEFAULT NULL,
	NAME VARCHAR(100) NOT NULL,
	ADDRESS VARCHAR(255) NOT NULL,
	OPEN_TIME VARCHAR(255) NOT NULL,
	ADD_INFO VARCHAR(1000) NOT NULL,
	RATING INT DEFAULT 0,
	CATEGORY_ID INT NOT NULL,
	PRIMARY KEY(ID),
	FOREIGN KEY(CATEGORY_ID) REFERENCES  CATEGORY(ID)
);
/**
	The table of categories that locations in the database fall under i.e restuarants, shops etc.
	This table will have to be strictly guarded due to the fact that we don't want users to 
	add their own categories to when the existing ones should be sufficient.

	description
	ID: The primary key of the table
	CATEGORY: The type of category that defines the location( i.e Restaurant, Shopping center, super market etc)
	CAT_DESC: describes the category in detail and what kind of locations are entered under the category
**/
CREATE TABLE IF NOT EXISTS CATEGORY(
	ID INT AUTO_INCREMENT NOT NULL,
	CATEGORY VARCHAR(255),
	CAT_DESC VARCHAR(1000),
	PRIMARY KEY(ID)
);

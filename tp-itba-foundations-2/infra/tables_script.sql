CREATE SCHEMA ourairports;

CREATE TABLE ourairports.airports
(
    id int primary key,
	ident varchar(255),
	type varchar(255),
	name varchar(255),
	latitude_deg float,
	longitude_deg float,
	elevation_ft int,
	continent varchar(255),
	iso_country varchar(255),
	iso_region varchar(255),
	municipality varchar(255),
	scheduled_service varchar(255),
	gps_code varchar(255),
	iata_code varchar(255),
	local_code varchar(255),
	home_link varchar(255),
	wikipedia_link varchar(255),
	keywords varchar(255)
);

CREATE TABLE ourairports.frequencies
(
    id int primary key,
	airport_ref int,
	constraint fk_frequencies_ref foreign key (airport_ref) references ourairports.airports(id),
	airport_ident varchar(255),
	type varchar(255),
	description varchar(255),
	frequency_mhz varchar(255)
);

CREATE TABLE ourairports.runways
(
	id int primary key,
	airport_ref int,
	constraint fk_runways_ref foreign key (airport_ref) references ourairports.airports(id),
	airport_ident varchar(255),
	length_ft int,
	width_ft int,
	surface varchar(255),
	lighted int,
	closed int,
	le_ident varchar(255),
	le_latitude_deg float,
	le_longitude_deg float,
	le_elevation_ft int,
	le_heading_degT int, 
	le_displaced_threshold_ft int,
	he_ident varchar(255),
	he_latitude_deg float,
	he_longitude_deg float,
	he_elevation_ft int,
	he_heading_degT int,
	he_displaced_threshold_ft int
);

CREATE TABLE ourairports.navaids
(
	id int primary key,
	filename varchar(255),
	ident varchar(255),
	name varchar(255),
	type varchar(255),
	frequency_khz int,
	latitude_deg float,
	longitude_deg float,
	elevation_ft int,
	iso_country varchar(255),
	dme_frequency_khz int,
	dme_channel varchar(255),
	dme_latitude_deg float,
	dme_longitude_deg float,
	dme_elevation_ft int,
	slaved_variation_deg float, 
	magnetic_variation_deg float,
	usageType varchar(255),
	power varchar(255),
	associated_airport varchar(255)
);

CREATE TABLE ourairports.countries
(
	id int primary key,
	code varchar(255),
	name varchar(255),
	continent varchar(255),
	wikipedia_link varchar(255),
	keywords varchar(255)
);

CREATE TABLE ourairports.regions
(
	id int primary key,
	code varchar(255),
	local_code varchar(255),
	name varchar(255),
	continent varchar(255),
	iso_country varchar(255),
	wikipedia_link varchar(255),
	keywords varchar(255)
);
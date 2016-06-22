--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.2
-- Dumped by pg_dump version 9.5.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: hoth; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA hoth;


ALTER SCHEMA hoth OWNER TO postgres;

--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: chris
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO chris;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


SET search_path = hoth, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: activityinfo_activity; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE activityinfo_activity (
    id integer NOT NULL,
    ai_id integer NOT NULL,
    name character varying(254) NOT NULL,
    location_type character varying(254) NOT NULL,
    database_id integer NOT NULL,
    CONSTRAINT activityinfo_activity_ai_id_check CHECK ((ai_id >= 0))
);


ALTER TABLE activityinfo_activity OWNER TO postgres;

--
-- Name: activityinfo_activity_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE activityinfo_activity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE activityinfo_activity_id_seq OWNER TO postgres;

--
-- Name: activityinfo_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE activityinfo_activity_id_seq OWNED BY activityinfo_activity.id;


--
-- Name: activityinfo_attribute; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE activityinfo_attribute (
    id integer NOT NULL,
    ai_id integer NOT NULL,
    name character varying(254) NOT NULL,
    attribute_group_id integer NOT NULL,
    CONSTRAINT activityinfo_attribute_ai_id_check CHECK ((ai_id >= 0))
);


ALTER TABLE activityinfo_attribute OWNER TO postgres;

--
-- Name: activityinfo_attribute_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE activityinfo_attribute_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE activityinfo_attribute_id_seq OWNER TO postgres;

--
-- Name: activityinfo_attribute_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE activityinfo_attribute_id_seq OWNED BY activityinfo_attribute.id;


--
-- Name: activityinfo_attributegroup; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE activityinfo_attributegroup (
    id integer NOT NULL,
    ai_id integer NOT NULL,
    name character varying(254) NOT NULL,
    multiple_allowed boolean NOT NULL,
    mandatory boolean NOT NULL,
    activity_id integer NOT NULL,
    CONSTRAINT activityinfo_attributegroup_ai_id_check CHECK ((ai_id >= 0))
);


ALTER TABLE activityinfo_attributegroup OWNER TO postgres;

--
-- Name: activityinfo_attributegroup_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE activityinfo_attributegroup_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE activityinfo_attributegroup_id_seq OWNER TO postgres;

--
-- Name: activityinfo_attributegroup_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE activityinfo_attributegroup_id_seq OWNED BY activityinfo_attributegroup.id;


--
-- Name: activityinfo_database; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE activityinfo_database (
    id integer NOT NULL,
    ai_id integer NOT NULL,
    name character varying(254) NOT NULL,
    username character varying(254) NOT NULL,
    password character varying(254) NOT NULL,
    description character varying(254),
    country_name character varying(254),
    ai_country_id integer,
    CONSTRAINT activityinfo_database_ai_country_id_check CHECK ((ai_country_id >= 0)),
    CONSTRAINT activityinfo_database_ai_id_check CHECK ((ai_id >= 0))
);


ALTER TABLE activityinfo_database OWNER TO postgres;

--
-- Name: activityinfo_database_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE activityinfo_database_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE activityinfo_database_id_seq OWNER TO postgres;

--
-- Name: activityinfo_database_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE activityinfo_database_id_seq OWNED BY activityinfo_database.id;


--
-- Name: activityinfo_indicator; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE activityinfo_indicator (
    id integer NOT NULL,
    ai_id integer NOT NULL,
    name character varying(254) NOT NULL,
    units character varying(254) NOT NULL,
    category character varying(254),
    activity_id integer NOT NULL,
    CONSTRAINT activityinfo_indicator_ai_id_check CHECK ((ai_id >= 0))
);


ALTER TABLE activityinfo_indicator OWNER TO postgres;

--
-- Name: activityinfo_indicator_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE activityinfo_indicator_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE activityinfo_indicator_id_seq OWNER TO postgres;

--
-- Name: activityinfo_indicator_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE activityinfo_indicator_id_seq OWNED BY activityinfo_indicator.id;


--
-- Name: activityinfo_partner; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE activityinfo_partner (
    id integer NOT NULL,
    ai_id integer NOT NULL,
    name character varying(254) NOT NULL,
    full_name character varying(254),
    database_id integer NOT NULL,
    CONSTRAINT activityinfo_partner_ai_id_check CHECK ((ai_id >= 0))
);


ALTER TABLE activityinfo_partner OWNER TO postgres;

--
-- Name: activityinfo_partner_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE activityinfo_partner_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE activityinfo_partner_id_seq OWNER TO postgres;

--
-- Name: activityinfo_partner_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE activityinfo_partner_id_seq OWNED BY activityinfo_partner.id;


--
-- Name: django_migrations; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: funds_donor; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE funds_donor (
    id integer NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE funds_donor OWNER TO postgres;

--
-- Name: funds_donor_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE funds_donor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE funds_donor_id_seq OWNER TO postgres;

--
-- Name: funds_donor_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE funds_donor_id_seq OWNED BY funds_donor.id;


--
-- Name: funds_grant; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE funds_grant (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    donor_id integer NOT NULL,
    expiry date,
    description character varying(255)
);


ALTER TABLE funds_grant OWNER TO postgres;

--
-- Name: funds_grant_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE funds_grant_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE funds_grant_id_seq OWNER TO postgres;

--
-- Name: funds_grant_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE funds_grant_id_seq OWNED BY funds_grant.id;


--
-- Name: locations_cartodbtable; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE locations_cartodbtable (
    id integer NOT NULL,
    domain character varying(254) NOT NULL,
    api_key character varying(254) NOT NULL,
    table_name character varying(254) NOT NULL,
    display_name character varying(254),
    name_col character varying(254) NOT NULL,
    pcode_col character varying(254) NOT NULL,
    parent_code_col character varying(254),
    color character varying(7),
    location_type_id integer NOT NULL,
    level integer NOT NULL,
    lft integer NOT NULL,
    parent_id integer,
    rght integer NOT NULL,
    tree_id integer NOT NULL,
    CONSTRAINT locations_cartodbtable_level_check CHECK ((level >= 0)),
    CONSTRAINT locations_cartodbtable_lft_check CHECK ((lft >= 0)),
    CONSTRAINT locations_cartodbtable_rght_check CHECK ((rght >= 0)),
    CONSTRAINT locations_cartodbtable_tree_id_check CHECK ((tree_id >= 0))
);


ALTER TABLE locations_cartodbtable OWNER TO postgres;

--
-- Name: locations_cartodbtable_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE locations_cartodbtable_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE locations_cartodbtable_id_seq OWNER TO postgres;

--
-- Name: locations_cartodbtable_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE locations_cartodbtable_id_seq OWNED BY locations_cartodbtable.id;


--
-- Name: locations_gatewaytype; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE locations_gatewaytype (
    id integer NOT NULL,
    name character varying(64) NOT NULL
);


ALTER TABLE locations_gatewaytype OWNER TO postgres;

--
-- Name: locations_gatewaytype_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE locations_gatewaytype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE locations_gatewaytype_id_seq OWNER TO postgres;

--
-- Name: locations_gatewaytype_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE locations_gatewaytype_id_seq OWNED BY locations_gatewaytype.id;


--
-- Name: locations_governorate; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE locations_governorate (
    id integer NOT NULL,
    name character varying(45) NOT NULL,
    p_code character varying(32),
    color character varying(7),
    geom public.geometry(MultiPolygon,4326),
    gateway_id integer
);


ALTER TABLE locations_governorate OWNER TO postgres;

--
-- Name: locations_governorate_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE locations_governorate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE locations_governorate_id_seq OWNER TO postgres;

--
-- Name: locations_governorate_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE locations_governorate_id_seq OWNED BY locations_governorate.id;


--
-- Name: locations_linkedlocation; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE locations_linkedlocation (
    id integer NOT NULL,
    object_id integer NOT NULL,
    content_type_id integer NOT NULL,
    governorate_id integer NOT NULL,
    locality_id integer,
    location_id integer,
    region_id integer NOT NULL,
    CONSTRAINT locations_linkedlocation_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE locations_linkedlocation OWNER TO postgres;

--
-- Name: locations_linkedlocation_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE locations_linkedlocation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE locations_linkedlocation_id_seq OWNER TO postgres;

--
-- Name: locations_linkedlocation_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE locations_linkedlocation_id_seq OWNED BY locations_linkedlocation.id;


--
-- Name: locations_locality; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE locations_locality (
    id integer NOT NULL,
    cad_code character varying(11) NOT NULL,
    cas_code character varying(11) NOT NULL,
    cas_code_un character varying(11) NOT NULL,
    name character varying(128) NOT NULL,
    cas_village_name character varying(128) NOT NULL,
    p_code character varying(32),
    color character varying(7),
    geom public.geometry(MultiPolygon,4326),
    gateway_id integer,
    region_id integer NOT NULL
);


ALTER TABLE locations_locality OWNER TO postgres;

--
-- Name: locations_locality_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE locations_locality_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE locations_locality_id_seq OWNER TO postgres;

--
-- Name: locations_locality_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE locations_locality_id_seq OWNED BY locations_locality.id;


--
-- Name: locations_location; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE locations_location (
    id integer NOT NULL,
    name character varying(254) NOT NULL,
    latitude double precision,
    longitude double precision,
    p_code character varying(32),
    point public.geometry(Point,4326),
    gateway_id integer NOT NULL,
    locality_id integer,
    geom public.geometry(MultiPolygon,4326),
    level integer NOT NULL,
    lft integer NOT NULL,
    parent_id integer,
    rght integer NOT NULL,
    tree_id integer NOT NULL,
    CONSTRAINT locations_location_level_check CHECK ((level >= 0)),
    CONSTRAINT locations_location_lft_check CHECK ((lft >= 0)),
    CONSTRAINT locations_location_rght_check CHECK ((rght >= 0)),
    CONSTRAINT locations_location_tree_id_check CHECK ((tree_id >= 0))
);


ALTER TABLE locations_location OWNER TO postgres;

--
-- Name: locations_location_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE locations_location_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE locations_location_id_seq OWNER TO postgres;

--
-- Name: locations_location_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE locations_location_id_seq OWNED BY locations_location.id;


--
-- Name: locations_region; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE locations_region (
    id integer NOT NULL,
    name character varying(45) NOT NULL,
    p_code character varying(32),
    color character varying(7),
    geom public.geometry(MultiPolygon,4326),
    gateway_id integer,
    governorate_id integer NOT NULL
);


ALTER TABLE locations_region OWNER TO postgres;

--
-- Name: locations_region_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE locations_region_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE locations_region_id_seq OWNER TO postgres;

--
-- Name: locations_region_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE locations_region_id_seq OWNED BY locations_region.id;


--
-- Name: partners_agreement; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE partners_agreement (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    start date,
    "end" date,
    agreement_type character varying(10) NOT NULL,
    agreement_number character varying(45) NOT NULL,
    attached_agreement character varying(100) NOT NULL,
    signed_by_unicef_date date,
    signed_by_partner_date date,
    partner_id integer NOT NULL,
    partner_manager_id integer,
    signed_by_id integer,
    account_number character varying(50),
    account_title character varying(255),
    bank_address character varying(256) NOT NULL,
    bank_contact_person character varying(255),
    bank_name character varying(255),
    routing_details character varying(255)
);


ALTER TABLE partners_agreement OWNER TO postgres;

--
-- Name: partners_agreement_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE partners_agreement_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partners_agreement_id_seq OWNER TO postgres;

--
-- Name: partners_agreement_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE partners_agreement_id_seq OWNED BY partners_agreement.id;


--
-- Name: partners_agreementamendmentlog; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE partners_agreementamendmentlog (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    type character varying(50) NOT NULL,
    amended_at date,
    status character varying(32) NOT NULL,
    agreement_id integer NOT NULL
);


ALTER TABLE partners_agreementamendmentlog OWNER TO postgres;

--
-- Name: partners_agreementamendmentlog_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE partners_agreementamendmentlog_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partners_agreementamendmentlog_id_seq OWNER TO postgres;

--
-- Name: partners_agreementamendmentlog_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE partners_agreementamendmentlog_id_seq OWNED BY partners_agreementamendmentlog.id;


--
-- Name: partners_amendmentlog; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE partners_amendmentlog (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    type character varying(50) NOT NULL,
    amended_at date,
    partnership_id integer NOT NULL,
    status character varying(32) NOT NULL
);


ALTER TABLE partners_amendmentlog OWNER TO postgres;

--
-- Name: partners_amendmentlog_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE partners_amendmentlog_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partners_amendmentlog_id_seq OWNER TO postgres;

--
-- Name: partners_amendmentlog_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE partners_amendmentlog_id_seq OWNED BY partners_amendmentlog.id;


--
-- Name: partners_assessment; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE partners_assessment (
    id integer NOT NULL,
    type character varying(50) NOT NULL,
    names_of_other_agencies character varying(255),
    expected_budget integer,
    notes character varying(255),
    requested_date date NOT NULL,
    planned_date date,
    completed_date date,
    rating character varying(50) NOT NULL,
    report character varying(100),
    current boolean NOT NULL,
    approving_officer_id integer,
    partner_id integer NOT NULL,
    requesting_officer_id integer
);


ALTER TABLE partners_assessment OWNER TO postgres;

--
-- Name: partners_assessment_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE partners_assessment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partners_assessment_id_seq OWNER TO postgres;

--
-- Name: partners_assessment_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE partners_assessment_id_seq OWNED BY partners_assessment.id;


--
-- Name: partners_authorizedofficer; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE partners_authorizedofficer (
    id integer NOT NULL,
    agreement_id integer NOT NULL,
    officer_id integer NOT NULL,
    amendment_id integer
);


ALTER TABLE partners_authorizedofficer OWNER TO postgres;

--
-- Name: partners_authorizedofficer_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE partners_authorizedofficer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partners_authorizedofficer_id_seq OWNER TO postgres;

--
-- Name: partners_authorizedofficer_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE partners_authorizedofficer_id_seq OWNED BY partners_authorizedofficer.id;


--
-- Name: partners_bankdetails; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE partners_bankdetails (
    id integer NOT NULL,
    bank_name character varying(255),
    bank_address character varying(256) NOT NULL,
    account_title character varying(255),
    account_number character varying(50),
    routing_details character varying(255),
    bank_contact_person character varying(255),
    agreement_id integer NOT NULL,
    amendment_id integer
);


ALTER TABLE partners_bankdetails OWNER TO postgres;

--
-- Name: partners_bankdetails_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE partners_bankdetails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partners_bankdetails_id_seq OWNER TO postgres;

--
-- Name: partners_bankdetails_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE partners_bankdetails_id_seq OWNED BY partners_bankdetails.id;


--
-- Name: partners_directcashtransfer; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE partners_directcashtransfer (
    id integer NOT NULL,
    fc_ref character varying(50) NOT NULL,
    amount_usd numeric(10,2) NOT NULL,
    liquidation_usd numeric(10,2) NOT NULL,
    outstanding_balance_usd numeric(10,2) NOT NULL,
    "amount_less_than_3_Months_usd" numeric(10,2) NOT NULL,
    amount_3_to_6_months_usd numeric(10,2) NOT NULL,
    amount_6_to_9_months_usd numeric(10,2) NOT NULL,
    "amount_more_than_9_Months_usd" numeric(10,2) NOT NULL
);


ALTER TABLE partners_directcashtransfer OWNER TO postgres;

--
-- Name: partners_directcashtransfer_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE partners_directcashtransfer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partners_directcashtransfer_id_seq OWNER TO postgres;

--
-- Name: partners_directcashtransfer_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE partners_directcashtransfer_id_seq OWNED BY partners_directcashtransfer.id;


--
-- Name: partners_distributionplan; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE partners_distributionplan (
    id integer NOT NULL,
    quantity integer NOT NULL,
    send boolean NOT NULL,
    sent boolean NOT NULL,
    delivered integer NOT NULL,
    item_id integer NOT NULL,
    partnership_id integer NOT NULL,
    site_id integer,
    document text,
    CONSTRAINT partners_distributionplan_quantity_check CHECK ((quantity >= 0))
);


ALTER TABLE partners_distributionplan OWNER TO postgres;

--
-- Name: partners_distributionplan_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE partners_distributionplan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partners_distributionplan_id_seq OWNER TO postgres;

--
-- Name: partners_distributionplan_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE partners_distributionplan_id_seq OWNED BY partners_distributionplan.id;


--
-- Name: partners_filetype; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE partners_filetype (
    id integer NOT NULL,
    name character varying(64) NOT NULL
);


ALTER TABLE partners_filetype OWNER TO postgres;

--
-- Name: partners_filetype_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE partners_filetype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partners_filetype_id_seq OWNER TO postgres;

--
-- Name: partners_filetype_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE partners_filetype_id_seq OWNED BY partners_filetype.id;


--
-- Name: partners_fundingcommitment; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE partners_fundingcommitment (
    id integer NOT NULL,
    fr_number character varying(50) NOT NULL,
    wbs character varying(50) NOT NULL,
    fc_type character varying(50) NOT NULL,
    fc_ref character varying(50),
    fr_item_amount_usd numeric(10,2),
    agreement_amount numeric(10,2),
    commitment_amount numeric(10,2),
    expenditure_amount numeric(10,2),
    grant_id integer NOT NULL,
    intervention_id integer,
    "end" timestamp with time zone,
    start timestamp with time zone
);


ALTER TABLE partners_fundingcommitment OWNER TO postgres;

--
-- Name: partners_fundingcommitment_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE partners_fundingcommitment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partners_fundingcommitment_id_seq OWNER TO postgres;

--
-- Name: partners_fundingcommitment_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE partners_fundingcommitment_id_seq OWNED BY partners_fundingcommitment.id;


--
-- Name: partners_governmentintervention; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE partners_governmentintervention (
    id integer NOT NULL,
    partner_id integer NOT NULL,
    result_structure_id integer NOT NULL
);


ALTER TABLE partners_governmentintervention OWNER TO postgres;

--
-- Name: partners_governmentintervention_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE partners_governmentintervention_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partners_governmentintervention_id_seq OWNER TO postgres;

--
-- Name: partners_governmentintervention_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE partners_governmentintervention_id_seq OWNED BY partners_governmentintervention.id;


--
-- Name: partners_governmentinterventionresult; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE partners_governmentinterventionresult (
    id integer NOT NULL,
    year character varying(4) NOT NULL,
    planned_amount integer NOT NULL,
    intervention_id integer NOT NULL,
    result_id integer NOT NULL,
    section_id integer,
    sector_id integer,
    activities public.hstore
);


ALTER TABLE partners_governmentinterventionresult OWNER TO postgres;

--
-- Name: partners_governmentinterventionresult_activities_list; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE partners_governmentinterventionresult_activities_list (
    id integer NOT NULL,
    governmentinterventionresult_id integer NOT NULL,
    result_id integer NOT NULL
);


ALTER TABLE partners_governmentinterventionresult_activities_list OWNER TO postgres;

--
-- Name: partners_governmentinterventionresult_activities_list_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE partners_governmentinterventionresult_activities_list_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partners_governmentinterventionresult_activities_list_id_seq OWNER TO postgres;

--
-- Name: partners_governmentinterventionresult_activities_list_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE partners_governmentinterventionresult_activities_list_id_seq OWNED BY partners_governmentinterventionresult_activities_list.id;


--
-- Name: partners_governmentinterventionresult_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE partners_governmentinterventionresult_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partners_governmentinterventionresult_id_seq OWNER TO postgres;

--
-- Name: partners_governmentinterventionresult_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE partners_governmentinterventionresult_id_seq OWNED BY partners_governmentinterventionresult.id;


--
-- Name: partners_governmentinterventionresult_unicef_managers; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE partners_governmentinterventionresult_unicef_managers (
    id integer NOT NULL,
    governmentinterventionresult_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE partners_governmentinterventionresult_unicef_managers OWNER TO postgres;

--
-- Name: partners_governmentinterventionresult_unicef_managers_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE partners_governmentinterventionresult_unicef_managers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partners_governmentinterventionresult_unicef_managers_id_seq OWNER TO postgres;

--
-- Name: partners_governmentinterventionresult_unicef_managers_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE partners_governmentinterventionresult_unicef_managers_id_seq OWNED BY partners_governmentinterventionresult_unicef_managers.id;


--
-- Name: partners_gwpcalocation; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE partners_gwpcalocation (
    id integer NOT NULL,
    tpm_visit boolean NOT NULL,
    governorate_id integer,
    locality_id integer,
    location_id integer,
    pca_id integer NOT NULL,
    region_id integer,
    sector_id integer
);


ALTER TABLE partners_gwpcalocation OWNER TO postgres;

--
-- Name: partners_gwpcalocation_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE partners_gwpcalocation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partners_gwpcalocation_id_seq OWNER TO postgres;

--
-- Name: partners_gwpcalocation_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE partners_gwpcalocation_id_seq OWNED BY partners_gwpcalocation.id;


--
-- Name: partners_indicatorduedates; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE partners_indicatorduedates (
    id integer NOT NULL,
    due_date date,
    intervention_id integer
);


ALTER TABLE partners_indicatorduedates OWNER TO postgres;

--
-- Name: partners_indicatorduedates_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE partners_indicatorduedates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partners_indicatorduedates_id_seq OWNER TO postgres;

--
-- Name: partners_indicatorduedates_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE partners_indicatorduedates_id_seq OWNED BY partners_indicatorduedates.id;


--
-- Name: partners_indicatorreport; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE partners_indicatorreport (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    total integer NOT NULL,
    disaggregated boolean NOT NULL,
    disaggregation text NOT NULL,
    remarks text,
    indicator_id integer NOT NULL,
    location_id integer,
    partner_staff_member_id integer NOT NULL,
    result_chain_id integer NOT NULL,
    "end" timestamp with time zone,
    start timestamp with time zone,
    report_status character varying(15) NOT NULL,
    CONSTRAINT partners_indicatorreport_total_check CHECK ((total >= 0))
);


ALTER TABLE partners_indicatorreport OWNER TO postgres;

--
-- Name: partners_indicatorreport_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE partners_indicatorreport_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partners_indicatorreport_id_seq OWNER TO postgres;

--
-- Name: partners_indicatorreport_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE partners_indicatorreport_id_seq OWNED BY partners_indicatorreport.id;


--
-- Name: partners_partnerorganization; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE partners_partnerorganization (
    id integer NOT NULL,
    partner_type character varying(50) NOT NULL,
    name character varying(255) NOT NULL,
    short_name character varying(50) NOT NULL,
    description character varying(256) NOT NULL,
    address text,
    email character varying(255),
    phone_number character varying(32),
    vendor_number bigint,
    alternate_id integer,
    alternate_name character varying(255),
    rating character varying(50),
    core_values_assessment_date date,
    core_values_assessment character varying(100),
    cso_type character varying(50),
    vision_synced boolean NOT NULL,
    type_of_assessment character varying(50),
    last_assessment_date date,
    shared_partner character varying(50) NOT NULL
);


ALTER TABLE partners_partnerorganization OWNER TO postgres;

--
-- Name: partners_partnerorganization_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE partners_partnerorganization_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partners_partnerorganization_id_seq OWNER TO postgres;

--
-- Name: partners_partnerorganization_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE partners_partnerorganization_id_seq OWNED BY partners_partnerorganization.id;


--
-- Name: partners_partnershipbudget; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE partners_partnershipbudget (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    partner_contribution integer NOT NULL,
    unicef_cash integer NOT NULL,
    in_kind_amount integer NOT NULL,
    total integer NOT NULL,
    amendment_id integer,
    partnership_id integer NOT NULL,
    year character varying(5)
);


ALTER TABLE partners_partnershipbudget OWNER TO postgres;

--
-- Name: partners_partnershipbudget_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE partners_partnershipbudget_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partners_partnershipbudget_id_seq OWNER TO postgres;

--
-- Name: partners_partnershipbudget_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE partners_partnershipbudget_id_seq OWNED BY partners_partnershipbudget.id;


--
-- Name: partners_partnerstaffmember; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE partners_partnerstaffmember (
    id integer NOT NULL,
    title character varying(64) NOT NULL,
    first_name character varying(64) NOT NULL,
    last_name character varying(64) NOT NULL,
    email character varying(128) NOT NULL,
    phone character varying(64) NOT NULL,
    partner_id integer NOT NULL,
    active boolean NOT NULL
);


ALTER TABLE partners_partnerstaffmember OWNER TO postgres;

--
-- Name: partners_partnerstaffmember_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE partners_partnerstaffmember_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partners_partnerstaffmember_id_seq OWNER TO postgres;

--
-- Name: partners_partnerstaffmember_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE partners_partnerstaffmember_id_seq OWNED BY partners_partnerstaffmember.id;


--
-- Name: partners_pca; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE partners_pca (
    id integer NOT NULL,
    partnership_type character varying(255),
    number character varying(45),
    title character varying(256) NOT NULL,
    status character varying(32) NOT NULL,
    start_date date,
    end_date date,
    initiation_date date NOT NULL,
    submission_date date,
    review_date date,
    signed_by_unicef_date date,
    signed_by_partner_date date,
    sectors character varying(255),
    current boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    agreement_id integer,
    partner_id integer NOT NULL,
    partner_focal_point_id integer,
    partner_manager_id integer,
    result_structure_id integer,
    unicef_manager_id integer,
    fr_number character varying(50),
    project_type character varying(20),
    planned_visits integer NOT NULL
);


ALTER TABLE partners_pca OWNER TO postgres;

--
-- Name: partners_pca_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE partners_pca_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partners_pca_id_seq OWNER TO postgres;

--
-- Name: partners_pca_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE partners_pca_id_seq OWNED BY partners_pca.id;


--
-- Name: partners_pca_unicef_managers; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE partners_pca_unicef_managers (
    id integer NOT NULL,
    pca_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE partners_pca_unicef_managers OWNER TO postgres;

--
-- Name: partners_pca_unicef_managers_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE partners_pca_unicef_managers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partners_pca_unicef_managers_id_seq OWNER TO postgres;

--
-- Name: partners_pca_unicef_managers_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE partners_pca_unicef_managers_id_seq OWNED BY partners_pca_unicef_managers.id;


--
-- Name: partners_pcafile; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE partners_pcafile (
    id integer NOT NULL,
    pca_id integer NOT NULL,
    type_id integer NOT NULL,
    attachment character varying(255) NOT NULL
);


ALTER TABLE partners_pcafile OWNER TO postgres;

--
-- Name: partners_pcafile_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE partners_pcafile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partners_pcafile_id_seq OWNER TO postgres;

--
-- Name: partners_pcafile_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE partners_pcafile_id_seq OWNED BY partners_pcafile.id;


--
-- Name: partners_pcagrant; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE partners_pcagrant (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    funds integer,
    amendment_id integer,
    grant_id integer NOT NULL,
    partnership_id integer NOT NULL
);


ALTER TABLE partners_pcagrant OWNER TO postgres;

--
-- Name: partners_pcagrant_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE partners_pcagrant_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partners_pcagrant_id_seq OWNER TO postgres;

--
-- Name: partners_pcagrant_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE partners_pcagrant_id_seq OWNED BY partners_pcagrant.id;


--
-- Name: partners_pcasector; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE partners_pcasector (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    amendment_id integer,
    pca_id integer NOT NULL,
    sector_id integer NOT NULL
);


ALTER TABLE partners_pcasector OWNER TO postgres;

--
-- Name: partners_pcasector_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE partners_pcasector_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partners_pcasector_id_seq OWNER TO postgres;

--
-- Name: partners_pcasector_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE partners_pcasector_id_seq OWNED BY partners_pcasector.id;


--
-- Name: partners_pcasectorgoal; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE partners_pcasectorgoal (
    id integer NOT NULL,
    goal_id integer NOT NULL,
    pca_sector_id integer NOT NULL
);


ALTER TABLE partners_pcasectorgoal OWNER TO postgres;

--
-- Name: partners_pcasectorgoal_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE partners_pcasectorgoal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partners_pcasectorgoal_id_seq OWNER TO postgres;

--
-- Name: partners_pcasectorgoal_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE partners_pcasectorgoal_id_seq OWNED BY partners_pcasectorgoal.id;


--
-- Name: partners_ramindicator; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE partners_ramindicator (
    id integer NOT NULL,
    indicator_id integer NOT NULL,
    intervention_id integer NOT NULL,
    result_id integer NOT NULL
);


ALTER TABLE partners_ramindicator OWNER TO postgres;

--
-- Name: partners_ramindicator_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE partners_ramindicator_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partners_ramindicator_id_seq OWNER TO postgres;

--
-- Name: partners_ramindicator_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE partners_ramindicator_id_seq OWNED BY partners_ramindicator.id;


--
-- Name: partners_resultchain; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE partners_resultchain (
    id integer NOT NULL,
    target integer,
    indicator_id integer,
    partnership_id integer NOT NULL,
    result_id integer NOT NULL,
    result_type_id integer NOT NULL,
    code character varying(50),
    in_kind_amount integer NOT NULL,
    partner_contribution integer NOT NULL,
    unicef_cash integer NOT NULL,
    disaggregation text,
    current_progress integer NOT NULL,
    CONSTRAINT partners_resultchain_current_progress_check CHECK ((current_progress >= 0)),
    CONSTRAINT partners_resultchain_target_check CHECK ((target >= 0))
);


ALTER TABLE partners_resultchain OWNER TO postgres;

--
-- Name: partners_resultchain_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE partners_resultchain_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partners_resultchain_id_seq OWNER TO postgres;

--
-- Name: partners_resultchain_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE partners_resultchain_id_seq OWNED BY partners_resultchain.id;


--
-- Name: partners_supplyplan; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE partners_supplyplan (
    id integer NOT NULL,
    quantity integer NOT NULL,
    item_id integer NOT NULL,
    partnership_id integer NOT NULL,
    CONSTRAINT partners_supplyplan_quantity_check CHECK ((quantity >= 0))
);


ALTER TABLE partners_supplyplan OWNER TO postgres;

--
-- Name: partners_supplyplan_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE partners_supplyplan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partners_supplyplan_id_seq OWNER TO postgres;

--
-- Name: partners_supplyplan_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE partners_supplyplan_id_seq OWNED BY partners_supplyplan.id;


--
-- Name: reports_goal; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE reports_goal (
    id integer NOT NULL,
    name character varying(512) NOT NULL,
    description character varying(512) NOT NULL,
    result_structure_id integer,
    sector_id integer NOT NULL
);


ALTER TABLE reports_goal OWNER TO postgres;

--
-- Name: reports_goal_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE reports_goal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reports_goal_id_seq OWNER TO postgres;

--
-- Name: reports_goal_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE reports_goal_id_seq OWNED BY reports_goal.id;


--
-- Name: reports_indicator; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE reports_indicator (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    code character varying(50),
    total integer,
    sector_total integer,
    current integer,
    sector_current integer,
    view_on_dashboard boolean NOT NULL,
    in_activity_info boolean NOT NULL,
    result_id integer,
    result_structure_id integer,
    sector_id integer,
    unit_id integer,
    baseline character varying(255),
    ram_indicator boolean NOT NULL,
    target character varying(255)
);


ALTER TABLE reports_indicator OWNER TO postgres;

--
-- Name: reports_indicator_activity_info_indicators; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE reports_indicator_activity_info_indicators (
    id integer NOT NULL,
    from_indicator_id integer NOT NULL,
    to_indicator_id integer NOT NULL
);


ALTER TABLE reports_indicator_activity_info_indicators OWNER TO postgres;

--
-- Name: reports_indicator_activity_info_indicators_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE reports_indicator_activity_info_indicators_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reports_indicator_activity_info_indicators_id_seq OWNER TO postgres;

--
-- Name: reports_indicator_activity_info_indicators_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE reports_indicator_activity_info_indicators_id_seq OWNED BY reports_indicator_activity_info_indicators.id;


--
-- Name: reports_indicator_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE reports_indicator_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reports_indicator_id_seq OWNER TO postgres;

--
-- Name: reports_indicator_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE reports_indicator_id_seq OWNED BY reports_indicator.id;


--
-- Name: reports_result; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE reports_result (
    id integer NOT NULL,
    name text NOT NULL,
    code character varying(50),
    result_structure_id integer NOT NULL,
    result_type_id integer NOT NULL,
    sector_id integer,
    gic_code character varying(8),
    gic_name character varying(255),
    humanitarian_tag boolean NOT NULL,
    level integer NOT NULL,
    lft integer NOT NULL,
    parent_id integer,
    rght integer NOT NULL,
    sic_code character varying(8),
    sic_name character varying(255),
    tree_id integer NOT NULL,
    vision_id character varying(10),
    wbs character varying(50),
    activity_focus_code character varying(8),
    activity_focus_name character varying(255),
    hidden boolean NOT NULL,
    from_date date,
    to_date date,
    ram boolean NOT NULL,
    CONSTRAINT reports_result_level_check CHECK ((level >= 0)),
    CONSTRAINT reports_result_lft_check CHECK ((lft >= 0)),
    CONSTRAINT reports_result_rght_check CHECK ((rght >= 0)),
    CONSTRAINT reports_result_tree_id_check CHECK ((tree_id >= 0))
);


ALTER TABLE reports_result OWNER TO postgres;

--
-- Name: reports_result_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE reports_result_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reports_result_id_seq OWNER TO postgres;

--
-- Name: reports_result_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE reports_result_id_seq OWNED BY reports_result.id;


--
-- Name: reports_resultstructure; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE reports_resultstructure (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    from_date date NOT NULL,
    to_date date NOT NULL
);


ALTER TABLE reports_resultstructure OWNER TO postgres;

--
-- Name: reports_resultstructure_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE reports_resultstructure_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reports_resultstructure_id_seq OWNER TO postgres;

--
-- Name: reports_resultstructure_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE reports_resultstructure_id_seq OWNED BY reports_resultstructure.id;


--
-- Name: reports_resulttype; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE reports_resulttype (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE reports_resulttype OWNER TO postgres;

--
-- Name: reports_resulttype_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE reports_resulttype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reports_resulttype_id_seq OWNER TO postgres;

--
-- Name: reports_resulttype_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE reports_resulttype_id_seq OWNED BY reports_resulttype.id;


--
-- Name: reports_sector; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE reports_sector (
    id integer NOT NULL,
    name character varying(45) NOT NULL,
    description character varying(256),
    alternate_id integer,
    alternate_name character varying(255),
    dashboard boolean NOT NULL,
    color character varying(7)
);


ALTER TABLE reports_sector OWNER TO postgres;

--
-- Name: reports_sector_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE reports_sector_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reports_sector_id_seq OWNER TO postgres;

--
-- Name: reports_sector_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE reports_sector_id_seq OWNED BY reports_sector.id;


--
-- Name: reports_unit; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE reports_unit (
    id integer NOT NULL,
    type character varying(45) NOT NULL
);


ALTER TABLE reports_unit OWNER TO postgres;

--
-- Name: reports_unit_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE reports_unit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reports_unit_id_seq OWNER TO postgres;

--
-- Name: reports_unit_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE reports_unit_id_seq OWNED BY reports_unit.id;


--
-- Name: supplies_supplyitem; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE supplies_supplyitem (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text NOT NULL
);


ALTER TABLE supplies_supplyitem OWNER TO postgres;

--
-- Name: supplies_supplyitem_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE supplies_supplyitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE supplies_supplyitem_id_seq OWNER TO postgres;

--
-- Name: supplies_supplyitem_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE supplies_supplyitem_id_seq OWNED BY supplies_supplyitem.id;


--
-- Name: tpm_tpmvisit; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE tpm_tpmvisit (
    id integer NOT NULL,
    status character varying(32) NOT NULL,
    cycle_number integer,
    tentative_date date,
    completed_date date,
    comments text,
    created_date timestamp with time zone NOT NULL,
    report character varying(100),
    assigned_by_id integer NOT NULL,
    pca_id integer NOT NULL,
    pca_location_id integer,
    CONSTRAINT tpm_tpmvisit_cycle_number_check CHECK ((cycle_number >= 0))
);


ALTER TABLE tpm_tpmvisit OWNER TO postgres;

--
-- Name: tpm_tpmvisit_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE tpm_tpmvisit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tpm_tpmvisit_id_seq OWNER TO postgres;

--
-- Name: tpm_tpmvisit_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE tpm_tpmvisit_id_seq OWNED BY tpm_tpmvisit.id;


--
-- Name: trips_actionpoint; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE trips_actionpoint (
    id integer NOT NULL,
    description character varying(254) NOT NULL,
    due_date date NOT NULL,
    actions_taken text,
    completed_date date,
    comments text,
    status character varying(254),
    created_date timestamp with time zone NOT NULL,
    person_responsible_id integer NOT NULL,
    trip_id integer NOT NULL,
    follow_up boolean NOT NULL
);


ALTER TABLE trips_actionpoint OWNER TO postgres;

--
-- Name: trips_actionpoint_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE trips_actionpoint_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trips_actionpoint_id_seq OWNER TO postgres;

--
-- Name: trips_actionpoint_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE trips_actionpoint_id_seq OWNED BY trips_actionpoint.id;


--
-- Name: trips_fileattachment; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE trips_fileattachment (
    id integer NOT NULL,
    report character varying(255) NOT NULL,
    object_id integer,
    content_type_id integer,
    trip_id integer,
    type_id integer NOT NULL,
    caption text,
    CONSTRAINT trips_fileattachment_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE trips_fileattachment OWNER TO postgres;

--
-- Name: trips_fileattachment_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE trips_fileattachment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trips_fileattachment_id_seq OWNER TO postgres;

--
-- Name: trips_fileattachment_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE trips_fileattachment_id_seq OWNED BY trips_fileattachment.id;


--
-- Name: trips_linkedpartner; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE trips_linkedpartner (
    id integer NOT NULL,
    intervention_id integer,
    partner_id integer NOT NULL,
    result_id integer,
    trip_id integer NOT NULL
);


ALTER TABLE trips_linkedpartner OWNER TO postgres;

--
-- Name: trips_linkedpartner_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE trips_linkedpartner_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trips_linkedpartner_id_seq OWNER TO postgres;

--
-- Name: trips_linkedpartner_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE trips_linkedpartner_id_seq OWNED BY trips_linkedpartner.id;


--
-- Name: trips_travelroutes; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE trips_travelroutes (
    id integer NOT NULL,
    origin character varying(254) NOT NULL,
    destination character varying(254) NOT NULL,
    depart timestamp with time zone NOT NULL,
    arrive timestamp with time zone NOT NULL,
    remarks character varying(254),
    trip_id integer NOT NULL
);


ALTER TABLE trips_travelroutes OWNER TO postgres;

--
-- Name: trips_travelroutes_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE trips_travelroutes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trips_travelroutes_id_seq OWNER TO postgres;

--
-- Name: trips_travelroutes_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE trips_travelroutes_id_seq OWNED BY trips_travelroutes.id;


--
-- Name: trips_trip; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE trips_trip (
    id integer NOT NULL,
    status character varying(32) NOT NULL,
    cancelled_reason character varying(254),
    purpose_of_travel character varying(254) NOT NULL,
    travel_type character varying(32) NOT NULL,
    security_clearance_required boolean NOT NULL,
    international_travel boolean NOT NULL,
    from_date date NOT NULL,
    to_date date NOT NULL,
    main_observations text,
    constraints text,
    lessons_learned text,
    opportunities text,
    ta_required boolean NOT NULL,
    ta_drafted boolean NOT NULL,
    ta_drafted_date date,
    ta_reference character varying(254),
    transport_booked boolean NOT NULL,
    security_granted boolean NOT NULL,
    approved_by_supervisor boolean NOT NULL,
    date_supervisor_approved date,
    approved_by_budget_owner boolean NOT NULL,
    date_budget_owner_approved date,
    approved_by_human_resources boolean,
    date_human_resources_approved date,
    representative_approval boolean,
    date_representative_approved date,
    approved_date date,
    created_date timestamp with time zone NOT NULL,
    approved_email_sent boolean NOT NULL,
    ta_trip_took_place_as_planned boolean NOT NULL,
    ta_trip_repay_travel_allowance boolean NOT NULL,
    ta_trip_final_claim boolean NOT NULL,
    budget_owner_id integer,
    human_resources_id integer,
    office_id integer,
    owner_id integer NOT NULL,
    programme_assistant_id integer,
    representative_id integer,
    section_id integer,
    supervisor_id integer NOT NULL,
    travel_assistant_id integer,
    vision_approver_id integer,
    driver_id integer,
    driver_supervisor_id integer,
    driver_trip_id integer,
    pending_ta_amendment boolean NOT NULL,
    submitted_email_sent boolean NOT NULL
);


ALTER TABLE trips_trip OWNER TO postgres;

--
-- Name: trips_trip_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE trips_trip_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trips_trip_id_seq OWNER TO postgres;

--
-- Name: trips_trip_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE trips_trip_id_seq OWNED BY trips_trip.id;


--
-- Name: trips_trip_partners; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE trips_trip_partners (
    id integer NOT NULL,
    trip_id integer NOT NULL,
    partnerorganization_id integer NOT NULL
);


ALTER TABLE trips_trip_partners OWNER TO postgres;

--
-- Name: trips_trip_partners_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE trips_trip_partners_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trips_trip_partners_id_seq OWNER TO postgres;

--
-- Name: trips_trip_partners_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE trips_trip_partners_id_seq OWNED BY trips_trip_partners.id;


--
-- Name: trips_trip_pcas; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE trips_trip_pcas (
    id integer NOT NULL,
    trip_id integer NOT NULL,
    pca_id integer NOT NULL
);


ALTER TABLE trips_trip_pcas OWNER TO postgres;

--
-- Name: trips_trip_pcas_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE trips_trip_pcas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trips_trip_pcas_id_seq OWNER TO postgres;

--
-- Name: trips_trip_pcas_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE trips_trip_pcas_id_seq OWNED BY trips_trip_pcas.id;


--
-- Name: trips_tripfunds; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE trips_tripfunds (
    id integer NOT NULL,
    amount integer NOT NULL,
    grant_id integer NOT NULL,
    trip_id integer NOT NULL,
    wbs_id integer NOT NULL,
    CONSTRAINT trips_tripfunds_amount_check CHECK ((amount >= 0))
);


ALTER TABLE trips_tripfunds OWNER TO postgres;

--
-- Name: trips_tripfunds_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE trips_tripfunds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trips_tripfunds_id_seq OWNER TO postgres;

--
-- Name: trips_tripfunds_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE trips_tripfunds_id_seq OWNED BY trips_tripfunds.id;


--
-- Name: trips_triplocation; Type: TABLE; Schema: hoth; Owner: postgres
--

CREATE TABLE trips_triplocation (
    id integer NOT NULL,
    governorate_id integer,
    locality_id integer,
    location_id integer,
    region_id integer,
    trip_id integer NOT NULL
);


ALTER TABLE trips_triplocation OWNER TO postgres;

--
-- Name: trips_triplocation_id_seq; Type: SEQUENCE; Schema: hoth; Owner: postgres
--

CREATE SEQUENCE trips_triplocation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trips_triplocation_id_seq OWNER TO postgres;

--
-- Name: trips_triplocation_id_seq; Type: SEQUENCE OWNED BY; Schema: hoth; Owner: postgres
--

ALTER SEQUENCE trips_triplocation_id_seq OWNED BY trips_triplocation.id;


SET search_path = public, pg_catalog;

--
-- Name: account_emailaddress; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE account_emailaddress (
    id integer NOT NULL,
    email character varying(254) NOT NULL,
    verified boolean NOT NULL,
    "primary" boolean NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE account_emailaddress OWNER TO postgres;

--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE account_emailaddress_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE account_emailaddress_id_seq OWNER TO postgres;

--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE account_emailaddress_id_seq OWNED BY account_emailaddress.id;


--
-- Name: account_emailconfirmation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE account_emailconfirmation (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    sent timestamp with time zone,
    key character varying(64) NOT NULL,
    email_address_id integer NOT NULL
);


ALTER TABLE account_emailconfirmation OWNER TO postgres;

--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE account_emailconfirmation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE account_emailconfirmation_id_seq OWNER TO postgres;

--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE account_emailconfirmation_id_seq OWNED BY account_emailconfirmation.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(30) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE auth_user OWNER TO postgres;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE auth_user_groups OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_groups_id_seq OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_id_seq OWNER TO postgres;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_user_user_permissions OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- Name: authtoken_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE authtoken_token (
    key character varying(40) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE authtoken_token OWNER TO postgres;

--
-- Name: celery_taskmeta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE celery_taskmeta (
    id integer NOT NULL,
    task_id character varying(255) NOT NULL,
    status character varying(50) NOT NULL,
    result text,
    date_done timestamp with time zone NOT NULL,
    traceback text,
    hidden boolean NOT NULL,
    meta text
);


ALTER TABLE celery_taskmeta OWNER TO postgres;

--
-- Name: celery_taskmeta_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE celery_taskmeta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE celery_taskmeta_id_seq OWNER TO postgres;

--
-- Name: celery_taskmeta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE celery_taskmeta_id_seq OWNED BY celery_taskmeta.id;


--
-- Name: celery_tasksetmeta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE celery_tasksetmeta (
    id integer NOT NULL,
    taskset_id character varying(255) NOT NULL,
    result text NOT NULL,
    date_done timestamp with time zone NOT NULL,
    hidden boolean NOT NULL
);


ALTER TABLE celery_tasksetmeta OWNER TO postgres;

--
-- Name: celery_tasksetmeta_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE celery_tasksetmeta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE celery_tasksetmeta_id_seq OWNER TO postgres;

--
-- Name: celery_tasksetmeta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE celery_tasksetmeta_id_seq OWNED BY celery_tasksetmeta.id;


--
-- Name: corsheaders_corsmodel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE corsheaders_corsmodel (
    id integer NOT NULL,
    cors character varying(255) NOT NULL
);


ALTER TABLE corsheaders_corsmodel OWNER TO postgres;

--
-- Name: corsheaders_corsmodel_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE corsheaders_corsmodel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE corsheaders_corsmodel_id_seq OWNER TO postgres;

--
-- Name: corsheaders_corsmodel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE corsheaders_corsmodel_id_seq OWNED BY corsheaders_corsmodel.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE django_session OWNER TO postgres;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE django_site OWNER TO postgres;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_site_id_seq OWNER TO postgres;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_site_id_seq OWNED BY django_site.id;


--
-- Name: djcelery_crontabschedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE djcelery_crontabschedule (
    id integer NOT NULL,
    minute character varying(64) NOT NULL,
    hour character varying(64) NOT NULL,
    day_of_week character varying(64) NOT NULL,
    day_of_month character varying(64) NOT NULL,
    month_of_year character varying(64) NOT NULL
);


ALTER TABLE djcelery_crontabschedule OWNER TO postgres;

--
-- Name: djcelery_crontabschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE djcelery_crontabschedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE djcelery_crontabschedule_id_seq OWNER TO postgres;

--
-- Name: djcelery_crontabschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE djcelery_crontabschedule_id_seq OWNED BY djcelery_crontabschedule.id;


--
-- Name: djcelery_intervalschedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE djcelery_intervalschedule (
    id integer NOT NULL,
    every integer NOT NULL,
    period character varying(24) NOT NULL
);


ALTER TABLE djcelery_intervalschedule OWNER TO postgres;

--
-- Name: djcelery_intervalschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE djcelery_intervalschedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE djcelery_intervalschedule_id_seq OWNER TO postgres;

--
-- Name: djcelery_intervalschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE djcelery_intervalschedule_id_seq OWNED BY djcelery_intervalschedule.id;


--
-- Name: djcelery_periodictask; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE djcelery_periodictask (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    task character varying(200) NOT NULL,
    args text NOT NULL,
    kwargs text NOT NULL,
    queue character varying(200),
    exchange character varying(200),
    routing_key character varying(200),
    expires timestamp with time zone,
    enabled boolean NOT NULL,
    last_run_at timestamp with time zone,
    total_run_count integer NOT NULL,
    date_changed timestamp with time zone NOT NULL,
    description text NOT NULL,
    crontab_id integer,
    interval_id integer,
    CONSTRAINT djcelery_periodictask_total_run_count_check CHECK ((total_run_count >= 0))
);


ALTER TABLE djcelery_periodictask OWNER TO postgres;

--
-- Name: djcelery_periodictask_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE djcelery_periodictask_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE djcelery_periodictask_id_seq OWNER TO postgres;

--
-- Name: djcelery_periodictask_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE djcelery_periodictask_id_seq OWNED BY djcelery_periodictask.id;


--
-- Name: djcelery_periodictasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE djcelery_periodictasks (
    ident smallint NOT NULL,
    last_update timestamp with time zone NOT NULL
);


ALTER TABLE djcelery_periodictasks OWNER TO postgres;

--
-- Name: djcelery_taskstate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE djcelery_taskstate (
    id integer NOT NULL,
    state character varying(64) NOT NULL,
    task_id character varying(36) NOT NULL,
    name character varying(200),
    tstamp timestamp with time zone NOT NULL,
    args text,
    kwargs text,
    eta timestamp with time zone,
    expires timestamp with time zone,
    result text,
    traceback text,
    runtime double precision,
    retries integer NOT NULL,
    hidden boolean NOT NULL,
    worker_id integer
);


ALTER TABLE djcelery_taskstate OWNER TO postgres;

--
-- Name: djcelery_taskstate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE djcelery_taskstate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE djcelery_taskstate_id_seq OWNER TO postgres;

--
-- Name: djcelery_taskstate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE djcelery_taskstate_id_seq OWNED BY djcelery_taskstate.id;


--
-- Name: djcelery_workerstate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE djcelery_workerstate (
    id integer NOT NULL,
    hostname character varying(255) NOT NULL,
    last_heartbeat timestamp with time zone
);


ALTER TABLE djcelery_workerstate OWNER TO postgres;

--
-- Name: djcelery_workerstate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE djcelery_workerstate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE djcelery_workerstate_id_seq OWNER TO postgres;

--
-- Name: djcelery_workerstate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE djcelery_workerstate_id_seq OWNED BY djcelery_workerstate.id;


--
-- Name: easy_thumbnails_source; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE easy_thumbnails_source (
    id integer NOT NULL,
    storage_hash character varying(40) NOT NULL,
    name character varying(255) NOT NULL,
    modified timestamp with time zone NOT NULL
);


ALTER TABLE easy_thumbnails_source OWNER TO postgres;

--
-- Name: easy_thumbnails_source_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE easy_thumbnails_source_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE easy_thumbnails_source_id_seq OWNER TO postgres;

--
-- Name: easy_thumbnails_source_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE easy_thumbnails_source_id_seq OWNED BY easy_thumbnails_source.id;


--
-- Name: easy_thumbnails_thumbnail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE easy_thumbnails_thumbnail (
    id integer NOT NULL,
    storage_hash character varying(40) NOT NULL,
    name character varying(255) NOT NULL,
    modified timestamp with time zone NOT NULL,
    source_id integer NOT NULL
);


ALTER TABLE easy_thumbnails_thumbnail OWNER TO postgres;

--
-- Name: easy_thumbnails_thumbnail_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE easy_thumbnails_thumbnail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE easy_thumbnails_thumbnail_id_seq OWNER TO postgres;

--
-- Name: easy_thumbnails_thumbnail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE easy_thumbnails_thumbnail_id_seq OWNED BY easy_thumbnails_thumbnail.id;


--
-- Name: easy_thumbnails_thumbnaildimensions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE easy_thumbnails_thumbnaildimensions (
    id integer NOT NULL,
    thumbnail_id integer NOT NULL,
    width integer,
    height integer,
    CONSTRAINT easy_thumbnails_thumbnaildimensions_height_check CHECK ((height >= 0)),
    CONSTRAINT easy_thumbnails_thumbnaildimensions_width_check CHECK ((width >= 0))
);


ALTER TABLE easy_thumbnails_thumbnaildimensions OWNER TO postgres;

--
-- Name: easy_thumbnails_thumbnaildimensions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE easy_thumbnails_thumbnaildimensions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE easy_thumbnails_thumbnaildimensions_id_seq OWNER TO postgres;

--
-- Name: easy_thumbnails_thumbnaildimensions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE easy_thumbnails_thumbnaildimensions_id_seq OWNED BY easy_thumbnails_thumbnaildimensions.id;


--
-- Name: filer_clipboard; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE filer_clipboard (
    id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE filer_clipboard OWNER TO postgres;

--
-- Name: filer_clipboard_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE filer_clipboard_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE filer_clipboard_id_seq OWNER TO postgres;

--
-- Name: filer_clipboard_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE filer_clipboard_id_seq OWNED BY filer_clipboard.id;


--
-- Name: filer_clipboarditem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE filer_clipboarditem (
    id integer NOT NULL,
    clipboard_id integer NOT NULL,
    file_id integer NOT NULL
);


ALTER TABLE filer_clipboarditem OWNER TO postgres;

--
-- Name: filer_clipboarditem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE filer_clipboarditem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE filer_clipboarditem_id_seq OWNER TO postgres;

--
-- Name: filer_clipboarditem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE filer_clipboarditem_id_seq OWNED BY filer_clipboarditem.id;


--
-- Name: filer_file; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE filer_file (
    id integer NOT NULL,
    file character varying(255),
    _file_size integer,
    sha1 character varying(40) NOT NULL,
    has_all_mandatory_data boolean NOT NULL,
    original_filename character varying(255),
    name character varying(255) NOT NULL,
    description text,
    uploaded_at timestamp with time zone NOT NULL,
    modified_at timestamp with time zone NOT NULL,
    is_public boolean NOT NULL,
    folder_id integer,
    owner_id integer,
    polymorphic_ctype_id integer
);


ALTER TABLE filer_file OWNER TO postgres;

--
-- Name: filer_file_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE filer_file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE filer_file_id_seq OWNER TO postgres;

--
-- Name: filer_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE filer_file_id_seq OWNED BY filer_file.id;


--
-- Name: filer_folder; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE filer_folder (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    uploaded_at timestamp with time zone NOT NULL,
    created_at timestamp with time zone NOT NULL,
    modified_at timestamp with time zone NOT NULL,
    lft integer NOT NULL,
    rght integer NOT NULL,
    tree_id integer NOT NULL,
    level integer NOT NULL,
    owner_id integer,
    parent_id integer,
    CONSTRAINT filer_folder_level_check CHECK ((level >= 0)),
    CONSTRAINT filer_folder_lft_check CHECK ((lft >= 0)),
    CONSTRAINT filer_folder_rght_check CHECK ((rght >= 0)),
    CONSTRAINT filer_folder_tree_id_check CHECK ((tree_id >= 0))
);


ALTER TABLE filer_folder OWNER TO postgres;

--
-- Name: filer_folder_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE filer_folder_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE filer_folder_id_seq OWNER TO postgres;

--
-- Name: filer_folder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE filer_folder_id_seq OWNED BY filer_folder.id;


--
-- Name: filer_folderpermission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE filer_folderpermission (
    id integer NOT NULL,
    type smallint NOT NULL,
    everybody boolean NOT NULL,
    can_edit smallint,
    can_read smallint,
    can_add_children smallint,
    folder_id integer,
    group_id integer,
    user_id integer
);


ALTER TABLE filer_folderpermission OWNER TO postgres;

--
-- Name: filer_folderpermission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE filer_folderpermission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE filer_folderpermission_id_seq OWNER TO postgres;

--
-- Name: filer_folderpermission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE filer_folderpermission_id_seq OWNED BY filer_folderpermission.id;


--
-- Name: filer_image; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE filer_image (
    file_ptr_id integer NOT NULL,
    _height integer,
    _width integer,
    date_taken timestamp with time zone,
    default_alt_text character varying(255),
    default_caption character varying(255),
    author character varying(255),
    must_always_publish_author_credit boolean NOT NULL,
    must_always_publish_copyright boolean NOT NULL,
    subject_location character varying(64)
);


ALTER TABLE filer_image OWNER TO postgres;

--
-- Name: generic_links_genericlink; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE generic_links_genericlink (
    id integer NOT NULL,
    object_id integer NOT NULL,
    url character varying(200) NOT NULL,
    title character varying(200) NOT NULL,
    description text,
    created_at timestamp with time zone NOT NULL,
    is_external boolean NOT NULL,
    content_type_id integer NOT NULL,
    user_id integer,
    CONSTRAINT generic_links_genericlink_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE generic_links_genericlink OWNER TO postgres;

--
-- Name: generic_links_genericlink_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE generic_links_genericlink_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE generic_links_genericlink_id_seq OWNER TO postgres;

--
-- Name: generic_links_genericlink_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE generic_links_genericlink_id_seq OWNED BY generic_links_genericlink.id;


--
-- Name: post_office_attachment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE post_office_attachment (
    id integer NOT NULL,
    file character varying(100) NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE post_office_attachment OWNER TO postgres;

--
-- Name: post_office_attachment_emails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE post_office_attachment_emails (
    id integer NOT NULL,
    attachment_id integer NOT NULL,
    email_id integer NOT NULL
);


ALTER TABLE post_office_attachment_emails OWNER TO postgres;

--
-- Name: post_office_attachment_emails_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE post_office_attachment_emails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE post_office_attachment_emails_id_seq OWNER TO postgres;

--
-- Name: post_office_attachment_emails_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE post_office_attachment_emails_id_seq OWNED BY post_office_attachment_emails.id;


--
-- Name: post_office_attachment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE post_office_attachment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE post_office_attachment_id_seq OWNER TO postgres;

--
-- Name: post_office_attachment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE post_office_attachment_id_seq OWNED BY post_office_attachment.id;


--
-- Name: post_office_email; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE post_office_email (
    id integer NOT NULL,
    from_email character varying(254) NOT NULL,
    "to" text NOT NULL,
    cc text NOT NULL,
    bcc text NOT NULL,
    subject character varying(255) NOT NULL,
    message text NOT NULL,
    html_message text NOT NULL,
    status smallint,
    priority smallint,
    created timestamp with time zone NOT NULL,
    last_updated timestamp with time zone NOT NULL,
    scheduled_time timestamp with time zone,
    headers text,
    context text,
    template_id integer,
    backend_alias character varying(64) NOT NULL,
    CONSTRAINT post_office_email_priority_check CHECK ((priority >= 0)),
    CONSTRAINT post_office_email_status_check CHECK ((status >= 0))
);


ALTER TABLE post_office_email OWNER TO postgres;

--
-- Name: post_office_email_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE post_office_email_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE post_office_email_id_seq OWNER TO postgres;

--
-- Name: post_office_email_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE post_office_email_id_seq OWNED BY post_office_email.id;


--
-- Name: post_office_emailtemplate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE post_office_emailtemplate (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text NOT NULL,
    subject character varying(255) NOT NULL,
    content text NOT NULL,
    html_content text NOT NULL,
    created timestamp with time zone NOT NULL,
    last_updated timestamp with time zone NOT NULL,
    default_template_id integer,
    language character varying(12) NOT NULL
);


ALTER TABLE post_office_emailtemplate OWNER TO postgres;

--
-- Name: post_office_emailtemplate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE post_office_emailtemplate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE post_office_emailtemplate_id_seq OWNER TO postgres;

--
-- Name: post_office_emailtemplate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE post_office_emailtemplate_id_seq OWNED BY post_office_emailtemplate.id;


--
-- Name: post_office_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE post_office_log (
    id integer NOT NULL,
    date timestamp with time zone NOT NULL,
    status smallint NOT NULL,
    exception_type character varying(255) NOT NULL,
    message text NOT NULL,
    email_id integer NOT NULL,
    CONSTRAINT post_office_log_status_check CHECK ((status >= 0))
);


ALTER TABLE post_office_log OWNER TO postgres;

--
-- Name: post_office_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE post_office_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE post_office_log_id_seq OWNER TO postgres;

--
-- Name: post_office_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE post_office_log_id_seq OWNED BY post_office_log.id;


--
-- Name: reversion_revision; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE reversion_revision (
    id integer NOT NULL,
    manager_slug character varying(191) NOT NULL,
    date_created timestamp with time zone NOT NULL,
    comment text NOT NULL,
    user_id integer
);


ALTER TABLE reversion_revision OWNER TO postgres;

--
-- Name: reversion_revision_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE reversion_revision_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reversion_revision_id_seq OWNER TO postgres;

--
-- Name: reversion_revision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE reversion_revision_id_seq OWNED BY reversion_revision.id;


--
-- Name: reversion_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE reversion_version (
    id integer NOT NULL,
    object_id text NOT NULL,
    object_id_int integer,
    format character varying(255) NOT NULL,
    serialized_data text NOT NULL,
    object_repr text NOT NULL,
    content_type_id integer NOT NULL,
    revision_id integer NOT NULL
);


ALTER TABLE reversion_version OWNER TO postgres;

--
-- Name: reversion_version_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE reversion_version_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reversion_version_id_seq OWNER TO postgres;

--
-- Name: reversion_version_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE reversion_version_id_seq OWNED BY reversion_version.id;


--
-- Name: socialaccount_socialaccount; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE socialaccount_socialaccount (
    id integer NOT NULL,
    provider character varying(30) NOT NULL,
    uid character varying(191) NOT NULL,
    last_login timestamp with time zone NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    extra_data text NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE socialaccount_socialaccount OWNER TO postgres;

--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE socialaccount_socialaccount_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE socialaccount_socialaccount_id_seq OWNER TO postgres;

--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE socialaccount_socialaccount_id_seq OWNED BY socialaccount_socialaccount.id;


--
-- Name: socialaccount_socialapp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE socialaccount_socialapp (
    id integer NOT NULL,
    provider character varying(30) NOT NULL,
    name character varying(40) NOT NULL,
    client_id character varying(191) NOT NULL,
    secret character varying(191) NOT NULL,
    key character varying(191) NOT NULL
);


ALTER TABLE socialaccount_socialapp OWNER TO postgres;

--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE socialaccount_socialapp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE socialaccount_socialapp_id_seq OWNER TO postgres;

--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE socialaccount_socialapp_id_seq OWNED BY socialaccount_socialapp.id;


--
-- Name: socialaccount_socialapp_sites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE socialaccount_socialapp_sites (
    id integer NOT NULL,
    socialapp_id integer NOT NULL,
    site_id integer NOT NULL
);


ALTER TABLE socialaccount_socialapp_sites OWNER TO postgres;

--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE socialaccount_socialapp_sites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE socialaccount_socialapp_sites_id_seq OWNER TO postgres;

--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE socialaccount_socialapp_sites_id_seq OWNED BY socialaccount_socialapp_sites.id;


--
-- Name: socialaccount_socialtoken; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE socialaccount_socialtoken (
    id integer NOT NULL,
    token text NOT NULL,
    token_secret text NOT NULL,
    expires_at timestamp with time zone,
    account_id integer NOT NULL,
    app_id integer NOT NULL
);


ALTER TABLE socialaccount_socialtoken OWNER TO postgres;

--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE socialaccount_socialtoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE socialaccount_socialtoken_id_seq OWNER TO postgres;

--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE socialaccount_socialtoken_id_seq OWNED BY socialaccount_socialtoken.id;


--
-- Name: users_country; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users_country (
    id integer NOT NULL,
    domain_url character varying(128) NOT NULL,
    schema_name character varying(63) NOT NULL,
    name character varying(100) NOT NULL,
    business_area_code character varying(10),
    initial_zoom integer NOT NULL,
    latitude numeric(8,6),
    longitude numeric(8,6),
    country_short_code character varying(10),
    vision_sync_enabled boolean NOT NULL,
    vision_last_synced timestamp with time zone
);


ALTER TABLE users_country OWNER TO postgres;

--
-- Name: users_country_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_country_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_country_id_seq OWNER TO postgres;

--
-- Name: users_country_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_country_id_seq OWNED BY users_country.id;


--
-- Name: users_country_offices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users_country_offices (
    id integer NOT NULL,
    country_id integer NOT NULL,
    office_id integer NOT NULL
);


ALTER TABLE users_country_offices OWNER TO postgres;

--
-- Name: users_country_offices_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_country_offices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_country_offices_id_seq OWNER TO postgres;

--
-- Name: users_country_offices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_country_offices_id_seq OWNED BY users_country_offices.id;


--
-- Name: users_country_sections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users_country_sections (
    id integer NOT NULL,
    country_id integer NOT NULL,
    section_id integer NOT NULL
);


ALTER TABLE users_country_sections OWNER TO postgres;

--
-- Name: users_country_sections_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_country_sections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_country_sections_id_seq OWNER TO postgres;

--
-- Name: users_country_sections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_country_sections_id_seq OWNED BY users_country_sections.id;


--
-- Name: users_office; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users_office (
    id integer NOT NULL,
    name character varying(254) NOT NULL,
    zonal_chief_id integer
);


ALTER TABLE users_office OWNER TO postgres;

--
-- Name: users_office_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_office_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_office_id_seq OWNER TO postgres;

--
-- Name: users_office_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_office_id_seq OWNED BY users_office.id;


--
-- Name: users_section; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users_section (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE users_section OWNER TO postgres;

--
-- Name: users_section_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_section_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_section_id_seq OWNER TO postgres;

--
-- Name: users_section_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_section_id_seq OWNED BY users_section.id;


--
-- Name: users_userprofile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users_userprofile (
    id integer NOT NULL,
    job_title character varying(255),
    phone_number character varying(20),
    installation_id character varying(50),
    country_id integer,
    office_id integer,
    section_id integer,
    user_id integer NOT NULL,
    country_override_id integer,
    partner_staff_member integer
);


ALTER TABLE users_userprofile OWNER TO postgres;

--
-- Name: users_userprofile_countries_available; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users_userprofile_countries_available (
    id integer NOT NULL,
    userprofile_id integer NOT NULL,
    country_id integer NOT NULL
);


ALTER TABLE users_userprofile_countries_available OWNER TO postgres;

--
-- Name: users_userprofile_countries_available_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_userprofile_countries_available_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_userprofile_countries_available_id_seq OWNER TO postgres;

--
-- Name: users_userprofile_countries_available_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_userprofile_countries_available_id_seq OWNED BY users_userprofile_countries_available.id;


--
-- Name: users_userprofile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_userprofile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_userprofile_id_seq OWNER TO postgres;

--
-- Name: users_userprofile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_userprofile_id_seq OWNED BY users_userprofile.id;


--
-- Name: vision_visionsynclog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE vision_visionsynclog (
    id integer NOT NULL,
    handler_name character varying(50) NOT NULL,
    total_records integer NOT NULL,
    total_processed integer NOT NULL,
    successful boolean NOT NULL,
    exception_message text,
    date_processed timestamp with time zone NOT NULL,
    country_id integer NOT NULL
);


ALTER TABLE vision_visionsynclog OWNER TO postgres;

--
-- Name: vision_visionsynclog_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE vision_visionsynclog_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE vision_visionsynclog_id_seq OWNER TO postgres;

--
-- Name: vision_visionsynclog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE vision_visionsynclog_id_seq OWNED BY vision_visionsynclog.id;


SET search_path = hoth, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY activityinfo_activity ALTER COLUMN id SET DEFAULT nextval('activityinfo_activity_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY activityinfo_attribute ALTER COLUMN id SET DEFAULT nextval('activityinfo_attribute_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY activityinfo_attributegroup ALTER COLUMN id SET DEFAULT nextval('activityinfo_attributegroup_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY activityinfo_database ALTER COLUMN id SET DEFAULT nextval('activityinfo_database_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY activityinfo_indicator ALTER COLUMN id SET DEFAULT nextval('activityinfo_indicator_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY activityinfo_partner ALTER COLUMN id SET DEFAULT nextval('activityinfo_partner_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY funds_donor ALTER COLUMN id SET DEFAULT nextval('funds_donor_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY funds_grant ALTER COLUMN id SET DEFAULT nextval('funds_grant_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_cartodbtable ALTER COLUMN id SET DEFAULT nextval('locations_cartodbtable_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_gatewaytype ALTER COLUMN id SET DEFAULT nextval('locations_gatewaytype_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_governorate ALTER COLUMN id SET DEFAULT nextval('locations_governorate_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_linkedlocation ALTER COLUMN id SET DEFAULT nextval('locations_linkedlocation_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_locality ALTER COLUMN id SET DEFAULT nextval('locations_locality_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_location ALTER COLUMN id SET DEFAULT nextval('locations_location_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_region ALTER COLUMN id SET DEFAULT nextval('locations_region_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_agreement ALTER COLUMN id SET DEFAULT nextval('partners_agreement_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_agreementamendmentlog ALTER COLUMN id SET DEFAULT nextval('partners_agreementamendmentlog_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_amendmentlog ALTER COLUMN id SET DEFAULT nextval('partners_amendmentlog_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_assessment ALTER COLUMN id SET DEFAULT nextval('partners_assessment_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_authorizedofficer ALTER COLUMN id SET DEFAULT nextval('partners_authorizedofficer_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_bankdetails ALTER COLUMN id SET DEFAULT nextval('partners_bankdetails_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_directcashtransfer ALTER COLUMN id SET DEFAULT nextval('partners_directcashtransfer_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_distributionplan ALTER COLUMN id SET DEFAULT nextval('partners_distributionplan_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_filetype ALTER COLUMN id SET DEFAULT nextval('partners_filetype_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_fundingcommitment ALTER COLUMN id SET DEFAULT nextval('partners_fundingcommitment_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_governmentintervention ALTER COLUMN id SET DEFAULT nextval('partners_governmentintervention_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_governmentinterventionresult ALTER COLUMN id SET DEFAULT nextval('partners_governmentinterventionresult_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_governmentinterventionresult_activities_list ALTER COLUMN id SET DEFAULT nextval('partners_governmentinterventionresult_activities_list_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_governmentinterventionresult_unicef_managers ALTER COLUMN id SET DEFAULT nextval('partners_governmentinterventionresult_unicef_managers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_gwpcalocation ALTER COLUMN id SET DEFAULT nextval('partners_gwpcalocation_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_indicatorduedates ALTER COLUMN id SET DEFAULT nextval('partners_indicatorduedates_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_indicatorreport ALTER COLUMN id SET DEFAULT nextval('partners_indicatorreport_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_partnerorganization ALTER COLUMN id SET DEFAULT nextval('partners_partnerorganization_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_partnershipbudget ALTER COLUMN id SET DEFAULT nextval('partners_partnershipbudget_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_partnerstaffmember ALTER COLUMN id SET DEFAULT nextval('partners_partnerstaffmember_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pca ALTER COLUMN id SET DEFAULT nextval('partners_pca_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pca_unicef_managers ALTER COLUMN id SET DEFAULT nextval('partners_pca_unicef_managers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pcafile ALTER COLUMN id SET DEFAULT nextval('partners_pcafile_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pcagrant ALTER COLUMN id SET DEFAULT nextval('partners_pcagrant_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pcasector ALTER COLUMN id SET DEFAULT nextval('partners_pcasector_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pcasectorgoal ALTER COLUMN id SET DEFAULT nextval('partners_pcasectorgoal_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_ramindicator ALTER COLUMN id SET DEFAULT nextval('partners_ramindicator_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_resultchain ALTER COLUMN id SET DEFAULT nextval('partners_resultchain_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_supplyplan ALTER COLUMN id SET DEFAULT nextval('partners_supplyplan_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_goal ALTER COLUMN id SET DEFAULT nextval('reports_goal_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_indicator ALTER COLUMN id SET DEFAULT nextval('reports_indicator_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_indicator_activity_info_indicators ALTER COLUMN id SET DEFAULT nextval('reports_indicator_activity_info_indicators_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_result ALTER COLUMN id SET DEFAULT nextval('reports_result_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_resultstructure ALTER COLUMN id SET DEFAULT nextval('reports_resultstructure_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_resulttype ALTER COLUMN id SET DEFAULT nextval('reports_resulttype_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_sector ALTER COLUMN id SET DEFAULT nextval('reports_sector_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_unit ALTER COLUMN id SET DEFAULT nextval('reports_unit_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY supplies_supplyitem ALTER COLUMN id SET DEFAULT nextval('supplies_supplyitem_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY tpm_tpmvisit ALTER COLUMN id SET DEFAULT nextval('tpm_tpmvisit_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_actionpoint ALTER COLUMN id SET DEFAULT nextval('trips_actionpoint_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_fileattachment ALTER COLUMN id SET DEFAULT nextval('trips_fileattachment_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_linkedpartner ALTER COLUMN id SET DEFAULT nextval('trips_linkedpartner_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_travelroutes ALTER COLUMN id SET DEFAULT nextval('trips_travelroutes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_trip ALTER COLUMN id SET DEFAULT nextval('trips_trip_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_trip_partners ALTER COLUMN id SET DEFAULT nextval('trips_trip_partners_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_trip_pcas ALTER COLUMN id SET DEFAULT nextval('trips_trip_pcas_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_tripfunds ALTER COLUMN id SET DEFAULT nextval('trips_tripfunds_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_triplocation ALTER COLUMN id SET DEFAULT nextval('trips_triplocation_id_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY account_emailaddress ALTER COLUMN id SET DEFAULT nextval('account_emailaddress_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY account_emailconfirmation ALTER COLUMN id SET DEFAULT nextval('account_emailconfirmation_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY celery_taskmeta ALTER COLUMN id SET DEFAULT nextval('celery_taskmeta_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY celery_tasksetmeta ALTER COLUMN id SET DEFAULT nextval('celery_tasksetmeta_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY corsheaders_corsmodel ALTER COLUMN id SET DEFAULT nextval('corsheaders_corsmodel_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_site ALTER COLUMN id SET DEFAULT nextval('django_site_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY djcelery_crontabschedule ALTER COLUMN id SET DEFAULT nextval('djcelery_crontabschedule_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY djcelery_intervalschedule ALTER COLUMN id SET DEFAULT nextval('djcelery_intervalschedule_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY djcelery_periodictask ALTER COLUMN id SET DEFAULT nextval('djcelery_periodictask_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY djcelery_taskstate ALTER COLUMN id SET DEFAULT nextval('djcelery_taskstate_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY djcelery_workerstate ALTER COLUMN id SET DEFAULT nextval('djcelery_workerstate_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY easy_thumbnails_source ALTER COLUMN id SET DEFAULT nextval('easy_thumbnails_source_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY easy_thumbnails_thumbnail ALTER COLUMN id SET DEFAULT nextval('easy_thumbnails_thumbnail_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY easy_thumbnails_thumbnaildimensions ALTER COLUMN id SET DEFAULT nextval('easy_thumbnails_thumbnaildimensions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY filer_clipboard ALTER COLUMN id SET DEFAULT nextval('filer_clipboard_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY filer_clipboarditem ALTER COLUMN id SET DEFAULT nextval('filer_clipboarditem_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY filer_file ALTER COLUMN id SET DEFAULT nextval('filer_file_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY filer_folder ALTER COLUMN id SET DEFAULT nextval('filer_folder_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY filer_folderpermission ALTER COLUMN id SET DEFAULT nextval('filer_folderpermission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY generic_links_genericlink ALTER COLUMN id SET DEFAULT nextval('generic_links_genericlink_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY post_office_attachment ALTER COLUMN id SET DEFAULT nextval('post_office_attachment_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY post_office_attachment_emails ALTER COLUMN id SET DEFAULT nextval('post_office_attachment_emails_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY post_office_email ALTER COLUMN id SET DEFAULT nextval('post_office_email_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY post_office_emailtemplate ALTER COLUMN id SET DEFAULT nextval('post_office_emailtemplate_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY post_office_log ALTER COLUMN id SET DEFAULT nextval('post_office_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reversion_revision ALTER COLUMN id SET DEFAULT nextval('reversion_revision_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reversion_version ALTER COLUMN id SET DEFAULT nextval('reversion_version_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY socialaccount_socialaccount ALTER COLUMN id SET DEFAULT nextval('socialaccount_socialaccount_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY socialaccount_socialapp ALTER COLUMN id SET DEFAULT nextval('socialaccount_socialapp_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY socialaccount_socialapp_sites ALTER COLUMN id SET DEFAULT nextval('socialaccount_socialapp_sites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY socialaccount_socialtoken ALTER COLUMN id SET DEFAULT nextval('socialaccount_socialtoken_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_country ALTER COLUMN id SET DEFAULT nextval('users_country_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_country_offices ALTER COLUMN id SET DEFAULT nextval('users_country_offices_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_country_sections ALTER COLUMN id SET DEFAULT nextval('users_country_sections_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_office ALTER COLUMN id SET DEFAULT nextval('users_office_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_section ALTER COLUMN id SET DEFAULT nextval('users_section_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_userprofile ALTER COLUMN id SET DEFAULT nextval('users_userprofile_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_userprofile_countries_available ALTER COLUMN id SET DEFAULT nextval('users_userprofile_countries_available_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vision_visionsynclog ALTER COLUMN id SET DEFAULT nextval('vision_visionsynclog_id_seq'::regclass);


SET search_path = hoth, pg_catalog;

--
-- Data for Name: activityinfo_activity; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY activityinfo_activity (id, ai_id, name, location_type, database_id) FROM stdin;
\.


--
-- Name: activityinfo_activity_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('activityinfo_activity_id_seq', 1, false);


--
-- Data for Name: activityinfo_attribute; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY activityinfo_attribute (id, ai_id, name, attribute_group_id) FROM stdin;
\.


--
-- Name: activityinfo_attribute_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('activityinfo_attribute_id_seq', 1, false);


--
-- Data for Name: activityinfo_attributegroup; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY activityinfo_attributegroup (id, ai_id, name, multiple_allowed, mandatory, activity_id) FROM stdin;
\.


--
-- Name: activityinfo_attributegroup_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('activityinfo_attributegroup_id_seq', 1, false);


--
-- Data for Name: activityinfo_database; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY activityinfo_database (id, ai_id, name, username, password, description, country_name, ai_country_id) FROM stdin;
\.


--
-- Name: activityinfo_database_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('activityinfo_database_id_seq', 1, false);


--
-- Data for Name: activityinfo_indicator; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY activityinfo_indicator (id, ai_id, name, units, category, activity_id) FROM stdin;
\.


--
-- Name: activityinfo_indicator_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('activityinfo_indicator_id_seq', 1, false);


--
-- Data for Name: activityinfo_partner; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY activityinfo_partner (id, ai_id, name, full_name, database_id) FROM stdin;
\.


--
-- Name: activityinfo_partner_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('activityinfo_partner_id_seq', 1, false);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2016-02-15 09:29:51.682047-05
2	auth	0001_initial	2016-02-15 09:29:51.777996-05
3	account	0001_initial	2016-02-15 09:29:51.873268-05
4	account	0002_email_max_length	2016-02-15 09:29:51.929933-05
5	activityinfo	0001_initial	2016-02-15 09:29:52.244435-05
6	activityinfo	0002_auto_20151004_2246	2016-02-15 09:29:52.346517-05
7	admin	0001_initial	2016-02-15 09:29:52.406229-05
8	contenttypes	0002_remove_content_type_name	2016-02-15 09:29:52.517484-05
9	auth	0002_alter_permission_name_max_length	2016-02-15 09:29:52.580049-05
10	auth	0003_alter_user_email_max_length	2016-02-15 09:29:52.632707-05
11	auth	0004_alter_user_username_opts	2016-02-15 09:29:52.690472-05
12	auth	0005_alter_user_last_login_null	2016-02-15 09:29:52.743191-05
13	auth	0006_require_contenttypes_0002	2016-02-15 09:29:52.775649-05
14	djcelery	0001_initial	2016-02-15 09:29:52.921867-05
15	easy_thumbnails	0001_initial	2016-02-15 09:29:53.041554-05
16	easy_thumbnails	0002_thumbnaildimensions	2016-02-15 09:29:53.123252-05
17	filer	0001_initial	2016-02-15 09:29:53.868996-05
18	filer	0002_auto_20150606_2003	2016-02-15 09:29:53.957255-05
19	funds	0001_initial	2016-02-15 09:29:54.11185-05
20	generic_links	0001_initial	2016-02-15 09:29:54.208133-05
21	locations	0001_initial	2016-02-15 09:29:55.729224-05
22	locations	0002_auto_20151211_1528	2016-02-15 09:29:57.354608-05
23	locations	0003_auto_20151216_1339	2016-02-15 09:29:57.508795-05
24	supplies	0001_initial	2016-02-15 09:29:57.572508-05
25	reports	0001_initial	2016-02-15 09:29:59.53159-05
26	partners	0001_initial	2016-02-15 09:30:09.039636-05
27	partners	0002_auto_20151009_2046	2016-02-15 09:30:09.771716-05
28	partners	0003_auto_20151012_1321	2016-02-15 09:30:12.01512-05
29	partners	0004_auto_20151014_0817	2016-02-15 09:30:12.747926-05
30	partners	0005_auto_20151014_1955	2016-02-15 09:30:14.998839-05
31	partners	0006_auto_20151015_1202	2016-02-15 09:30:15.760412-05
32	partners	0007_auto_20151018_2024	2016-02-15 09:30:16.976592-05
33	partners	0008_auto_20151018_2238	2016-02-15 09:30:17.533245-05
34	partners	0009_auto_20151022_1216	2016-02-15 09:30:17.843105-05
35	partners	0010_auto_20151027_1852	2016-02-15 09:30:18.141565-05
36	partners	0011_auto_20151102_2052	2016-02-15 09:30:18.640173-05
37	partners	0012_auto_20151109_1503	2016-02-15 09:30:18.906735-05
38	partners	0013_auto_20151118_1151	2016-02-15 09:30:19.826022-05
39	partners	0014_auto_20151119_1310	2016-02-15 09:30:21.056895-05
40	partners	0015_auto_20151120_1817	2016-02-15 09:30:22.099942-05
41	partners	0016_auto_20151126_1702	2016-02-15 09:30:22.606542-05
42	partners	0017_auto_20151203_1758	2016-02-15 09:30:22.907999-05
43	partners	0018_auto_20151211_1528	2016-02-15 09:30:23.214978-05
44	partners	0019_auto_20160113_1554	2016-02-15 09:30:24.571577-05
45	partners	0020_auto_20160127_1751	2016-02-15 09:30:25.65988-05
46	post_office	0001_initial	2016-02-15 09:30:25.864276-05
47	post_office	0002_add_i18n_and_backend_alias	2016-02-15 09:30:26.594952-05
48	users	0001_initial	2016-02-15 09:30:27.855114-05
49	trips	0001_initial	2016-02-15 09:30:28.953245-05
50	trips	0002_auto_20151004_2225	2016-02-15 09:30:35.388277-05
51	trips	0003_auto_20151009_2046	2016-02-15 09:30:35.772238-05
52	trips	0004_auto_20151012_1321	2016-02-15 09:30:36.150929-05
53	reports	0002_auto_20151012_1321	2016-02-15 09:30:43.823996-05
54	reports	0003_auto_20151014_0817	2016-02-15 09:30:44.144574-05
55	reports	0004_auto_20151015_1202	2016-02-15 09:30:45.132171-05
56	reports	0005_auto_20151015_1930	2016-02-15 09:30:45.496212-05
57	reports	0006_auto_20151015_1934	2016-02-15 09:30:45.822887-05
58	reports	0007_auto_20151124_1245	2016-02-15 09:30:46.41448-05
59	reports	0008_auto_20151124_1417	2016-02-15 09:30:46.771011-05
60	reports	0009_auto_20151126_1702	2016-02-15 09:30:47.150726-05
61	reports	0010_auto_20160202_1756	2016-02-15 09:30:48.178084-05
62	reports	0011_auto_20160207_2248	2016-02-15 09:30:48.718774-05
63	reversion	0001_initial	2016-02-15 09:30:49.307206-05
64	reversion	0002_auto_20141216_1509	2016-02-15 09:30:49.685842-05
65	sessions	0001_initial	2016-02-15 09:30:49.775442-05
66	sites	0001_initial	2016-02-15 09:30:49.856359-05
67	socialaccount	0001_initial	2016-02-15 09:30:51.083954-05
68	socialaccount	0002_token_max_lengths	2016-02-15 09:30:52.43811-05
69	tpm	0001_initial	2016-02-15 09:30:52.88902-05
70	trips	0005_auto_20151014_1955	2016-02-15 09:30:53.569649-05
71	trips	0006_fileattachment_caption	2016-02-15 09:30:54.619997-05
72	trips	0007_auto_20151027_1852	2016-02-15 09:30:54.992605-05
73	trips	0008_auto_20151102_2052	2016-02-15 09:30:56.05401-05
74	trips	0009_auto_20151118_1151	2016-02-15 09:30:58.385098-05
75	trips	0010_auto_20160113_2233	2016-02-15 09:30:59.880787-05
76	users	0002_userprofile_country_override	2016-02-15 09:31:00.261218-05
77	users	0003_country_override	2016-02-15 09:31:00.352424-05
78	users	0004_userprofile_partner_staff_member	2016-02-15 09:31:01.43732-05
79	users	0005_country_buisness_area_code	2016-02-15 09:31:01.799617-05
80	users	0006_auto_20160204_1237	2016-02-15 09:31:02.11018-05
81	users	0007_auto_20160205_2230	2016-02-15 09:31:02.442501-05
82	users	0008_userprofile_countries_available	2016-02-15 09:31:02.74727-05
83	users	0009_countries_available	2016-02-15 09:31:02.821371-05
84	admin	0002_logentry_remove_auto_add	2016-02-23 10:43:50.166945-05
85	auth	0007_alter_validators_add_error_messages	2016-02-23 10:43:50.284455-05
86	locations	0004_auto_20160222_1652	2016-02-23 10:43:51.670749-05
87	partners	0021_partnerstaffmember_active	2016-02-23 10:44:01.856137-05
88	reports	0012_auto_20160222_1652	2016-02-23 10:44:09.974328-05
89	sites	0002_alter_domain_unique	2016-02-23 10:44:10.508358-05
90	users	0010_auto_20160216_1814	2016-02-23 10:44:15.982261-05
91	authtoken	0001_initial	2016-03-01 13:16:12.883352-05
92	funds	0002_grant_expiry	2016-03-01 13:16:12.903458-05
93	locations	0005_auto_20160226_1543	2016-03-01 13:16:12.992218-05
94	locations	0006_auto_20160229_1545	2016-03-01 13:16:13.075635-05
95	partners	0022_auto_20160223_2222	2016-03-01 13:16:14.391503-05
96	partners	0023_auto_20160228_0002	2016-03-01 13:16:16.087876-05
97	partners	0024_pca_fr_number	2016-03-01 13:16:16.319454-05
98	partners	0025_auto_20160229_1333	2016-03-01 13:16:16.750456-05
99	partners	0026_auto_20160229_1545	2016-03-01 13:16:17.598008-05
100	reports	0013_auto_20160226_1543	2016-03-01 13:16:17.843124-05
101	partners	0024_indicatorreport	2016-03-09 14:24:58.382632-05
102	partners	0027_resultchain_current_progress	2016-03-09 14:24:58.662368-05
103	partners	0028_auto_20160304_1840	2016-03-09 14:25:00.452836-05
104	partners	0029_auto_20160308_0142	2016-03-09 14:25:00.737037-05
105	reports	0014_auto_20160314_0319	2016-03-24 11:26:07.78111-04
106	partners	0030_auto_20160313_0006	2016-03-24 11:26:08.038183-04
107	partners	0031_auto_20160313_1241	2016-03-24 11:26:08.290166-04
108	partners	0032_pca_project_type	2016-03-24 11:26:08.55009-04
109	partners	0033_auto_20160313_2153	2016-03-24 11:26:08.87837-04
110	partners	0034_ramindicator	2016-03-24 11:26:09.206573-04
111	partners	0035_auto_20160314_1524	2016-03-24 11:26:10.054888-04
112	reports	0015_result_ram	2016-03-24 11:26:10.378742-04
113	users	0011_auto_20160313_1241	2016-03-24 11:26:11.083207-04
114	partners	0036_auto_20160328_0122	2016-04-20 09:51:05.286847-04
115	partners	0037_auto_20160329_0220	2016-04-20 09:51:06.096935-04
116	partners	0038_auto_20160404_1519	2016-04-20 09:51:06.927207-04
117	partners	0039_distributionplan_document	2016-04-20 09:51:07.215133-04
118	partners	0040_auto_20160411_1404	2016-04-20 09:51:08.523467-04
119	partners	0041_auto_20160413_0051	2016-04-20 09:51:09.073994-04
120	partners	0042_auto_20160413_1321	2016-04-20 09:51:09.340391-04
121	partners	0043_auto_20160413_1358	2016-04-20 09:51:09.626157-04
122	partners	0044_pca_planned_visits	2016-04-20 09:51:10.192502-04
123	reports	0016_auto_20160323_1933	2016-04-20 09:51:10.769784-04
124	trips	0011_linkedpartner	2016-04-20 09:51:11.128772-04
125	users	0012_country_vision_last_synced	2016-04-20 09:51:11.450803-04
126	vision	0001_initial	2016-04-20 09:51:12.14766-04
127	funds	0003_grant_description	2016-04-29 11:11:08.829299-04
128	partners	0045_remove_pcafile_file	2016-04-29 11:11:09.08614-04
129	partners	0046_auto_20160426_1521	2016-04-29 11:11:15.083814-04
130	partners	0047_auto_20160427_2035	2016-04-29 11:11:15.624329-04
131	partners	0048_indicatorduedates	2016-04-29 11:11:15.889732-04
132	partners	0049_auto_20160428_0213	2016-04-29 11:11:17.325151-04
133	partners	0050_partnerorganization_shared_partner	2016-04-29 11:11:17.61184-04
134	reports	0017_auto_20160428_1033	2016-04-29 11:11:17.940153-04
135	trips	0012_auto_20160425_1243	2016-04-29 11:11:18.624922-04
136	trips	0013_auto_20160428_1249	2016-04-29 11:11:19.60789-04
137	partners	0051_auto_20160505_1740	2016-05-10 09:09:44.219784-04
138	partners	0052_convert_disaggregation_to_json	2016-05-10 09:09:44.286516-04
139	partners	0053_auto_20160505_1810	2016-05-10 09:09:45.244832-04
140	partners	0054_bankdetails	2016-05-10 09:09:45.99148-04
141	partners	0055_auto_20160509_0934	2016-05-10 09:09:47.071812-04
142	partners	0056_auto_20160509_1330	2016-05-10 09:09:48.0252-04
143	partners	0057_auto_20160509_1827	2016-05-10 09:09:48.991701-04
144	users	0013_auto_20160509_2148	2016-05-10 09:09:50.516689-04
145	partners	0058_governmentinterventionresult_activities_list	2016-05-23 22:06:25.624103-04
146	trips	0014_auto_20160510_1432	2016-05-23 22:06:25.674938-04
147	trips	0015_auto_20160526_1916	2016-06-01 10:20:32.184998-04
148	trips	0016_auto_20160607_2237	2016-06-22 17:56:59.547475-04
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('django_migrations_id_seq', 148, true);


--
-- Data for Name: funds_donor; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY funds_donor (id, name) FROM stdin;
1	Maggio Group
2	Upton, Kub and Stamm
3	Gaylord - Bergstrom
4	Strosin, Gibson and Hammes
5	Cole - Schumm
\.


--
-- Name: funds_donor_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('funds_donor_id_seq', 1, false);


--
-- Data for Name: funds_grant; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY funds_grant (id, name, donor_id, expiry, description) FROM stdin;
\.


--
-- Name: funds_grant_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('funds_grant_id_seq', 1, false);


--
-- Data for Name: locations_cartodbtable; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY locations_cartodbtable (id, domain, api_key, table_name, display_name, name_col, pcode_col, parent_code_col, color, location_type_id, level, lft, parent_id, rght, tree_id) FROM stdin;
\.


--
-- Name: locations_cartodbtable_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('locations_cartodbtable_id_seq', 1, false);


--
-- Data for Name: locations_gatewaytype; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY locations_gatewaytype (id, name) FROM stdin;
1	Emmett
2	Eladio
3	Arnaldo
4	Ciara
5	Reyes
\.


--
-- Name: locations_gatewaytype_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('locations_gatewaytype_id_seq', 1, false);


--
-- Data for Name: locations_governorate; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY locations_governorate (id, name, p_code, color, geom, gateway_id) FROM stdin;
\.


--
-- Name: locations_governorate_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('locations_governorate_id_seq', 1, false);


--
-- Data for Name: locations_linkedlocation; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY locations_linkedlocation (id, object_id, content_type_id, governorate_id, locality_id, location_id, region_id) FROM stdin;
\.


--
-- Name: locations_linkedlocation_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('locations_linkedlocation_id_seq', 1, false);


--
-- Data for Name: locations_locality; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY locations_locality (id, cad_code, cas_code, cas_code_un, name, cas_village_name, p_code, color, geom, gateway_id, region_id) FROM stdin;
\.


--
-- Name: locations_locality_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('locations_locality_id_seq', 1, false);


--
-- Data for Name: locations_location; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY locations_location (id, name, latitude, longitude, p_code, point, gateway_id, locality_id, geom, level, lft, parent_id, rght, tree_id) FROM stdin;
1	Praesent	\N	\N		0101000020E61000000000000000A202404729584A3B744840	3	\N	\N	0	1	\N	2	1
2	Cras	\N	\N		0101000020E6100000000000000080C6BF78F3226ADDC94940	4	\N	\N	0	1	\N	2	2
3	Phasellus	\N	\N		0101000020E610000000000000008B2A40B7B21C5C22594A40	2	\N	\N	0	1	\N	2	3
4	Maecenas	\N	\N		\N	5	\N	\N	0	1	\N	2	4
\.


--
-- Name: locations_location_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('locations_location_id_seq', 4, true);


--
-- Data for Name: locations_region; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY locations_region (id, name, p_code, color, geom, gateway_id, governorate_id) FROM stdin;
\.


--
-- Name: locations_region_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('locations_region_id_seq', 1, false);


--
-- Data for Name: partners_agreement; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY partners_agreement (id, created, modified, start, "end", agreement_type, agreement_number, attached_agreement, signed_by_unicef_date, signed_by_partner_date, partner_id, partner_manager_id, signed_by_id, account_number, account_title, bank_address, bank_contact_person, bank_name, routing_details) FROM stdin;
1	2016-05-23 22:27:14.625203-04	2016-05-23 22:27:14.648861-04	\N	\N	SSFA			\N	\N	4	\N	\N	\N	\N		\N	\N	\N
2	2016-05-23 22:28:54.211088-04	2016-05-23 22:28:54.234731-04	\N	\N	AWP			\N	\N	2	\N	\N	\N	\N		\N	\N	\N
3	2016-05-23 22:32:02.791001-04	2016-05-23 22:32:02.811332-04	\N	\N	AWP			\N	\N	1	\N	\N	\N	\N		\N	\N	\N
\.


--
-- Name: partners_agreement_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('partners_agreement_id_seq', 3, true);


--
-- Data for Name: partners_agreementamendmentlog; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY partners_agreementamendmentlog (id, created, modified, type, amended_at, status, agreement_id) FROM stdin;
\.


--
-- Name: partners_agreementamendmentlog_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('partners_agreementamendmentlog_id_seq', 1, false);


--
-- Data for Name: partners_amendmentlog; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY partners_amendmentlog (id, created, modified, type, amended_at, partnership_id, status) FROM stdin;
\.


--
-- Name: partners_amendmentlog_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('partners_amendmentlog_id_seq', 1, false);


--
-- Data for Name: partners_assessment; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY partners_assessment (id, type, names_of_other_agencies, expected_budget, notes, requested_date, planned_date, completed_date, rating, report, current, approving_officer_id, partner_id, requesting_officer_id) FROM stdin;
\.


--
-- Name: partners_assessment_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('partners_assessment_id_seq', 1, false);


--
-- Data for Name: partners_authorizedofficer; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY partners_authorizedofficer (id, agreement_id, officer_id, amendment_id) FROM stdin;
\.


--
-- Name: partners_authorizedofficer_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('partners_authorizedofficer_id_seq', 1, false);


--
-- Data for Name: partners_bankdetails; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY partners_bankdetails (id, bank_name, bank_address, account_title, account_number, routing_details, bank_contact_person, agreement_id, amendment_id) FROM stdin;
\.


--
-- Name: partners_bankdetails_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('partners_bankdetails_id_seq', 1, false);


--
-- Data for Name: partners_directcashtransfer; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY partners_directcashtransfer (id, fc_ref, amount_usd, liquidation_usd, outstanding_balance_usd, "amount_less_than_3_Months_usd", amount_3_to_6_months_usd, amount_6_to_9_months_usd, "amount_more_than_9_Months_usd") FROM stdin;
\.


--
-- Name: partners_directcashtransfer_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('partners_directcashtransfer_id_seq', 1, false);


--
-- Data for Name: partners_distributionplan; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY partners_distributionplan (id, quantity, send, sent, delivered, item_id, partnership_id, site_id, document) FROM stdin;
1	5	f	f	0	1	2	2	\N
2	5	f	f	0	1	1	2	\N
\.


--
-- Name: partners_distributionplan_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('partners_distributionplan_id_seq', 2, true);


--
-- Data for Name: partners_filetype; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY partners_filetype (id, name) FROM stdin;
\.


--
-- Name: partners_filetype_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('partners_filetype_id_seq', 1, false);


--
-- Data for Name: partners_fundingcommitment; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY partners_fundingcommitment (id, fr_number, wbs, fc_type, fc_ref, fr_item_amount_usd, agreement_amount, commitment_amount, expenditure_amount, grant_id, intervention_id, "end", start) FROM stdin;
\.


--
-- Name: partners_fundingcommitment_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('partners_fundingcommitment_id_seq', 1, false);


--
-- Data for Name: partners_governmentintervention; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY partners_governmentintervention (id, partner_id, result_structure_id) FROM stdin;
\.


--
-- Name: partners_governmentintervention_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('partners_governmentintervention_id_seq', 1, false);


--
-- Data for Name: partners_governmentinterventionresult; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY partners_governmentinterventionresult (id, year, planned_amount, intervention_id, result_id, section_id, sector_id, activities) FROM stdin;
\.


--
-- Data for Name: partners_governmentinterventionresult_activities_list; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY partners_governmentinterventionresult_activities_list (id, governmentinterventionresult_id, result_id) FROM stdin;
\.


--
-- Name: partners_governmentinterventionresult_activities_list_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('partners_governmentinterventionresult_activities_list_id_seq', 1, false);


--
-- Name: partners_governmentinterventionresult_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('partners_governmentinterventionresult_id_seq', 1, false);


--
-- Data for Name: partners_governmentinterventionresult_unicef_managers; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY partners_governmentinterventionresult_unicef_managers (id, governmentinterventionresult_id, user_id) FROM stdin;
\.


--
-- Name: partners_governmentinterventionresult_unicef_managers_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('partners_governmentinterventionresult_unicef_managers_id_seq', 1, false);


--
-- Data for Name: partners_gwpcalocation; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY partners_gwpcalocation (id, tpm_visit, governorate_id, locality_id, location_id, pca_id, region_id, sector_id) FROM stdin;
1	f	\N	\N	2	1	\N	5
2	f	\N	\N	3	2	\N	1
3	f	\N	\N	2	3	\N	3
\.


--
-- Name: partners_gwpcalocation_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('partners_gwpcalocation_id_seq', 3, true);


--
-- Data for Name: partners_indicatorduedates; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY partners_indicatorduedates (id, due_date, intervention_id) FROM stdin;
\.


--
-- Name: partners_indicatorduedates_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('partners_indicatorduedates_id_seq', 1, false);


--
-- Data for Name: partners_indicatorreport; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY partners_indicatorreport (id, created, modified, total, disaggregated, disaggregation, remarks, indicator_id, location_id, partner_staff_member_id, result_chain_id, "end", start, report_status) FROM stdin;
\.


--
-- Name: partners_indicatorreport_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('partners_indicatorreport_id_seq', 1, false);


--
-- Data for Name: partners_partnerorganization; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY partners_partnerorganization (id, partner_type, name, short_name, description, address, email, phone_number, vendor_number, alternate_id, alternate_name, rating, core_values_assessment_date, core_values_assessment, cso_type, vision_synced, type_of_assessment, last_assessment_date, shared_partner) FROM stdin;
1	Wolff	Jettie	assumenda iure veritatis	asperiores eos eaque	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	undefined
2	Renner	Ellsworth	voluptatem ipsa est	quae optio sint	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	undefined
3	Ruecker	Molly	quia maiores pariatur	ab optio rem	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	undefined
4	Rowe	Elise	est ipsa ex	sint saepe consequatur	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	undefined
5	Zieme	Hunter	officia ipsa vel	ea a quos	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	undefined
\.


--
-- Name: partners_partnerorganization_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('partners_partnerorganization_id_seq', 1, false);


--
-- Data for Name: partners_partnershipbudget; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY partners_partnershipbudget (id, created, modified, partner_contribution, unicef_cash, in_kind_amount, total, amendment_id, partnership_id, year) FROM stdin;
\.


--
-- Name: partners_partnershipbudget_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('partners_partnershipbudget_id_seq', 1, false);


--
-- Data for Name: partners_partnerstaffmember; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY partners_partnerstaffmember (id, title, first_name, last_name, email, phone, partner_id, active) FROM stdin;
\.


--
-- Name: partners_partnerstaffmember_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('partners_partnerstaffmember_id_seq', 1, false);


--
-- Data for Name: partners_pca; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY partners_pca (id, partnership_type, number, title, status, start_date, end_date, initiation_date, submission_date, review_date, signed_by_unicef_date, signed_by_partner_date, sectors, current, created_at, updated_at, agreement_id, partner_id, partner_focal_point_id, partner_manager_id, result_structure_id, unicef_manager_id, fr_number, project_type, planned_visits) FROM stdin;
3	AWP	\N	Sed fringilla mauris sit	in_process	\N	\N	2016-05-23	\N	\N	\N	\N	\N	t	2016-05-23 22:32:57.443956-04	2016-05-23 22:33:25.822299-04	3	1	\N	\N	5	\N		\N	0
2	AWP	\N	Duis lobortis massa imperdiet quam	active	\N	\N	2016-05-23	\N	\N	\N	\N	\N	t	2016-05-23 22:29:22.089255-04	2016-05-23 22:34:48.169442-04	2	2	\N	\N	2	\N		\N	0
1	SSFA	\N	Praesent congue erat at massa	active	\N	\N	2016-05-23	\N	\N	\N	\N	\N	t	2016-05-23 22:27:36.335719-04	2016-05-23 22:36:50.079563-04	1	4	\N	\N	5	\N		\N	0
\.


--
-- Name: partners_pca_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('partners_pca_id_seq', 3, true);


--
-- Data for Name: partners_pca_unicef_managers; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY partners_pca_unicef_managers (id, pca_id, user_id) FROM stdin;
\.


--
-- Name: partners_pca_unicef_managers_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('partners_pca_unicef_managers_id_seq', 1, false);


--
-- Data for Name: partners_pcafile; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY partners_pcafile (id, pca_id, type_id, attachment) FROM stdin;
\.


--
-- Name: partners_pcafile_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('partners_pcafile_id_seq', 1, false);


--
-- Data for Name: partners_pcagrant; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY partners_pcagrant (id, created, modified, funds, amendment_id, grant_id, partnership_id) FROM stdin;
\.


--
-- Name: partners_pcagrant_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('partners_pcagrant_id_seq', 1, false);


--
-- Data for Name: partners_pcasector; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY partners_pcasector (id, created, modified, amendment_id, pca_id, sector_id) FROM stdin;
1	2016-05-23 22:36:49.971444-04	2016-05-23 22:36:50.106857-04	\N	1	5
\.


--
-- Name: partners_pcasector_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('partners_pcasector_id_seq', 1, true);


--
-- Data for Name: partners_pcasectorgoal; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY partners_pcasectorgoal (id, goal_id, pca_sector_id) FROM stdin;
\.


--
-- Name: partners_pcasectorgoal_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('partners_pcasectorgoal_id_seq', 1, false);


--
-- Data for Name: partners_ramindicator; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY partners_ramindicator (id, indicator_id, intervention_id, result_id) FROM stdin;
\.


--
-- Name: partners_ramindicator_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('partners_ramindicator_id_seq', 1, false);


--
-- Data for Name: partners_resultchain; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY partners_resultchain (id, target, indicator_id, partnership_id, result_id, result_type_id, code, in_kind_amount, partner_contribution, unicef_cash, disaggregation, current_progress) FROM stdin;
\.


--
-- Name: partners_resultchain_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('partners_resultchain_id_seq', 1, false);


--
-- Data for Name: partners_supplyplan; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY partners_supplyplan (id, quantity, item_id, partnership_id) FROM stdin;
1	10	1	2
2	10	1	1
\.


--
-- Name: partners_supplyplan_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('partners_supplyplan_id_seq', 2, true);


--
-- Data for Name: reports_goal; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY reports_goal (id, name, description, result_structure_id, sector_id) FROM stdin;
\.


--
-- Name: reports_goal_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('reports_goal_id_seq', 1, false);


--
-- Data for Name: reports_indicator; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY reports_indicator (id, name, code, total, sector_total, current, sector_current, view_on_dashboard, in_activity_info, result_id, result_structure_id, sector_id, unit_id, baseline, ram_indicator, target) FROM stdin;
\.


--
-- Data for Name: reports_indicator_activity_info_indicators; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY reports_indicator_activity_info_indicators (id, from_indicator_id, to_indicator_id) FROM stdin;
\.


--
-- Name: reports_indicator_activity_info_indicators_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('reports_indicator_activity_info_indicators_id_seq', 1, false);


--
-- Name: reports_indicator_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('reports_indicator_id_seq', 1, false);


--
-- Data for Name: reports_result; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY reports_result (id, name, code, result_structure_id, result_type_id, sector_id, gic_code, gic_name, humanitarian_tag, level, lft, parent_id, rght, sic_code, sic_name, tree_id, vision_id, wbs, activity_focus_code, activity_focus_name, hidden, from_date, to_date, ram) FROM stdin;
\.


--
-- Name: reports_result_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('reports_result_id_seq', 1, false);


--
-- Data for Name: reports_resultstructure; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY reports_resultstructure (id, name, from_date, to_date) FROM stdin;
1	Predovic Group	2001-01-01	2001-01-01
2	Mante, Ledner and Lockman	2001-01-01	2001-01-01
3	McClure, Hills and Luettgen	2001-01-01	2001-01-01
4	Schinner and Sons	2001-01-01	2001-01-01
5	Bode - Sporer	2001-01-01	2001-01-01
\.


--
-- Name: reports_resultstructure_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('reports_resultstructure_id_seq', 1, false);


--
-- Data for Name: reports_resulttype; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY reports_resulttype (id, name) FROM stdin;
\.


--
-- Name: reports_resulttype_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('reports_resulttype_id_seq', 1, false);


--
-- Data for Name: reports_sector; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY reports_sector (id, name, description, alternate_id, alternate_name, dashboard, color) FROM stdin;
1	Horizontal systemic ability	\N	\N	\N	t	\N
2	Distributed cohesive conglomeration	\N	\N	\N	t	\N
3	User-centric asymmetric database	\N	\N	\N	t	\N
4	Distributed responsive capacity	\N	\N	\N	t	\N
5	Centralized object-oriented data-warehouse	\N	\N	\N	t	\N
\.


--
-- Name: reports_sector_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('reports_sector_id_seq', 1, false);


--
-- Data for Name: reports_unit; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY reports_unit (id, type) FROM stdin;
\.


--
-- Name: reports_unit_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('reports_unit_id_seq', 1, false);


--
-- Data for Name: supplies_supplyitem; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY supplies_supplyitem (id, name, description) FROM stdin;
1	Praesent egestas tristique	Vivamus laoreet. Fusce commodo aliquam arcu. Phasellus a est. Sed augue ipsum, egestas nec, vestibulum et, malesuada adipiscing, dui. Suspendisse non nisl sit amet velit hendrerit rutrum.
\.


--
-- Name: supplies_supplyitem_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('supplies_supplyitem_id_seq', 1, true);


--
-- Data for Name: tpm_tpmvisit; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY tpm_tpmvisit (id, status, cycle_number, tentative_date, completed_date, comments, created_date, report, assigned_by_id, pca_id, pca_location_id) FROM stdin;
\.


--
-- Name: tpm_tpmvisit_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('tpm_tpmvisit_id_seq', 1, false);


--
-- Data for Name: trips_actionpoint; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY trips_actionpoint (id, description, due_date, actions_taken, completed_date, comments, status, created_date, person_responsible_id, trip_id, follow_up) FROM stdin;
2	Impedit praesentium ab dolores molestias commodi et. Quia aut doloremque dolorem est aut. Est inventore quibusdam.	2017-01-03	\N	\N	Voluptas repudiandae voluptatum in quos ea vel ullam minima. Quia enim aspernatur ex qui vel deserunt vel. Et explicabo excepturi doloribus. Optio illum et. Dolores et dolorem ut rerum quam alias similique sapiente in. Est est veniam.	open	2016-05-23 22:12:09.329712-04	5	8	f
\.


--
-- Name: trips_actionpoint_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('trips_actionpoint_id_seq', 2, true);


--
-- Data for Name: trips_fileattachment; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY trips_fileattachment (id, report, object_id, content_type_id, trip_id, type_id, caption) FROM stdin;
\.


--
-- Name: trips_fileattachment_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('trips_fileattachment_id_seq', 1, false);


--
-- Data for Name: trips_linkedpartner; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY trips_linkedpartner (id, intervention_id, partner_id, result_id, trip_id) FROM stdin;
\.


--
-- Name: trips_linkedpartner_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('trips_linkedpartner_id_seq', 1, false);


--
-- Data for Name: trips_travelroutes; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY trips_travelroutes (id, origin, destination, depart, arrive, remarks, trip_id) FROM stdin;
1	NYC	LDN	2016-04-19 14:45:00-04	2016-04-20 01:05:00-04		8
\.


--
-- Name: trips_travelroutes_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('trips_travelroutes_id_seq', 1, true);


--
-- Data for Name: trips_trip; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY trips_trip (id, status, cancelled_reason, purpose_of_travel, travel_type, security_clearance_required, international_travel, from_date, to_date, main_observations, constraints, lessons_learned, opportunities, ta_required, ta_drafted, ta_drafted_date, ta_reference, transport_booked, security_granted, approved_by_supervisor, date_supervisor_approved, approved_by_budget_owner, date_budget_owner_approved, approved_by_human_resources, date_human_resources_approved, representative_approval, date_representative_approved, approved_date, created_date, approved_email_sent, ta_trip_took_place_as_planned, ta_trip_repay_travel_allowance, ta_trip_final_claim, budget_owner_id, human_resources_id, office_id, owner_id, programme_assistant_id, representative_id, section_id, supervisor_id, travel_assistant_id, vision_approver_id, driver_id, driver_supervisor_id, driver_trip_id, pending_ta_amendment, submitted_email_sent) FROM stdin;
2	submitted		find luke	meeting	f	f	2016-01-01	2016-12-31					f	f	\N		f	f	f	\N	f	\N	\N	\N	\N	\N	\N	2016-02-15 10:06:44.415137-05	f	f	f	f	\N	\N	\N	4	\N	\N	\N	3	\N	\N	\N	\N	\N	f	t
6	approved		find han and chewie	meeting	f	f	2016-01-01	2016-12-31					f	f	\N		f	f	t	2016-03-01	f	\N	\N	\N	\N	\N	2016-03-01	2016-02-15 10:27:14.61473-05	t	f	f	f	\N	\N	\N	5	\N	\N	\N	4	\N	\N	\N	\N	\N	f	t
3	planned		learn how to use a lightsaber	meeting	f	f	2016-01-01	2016-12-31					f	f	\N		f	f	f	\N	f	\N	\N	\N	\N	\N	\N	2016-02-15 10:11:40.388791-05	f	f	f	f	\N	\N	\N	4	\N	\N	\N	2	\N	\N	\N	\N	\N	f	t
7	submitted		leave jakku	technical_support	f	f	2016-01-01	2016-12-31					f	f	\N		f	f	f	2016-03-28	f	\N	\N	\N	\N	\N	2016-03-28	2016-02-15 10:29:42.327017-05	t	f	f	f	\N	\N	\N	5	\N	\N	\N	4	\N	\N	\N	\N	\N	f	t
8	approved		bring bb-8 to d'qar	technical_support	f	f	2016-01-01	2016-12-31					f	f	\N		f	f	t	2016-04-19	f	\N	\N	\N	\N	\N	2016-04-20	2016-02-15 10:40:19.491323-05	t	f	f	f	\N	\N	\N	4	\N	\N	\N	2	\N	\N	\N	\N	\N	f	t
\.


--
-- Name: trips_trip_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('trips_trip_id_seq', 8, true);


--
-- Data for Name: trips_trip_partners; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY trips_trip_partners (id, trip_id, partnerorganization_id) FROM stdin;
\.


--
-- Name: trips_trip_partners_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('trips_trip_partners_id_seq', 1, false);


--
-- Data for Name: trips_trip_pcas; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY trips_trip_pcas (id, trip_id, pca_id) FROM stdin;
\.


--
-- Name: trips_trip_pcas_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('trips_trip_pcas_id_seq', 1, false);


--
-- Data for Name: trips_tripfunds; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY trips_tripfunds (id, amount, grant_id, trip_id, wbs_id) FROM stdin;
\.


--
-- Name: trips_tripfunds_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('trips_tripfunds_id_seq', 1, false);


--
-- Data for Name: trips_triplocation; Type: TABLE DATA; Schema: hoth; Owner: postgres
--

COPY trips_triplocation (id, governorate_id, locality_id, location_id, region_id, trip_id) FROM stdin;
\.


--
-- Name: trips_triplocation_id_seq; Type: SEQUENCE SET; Schema: hoth; Owner: postgres
--

SELECT pg_catalog.setval('trips_triplocation_id_seq', 1, false);


SET search_path = public, pg_catalog;

--
-- Data for Name: account_emailaddress; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY account_emailaddress (id, email, verified, "primary", user_id) FROM stdin;
\.


--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('account_emailaddress_id_seq', 1, false);


--
-- Data for Name: account_emailconfirmation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY account_emailconfirmation (id, created, sent, key, email_address_id) FROM stdin;
\.


--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('account_emailconfirmation_id_seq', 1, false);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY auth_group (id, name) FROM stdin;
5	Driver
6	Senior Management Team
7	Human Resources
8	Representative Office
9	read_only
10	Partnership Manager
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_group_id_seq', 10, true);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add permission	1	add_permission
2	Can change permission	1	change_permission
3	Can delete permission	1	delete_permission
4	Can add group	2	add_group
5	Can change group	2	change_group
6	Can delete group	2	delete_group
7	Can add user	3	add_user
8	Can change user	3	change_user
9	Can delete user	3	delete_user
10	Can add content type	4	add_contenttype
11	Can change content type	4	change_contenttype
12	Can delete content type	4	delete_contenttype
13	Can add session	5	add_session
14	Can change session	5	change_session
15	Can delete session	5	delete_session
16	Can add site	6	add_site
17	Can change site	6	change_site
18	Can delete site	6	delete_site
19	Can add log entry	7	add_logentry
20	Can change log entry	7	change_logentry
21	Can delete log entry	7	delete_logentry
22	Can add source	8	add_source
23	Can change source	8	change_source
24	Can delete source	8	delete_source
25	Can add thumbnail	9	add_thumbnail
26	Can change thumbnail	9	change_thumbnail
27	Can delete thumbnail	9	delete_thumbnail
28	Can add thumbnail dimensions	10	add_thumbnaildimensions
29	Can change thumbnail dimensions	10	change_thumbnaildimensions
30	Can delete thumbnail dimensions	10	delete_thumbnaildimensions
31	Can add Folder	11	add_folder
32	Can change Folder	11	change_folder
33	Can delete Folder	11	delete_folder
34	Can use directory listing	11	can_use_directory_listing
35	Can add folder permission	12	add_folderpermission
36	Can change folder permission	12	change_folderpermission
37	Can delete folder permission	12	delete_folderpermission
38	Can add file	13	add_file
39	Can change file	13	change_file
40	Can delete file	13	delete_file
41	Can add clipboard	14	add_clipboard
42	Can change clipboard	14	change_clipboard
43	Can delete clipboard	14	delete_clipboard
44	Can add clipboard item	15	add_clipboarditem
45	Can change clipboard item	15	change_clipboarditem
46	Can delete clipboard item	15	delete_clipboarditem
47	Can add image	16	add_image
48	Can change image	16	change_image
49	Can delete image	16	delete_image
50	Can add revision	17	add_revision
51	Can change revision	17	change_revision
52	Can delete revision	17	delete_revision
53	Can add version	18	add_version
54	Can change version	18	change_version
55	Can delete version	18	delete_version
56	Can add Generic Link	19	add_genericlink
57	Can change Generic Link	19	change_genericlink
58	Can delete Generic Link	19	delete_genericlink
59	Can add email	20	add_email
60	Can change email	20	change_email
61	Can delete email	20	delete_email
62	Can add log	21	add_log
63	Can change log	21	change_log
64	Can delete log	21	delete_log
65	Can add Email Template	22	add_emailtemplate
66	Can change Email Template	22	change_emailtemplate
67	Can delete Email Template	22	delete_emailtemplate
68	Can add attachment	23	add_attachment
69	Can change attachment	23	change_attachment
70	Can delete attachment	23	delete_attachment
71	Can add task state	24	add_taskmeta
72	Can change task state	24	change_taskmeta
73	Can delete task state	24	delete_taskmeta
74	Can add saved group result	25	add_tasksetmeta
75	Can change saved group result	25	change_tasksetmeta
76	Can delete saved group result	25	delete_tasksetmeta
77	Can add interval	26	add_intervalschedule
78	Can change interval	26	change_intervalschedule
79	Can delete interval	26	delete_intervalschedule
80	Can add crontab	27	add_crontabschedule
81	Can change crontab	27	change_crontabschedule
82	Can delete crontab	27	delete_crontabschedule
83	Can add periodic tasks	28	add_periodictasks
84	Can change periodic tasks	28	change_periodictasks
85	Can delete periodic tasks	28	delete_periodictasks
86	Can add periodic task	29	add_periodictask
87	Can change periodic task	29	change_periodictask
88	Can delete periodic task	29	delete_periodictask
89	Can add worker	30	add_workerstate
90	Can change worker	30	change_workerstate
91	Can delete worker	30	delete_workerstate
92	Can add task	31	add_taskstate
93	Can change task	31	change_taskstate
94	Can delete task	31	delete_taskstate
95	Can add cors model	32	add_corsmodel
96	Can change cors model	32	change_corsmodel
97	Can delete cors model	32	delete_corsmodel
98	Can add email address	33	add_emailaddress
99	Can change email address	33	change_emailaddress
100	Can delete email address	33	delete_emailaddress
101	Can add email confirmation	34	add_emailconfirmation
102	Can change email confirmation	34	change_emailconfirmation
103	Can delete email confirmation	34	delete_emailconfirmation
104	Can add social application	35	add_socialapp
105	Can change social application	35	change_socialapp
106	Can delete social application	35	delete_socialapp
107	Can add social account	36	add_socialaccount
108	Can change social account	36	change_socialaccount
109	Can delete social account	36	delete_socialaccount
110	Can add social application token	37	add_socialtoken
111	Can change social application token	37	change_socialtoken
112	Can delete social application token	37	delete_socialtoken
113	Can add country	38	add_country
114	Can change country	38	change_country
115	Can delete country	38	delete_country
116	Can add section	39	add_section
117	Can change section	39	change_section
118	Can delete section	39	delete_section
119	Can add office	40	add_office
120	Can change office	40	change_office
121	Can delete office	40	delete_office
122	Can add user profile	41	add_userprofile
123	Can change user profile	41	change_userprofile
124	Can delete user profile	41	delete_userprofile
125	Can add donor	42	add_donor
126	Can change donor	42	change_donor
127	Can delete donor	42	delete_donor
128	Can add grant	43	add_grant
129	Can change grant	43	change_grant
130	Can delete grant	43	delete_grant
131	Can add gateway type	44	add_gatewaytype
132	Can change gateway type	44	change_gatewaytype
133	Can delete gateway type	44	delete_gatewaytype
134	Can add governorate	45	add_governorate
135	Can change governorate	45	change_governorate
136	Can delete governorate	45	delete_governorate
137	Can add District	46	add_region
138	Can change District	46	change_region
139	Can delete District	46	delete_region
140	Can add Sub-district	47	add_locality
141	Can change Sub-district	47	change_locality
142	Can delete Sub-district	47	delete_locality
143	Can add location	48	add_location
144	Can change location	48	change_location
145	Can delete location	48	delete_location
146	Can add linked location	49	add_linkedlocation
147	Can change linked location	49	change_linkedlocation
148	Can delete linked location	49	delete_linkedlocation
149	Can add carto db table	50	add_cartodbtable
150	Can change carto db table	50	change_cartodbtable
151	Can delete carto db table	50	delete_cartodbtable
152	Can add database	51	add_database
153	Can change database	51	change_database
154	Can delete database	51	delete_database
155	Can add partner	52	add_partner
156	Can change partner	52	change_partner
157	Can delete partner	52	delete_partner
158	Can add activity	53	add_activity
159	Can change activity	53	change_activity
160	Can delete activity	53	delete_activity
161	Can add indicator	54	add_indicator
162	Can change indicator	54	change_indicator
163	Can delete indicator	54	delete_indicator
164	Can add attribute group	55	add_attributegroup
165	Can change attribute group	55	change_attributegroup
166	Can delete attribute group	55	delete_attributegroup
167	Can add attribute	56	add_attribute
168	Can change attribute	56	change_attribute
169	Can delete attribute	56	delete_attribute
170	Can add result structure	57	add_resultstructure
171	Can change result structure	57	change_resultstructure
172	Can delete result structure	57	delete_resultstructure
173	Can add result type	58	add_resulttype
174	Can change result type	58	change_resulttype
175	Can delete result type	58	delete_resulttype
176	Can add sector	59	add_sector
177	Can change sector	59	change_sector
178	Can delete sector	59	delete_sector
179	Can add result	60	add_result
180	Can change result	60	change_result
181	Can delete result	60	delete_result
182	Can add CCC	61	add_goal
183	Can change CCC	61	change_goal
184	Can delete CCC	61	delete_goal
185	Can add unit	62	add_unit
186	Can change unit	62	change_unit
187	Can delete unit	62	delete_unit
188	Can add indicator	63	add_indicator
189	Can change indicator	63	change_indicator
190	Can delete indicator	63	delete_indicator
191	Can add partner organization	64	add_partnerorganization
192	Can change partner organization	64	change_partnerorganization
193	Can delete partner organization	64	delete_partnerorganization
194	Can add partner staff member	65	add_partnerstaffmember
195	Can change partner staff member	65	change_partnerstaffmember
196	Can delete partner staff member	65	delete_partnerstaffmember
197	Can add assessment	66	add_assessment
198	Can change assessment	66	change_assessment
199	Can delete assessment	66	delete_assessment
200	Can add Key recommendation	67	add_recommendation
201	Can change Key recommendation	67	change_recommendation
202	Can delete Key recommendation	67	delete_recommendation
203	Can add agreement	68	add_agreement
204	Can change agreement	68	change_agreement
205	Can delete agreement	68	delete_agreement
206	Can add authorized officer	69	add_authorizedofficer
207	Can change authorized officer	69	change_authorizedofficer
208	Can delete authorized officer	69	delete_authorizedofficer
209	Can add Intervention	70	add_pca
210	Can change Intervention	70	change_pca
211	Can delete Intervention	70	delete_pca
212	Can add amendment log	71	add_amendmentlog
213	Can change amendment log	71	change_amendmentlog
214	Can delete amendment log	71	delete_amendmentlog
215	Can add partnership budget	72	add_partnershipbudget
216	Can change partnership budget	72	change_partnershipbudget
217	Can delete partnership budget	72	delete_partnershipbudget
218	Can add pca grant	73	add_pcagrant
219	Can change pca grant	73	change_pcagrant
220	Can delete pca grant	73	delete_pcagrant
221	Can add Partnership Location	74	add_gwpcalocation
222	Can change Partnership Location	74	change_gwpcalocation
223	Can delete Partnership Location	74	delete_gwpcalocation
224	Can add PCA Sector	75	add_pcasector
225	Can change PCA Sector	75	change_pcasector
226	Can delete PCA Sector	75	delete_pcasector
227	Can add CCC	76	add_pcasectorgoal
228	Can change CCC	76	change_pcasectorgoal
229	Can delete CCC	76	delete_pcasectorgoal
230	Can add indicator progress	77	add_indicatorprogress
231	Can change indicator progress	77	change_indicatorprogress
232	Can delete indicator progress	77	delete_indicatorprogress
233	Can add file type	78	add_filetype
234	Can change file type	78	change_filetype
235	Can delete file type	78	delete_filetype
236	Can add pca file	79	add_pcafile
237	Can change pca file	79	change_pcafile
238	Can delete pca file	79	delete_pcafile
239	Can add result chain	80	add_resultchain
240	Can change result chain	80	change_resultchain
241	Can delete result chain	80	delete_resultchain
242	Can add supply plan	81	add_supplyplan
243	Can change supply plan	81	change_supplyplan
244	Can delete supply plan	81	delete_supplyplan
245	Can add distribution plan	82	add_distributionplan
246	Can change distribution plan	82	change_distributionplan
247	Can delete distribution plan	82	delete_distributionplan
248	Can add trip	83	add_trip
249	Can change trip	83	change_trip
250	Can delete trip	83	delete_trip
251	Can add Funding	84	add_tripfunds
252	Can change Funding	84	change_tripfunds
253	Can delete Funding	84	delete_tripfunds
254	Can add trip location	85	add_triplocation
255	Can change trip location	85	change_triplocation
256	Can delete trip location	85	delete_triplocation
257	Can add Travel Itinerary	86	add_travelroutes
258	Can change Travel Itinerary	86	change_travelroutes
259	Can delete Travel Itinerary	86	delete_travelroutes
260	Can add action point	87	add_actionpoint
261	Can change action point	87	change_actionpoint
262	Can delete action point	87	delete_actionpoint
263	Can add file attachment	88	add_fileattachment
264	Can change file attachment	88	change_fileattachment
265	Can delete file attachment	88	delete_fileattachment
266	Can add TPM Visit	89	add_tpmvisit
267	Can change TPM Visit	89	change_tpmvisit
268	Can delete TPM Visit	89	delete_tpmvisit
269	Can add supply item	90	add_supplyitem
270	Can change supply item	90	change_supplyitem
271	Can delete supply item	90	delete_supplyitem
272	Can add token	91	add_token
273	Can change token	91	change_token
274	Can delete token	91	delete_token
275	Can add funding commitment	92	add_fundingcommitment
276	Can change funding commitment	92	change_fundingcommitment
277	Can delete funding commitment	92	delete_fundingcommitment
278	Can add direct cash transfer	93	add_directcashtransfer
279	Can change direct cash transfer	93	change_directcashtransfer
280	Can delete direct cash transfer	93	delete_directcashtransfer
281	Can add indicator report	94	add_indicatorreport
282	Can change indicator report	94	change_indicatorreport
283	Can delete indicator report	94	delete_indicatorreport
284	Can add ram indicator	95	add_ramindicator
285	Can change ram indicator	95	change_ramindicator
286	Can delete ram indicator	95	delete_ramindicator
287	Can add vision sync log	96	add_visionsynclog
288	Can change vision sync log	96	change_visionsynclog
289	Can delete vision sync log	96	delete_visionsynclog
290	Can add agreement amendment log	97	add_agreementamendmentlog
291	Can change agreement amendment log	97	change_agreementamendmentlog
292	Can delete agreement amendment log	97	delete_agreementamendmentlog
293	Can add linked partner	98	add_linkedpartner
294	Can change linked partner	98	change_linkedpartner
295	Can delete linked partner	98	delete_linkedpartner
296	Can add government intervention	99	add_governmentintervention
297	Can change government intervention	99	change_governmentintervention
298	Can delete government intervention	99	delete_governmentintervention
299	Can add government intervention result	100	add_governmentinterventionresult
300	Can change government intervention result	100	change_governmentinterventionresult
301	Can delete government intervention result	100	delete_governmentinterventionresult
302	Can add Report Due Date	101	add_indicatorduedates
303	Can change Report Due Date	101	change_indicatorduedates
304	Can delete Report Due Date	101	delete_indicatorduedates
305	Can add bank details	102	add_bankdetails
306	Can change bank details	102	change_bankdetails
307	Can delete bank details	102	delete_bankdetails
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_permission_id_seq', 307, true);


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
5	pbkdf2_sha256$20000$oZXu8tvCPRtW$jfQ70X25+mQuls1KqaR2J4qQEfaQPf8LOl5mQQDDgmM=	\N	t	finn@force.com	finn		finn@force.com	t	t	2016-02-15 09:27:16-05
1	pbkdf2_sha256$20000$oLSDagdBJZQe$GjusoFurVNg8wfUZ6TCR7w5SKz1W6QuSGNvfGfxn/oU=	2016-02-15 09:49:48-05	t	luke@force.com	luke		luke@force.com	t	t	2016-02-15 09:27:08-05
3	pbkdf2_sha256$20000$BwvYLpZCW0cD$v8brgatQrEEYnma9CP8m+6fohtQMw0zFcb0K3Wk/qbQ=	2016-02-15 10:03:00.183242-05	t	leia@force.com	leia		leia@force.com	t	t	2016-02-15 09:27:12-05
6	pbkdf2_sha256$20000$Ort98H5Fvhah$LZA7OhRpLW9LX0TzGJp9ge+HyJi6K7Y9DIuPhSqgmyU=	\N	t	bb8@force.com	bb8		bb8@force.com	t	t	2016-02-15 10:37:06-05
2	pbkdf2_sha256$20000$6MlpbG8f8UAz$3FJ8f+IfvQ8Sd+INDKZEBhKKP5a9t2VZBzyNqJloYuc=	2016-04-19 21:48:50.793195-04	t	han@force.com	han		han@force.com	t	t	2016-02-15 09:27:10-05
4	pbkdf2_sha256$20000$BAo8H3WDRa0E$vHMi+E7mTIEWqcHumAFvyl8M00rkKv3C44mdCcVGJCc=	2016-05-23 22:23:11.26348-04	t	rey@force.com	rey		rey@force.com	t	t	2016-02-15 09:27:14-05
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_user_id_seq', 6, true);


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- Data for Name: authtoken_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY authtoken_token (key, created, user_id) FROM stdin;
\.


--
-- Data for Name: celery_taskmeta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY celery_taskmeta (id, task_id, status, result, date_done, traceback, hidden, meta) FROM stdin;
\.


--
-- Name: celery_taskmeta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('celery_taskmeta_id_seq', 1, false);


--
-- Data for Name: celery_tasksetmeta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY celery_tasksetmeta (id, taskset_id, result, date_done, hidden) FROM stdin;
\.


--
-- Name: celery_tasksetmeta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('celery_tasksetmeta_id_seq', 1, false);


--
-- Data for Name: corsheaders_corsmodel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY corsheaders_corsmodel (id, cors) FROM stdin;
\.


--
-- Name: corsheaders_corsmodel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('corsheaders_corsmodel_id_seq', 1, false);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2016-02-15 09:31:02.921924-05	1	hoth	1		38	1
2	2016-02-15 09:31:22.868714-05	5	User profile for 	2	Changed country.	41	1
3	2016-02-15 09:31:22.88277-05	4	User profile for 	2	Changed country.	41	1
4	2016-02-15 09:31:22.895649-05	3	User profile for 	2	Changed country.	41	1
5	2016-02-15 09:31:22.911447-05	2	User profile for 	2	Changed country.	41	1
6	2016-02-15 09:31:22.924435-05	1	User profile for 	2	Changed country.	41	1
7	2016-02-15 09:50:46.017787-05	5	Driver	1		2	1
8	2016-02-15 09:52:28.575447-05	6	Senior Management Team	1		2	1
9	2016-02-15 09:55:54.712148-05	5	Finn	2	Changed first_name and email.	3	1
10	2016-02-15 09:56:04.088409-05	5	finn	2	Changed first_name and email.	3	1
11	2016-02-15 09:56:22.569564-05	2	han	2	Changed first_name.	3	1
12	2016-02-15 09:56:30.258919-05	3	leia	2	Changed first_name.	3	1
13	2016-02-15 09:56:36.100382-05	1	luke	2	Changed first_name.	3	1
14	2016-02-15 09:56:54.092472-05	4	rey	2	Changed first_name and email.	3	1
15	2016-02-15 09:57:51.709514-05	1	2016/1-0   2016-02-15 - 2016-02-29: find luke	1		83	1
16	2016-02-15 09:59:48.212536-05	1	2016/1-1   2016-02-15 - 2016-02-29: find luke	2	Changed status.	83	3
17	2016-02-15 10:03:51.141574-05	1	2016/1-2   2016-02-15 - 2016-02-29: find luke	3		83	3
18	2016-02-15 10:06:44.460675-05	2	2016/2-0   2016-02-15 - 2016-02-29: find luke	1		83	3
19	2016-02-15 10:11:40.433872-05	3	2016/3-0   2016-02-15 - 2016-04-15: learn how to use a lightsaber	1		83	3
20	2016-02-15 10:12:10.297116-05	3	2016/3-1   2016-02-15 - 2016-04-15: learn how to use a lightsaber	2	Changed travel_type.	83	3
21	2016-02-15 10:13:12.922016-05	3	2016/3-2   2016-02-15 - 2016-04-15: learn how to use a lightsaber	2	Changed travel_type.	83	3
22	2016-02-15 10:13:35.026983-05	3	2016/3-3   2016-02-10 - 2016-04-15: learn how to use a lightsaber	2	Changed from_date.	83	3
23	2016-02-15 10:16:38.309371-05	4	2016/4-0   2016-02-15 - 2016-02-26: find han	1		83	3
24	2016-02-15 10:17:24.11272-05	4	2016/4-1   2016-02-15 - 2016-02-26: find han	2	Changed travel_assistant.	83	3
25	2016-02-15 10:22:42.911974-05	4	2016/4-2   2016-02-15 - 2016-02-26: find han	2	Changed approved_by_supervisor and date_supervisor_approved.	83	4
26	2016-02-15 10:23:29.692135-05	4	2016/4-3   2016-02-15 - 2016-02-26: find han	2	Changed status.	83	4
27	2016-02-15 10:24:32.190987-05	4	2016/4-4   2016-02-15 - 2016-02-26: find han	2	Changed status.	83	4
28	2016-02-15 10:24:56.067099-05	4	2016/4-5   2016-02-15 - 2016-02-26: find han	2	Changed status.	83	4
29	2016-02-15 10:25:20.933475-05	4	2016/4-6   2016-02-15 - 2016-02-26: find han	3		83	4
30	2016-02-15 10:25:57.721092-05	5	2016/5-0   2016-02-15 - 2016-02-26: find han / chewie	1		83	4
31	2016-02-15 10:26:10.724081-05	5	2016/5-1   2016-02-15 - 2016-02-26: find han / chewie	2	Changed approved_by_supervisor and date_supervisor_approved.	83	4
32	2016-02-15 10:26:23.828828-05	5	2016/5-2   2016-02-15 - 2016-02-26: find han / chewie	2	Changed status.	83	4
33	2016-02-15 10:26:38.690026-05	5	2016/5-3   2016-02-15 - 2016-02-26: find han / chewie	2	Changed approved_by_supervisor.	83	4
34	2016-02-15 10:26:49.710041-05	5	2016/5-4   2016-02-15 - 2016-02-26: find han / chewie	3		83	4
35	2016-02-15 10:27:14.664094-05	6	2016/6-0   2016-02-15 - 2016-02-26: find han and chewie	1		83	4
36	2016-02-15 10:27:30.66817-05	6	2016/6-1   2016-02-15 - 2016-02-26: find han and chewie	2	Changed status.	83	4
37	2016-02-15 10:29:42.373929-05	7	2016/7-0   2016-01-01 - 2016-03-26: bring bb-8 to leia	1		83	4
38	2016-02-15 10:30:24.076831-05	7	2016/7-1   2016-01-01 - 2016-03-26: bring bb-8 to leia	2	Changed status.	83	4
39	2016-02-15 10:37:38.491699-05	6	User profile for 	2	Changed country.	41	4
40	2016-02-15 10:38:00.813702-05	6	bb8	2	Changed first_name.	3	4
41	2016-02-15 10:39:04.117812-05	7	2016/7-2   2016-01-01 - 2016-03-26: leave jakku	2	Changed purpose_of_travel.	83	4
42	2016-02-15 10:40:19.53627-05	8	2016/8-0   2016-01-01 - 2016-04-22: bring bb-8 to d'qar	1		83	4
43	2016-02-15 10:59:21.748632-05	8	2016/8-1   2016-01-01 - 2016-04-22: bring bb-8 to d'qar	2	Changed status.	83	2
44	2016-02-15 11:24:49.790115-05	8	2016/8-2   2016-01-01 - 2016-12-31: bring bb-8 to d'qar	2	Changed approved_by_supervisor and date_supervisor_approved.	83	2
45	2016-04-19 21:48:24.019512-04	8	2016/8-3   2016-01-01 - 2016-12-31: bring bb-8 to d'qar	2	Added Travel Itinerary "TravelRoutes object".	83	4
46	2016-04-19 21:49:22.125306-04	8	2016/8-4   2016-01-01 - 2016-12-31: bring bb-8 to d'qar	2	Changed approved_by_supervisor and date_supervisor_approved.	83	2
47	2016-05-23 22:25:22.681976-04	1	Praesent (Arnaldo PCode: )	1		48	4
48	2016-05-23 22:25:48.742328-04	2	Cras (Ciara PCode: )	1		48	4
49	2016-05-23 22:26:09.568087-04	3	Phasellus (Eladio PCode: )	1		48	4
50	2016-05-23 22:26:23.836198-04	4	Maecenas (Reyes PCode: )	1		48	4
51	2016-05-23 22:27:14.654706-04	1	SSFA for Elise ( - )	1		68	4
52	2016-05-23 22:27:36.382883-04	1	Elise: /SSFA201601	1		70	4
53	2016-05-23 22:27:44.965836-04	1	Elise: /SSFA201601	2	Changed status.	70	4
54	2016-05-23 22:27:54.828791-04	1	Elise: /SSFA201601	2	Changed result_structure.	70	4
55	2016-05-23 22:28:32.972549-04	1	Elise: /SSFA201601	2	Added Partnership Location " -> Cras (Ciara PCode: )".	70	4
56	2016-05-23 22:28:54.241234-04	2	AWP for Ellsworth ( - )	1		68	4
57	2016-05-23 22:29:22.133378-04	2	Ellsworth: /AWP201601/AWP201601	1		70	4
58	2016-05-23 22:29:36.551742-04	2	Ellsworth: /AWP201601/AWP201601	2	Added Partnership Location " -> Phasellus (Eladio PCode: )".	70	4
59	2016-05-23 22:30:52.906493-04	2	Ellsworth: /AWP201601/AWP201601	2	Changed result_structure.	70	4
60	2016-05-23 22:32:02.816023-04	3	AWP for Jettie ( - )	1		68	4
61	2016-05-23 22:32:57.485874-04	3	Jettie: /AWP201602/AWP201601	1		70	4
62	2016-05-23 22:33:25.871011-04	3	Jettie: /AWP201602/AWP201601	2	Added Partnership Location " -> Cras (Ciara PCode: )".	70	4
63	2016-05-23 22:34:22.013552-04	1	Praesent egestas tristique	1		90	4
64	2016-05-23 22:34:27.42199-04	2	Ellsworth: /AWP201601/AWP201601	2	Added supply plan "SupplyPlan object".	70	4
65	2016-05-23 22:34:48.223955-04	2	Ellsworth: /AWP201601/AWP201601	2	Added distribution plan "Ellsworth: /AWP201601/AWP201601-Praesent egestas tristique-Cras (Ciara PCode: )-5".	70	4
66	2016-05-23 22:35:36.437234-04	1	Elise: /SSFA201601	2	Added supply plan "SupplyPlan object".	70	4
67	2016-05-23 22:35:51.644239-04	1	Elise: /SSFA201601	2	Added distribution plan "Elise: /SSFA201601-Praesent egestas tristique-Cras (Ciara PCode: )-5".	70	4
68	2016-05-23 22:36:50.12372-04	1	Elise: /SSFA201601	2	Added PCA Sector "Elise: None: Centralized object-oriented data-warehouse".	70	4
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 68, true);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_content_type (id, app_label, model) FROM stdin;
1	auth	permission
2	auth	group
3	auth	user
4	contenttypes	contenttype
5	sessions	session
6	sites	site
7	admin	logentry
8	easy_thumbnails	source
9	easy_thumbnails	thumbnail
10	easy_thumbnails	thumbnaildimensions
11	filer	folder
12	filer	folderpermission
13	filer	file
14	filer	clipboard
15	filer	clipboarditem
16	filer	image
17	reversion	revision
18	reversion	version
19	generic_links	genericlink
20	post_office	email
21	post_office	log
22	post_office	emailtemplate
23	post_office	attachment
24	djcelery	taskmeta
25	djcelery	tasksetmeta
26	djcelery	intervalschedule
27	djcelery	crontabschedule
28	djcelery	periodictasks
29	djcelery	periodictask
30	djcelery	workerstate
31	djcelery	taskstate
32	corsheaders	corsmodel
33	account	emailaddress
34	account	emailconfirmation
35	socialaccount	socialapp
36	socialaccount	socialaccount
37	socialaccount	socialtoken
38	users	country
39	users	section
40	users	office
41	users	userprofile
42	funds	donor
43	funds	grant
44	locations	gatewaytype
45	locations	governorate
46	locations	region
47	locations	locality
48	locations	location
49	locations	linkedlocation
50	locations	cartodbtable
51	activityinfo	database
52	activityinfo	partner
53	activityinfo	activity
54	activityinfo	indicator
55	activityinfo	attributegroup
56	activityinfo	attribute
57	reports	resultstructure
58	reports	resulttype
59	reports	sector
60	reports	result
61	reports	goal
62	reports	unit
63	reports	indicator
64	partners	partnerorganization
65	partners	partnerstaffmember
66	partners	assessment
67	partners	recommendation
68	partners	agreement
69	partners	authorizedofficer
70	partners	pca
71	partners	amendmentlog
72	partners	partnershipbudget
73	partners	pcagrant
74	partners	gwpcalocation
75	partners	pcasector
76	partners	pcasectorgoal
77	partners	indicatorprogress
78	partners	filetype
79	partners	pcafile
80	partners	resultchain
81	partners	supplyplan
82	partners	distributionplan
83	trips	trip
84	trips	tripfunds
85	trips	triplocation
86	trips	travelroutes
87	trips	actionpoint
88	trips	fileattachment
89	tpm	tpmvisit
90	supplies	supplyitem
91	authtoken	token
92	partners	fundingcommitment
93	partners	directcashtransfer
94	partners	indicatorreport
95	partners	ramindicator
96	vision	visionsynclog
97	partners	agreementamendmentlog
98	trips	linkedpartner
99	partners	governmentintervention
100	partners	governmentinterventionresult
101	partners	indicatorduedates
102	partners	bankdetails
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_content_type_id_seq', 102, true);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2016-02-15 09:25:58.415637-05
2	auth	0001_initial	2016-02-15 09:25:58.526911-05
3	account	0001_initial	2016-02-15 09:25:58.62444-05
4	account	0002_email_max_length	2016-02-15 09:25:58.652378-05
5	activityinfo	0001_initial	2016-02-15 09:25:58.813744-05
6	activityinfo	0002_auto_20151004_2246	2016-02-15 09:25:58.865676-05
7	admin	0001_initial	2016-02-15 09:25:58.940262-05
8	contenttypes	0002_remove_content_type_name	2016-02-15 09:25:59.039046-05
9	auth	0002_alter_permission_name_max_length	2016-02-15 09:25:59.073244-05
10	auth	0003_alter_user_email_max_length	2016-02-15 09:25:59.107739-05
11	auth	0004_alter_user_username_opts	2016-02-15 09:25:59.141792-05
12	auth	0005_alter_user_last_login_null	2016-02-15 09:25:59.174995-05
13	auth	0006_require_contenttypes_0002	2016-02-15 09:25:59.177288-05
14	djcelery	0001_initial	2016-02-15 09:25:59.381698-05
15	easy_thumbnails	0001_initial	2016-02-15 09:25:59.499176-05
16	easy_thumbnails	0002_thumbnaildimensions	2016-02-15 09:25:59.526826-05
17	filer	0001_initial	2016-02-15 09:26:00.407123-05
18	filer	0002_auto_20150606_2003	2016-02-15 09:26:00.48922-05
19	funds	0001_initial	2016-02-15 09:26:00.546967-05
20	generic_links	0001_initial	2016-02-15 09:26:00.673983-05
21	locations	0001_initial	2016-02-15 09:26:02.100295-05
22	locations	0002_auto_20151211_1528	2016-02-15 09:26:03.136387-05
23	locations	0003_auto_20151216_1339	2016-02-15 09:26:03.224371-05
24	supplies	0001_initial	2016-02-15 09:26:03.258534-05
25	reports	0001_initial	2016-02-15 09:26:05.330153-05
26	partners	0001_initial	2016-02-15 09:26:16.994314-05
27	partners	0002_auto_20151009_2046	2016-02-15 09:26:17.61639-05
28	partners	0003_auto_20151012_1321	2016-02-15 09:26:19.366181-05
29	partners	0004_auto_20151014_0817	2016-02-15 09:26:19.976321-05
30	partners	0005_auto_20151014_1955	2016-02-15 09:26:21.908072-05
31	partners	0006_auto_20151015_1202	2016-02-15 09:26:22.545376-05
32	partners	0007_auto_20151018_2024	2016-02-15 09:26:23.608155-05
33	partners	0008_auto_20151018_2238	2016-02-15 09:26:24.025319-05
34	partners	0009_auto_20151022_1216	2016-02-15 09:26:24.243065-05
35	partners	0010_auto_20151027_1852	2016-02-15 09:26:24.480051-05
36	partners	0011_auto_20151102_2052	2016-02-15 09:26:24.945689-05
37	partners	0012_auto_20151109_1503	2016-02-15 09:26:25.191971-05
38	partners	0013_auto_20151118_1151	2016-02-15 09:26:26.614078-05
39	partners	0014_auto_20151119_1310	2016-02-15 09:26:27.085148-05
40	partners	0015_auto_20151120_1817	2016-02-15 09:26:27.95538-05
41	partners	0016_auto_20151126_1702	2016-02-15 09:26:28.433532-05
42	partners	0017_auto_20151203_1758	2016-02-15 09:26:28.645351-05
43	partners	0018_auto_20151211_1528	2016-02-15 09:26:28.858269-05
44	partners	0019_auto_20160113_1554	2016-02-15 09:26:29.982137-05
45	partners	0020_auto_20160127_1751	2016-02-15 09:26:30.901809-05
46	post_office	0001_initial	2016-02-15 09:26:31.202001-05
47	post_office	0002_add_i18n_and_backend_alias	2016-02-15 09:26:32.458716-05
48	users	0001_initial	2016-02-15 09:26:33.353028-05
49	trips	0001_initial	2016-02-15 09:26:34.951966-05
50	trips	0002_auto_20151004_2225	2016-02-15 09:26:40.080273-05
51	trips	0003_auto_20151009_2046	2016-02-15 09:26:40.356592-05
52	trips	0004_auto_20151012_1321	2016-02-15 09:26:40.632625-05
53	reports	0002_auto_20151012_1321	2016-02-15 09:26:46.750177-05
54	reports	0003_auto_20151014_0817	2016-02-15 09:26:47.020992-05
55	reports	0004_auto_20151015_1202	2016-02-15 09:26:48.377929-05
56	reports	0005_auto_20151015_1930	2016-02-15 09:26:48.633115-05
57	reports	0006_auto_20151015_1934	2016-02-15 09:26:48.884438-05
58	reports	0007_auto_20151124_1245	2016-02-15 09:26:49.409517-05
59	reports	0008_auto_20151124_1417	2016-02-15 09:26:49.664418-05
60	reports	0009_auto_20151126_1702	2016-02-15 09:26:49.916046-05
61	reports	0010_auto_20160202_1756	2016-02-15 09:26:50.183454-05
62	reports	0011_auto_20160207_2248	2016-02-15 09:26:50.69434-05
63	reversion	0001_initial	2016-02-15 09:26:51.714323-05
64	reversion	0002_auto_20141216_1509	2016-02-15 09:26:51.998685-05
65	sessions	0001_initial	2016-02-15 09:26:52.069591-05
66	sites	0001_initial	2016-02-15 09:26:52.137177-05
67	socialaccount	0001_initial	2016-02-15 09:26:54.991811-05
68	socialaccount	0002_token_max_lengths	2016-02-15 09:26:56.135946-05
69	tpm	0001_initial	2016-02-15 09:26:56.73176-05
70	trips	0005_auto_20151014_1955	2016-02-15 09:26:57.341217-05
71	trips	0006_fileattachment_caption	2016-02-15 09:26:57.667504-05
72	trips	0007_auto_20151027_1852	2016-02-15 09:26:58.01031-05
73	trips	0008_auto_20151102_2052	2016-02-15 09:26:59.536632-05
74	trips	0009_auto_20151118_1151	2016-02-15 09:27:01.595795-05
75	trips	0010_auto_20160113_2233	2016-02-15 09:27:02.800052-05
76	users	0002_userprofile_country_override	2016-02-15 09:27:03.132715-05
77	users	0003_country_override	2016-02-15 09:27:03.159953-05
78	users	0004_userprofile_partner_staff_member	2016-02-15 09:27:03.501344-05
79	users	0005_country_buisness_area_code	2016-02-15 09:27:03.835372-05
80	users	0006_auto_20160204_1237	2016-02-15 09:27:04.753977-05
81	users	0007_auto_20160205_2230	2016-02-15 09:27:05.028088-05
82	users	0008_userprofile_countries_available	2016-02-15 09:27:05.32112-05
83	users	0009_countries_available	2016-02-15 09:27:05.347971-05
84	admin	0002_logentry_remove_auto_add	2016-02-23 10:43:23.980643-05
85	auth	0007_alter_validators_add_error_messages	2016-02-23 10:43:24.099567-05
86	locations	0004_auto_20160222_1652	2016-02-23 10:43:25.422673-05
87	partners	0021_partnerstaffmember_active	2016-02-23 10:43:35.555118-05
88	reports	0012_auto_20160222_1652	2016-02-23 10:43:43.779917-05
89	sites	0002_alter_domain_unique	2016-02-23 10:43:44.196252-05
90	users	0010_auto_20160216_1814	2016-02-23 10:43:49.750313-05
91	authtoken	0001_initial	2016-03-01 13:15:28.261321-05
92	funds	0002_grant_expiry	2016-03-01 13:15:28.279897-05
93	locations	0005_auto_20160226_1543	2016-03-01 13:15:28.369164-05
94	locations	0006_auto_20160229_1545	2016-03-01 13:15:28.450532-05
95	partners	0022_auto_20160223_2222	2016-03-01 13:15:29.836448-05
96	partners	0023_auto_20160228_0002	2016-03-01 13:15:31.475126-05
97	partners	0024_pca_fr_number	2016-03-01 13:15:31.699887-05
98	partners	0025_auto_20160229_1333	2016-03-01 13:15:31.910017-05
99	partners	0026_auto_20160229_1545	2016-03-01 13:15:32.75021-05
100	reports	0013_auto_20160226_1543	2016-03-01 13:15:33.03515-05
101	partners	0024_indicatorreport	2016-03-09 14:24:51.033068-05
102	partners	0027_resultchain_current_progress	2016-03-09 14:24:51.307647-05
103	partners	0028_auto_20160304_1840	2016-03-09 14:24:53.072575-05
104	partners	0029_auto_20160308_0142	2016-03-09 14:24:53.343751-05
105	reports	0014_auto_20160314_0319	2016-03-24 11:25:29.477171-04
106	partners	0030_auto_20160313_0006	2016-03-24 11:25:29.730313-04
107	partners	0031_auto_20160313_1241	2016-03-24 11:25:29.981638-04
108	partners	0032_pca_project_type	2016-03-24 11:25:30.237403-04
109	partners	0033_auto_20160313_2153	2016-03-24 11:25:30.722149-04
110	partners	0034_ramindicator	2016-03-24 11:25:30.972268-04
111	partners	0035_auto_20160314_1524	2016-03-24 11:25:31.459293-04
112	reports	0015_result_ram	2016-03-24 11:25:31.722345-04
113	users	0011_auto_20160313_1241	2016-03-24 11:25:32.35077-04
114	partners	0036_auto_20160328_0122	2016-04-20 09:49:38.042577-04
115	partners	0037_auto_20160329_0220	2016-04-20 09:49:38.608164-04
116	partners	0038_auto_20160404_1519	2016-04-20 09:49:39.769012-04
117	partners	0039_distributionplan_document	2016-04-20 09:49:40.042101-04
118	partners	0040_auto_20160411_1404	2016-04-20 09:49:41.157315-04
119	partners	0041_auto_20160413_0051	2016-04-20 09:49:41.966559-04
120	partners	0042_auto_20160413_1321	2016-04-20 09:49:42.223905-04
121	partners	0043_auto_20160413_1358	2016-04-20 09:49:42.507943-04
122	partners	0044_pca_planned_visits	2016-04-20 09:49:42.786022-04
123	reports	0016_auto_20160323_1933	2016-04-20 09:49:43.366539-04
124	trips	0011_linkedpartner	2016-04-20 09:49:43.695923-04
125	users	0012_country_vision_last_synced	2016-04-20 09:49:44.30225-04
126	vision	0001_initial	2016-04-20 09:49:45.005898-04
127	funds	0003_grant_description	2016-04-29 11:09:45.259484-04
128	partners	0045_remove_pcafile_file	2016-04-29 11:09:45.544624-04
129	partners	0046_auto_20160426_1521	2016-04-29 11:09:51.931111-04
130	partners	0047_auto_20160427_2035	2016-04-29 11:09:52.740499-04
131	partners	0048_indicatorduedates	2016-04-29 11:09:52.991619-04
132	partners	0049_auto_20160428_0213	2016-04-29 11:09:54.017421-04
133	partners	0050_partnerorganization_shared_partner	2016-04-29 11:09:54.287804-04
134	reports	0017_auto_20160428_1033	2016-04-29 11:09:54.789931-04
135	trips	0012_auto_20160425_1243	2016-04-29 11:09:55.41374-04
136	trips	0013_auto_20160428_1249	2016-04-29 11:09:56.028095-04
137	partners	0051_auto_20160505_1740	2016-05-10 09:09:22.200263-04
138	partners	0052_convert_disaggregation_to_json	2016-05-10 09:09:22.227415-04
139	partners	0053_auto_20160505_1810	2016-05-10 09:09:22.773193-04
140	partners	0054_bankdetails	2016-05-10 09:09:23.253678-04
141	partners	0055_auto_20160509_0934	2016-05-10 09:09:23.830977-04
142	partners	0056_auto_20160509_1330	2016-05-10 09:09:24.447978-04
143	partners	0057_auto_20160509_1827	2016-05-10 09:09:25.154995-04
144	users	0013_auto_20160509_2148	2016-05-10 09:09:26.268793-04
145	partners	0058_governmentinterventionresult_activities_list	2016-05-23 22:06:11.646164-04
146	trips	0014_auto_20160510_1432	2016-05-23 22:06:11.67875-04
147	trips	0015_auto_20160526_1916	2016-06-01 10:20:30.536829-04
148	trips	0016_auto_20160607_2237	2016-06-22 17:56:56.874069-04
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_migrations_id_seq', 148, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
3qbyf0oe0nd84gxjylhvg7ic8xyc2092	NWNjMDM3Nzg5ZThlMzgxYTNmMDA1M2U1NWQwZjI2Mjk0ZGU5MTUyNjp7Il9hdXRoX3VzZXJfaGFzaCI6ImFlYmY0NDI2ZmVjMzRkYzE5YzRlNmM5ZjRmMzE4YWVhMjU0YjczODUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2016-02-29 09:49:48.443724-05
u8lxo4e2m20kvl5bbvxf9zvruv6pehgp	NWRiYzhhZmFjZTMxYTBlM2ViZGVkZGQ1NDU5ZjJmNzgxYTFmMzg0MDp7Il9hdXRoX3VzZXJfaGFzaCI6IjlmMzA0YWI3ZTA3YTExZWMwMzljMTNiMDNiOTUxODgyZjI0ZTBhNWIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI0In0=	2016-02-29 10:22:11.825055-05
fi6yauvz57edo5e6lpr8sylmxm8uh665	YmE2OGY4NWJmNmQ2YTc3ZDQ3OWNkMTNhMjdiOGZlNmQyMWQzNmJhNDp7Il9hdXRoX3VzZXJfaGFzaCI6IjA1NGFkMzAxZDllZDI4MGFlMTBkMDQ5NzVkYzQ0NzgxM2M4YTJmZjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-02-29 10:59:02.20368-05
dp17ua786fw4yzqzjdzfc9bqbxltt1av	YmE2OGY4NWJmNmQ2YTc3ZDQ3OWNkMTNhMjdiOGZlNmQyMWQzNmJhNDp7Il9hdXRoX3VzZXJfaGFzaCI6IjA1NGFkMzAxZDllZDI4MGFlMTBkMDQ5NzVkYzQ0NzgxM2M4YTJmZjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-02-29 11:24:22.873822-05
h17r2hiydd8v1qw5vw6pr0fzbmdvoeqk	NmExYjI2YzZjNzI4NzQwODExYjBlMmEyNTZhMWI3NWQyZjljYzZjNTp7Il9hdXRoX3VzZXJfaGFzaCI6IjMwNzkyYjBmZThlNzkwY2EzNWY0MTljMGNlOWJhYTFhYjZkYjk3ODMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI0In0=	2016-04-11 14:46:48.221871-04
96aeauxcs63hflbxyw50mtneif49wyfk	NmExYjI2YzZjNzI4NzQwODExYjBlMmEyNTZhMWI3NWQyZjljYzZjNTp7Il9hdXRoX3VzZXJfaGFzaCI6IjMwNzkyYjBmZThlNzkwY2EzNWY0MTljMGNlOWJhYTFhYjZkYjk3ODMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI0In0=	2016-05-03 21:47:46.337835-04
yu7o3fyoe7bczd7a9ccp6n8di6s9qaa1	YmE2OGY4NWJmNmQ2YTc3ZDQ3OWNkMTNhMjdiOGZlNmQyMWQzNmJhNDp7Il9hdXRoX3VzZXJfaGFzaCI6IjA1NGFkMzAxZDllZDI4MGFlMTBkMDQ5NzVkYzQ0NzgxM2M4YTJmZjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-05-03 21:48:50.796034-04
j99pbh8of1lhl5ofyy0x8043ikby43k7	NmExYjI2YzZjNzI4NzQwODExYjBlMmEyNTZhMWI3NWQyZjljYzZjNTp7Il9hdXRoX3VzZXJfaGFzaCI6IjMwNzkyYjBmZThlNzkwY2EzNWY0MTljMGNlOWJhYTFhYjZkYjk3ODMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI0In0=	2016-06-06 22:23:11.265824-04
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_site (id, domain, name) FROM stdin;
1	example.com	example.com
\.


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_site_id_seq', 1, true);


--
-- Data for Name: djcelery_crontabschedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY djcelery_crontabschedule (id, minute, hour, day_of_week, day_of_month, month_of_year) FROM stdin;
\.


--
-- Name: djcelery_crontabschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('djcelery_crontabschedule_id_seq', 1, false);


--
-- Data for Name: djcelery_intervalschedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY djcelery_intervalschedule (id, every, period) FROM stdin;
\.


--
-- Name: djcelery_intervalschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('djcelery_intervalschedule_id_seq', 1, false);


--
-- Data for Name: djcelery_periodictask; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY djcelery_periodictask (id, name, task, args, kwargs, queue, exchange, routing_key, expires, enabled, last_run_at, total_run_count, date_changed, description, crontab_id, interval_id) FROM stdin;
\.


--
-- Name: djcelery_periodictask_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('djcelery_periodictask_id_seq', 1, false);


--
-- Data for Name: djcelery_periodictasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY djcelery_periodictasks (ident, last_update) FROM stdin;
\.


--
-- Data for Name: djcelery_taskstate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY djcelery_taskstate (id, state, task_id, name, tstamp, args, kwargs, eta, expires, result, traceback, runtime, retries, hidden, worker_id) FROM stdin;
\.


--
-- Name: djcelery_taskstate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('djcelery_taskstate_id_seq', 1, false);


--
-- Data for Name: djcelery_workerstate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY djcelery_workerstate (id, hostname, last_heartbeat) FROM stdin;
\.


--
-- Name: djcelery_workerstate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('djcelery_workerstate_id_seq', 1, false);


--
-- Data for Name: easy_thumbnails_source; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY easy_thumbnails_source (id, storage_hash, name, modified) FROM stdin;
\.


--
-- Name: easy_thumbnails_source_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('easy_thumbnails_source_id_seq', 1, false);


--
-- Data for Name: easy_thumbnails_thumbnail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY easy_thumbnails_thumbnail (id, storage_hash, name, modified, source_id) FROM stdin;
\.


--
-- Name: easy_thumbnails_thumbnail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('easy_thumbnails_thumbnail_id_seq', 1, false);


--
-- Data for Name: easy_thumbnails_thumbnaildimensions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY easy_thumbnails_thumbnaildimensions (id, thumbnail_id, width, height) FROM stdin;
\.


--
-- Name: easy_thumbnails_thumbnaildimensions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('easy_thumbnails_thumbnaildimensions_id_seq', 1, false);


--
-- Data for Name: filer_clipboard; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY filer_clipboard (id, user_id) FROM stdin;
\.


--
-- Name: filer_clipboard_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('filer_clipboard_id_seq', 1, false);


--
-- Data for Name: filer_clipboarditem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY filer_clipboarditem (id, clipboard_id, file_id) FROM stdin;
\.


--
-- Name: filer_clipboarditem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('filer_clipboarditem_id_seq', 1, false);


--
-- Data for Name: filer_file; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY filer_file (id, file, _file_size, sha1, has_all_mandatory_data, original_filename, name, description, uploaded_at, modified_at, is_public, folder_id, owner_id, polymorphic_ctype_id) FROM stdin;
\.


--
-- Name: filer_file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('filer_file_id_seq', 1, false);


--
-- Data for Name: filer_folder; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY filer_folder (id, name, uploaded_at, created_at, modified_at, lft, rght, tree_id, level, owner_id, parent_id) FROM stdin;
\.


--
-- Name: filer_folder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('filer_folder_id_seq', 1, false);


--
-- Data for Name: filer_folderpermission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY filer_folderpermission (id, type, everybody, can_edit, can_read, can_add_children, folder_id, group_id, user_id) FROM stdin;
\.


--
-- Name: filer_folderpermission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('filer_folderpermission_id_seq', 1, false);


--
-- Data for Name: filer_image; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY filer_image (file_ptr_id, _height, _width, date_taken, default_alt_text, default_caption, author, must_always_publish_author_credit, must_always_publish_copyright, subject_location) FROM stdin;
\.


--
-- Data for Name: generic_links_genericlink; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY generic_links_genericlink (id, object_id, url, title, description, created_at, is_external, content_type_id, user_id) FROM stdin;
\.


--
-- Name: generic_links_genericlink_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('generic_links_genericlink_id_seq', 1, false);


--
-- Data for Name: post_office_attachment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY post_office_attachment (id, file, name) FROM stdin;
\.


--
-- Data for Name: post_office_attachment_emails; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY post_office_attachment_emails (id, attachment_id, email_id) FROM stdin;
\.


--
-- Name: post_office_attachment_emails_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('post_office_attachment_emails_id_seq', 1, false);


--
-- Name: post_office_attachment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('post_office_attachment_id_seq', 1, false);


--
-- Data for Name: post_office_email; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY post_office_email (id, from_email, "to", cc, bcc, subject, message, html_message, status, priority, created, last_updated, scheduled_time, headers, context, template_id, backend_alias) FROM stdin;
1	rey@force.com	rey@force.com, leia@force.com			eTools  - Trip 2016/1-1 has been Submitted for rey	\n    Dear Colleague,\n\n    Trip 2016/1-1 has been Submitted for rey here:\n    http://example.com/admin/trips/trip/1/\n    Purpose of travel: find luke\n\n    Thank you.\n    		0	3	2016-02-15 09:59:46.183374-05	2016-02-15 09:59:48.151742-05	\N	\N	\N	\N	
2	finn@force.com	rey@force.com			eTools  - Travel for finn	\n    Dear rey,\n\n    Please organise the travel and security clearance (if needed) for the following trip:\n\n    http://example.com/admin/trips/trip/4/\n\n    Thanks,\n    finn\n    		0	3	2016-02-15 10:23:24.483753-05	2016-02-15 10:23:26.312603-05	\N	\N	\N	\N	
3	finn@force.com	finn@force.com, rey@force.com			eTools  - Trip Approved: 2016/4-3	\n    The following trip has been approved: 2016/4-3\n\n    http://example.com/admin/trips/trip/4/\n\n    Thank you.\n    		0	3	2016-02-15 10:23:26.366815-05	2016-02-15 10:23:28.120399-05	\N	\N	\N	\N	
4	finn@force.com	rey@force.com			eTools  - Travel for finn	\n    Dear rey,\n\n    Please organise the travel and security clearance (if needed) for the following trip:\n\n    http://example.com/admin/trips/trip/4/\n\n    Thanks,\n    finn\n    		0	3	2016-02-15 10:23:28.176827-05	2016-02-15 10:23:29.641541-05	\N	\N	\N	\N	
5	finn@force.com	rey@force.com			eTools  - Travel for finn	\n    Dear rey,\n\n    Please organise the travel and security clearance (if needed) for the following trip:\n\n    http://example.com/admin/trips/trip/4/\n\n    Thanks,\n    finn\n    		0	3	2016-02-15 10:24:29.39981-05	2016-02-15 10:24:32.13883-05	\N	\N	\N	\N	
6	finn@force.com	rey@force.com			eTools  - Travel for finn	\n    Dear rey,\n\n    Please organise the travel and security clearance (if needed) for the following trip:\n\n    http://example.com/admin/trips/trip/4/\n\n    Thanks,\n    finn\n    		0	3	2016-02-15 10:24:53.580344-05	2016-02-15 10:24:56.018288-05	\N	\N	\N	\N	
7	finn@force.com	finn@force.com, rey@force.com			eTools  - Trip Approved: 2016/5-2	\n    The following trip has been approved: 2016/5-2\n\n    http://example.com/admin/trips/trip/5/\n\n    Thank you.\n    		0	3	2016-02-15 10:26:20.555251-05	2016-02-15 10:26:23.770597-05	\N	\N	\N	\N	
8	finn@force.com	finn@force.com, rey@force.com			eTools  - Trip 2016/6-1 has been Submitted for finn	\n    Dear Colleague,\n\n    Trip 2016/6-1 has been Submitted for finn here:\n    http://example.com/admin/trips/trip/6/\n    Purpose of travel: find han and chewie\n\n    Thank you.\n    		0	3	2016-02-15 10:27:28.785283-05	2016-02-15 10:27:30.612068-05	\N	\N	\N	\N	
9	finn@force.com	finn@force.com, rey@force.com			eTools  - Trip 2016/7-1 has been Submitted for finn	\n    Dear Colleague,\n\n    Trip 2016/7-1 has been Submitted for finn here:\n    http://example.com/admin/trips/trip/7/\n    Purpose of travel: bring bb-8 to leia\n\n    Thank you.\n    		0	3	2016-02-15 10:30:03.141839-05	2016-02-15 10:30:23.973847-05	\N	\N	\N	\N	
10	rey@force.com	rey@force.com, han@force.com			eTools  - Trip 2016/8-1 has been Submitted for rey	\n    Dear Colleague,\n\n    Trip 2016/8-1 has been Submitted for rey here:\n    http://example.com/admin/trips/trip/8/\n    Purpose of travel: bring bb-8 to d&#39;qar\n\n    Thank you.\n    		0	3	2016-02-15 10:59:16.324178-05	2016-02-15 10:59:21.693784-05	\N	\N	\N	\N	
11	rey@force.com	rey@force.com, han@force.com			eTools  - Trip Approved: 2016/8-2	\n    The following trip has been approved: 2016/8-2\n\n    http://example.com/admin/trips/trip/8/\n\n    Thank you.\n    		0	3	2016-02-15 11:24:44.15781-05	2016-02-15 11:24:49.73508-05	\N	\N	\N	\N	
12	rey@force.com	rey@force.com, leia@force.com			eTools  - Trip 2016/2-1 has been Submitted for rey	\n    Dear Colleague,\n\n    Trip 2016/2-1 has been Submitted for rey here:\n    http://example.com/admin/trips/trip/2/change/\n    Purpose of travel: find luke\n\n    Thank you.\n    		0	3	2016-03-01 15:00:21.909249-05	2016-03-01 15:00:23.184729-05	\N	\N	\N	\N	
13	finn@force.com	finn@force.com, rey@force.com			eTools  - Trip Approved: 2016/6-2	\n    The following trip has been approved: 2016/6-2\n\n    http://example.com/admin/trips/trip/6/change/\n\n    Thank you.\n    		0	3	2016-03-01 15:00:38.586462-05	2016-03-01 15:00:40.2055-05	\N	\N	\N	\N	
14	rey@force.com	rey@force.com, han@force.com			eTools  - Trip 2016/3-4 has been Submitted for rey	\n    Dear Colleague,\n\n    Trip 2016/3-4 has been Submitted for rey here:\n    http://example.com/admin/trips/trip/3/\n    Purpose of travel: learn how to use a lightsaber\n\n    Thank you.\n    		0	3	2016-03-24 11:30:53.678782-04	2016-03-24 11:30:59.4886-04	\N	\N	\N	\N	
15	rey@force.com	rey@force.com, finn@force.com, han@force.com			eTools  - Trip action point Created for trip: 2016/8-3	\n    Trip action point by rey for finn was Created:"\n\n    http://example.com/admin/trips/trip/8/#reporting\n\n    Thank you.\n    		0	3	2016-03-24 11:32:10.107471-04	2016-03-24 11:32:15.934213-04	\N	\N	\N	\N	
16	finn@force.com	finn@force.com, rey@force.com			eTools  - Trip Approved: 2016/7-3	\n    The following trip has been approved: 2016/7-3\n\n    http://example.com/admin/trips/trip/7/\n\n    Thank you.\n    		0	3	2016-03-24 11:33:35.640929-04	2016-03-24 11:33:39.250994-04	\N	\N	\N	\N	
17	rey@force.com	rey@force.com, han@force.com			eTools  - Trip 2016/8-3 has been Submitted for rey	\n    Dear Colleague,\n\n    Trip 2016/8-3 has been Submitted for rey here:\n    http://example.com/admin/trips/trip/8/\n    Purpose of travel: bring bb-8 to d&#39;qar\n\n    Thank you.\n    		0	3	2016-04-19 21:48:22.351754-04	2016-04-19 21:48:24.005679-04	\N	\N	\N	\N	
18	rey@force.com	rey@force.com, han@force.com			eTools  - Trip Approved: 2016/8-4	\n    The following trip has been approved: 2016/8-4\n\n    http://example.com/admin/trips/trip/8/\n\n    Thank you.\n    		0	3	2016-04-19 21:49:20.465584-04	2016-04-19 21:49:22.106529-04	\N	\N	\N	\N	
19	rey@force.com	rey@force.com, finn@force.com, han@force.com			eTools  - Trip action point Created for trip: 2016/8-5	\n    Trip action point by rey for finn was Created:"\n\n    http://example.com/admin/trips/trip/8/#reporting\n\n    Thank you.\n    		0	3	2016-05-23 22:12:09.33969-04	2016-05-23 22:12:09.344215-04	\N	\N	\N	\N	
20	no-reply@unicef.org				Partnership Elise: /SSFA201601 has been Created	\n    Dear Colleague,\n\n    Partnership Elise: /SSFA201601 has been Created here:\n\n    http://example.com/admin/partners/pca/1/\n\n    Thank you.\n    		0	3	2016-05-23 22:27:36.355973-04	2016-05-23 22:27:36.363189-04	\N	\N	\N	\N	
21	no-reply@unicef.org				Partnership Elise: /SSFA201601 has been Updated	\n    Dear Colleague,\n\n    Partnership Elise: /SSFA201601 has been Updated here:\n\n    http://example.com/admin/partners/pca/1/\n\n    Thank you.\n    		0	3	2016-05-23 22:27:44.942569-04	2016-05-23 22:27:44.946449-04	\N	\N	\N	\N	
22	no-reply@unicef.org				Partnership Elise: /SSFA201601 has been Updated	\n    Dear Colleague,\n\n    Partnership Elise: /SSFA201601 has been Updated here:\n\n    http://example.com/admin/partners/pca/1/\n\n    Thank you.\n    		0	3	2016-05-23 22:27:54.805249-04	2016-05-23 22:27:54.808895-04	\N	\N	\N	\N	
23	no-reply@unicef.org				Partnership Elise: /SSFA201601 has been Updated	\n    Dear Colleague,\n\n    Partnership Elise: /SSFA201601 has been Updated here:\n\n    http://example.com/admin/partners/pca/1/\n\n    Thank you.\n    		0	3	2016-05-23 22:28:32.946163-04	2016-05-23 22:28:32.949377-04	\N	\N	\N	\N	
24	no-reply@unicef.org				Partnership Ellsworth: /AWP201601/AWP201601 has been Updated	\n    Dear Colleague,\n\n    Partnership Ellsworth: /AWP201601/AWP201601 has been Updated here:\n\n    http://example.com/admin/partners/pca/2/\n\n    Thank you.\n    		0	3	2016-05-23 22:29:22.108449-04	2016-05-23 22:29:22.111798-04	\N	\N	\N	\N	
25	no-reply@unicef.org				Partnership Ellsworth: /AWP201601/AWP201601 has been Updated	\n    Dear Colleague,\n\n    Partnership Ellsworth: /AWP201601/AWP201601 has been Updated here:\n\n    http://example.com/admin/partners/pca/2/\n\n    Thank you.\n    		0	3	2016-05-23 22:29:36.523149-04	2016-05-23 22:29:36.526658-04	\N	\N	\N	\N	
26	no-reply@unicef.org				Partnership Ellsworth: /AWP201601/AWP201601 has been Updated	\n    Dear Colleague,\n\n    Partnership Ellsworth: /AWP201601/AWP201601 has been Updated here:\n\n    http://example.com/admin/partners/pca/2/\n\n    Thank you.\n    		0	3	2016-05-23 22:30:52.879025-04	2016-05-23 22:30:52.882874-04	\N	\N	\N	\N	
27	no-reply@unicef.org				Partnership Jettie: /AWP201602/AWP201601 has been Updated	\n    Dear Colleague,\n\n    Partnership Jettie: /AWP201602/AWP201601 has been Updated here:\n\n    http://example.com/admin/partners/pca/3/\n\n    Thank you.\n    		0	3	2016-05-23 22:32:57.461675-04	2016-05-23 22:32:57.464729-04	\N	\N	\N	\N	
28	no-reply@unicef.org				Partnership Jettie: /AWP201602/AWP201601 has been Updated	\n    Dear Colleague,\n\n    Partnership Jettie: /AWP201602/AWP201601 has been Updated here:\n\n    http://example.com/admin/partners/pca/3/\n\n    Thank you.\n    		0	3	2016-05-23 22:33:25.839819-04	2016-05-23 22:33:25.843793-04	\N	\N	\N	\N	
29	no-reply@unicef.org				Partnership Ellsworth: /AWP201601/AWP201601 has been Updated	\n    Dear Colleague,\n\n    Partnership Ellsworth: /AWP201601/AWP201601 has been Updated here:\n\n    http://example.com/admin/partners/pca/2/\n\n    Thank you.\n    		0	3	2016-05-23 22:34:27.394462-04	2016-05-23 22:34:27.398451-04	\N	\N	\N	\N	
30	no-reply@unicef.org				Partnership Ellsworth: /AWP201601/AWP201601 has been Updated	\n    Dear Colleague,\n\n    Partnership Ellsworth: /AWP201601/AWP201601 has been Updated here:\n\n    http://example.com/admin/partners/pca/2/\n\n    Thank you.\n    		0	3	2016-05-23 22:34:48.187627-04	2016-05-23 22:34:48.191794-04	\N	\N	\N	\N	
31	no-reply@unicef.org				Partnership Elise: /SSFA201601 has been Updated	\n    Dear Colleague,\n\n    Partnership Elise: /SSFA201601 has been Updated here:\n\n    http://example.com/admin/partners/pca/1/\n\n    Thank you.\n    		0	3	2016-05-23 22:35:36.411294-04	2016-05-23 22:35:36.414869-04	\N	\N	\N	\N	
32	no-reply@unicef.org				Partnership Elise: /SSFA201601 has been Updated	\n    Dear Colleague,\n\n    Partnership Elise: /SSFA201601 has been Updated here:\n\n    http://example.com/admin/partners/pca/1/\n\n    Thank you.\n    		0	3	2016-05-23 22:35:51.608283-04	2016-05-23 22:35:51.611672-04	\N	\N	\N	\N	
33	no-reply@unicef.org				Partnership Elise: /SSFA201601 has been Updated	\n    Dear Colleague,\n\n    Partnership Elise: /SSFA201601 has been Updated here:\n\n    http://example.com/admin/partners/pca/1/\n\n    Thank you.\n    		0	3	2016-05-23 22:36:50.094667-04	2016-05-23 22:36:50.097888-04	\N	\N	\N	\N	
\.


--
-- Name: post_office_email_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('post_office_email_id_seq', 33, true);


--
-- Data for Name: post_office_emailtemplate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY post_office_emailtemplate (id, name, description, subject, content, html_content, created, last_updated, default_template_id, language) FROM stdin;
1	trips/trip/created/updated	The email that is sent to the supervisor, budget owner, traveller for any update	eTools {{environment}} - Trip {{number}} has been {{state}} for {{owner_name}}	\n    Dear Colleague,\n\n    Trip {{number}} has been {{state}} for {{owner_name}} here:\n    {{url}}\n    Purpose of travel: {{ purpose_of_travel }}\n\n    Thank you.\n    		2016-02-15 09:59:46.152638-05	2016-02-15 09:59:46.152667-05	\N	
2	travel/trip/travel_or_admin_assistant	This e-mail will be sent when the trip is approved by the supervisor. It will go to the travel assistant to prompt them to organise the travel (vehicles, flights etc.) and request security clearance.	eTools {{environment}} - Travel for {{owner_name}}	\n    Dear {{travel_assistant}},\n\n    Please organise the travel and security clearance (if needed) for the following trip:\n\n    {{url}}\n\n    Thanks,\n    {{owner_name}}\n    		2016-02-15 10:23:24.4546-05	2016-02-15 10:23:24.454629-05	\N	
3	trips/trip/approved	The email that is sent to the traveller if a trip has been approved	eTools {{environment}} - Trip Approved: {{trip_reference}}	\n    The following trip has been approved: {{trip_reference}}\n\n    {{url}}\n\n    Thank you.\n    		2016-02-15 10:23:26.339907-05	2016-02-15 10:23:26.339936-05	\N	
4	trips/action/created	Sent when trip action points are created	eTools {{environment}} - Trip action point {{state}} for trip: {{trip_reference}}	\n    Trip action point by {{owner_name}} for {{responsible}} was {{state}}:"\n\n    {{url}}\n\n    Thank you.\n    		2016-03-24 11:32:10.098681-04	2016-03-24 11:32:10.098712-04	\N	
5	partners/partnership/created/updated	The email that is sent when a partnership is added or is updated	Partnership {{number}} has been {{state}}	\n    Dear Colleague,\n\n    Partnership {{number}} has been {{state}} here:\n\n    {{url}}\n\n    Thank you.\n    		2016-05-23 22:27:36.345963-04	2016-05-23 22:27:36.34599-04	\N	
\.


--
-- Name: post_office_emailtemplate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('post_office_emailtemplate_id_seq', 5, true);


--
-- Data for Name: post_office_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY post_office_log (id, date, status, exception_type, message, email_id) FROM stdin;
1	2016-02-15 09:59:48.161581-05	0			1
2	2016-02-15 10:23:26.323244-05	0			2
3	2016-02-15 10:23:28.129249-05	0			3
4	2016-02-15 10:23:29.650867-05	0			4
5	2016-02-15 10:24:32.148703-05	0			5
6	2016-02-15 10:24:56.027473-05	0			6
7	2016-02-15 10:26:23.779693-05	0			7
8	2016-02-15 10:27:30.621094-05	0			8
9	2016-02-15 10:30:23.993322-05	0			9
10	2016-02-15 10:59:21.703252-05	0			10
11	2016-02-15 11:24:49.744227-05	0			11
12	2016-03-01 15:00:23.195221-05	0			12
13	2016-03-01 15:00:40.209049-05	0			13
14	2016-03-24 11:30:59.498061-04	0			14
15	2016-03-24 11:32:15.938329-04	0			15
16	2016-03-24 11:33:39.254403-04	0			16
17	2016-04-19 21:48:24.007825-04	0			17
18	2016-04-19 21:49:22.108774-04	0			18
19	2016-05-23 22:12:09.346649-04	0			19
20	2016-05-23 22:27:36.365629-04	0			20
21	2016-05-23 22:27:44.948416-04	0			21
22	2016-05-23 22:27:54.811151-04	0			22
23	2016-05-23 22:28:32.95138-04	0			23
24	2016-05-23 22:29:22.114585-04	0			24
25	2016-05-23 22:29:36.529411-04	0			25
26	2016-05-23 22:30:52.884868-04	0			26
27	2016-05-23 22:32:57.467125-04	0			27
28	2016-05-23 22:33:25.845943-04	0			28
29	2016-05-23 22:34:27.400768-04	0			29
30	2016-05-23 22:34:48.19405-04	0			30
31	2016-05-23 22:35:36.416916-04	0			31
32	2016-05-23 22:35:51.614666-04	0			32
33	2016-05-23 22:36:50.100393-04	0			33
\.


--
-- Name: post_office_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('post_office_log_id_seq', 33, true);


--
-- Data for Name: reversion_revision; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY reversion_revision (id, manager_slug, date_created, comment, user_id) FROM stdin;
1	default	2016-02-15 09:57:51.792871-05	Initial version.	1
2	default	2016-02-15 09:59:48.306569-05	Changed status.	3
3	default	2016-02-15 10:06:44.5455-05	Initial version.	3
4	default	2016-02-15 10:11:40.519073-05	Initial version.	3
5	default	2016-02-15 10:12:10.393162-05	Changed travel_type.	3
6	default	2016-02-15 10:13:13.012775-05	Changed travel_type.	3
7	default	2016-02-15 10:13:35.145734-05	Changed from_date.	3
8	default	2016-02-15 10:16:38.400095-05	Initial version.	3
9	default	2016-02-15 10:17:24.198006-05	Changed travel_assistant.	3
10	default	2016-02-15 10:22:42.998531-05	Changed approved_by_supervisor and date_supervisor_approved.	4
11	default	2016-02-15 10:23:29.785612-05	Changed status.	4
12	default	2016-02-15 10:24:32.27222-05	Changed status.	4
13	default	2016-02-15 10:24:56.154636-05	Changed status.	4
14	default	2016-02-15 10:25:57.800433-05	Initial version.	4
15	default	2016-02-15 10:26:10.802344-05	Changed approved_by_supervisor and date_supervisor_approved.	4
16	default	2016-02-15 10:26:23.91752-05	Changed status.	4
17	default	2016-02-15 10:26:38.77644-05	Changed approved_by_supervisor.	4
18	default	2016-02-15 10:27:14.749754-05	Initial version.	4
19	default	2016-02-15 10:27:30.753816-05	Changed status.	4
20	default	2016-02-15 10:29:42.456385-05	Initial version.	4
21	default	2016-02-15 10:30:24.200719-05	Changed status.	4
22	default	2016-02-15 10:39:04.211166-05	Changed purpose_of_travel.	4
23	default	2016-02-15 10:40:19.621637-05	Initial version.	4
24	default	2016-02-15 10:59:21.831276-05	Changed status.	2
25	default	2016-02-15 11:24:49.885674-05	Changed approved_by_supervisor and date_supervisor_approved.	2
26	default	2016-04-19 21:48:24.03886-04	Added Travel Itinerary "TravelRoutes object".	4
27	default	2016-04-19 21:49:22.145337-04	Changed approved_by_supervisor and date_supervisor_approved.	2
28	default	2016-05-23 22:27:36.416995-04	Initial version.	4
29	default	2016-05-23 22:27:44.992123-04	Changed status.	4
30	default	2016-05-23 22:27:54.854915-04	Changed result_structure.	4
31	default	2016-05-23 22:28:32.9989-04	Added Partnership Location " -> Cras (Ciara PCode: )".	4
32	default	2016-05-23 22:29:22.164922-04	Initial version.	4
33	default	2016-05-23 22:29:36.583726-04	Added Partnership Location " -> Phasellus (Eladio PCode: )".	4
34	default	2016-05-23 22:30:52.938883-04	Changed result_structure.	4
35	default	2016-05-23 22:32:57.51573-04	Initial version.	4
36	default	2016-05-23 22:33:25.906906-04	Added Partnership Location " -> Cras (Ciara PCode: )".	4
37	default	2016-05-23 22:34:27.456384-04	Added supply plan "SupplyPlan object".	4
38	default	2016-05-23 22:34:48.264041-04	Added distribution plan "Ellsworth: /AWP201601/AWP201601-Praesent egestas tristique-Cras (Ciara PCode: )-5".	4
39	default	2016-05-23 22:35:36.468585-04	Added supply plan "SupplyPlan object".	4
40	default	2016-05-23 22:35:51.686299-04	Added distribution plan "Elise: /SSFA201601-Praesent egestas tristique-Cras (Ciara PCode: )-5".	4
41	default	2016-05-23 22:36:50.166129-04	Added PCA Sector "Elise: None: Centralized object-oriented data-warehouse".	4
\.


--
-- Name: reversion_revision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('reversion_revision_id_seq', 41, true);


--
-- Data for Name: reversion_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY reversion_version (id, object_id, object_id_int, format, serialized_data, object_repr, content_type_id, revision_id) FROM stdin;
1	1	1	json	[{"fields": {"ta_trip_repay_travel_allowance": false, "programme_assistant": null, "office": null, "date_human_resources_approved": null, "budget_owner": null, "date_budget_owner_approved": null, "human_resources": null, "ta_required": false, "pending_ta_amendment": false, "to_date": "2016-02-29", "approved_email_sent": false, "owner": 4, "supervisor": 3, "ta_reference": "", "approved_by_human_resources": null, "driver_supervisor": null, "partners": [], "main_observations": "", "representative": null, "submitted_email_sent": false, "section": null, "approved_by_supervisor": false, "opportunities": "", "approved_date": null, "from_date": "2016-02-15", "ta_drafted": false, "ta_drafted_date": null, "travel_type": "staff_development", "driver_trip": null, "status": "planned", "lessons_learned": "", "security_granted": false, "vision_approver": null, "purpose_of_travel": "find luke", "international_travel": false, "driver": null, "representative_approval": null, "approved_by_budget_owner": false, "security_clearance_required": false, "pcas": [], "travel_assistant": null, "transport_booked": false, "date_supervisor_approved": null, "date_representative_approved": null, "ta_trip_took_place_as_planned": false, "created_date": "2016-02-15T14:57:51.663Z", "cancelled_reason": "", "ta_trip_final_claim": false, "constraints": ""}, "model": "trips.trip", "pk": 1}]	2016/1-0   2016-02-15 - 2016-02-29: find luke	83	1
2	1	1	json	[{"fields": {"ta_trip_repay_travel_allowance": false, "programme_assistant": null, "office": null, "date_human_resources_approved": null, "budget_owner": null, "date_budget_owner_approved": null, "human_resources": null, "ta_required": false, "pending_ta_amendment": false, "to_date": "2016-02-29", "approved_email_sent": false, "owner": 4, "supervisor": 3, "ta_reference": "", "approved_by_human_resources": null, "driver_supervisor": null, "partners": [], "main_observations": "", "representative": null, "submitted_email_sent": true, "section": null, "approved_by_supervisor": false, "opportunities": "", "approved_date": null, "from_date": "2016-02-15", "ta_drafted": false, "ta_drafted_date": null, "travel_type": "staff_development", "driver_trip": null, "status": "submitted", "lessons_learned": "", "security_granted": false, "vision_approver": null, "purpose_of_travel": "find luke", "international_travel": false, "driver": null, "representative_approval": null, "approved_by_budget_owner": false, "security_clearance_required": false, "pcas": [], "travel_assistant": null, "transport_booked": false, "date_supervisor_approved": null, "date_representative_approved": null, "ta_trip_took_place_as_planned": false, "created_date": "2016-02-15T14:57:51.663Z", "cancelled_reason": "", "ta_trip_final_claim": false, "constraints": ""}, "model": "trips.trip", "pk": 1}]	2016/1-1   2016-02-15 - 2016-02-29: find luke	83	2
3	2	2	json	[{"fields": {"ta_trip_repay_travel_allowance": false, "programme_assistant": null, "office": null, "date_human_resources_approved": null, "budget_owner": null, "date_budget_owner_approved": null, "human_resources": null, "ta_required": false, "pending_ta_amendment": false, "to_date": "2016-02-29", "approved_email_sent": false, "owner": 4, "supervisor": 3, "ta_reference": "", "approved_by_human_resources": null, "driver_supervisor": null, "partners": [], "main_observations": "", "representative": null, "submitted_email_sent": false, "section": null, "approved_by_supervisor": false, "opportunities": "", "approved_date": null, "from_date": "2016-02-15", "ta_drafted": false, "ta_drafted_date": null, "travel_type": "meeting", "driver_trip": null, "status": "planned", "lessons_learned": "", "security_granted": false, "vision_approver": null, "purpose_of_travel": "find luke", "international_travel": false, "driver": null, "representative_approval": null, "approved_by_budget_owner": false, "security_clearance_required": false, "pcas": [], "travel_assistant": null, "transport_booked": false, "date_supervisor_approved": null, "date_representative_approved": null, "ta_trip_took_place_as_planned": false, "created_date": "2016-02-15T15:06:44.415Z", "cancelled_reason": "", "ta_trip_final_claim": false, "constraints": ""}, "model": "trips.trip", "pk": 2}]	2016/2-0   2016-02-15 - 2016-02-29: find luke	83	3
4	3	3	json	[{"fields": {"ta_trip_repay_travel_allowance": false, "programme_assistant": null, "office": null, "date_human_resources_approved": null, "budget_owner": null, "date_budget_owner_approved": null, "human_resources": null, "ta_required": false, "pending_ta_amendment": false, "to_date": "2016-04-15", "approved_email_sent": false, "owner": 4, "supervisor": 2, "ta_reference": "", "approved_by_human_resources": null, "driver_supervisor": null, "partners": [], "main_observations": "", "representative": null, "submitted_email_sent": false, "section": null, "approved_by_supervisor": false, "opportunities": "", "approved_date": null, "from_date": "2016-02-15", "ta_drafted": false, "ta_drafted_date": null, "travel_type": "staff_development", "driver_trip": null, "status": "planned", "lessons_learned": "", "security_granted": false, "vision_approver": null, "purpose_of_travel": "learn how to use a lightsaber", "international_travel": false, "driver": null, "representative_approval": null, "approved_by_budget_owner": false, "security_clearance_required": false, "pcas": [], "travel_assistant": null, "transport_booked": false, "date_supervisor_approved": null, "date_representative_approved": null, "ta_trip_took_place_as_planned": false, "created_date": "2016-02-15T15:11:40.388Z", "cancelled_reason": "", "ta_trip_final_claim": false, "constraints": ""}, "model": "trips.trip", "pk": 3}]	2016/3-0   2016-02-15 - 2016-04-15: learn how to use a lightsaber	83	4
5	3	3	json	[{"fields": {"ta_trip_repay_travel_allowance": false, "programme_assistant": null, "office": null, "date_human_resources_approved": null, "budget_owner": null, "date_budget_owner_approved": null, "human_resources": null, "ta_required": false, "pending_ta_amendment": false, "to_date": "2016-04-15", "approved_email_sent": false, "owner": 4, "supervisor": 2, "ta_reference": "", "approved_by_human_resources": null, "driver_supervisor": null, "partners": [], "main_observations": "", "representative": null, "submitted_email_sent": false, "section": null, "approved_by_supervisor": false, "opportunities": "", "approved_date": null, "from_date": "2016-02-15", "ta_drafted": false, "ta_drafted_date": null, "travel_type": "staff_entitlement", "driver_trip": null, "status": "planned", "lessons_learned": "", "security_granted": false, "vision_approver": null, "purpose_of_travel": "learn how to use a lightsaber", "international_travel": false, "driver": null, "representative_approval": null, "approved_by_budget_owner": false, "security_clearance_required": false, "pcas": [], "travel_assistant": null, "transport_booked": false, "date_supervisor_approved": null, "date_representative_approved": null, "ta_trip_took_place_as_planned": false, "created_date": "2016-02-15T15:11:40.388Z", "cancelled_reason": "", "ta_trip_final_claim": false, "constraints": ""}, "model": "trips.trip", "pk": 3}]	2016/3-1   2016-02-15 - 2016-04-15: learn how to use a lightsaber	83	5
6	3	3	json	[{"fields": {"ta_trip_repay_travel_allowance": false, "programme_assistant": null, "office": null, "date_human_resources_approved": null, "budget_owner": null, "date_budget_owner_approved": null, "human_resources": null, "ta_required": false, "pending_ta_amendment": false, "to_date": "2016-04-15", "approved_email_sent": false, "owner": 4, "supervisor": 2, "ta_reference": "", "approved_by_human_resources": null, "driver_supervisor": null, "partners": [], "main_observations": "", "representative": null, "submitted_email_sent": false, "section": null, "approved_by_supervisor": false, "opportunities": "", "approved_date": null, "from_date": "2016-02-15", "ta_drafted": false, "ta_drafted_date": null, "travel_type": "meeting", "driver_trip": null, "status": "planned", "lessons_learned": "", "security_granted": false, "vision_approver": null, "purpose_of_travel": "learn how to use a lightsaber", "international_travel": false, "driver": null, "representative_approval": null, "approved_by_budget_owner": false, "security_clearance_required": false, "pcas": [], "travel_assistant": null, "transport_booked": false, "date_supervisor_approved": null, "date_representative_approved": null, "ta_trip_took_place_as_planned": false, "created_date": "2016-02-15T15:11:40.388Z", "cancelled_reason": "", "ta_trip_final_claim": false, "constraints": ""}, "model": "trips.trip", "pk": 3}]	2016/3-2   2016-02-15 - 2016-04-15: learn how to use a lightsaber	83	6
7	3	3	json	[{"fields": {"ta_trip_repay_travel_allowance": false, "programme_assistant": null, "office": null, "date_human_resources_approved": null, "budget_owner": null, "date_budget_owner_approved": null, "human_resources": null, "ta_required": false, "pending_ta_amendment": false, "to_date": "2016-04-15", "approved_email_sent": false, "owner": 4, "supervisor": 2, "ta_reference": "", "approved_by_human_resources": null, "driver_supervisor": null, "partners": [], "main_observations": "", "representative": null, "submitted_email_sent": false, "section": null, "approved_by_supervisor": false, "opportunities": "", "approved_date": null, "from_date": "2016-02-10", "ta_drafted": false, "ta_drafted_date": null, "travel_type": "meeting", "driver_trip": null, "status": "planned", "lessons_learned": "", "security_granted": false, "vision_approver": null, "purpose_of_travel": "learn how to use a lightsaber", "international_travel": false, "driver": null, "representative_approval": null, "approved_by_budget_owner": false, "security_clearance_required": false, "pcas": [], "travel_assistant": null, "transport_booked": false, "date_supervisor_approved": null, "date_representative_approved": null, "ta_trip_took_place_as_planned": false, "created_date": "2016-02-15T15:11:40.388Z", "cancelled_reason": "", "ta_trip_final_claim": false, "constraints": ""}, "model": "trips.trip", "pk": 3}]	2016/3-3   2016-02-10 - 2016-04-15: learn how to use a lightsaber	83	7
8	4	4	json	[{"fields": {"ta_trip_repay_travel_allowance": false, "programme_assistant": null, "office": null, "date_human_resources_approved": null, "budget_owner": null, "date_budget_owner_approved": null, "human_resources": null, "ta_required": false, "pending_ta_amendment": false, "to_date": "2016-02-26", "approved_email_sent": false, "owner": 5, "supervisor": 4, "ta_reference": "", "approved_by_human_resources": null, "driver_supervisor": null, "partners": [], "main_observations": "", "representative": null, "submitted_email_sent": false, "section": null, "approved_by_supervisor": false, "opportunities": "", "approved_date": null, "from_date": "2016-02-15", "ta_drafted": false, "ta_drafted_date": null, "travel_type": "meeting", "driver_trip": null, "status": "planned", "lessons_learned": "", "security_granted": false, "vision_approver": null, "purpose_of_travel": "find han", "international_travel": false, "driver": null, "representative_approval": null, "approved_by_budget_owner": false, "security_clearance_required": false, "pcas": [], "travel_assistant": null, "transport_booked": false, "date_supervisor_approved": null, "date_representative_approved": null, "ta_trip_took_place_as_planned": false, "created_date": "2016-02-15T15:16:38.231Z", "cancelled_reason": "", "ta_trip_final_claim": false, "constraints": ""}, "model": "trips.trip", "pk": 4}]	2016/4-0   2016-02-15 - 2016-02-26: find han	83	8
9	4	4	json	[{"fields": {"ta_trip_repay_travel_allowance": false, "programme_assistant": null, "office": null, "date_human_resources_approved": null, "budget_owner": null, "date_budget_owner_approved": null, "human_resources": null, "ta_required": false, "pending_ta_amendment": false, "to_date": "2016-02-26", "approved_email_sent": false, "owner": 5, "supervisor": 4, "ta_reference": "", "approved_by_human_resources": null, "driver_supervisor": null, "partners": [], "main_observations": "", "representative": null, "submitted_email_sent": false, "section": null, "approved_by_supervisor": false, "opportunities": "", "approved_date": null, "from_date": "2016-02-15", "ta_drafted": false, "ta_drafted_date": null, "travel_type": "meeting", "driver_trip": null, "status": "planned", "lessons_learned": "", "security_granted": false, "vision_approver": null, "purpose_of_travel": "find han", "international_travel": false, "driver": null, "representative_approval": null, "approved_by_budget_owner": false, "security_clearance_required": false, "pcas": [], "travel_assistant": 4, "transport_booked": false, "date_supervisor_approved": null, "date_representative_approved": null, "ta_trip_took_place_as_planned": false, "created_date": "2016-02-15T15:16:38.231Z", "cancelled_reason": "", "ta_trip_final_claim": false, "constraints": ""}, "model": "trips.trip", "pk": 4}]	2016/4-1   2016-02-15 - 2016-02-26: find han	83	9
10	4	4	json	[{"fields": {"ta_trip_repay_travel_allowance": false, "programme_assistant": null, "office": null, "date_human_resources_approved": null, "budget_owner": null, "date_budget_owner_approved": null, "human_resources": null, "ta_required": false, "pending_ta_amendment": false, "to_date": "2016-02-26", "approved_email_sent": false, "owner": 5, "supervisor": 4, "ta_reference": "", "approved_by_human_resources": null, "driver_supervisor": null, "partners": [], "main_observations": "", "representative": null, "submitted_email_sent": false, "section": null, "approved_by_supervisor": true, "opportunities": "", "approved_date": null, "from_date": "2016-02-15", "ta_drafted": false, "ta_drafted_date": null, "travel_type": "meeting", "driver_trip": null, "status": "planned", "lessons_learned": "", "security_granted": false, "vision_approver": null, "purpose_of_travel": "find han", "international_travel": false, "driver": null, "representative_approval": null, "approved_by_budget_owner": false, "security_clearance_required": false, "pcas": [], "travel_assistant": 4, "transport_booked": false, "date_supervisor_approved": "2016-02-15", "date_representative_approved": null, "ta_trip_took_place_as_planned": false, "created_date": "2016-02-15T15:16:38.231Z", "cancelled_reason": "", "ta_trip_final_claim": false, "constraints": ""}, "model": "trips.trip", "pk": 4}]	2016/4-2   2016-02-15 - 2016-02-26: find han	83	10
11	4	4	json	[{"fields": {"ta_trip_repay_travel_allowance": false, "programme_assistant": null, "office": null, "date_human_resources_approved": null, "budget_owner": null, "date_budget_owner_approved": null, "human_resources": null, "ta_required": false, "pending_ta_amendment": false, "to_date": "2016-02-26", "approved_email_sent": true, "owner": 5, "supervisor": 4, "ta_reference": "", "approved_by_human_resources": null, "driver_supervisor": null, "partners": [], "main_observations": "", "representative": null, "submitted_email_sent": false, "section": null, "approved_by_supervisor": true, "opportunities": "", "approved_date": "2016-02-15", "from_date": "2016-02-15", "ta_drafted": false, "ta_drafted_date": null, "travel_type": "meeting", "driver_trip": null, "status": "approved", "lessons_learned": "", "security_granted": false, "vision_approver": null, "purpose_of_travel": "find han", "international_travel": false, "driver": null, "representative_approval": null, "approved_by_budget_owner": false, "security_clearance_required": false, "pcas": [], "travel_assistant": 4, "transport_booked": false, "date_supervisor_approved": "2016-02-15", "date_representative_approved": null, "ta_trip_took_place_as_planned": false, "created_date": "2016-02-15T15:16:38.231Z", "cancelled_reason": "", "ta_trip_final_claim": false, "constraints": ""}, "model": "trips.trip", "pk": 4}]	2016/4-3   2016-02-15 - 2016-02-26: find han	83	11
12	4	4	json	[{"fields": {"ta_trip_repay_travel_allowance": false, "programme_assistant": null, "office": null, "date_human_resources_approved": null, "budget_owner": null, "date_budget_owner_approved": null, "human_resources": null, "ta_required": false, "pending_ta_amendment": false, "to_date": "2016-02-26", "approved_email_sent": true, "owner": 5, "supervisor": 4, "ta_reference": "", "approved_by_human_resources": null, "driver_supervisor": null, "partners": [], "main_observations": "", "representative": null, "submitted_email_sent": false, "section": null, "approved_by_supervisor": true, "opportunities": "", "approved_date": "2016-02-15", "from_date": "2016-02-15", "ta_drafted": false, "ta_drafted_date": null, "travel_type": "meeting", "driver_trip": null, "status": "approved", "lessons_learned": "", "security_granted": false, "vision_approver": null, "purpose_of_travel": "find han", "international_travel": false, "driver": null, "representative_approval": null, "approved_by_budget_owner": false, "security_clearance_required": false, "pcas": [], "travel_assistant": 4, "transport_booked": false, "date_supervisor_approved": "2016-02-15", "date_representative_approved": null, "ta_trip_took_place_as_planned": false, "created_date": "2016-02-15T15:16:38.231Z", "cancelled_reason": "", "ta_trip_final_claim": false, "constraints": ""}, "model": "trips.trip", "pk": 4}]	2016/4-4   2016-02-15 - 2016-02-26: find han	83	12
13	4	4	json	[{"fields": {"ta_trip_repay_travel_allowance": false, "programme_assistant": null, "office": null, "date_human_resources_approved": null, "budget_owner": null, "date_budget_owner_approved": null, "human_resources": null, "ta_required": false, "pending_ta_amendment": false, "to_date": "2016-02-26", "approved_email_sent": true, "owner": 5, "supervisor": 4, "ta_reference": "", "approved_by_human_resources": null, "driver_supervisor": null, "partners": [], "main_observations": "", "representative": null, "submitted_email_sent": false, "section": null, "approved_by_supervisor": true, "opportunities": "", "approved_date": "2016-02-15", "from_date": "2016-02-15", "ta_drafted": false, "ta_drafted_date": null, "travel_type": "meeting", "driver_trip": null, "status": "approved", "lessons_learned": "", "security_granted": false, "vision_approver": null, "purpose_of_travel": "find han", "international_travel": false, "driver": null, "representative_approval": null, "approved_by_budget_owner": false, "security_clearance_required": false, "pcas": [], "travel_assistant": 4, "transport_booked": false, "date_supervisor_approved": "2016-02-15", "date_representative_approved": null, "ta_trip_took_place_as_planned": false, "created_date": "2016-02-15T15:16:38.231Z", "cancelled_reason": "", "ta_trip_final_claim": false, "constraints": ""}, "model": "trips.trip", "pk": 4}]	2016/4-5   2016-02-15 - 2016-02-26: find han	83	13
14	5	5	json	[{"fields": {"ta_trip_repay_travel_allowance": false, "programme_assistant": null, "office": null, "date_human_resources_approved": null, "budget_owner": null, "date_budget_owner_approved": null, "human_resources": null, "ta_required": false, "pending_ta_amendment": false, "to_date": "2016-02-26", "approved_email_sent": false, "owner": 5, "supervisor": 4, "ta_reference": "", "approved_by_human_resources": null, "driver_supervisor": null, "partners": [], "main_observations": "", "representative": null, "submitted_email_sent": false, "section": null, "approved_by_supervisor": false, "opportunities": "", "approved_date": null, "from_date": "2016-02-15", "ta_drafted": false, "ta_drafted_date": null, "travel_type": "meeting", "driver_trip": null, "status": "planned", "lessons_learned": "", "security_granted": false, "vision_approver": null, "purpose_of_travel": "find han / chewie", "international_travel": false, "driver": null, "representative_approval": null, "approved_by_budget_owner": false, "security_clearance_required": false, "pcas": [], "travel_assistant": null, "transport_booked": false, "date_supervisor_approved": null, "date_representative_approved": null, "ta_trip_took_place_as_planned": false, "created_date": "2016-02-15T15:25:57.675Z", "cancelled_reason": "", "ta_trip_final_claim": false, "constraints": ""}, "model": "trips.trip", "pk": 5}]	2016/5-0   2016-02-15 - 2016-02-26: find han / chewie	83	14
15	5	5	json	[{"fields": {"ta_trip_repay_travel_allowance": false, "programme_assistant": null, "office": null, "date_human_resources_approved": null, "budget_owner": null, "date_budget_owner_approved": null, "human_resources": null, "ta_required": false, "pending_ta_amendment": false, "to_date": "2016-02-26", "approved_email_sent": false, "owner": 5, "supervisor": 4, "ta_reference": "", "approved_by_human_resources": null, "driver_supervisor": null, "partners": [], "main_observations": "", "representative": null, "submitted_email_sent": false, "section": null, "approved_by_supervisor": true, "opportunities": "", "approved_date": null, "from_date": "2016-02-15", "ta_drafted": false, "ta_drafted_date": null, "travel_type": "meeting", "driver_trip": null, "status": "planned", "lessons_learned": "", "security_granted": false, "vision_approver": null, "purpose_of_travel": "find han / chewie", "international_travel": false, "driver": null, "representative_approval": null, "approved_by_budget_owner": false, "security_clearance_required": false, "pcas": [], "travel_assistant": null, "transport_booked": false, "date_supervisor_approved": "2016-02-15", "date_representative_approved": null, "ta_trip_took_place_as_planned": false, "created_date": "2016-02-15T15:25:57.675Z", "cancelled_reason": "", "ta_trip_final_claim": false, "constraints": ""}, "model": "trips.trip", "pk": 5}]	2016/5-1   2016-02-15 - 2016-02-26: find han / chewie	83	15
16	5	5	json	[{"fields": {"ta_trip_repay_travel_allowance": false, "programme_assistant": null, "office": null, "date_human_resources_approved": null, "budget_owner": null, "date_budget_owner_approved": null, "human_resources": null, "ta_required": false, "pending_ta_amendment": false, "to_date": "2016-02-26", "approved_email_sent": true, "owner": 5, "supervisor": 4, "ta_reference": "", "approved_by_human_resources": null, "driver_supervisor": null, "partners": [], "main_observations": "", "representative": null, "submitted_email_sent": false, "section": null, "approved_by_supervisor": true, "opportunities": "", "approved_date": "2016-02-15", "from_date": "2016-02-15", "ta_drafted": false, "ta_drafted_date": null, "travel_type": "meeting", "driver_trip": null, "status": "approved", "lessons_learned": "", "security_granted": false, "vision_approver": null, "purpose_of_travel": "find han / chewie", "international_travel": false, "driver": null, "representative_approval": null, "approved_by_budget_owner": false, "security_clearance_required": false, "pcas": [], "travel_assistant": null, "transport_booked": false, "date_supervisor_approved": "2016-02-15", "date_representative_approved": null, "ta_trip_took_place_as_planned": false, "created_date": "2016-02-15T15:25:57.675Z", "cancelled_reason": "", "ta_trip_final_claim": false, "constraints": ""}, "model": "trips.trip", "pk": 5}]	2016/5-2   2016-02-15 - 2016-02-26: find han / chewie	83	16
17	5	5	json	[{"fields": {"ta_trip_repay_travel_allowance": false, "programme_assistant": null, "office": null, "date_human_resources_approved": null, "budget_owner": null, "date_budget_owner_approved": null, "human_resources": null, "ta_required": false, "pending_ta_amendment": false, "to_date": "2016-02-26", "approved_email_sent": true, "owner": 5, "supervisor": 4, "ta_reference": "", "approved_by_human_resources": null, "driver_supervisor": null, "partners": [], "main_observations": "", "representative": null, "submitted_email_sent": false, "section": null, "approved_by_supervisor": false, "opportunities": "", "approved_date": "2016-02-15", "from_date": "2016-02-15", "ta_drafted": false, "ta_drafted_date": null, "travel_type": "meeting", "driver_trip": null, "status": "approved", "lessons_learned": "", "security_granted": false, "vision_approver": null, "purpose_of_travel": "find han / chewie", "international_travel": false, "driver": null, "representative_approval": null, "approved_by_budget_owner": false, "security_clearance_required": false, "pcas": [], "travel_assistant": null, "transport_booked": false, "date_supervisor_approved": "2016-02-15", "date_representative_approved": null, "ta_trip_took_place_as_planned": false, "created_date": "2016-02-15T15:25:57.675Z", "cancelled_reason": "", "ta_trip_final_claim": false, "constraints": ""}, "model": "trips.trip", "pk": 5}]	2016/5-3   2016-02-15 - 2016-02-26: find han / chewie	83	17
18	6	6	json	[{"fields": {"ta_trip_repay_travel_allowance": false, "programme_assistant": null, "office": null, "date_human_resources_approved": null, "budget_owner": null, "date_budget_owner_approved": null, "human_resources": null, "ta_required": false, "pending_ta_amendment": false, "to_date": "2016-02-26", "approved_email_sent": false, "owner": 5, "supervisor": 4, "ta_reference": "", "approved_by_human_resources": null, "driver_supervisor": null, "partners": [], "main_observations": "", "representative": null, "submitted_email_sent": false, "section": null, "approved_by_supervisor": false, "opportunities": "", "approved_date": null, "from_date": "2016-02-15", "ta_drafted": false, "ta_drafted_date": null, "travel_type": "meeting", "driver_trip": null, "status": "planned", "lessons_learned": "", "security_granted": false, "vision_approver": null, "purpose_of_travel": "find han and chewie", "international_travel": false, "driver": null, "representative_approval": null, "approved_by_budget_owner": false, "security_clearance_required": false, "pcas": [], "travel_assistant": null, "transport_booked": false, "date_supervisor_approved": null, "date_representative_approved": null, "ta_trip_took_place_as_planned": false, "created_date": "2016-02-15T15:27:14.614Z", "cancelled_reason": "", "ta_trip_final_claim": false, "constraints": ""}, "model": "trips.trip", "pk": 6}]	2016/6-0   2016-02-15 - 2016-02-26: find han and chewie	83	18
19	6	6	json	[{"fields": {"ta_trip_repay_travel_allowance": false, "programme_assistant": null, "office": null, "date_human_resources_approved": null, "budget_owner": null, "date_budget_owner_approved": null, "human_resources": null, "ta_required": false, "pending_ta_amendment": false, "to_date": "2016-02-26", "approved_email_sent": false, "owner": 5, "supervisor": 4, "ta_reference": "", "approved_by_human_resources": null, "driver_supervisor": null, "partners": [], "main_observations": "", "representative": null, "submitted_email_sent": true, "section": null, "approved_by_supervisor": false, "opportunities": "", "approved_date": null, "from_date": "2016-02-15", "ta_drafted": false, "ta_drafted_date": null, "travel_type": "meeting", "driver_trip": null, "status": "submitted", "lessons_learned": "", "security_granted": false, "vision_approver": null, "purpose_of_travel": "find han and chewie", "international_travel": false, "driver": null, "representative_approval": null, "approved_by_budget_owner": false, "security_clearance_required": false, "pcas": [], "travel_assistant": null, "transport_booked": false, "date_supervisor_approved": null, "date_representative_approved": null, "ta_trip_took_place_as_planned": false, "created_date": "2016-02-15T15:27:14.614Z", "cancelled_reason": "", "ta_trip_final_claim": false, "constraints": ""}, "model": "trips.trip", "pk": 6}]	2016/6-1   2016-02-15 - 2016-02-26: find han and chewie	83	19
20	7	7	json	[{"fields": {"ta_trip_repay_travel_allowance": false, "programme_assistant": null, "office": null, "date_human_resources_approved": null, "budget_owner": null, "date_budget_owner_approved": null, "human_resources": null, "ta_required": false, "pending_ta_amendment": false, "to_date": "2016-03-26", "approved_email_sent": false, "owner": 5, "supervisor": 4, "ta_reference": "", "approved_by_human_resources": null, "driver_supervisor": null, "partners": [], "main_observations": "", "representative": null, "submitted_email_sent": false, "section": null, "approved_by_supervisor": false, "opportunities": "", "approved_date": null, "from_date": "2016-01-01", "ta_drafted": false, "ta_drafted_date": null, "travel_type": "technical_support", "driver_trip": null, "status": "planned", "lessons_learned": "", "security_granted": false, "vision_approver": null, "purpose_of_travel": "bring bb-8 to leia", "international_travel": false, "driver": null, "representative_approval": null, "approved_by_budget_owner": false, "security_clearance_required": false, "pcas": [], "travel_assistant": null, "transport_booked": false, "date_supervisor_approved": null, "date_representative_approved": null, "ta_trip_took_place_as_planned": false, "created_date": "2016-02-15T15:29:42.327Z", "cancelled_reason": "", "ta_trip_final_claim": false, "constraints": ""}, "model": "trips.trip", "pk": 7}]	2016/7-0   2016-01-01 - 2016-03-26: bring bb-8 to leia	83	20
21	7	7	json	[{"fields": {"ta_trip_repay_travel_allowance": false, "programme_assistant": null, "office": null, "date_human_resources_approved": null, "budget_owner": null, "date_budget_owner_approved": null, "human_resources": null, "ta_required": false, "pending_ta_amendment": false, "to_date": "2016-03-26", "approved_email_sent": false, "owner": 5, "supervisor": 4, "ta_reference": "", "approved_by_human_resources": null, "driver_supervisor": null, "partners": [], "main_observations": "", "representative": null, "submitted_email_sent": true, "section": null, "approved_by_supervisor": false, "opportunities": "", "approved_date": null, "from_date": "2016-01-01", "ta_drafted": false, "ta_drafted_date": null, "travel_type": "technical_support", "driver_trip": null, "status": "submitted", "lessons_learned": "", "security_granted": false, "vision_approver": null, "purpose_of_travel": "bring bb-8 to leia", "international_travel": false, "driver": null, "representative_approval": null, "approved_by_budget_owner": false, "security_clearance_required": false, "pcas": [], "travel_assistant": null, "transport_booked": false, "date_supervisor_approved": null, "date_representative_approved": null, "ta_trip_took_place_as_planned": false, "created_date": "2016-02-15T15:29:42.327Z", "cancelled_reason": "", "ta_trip_final_claim": false, "constraints": ""}, "model": "trips.trip", "pk": 7}]	2016/7-1   2016-01-01 - 2016-03-26: bring bb-8 to leia	83	21
22	7	7	json	[{"fields": {"ta_trip_repay_travel_allowance": false, "programme_assistant": null, "office": null, "date_human_resources_approved": null, "budget_owner": null, "date_budget_owner_approved": null, "human_resources": null, "ta_required": false, "pending_ta_amendment": false, "to_date": "2016-03-26", "approved_email_sent": false, "owner": 5, "supervisor": 4, "ta_reference": "", "approved_by_human_resources": null, "driver_supervisor": null, "partners": [], "main_observations": "", "representative": null, "submitted_email_sent": true, "section": null, "approved_by_supervisor": false, "opportunities": "", "approved_date": null, "from_date": "2016-01-01", "ta_drafted": false, "ta_drafted_date": null, "travel_type": "technical_support", "driver_trip": null, "status": "submitted", "lessons_learned": "", "security_granted": false, "vision_approver": null, "purpose_of_travel": "leave jakku", "international_travel": false, "driver": null, "representative_approval": null, "approved_by_budget_owner": false, "security_clearance_required": false, "pcas": [], "travel_assistant": null, "transport_booked": false, "date_supervisor_approved": null, "date_representative_approved": null, "ta_trip_took_place_as_planned": false, "created_date": "2016-02-15T15:29:42.327Z", "cancelled_reason": "", "ta_trip_final_claim": false, "constraints": ""}, "model": "trips.trip", "pk": 7}]	2016/7-2   2016-01-01 - 2016-03-26: leave jakku	83	22
23	8	8	json	[{"fields": {"ta_trip_repay_travel_allowance": false, "programme_assistant": null, "office": null, "date_human_resources_approved": null, "budget_owner": null, "date_budget_owner_approved": null, "human_resources": null, "ta_required": false, "pending_ta_amendment": false, "to_date": "2016-04-22", "approved_email_sent": false, "owner": 4, "supervisor": 2, "ta_reference": "", "approved_by_human_resources": null, "driver_supervisor": null, "partners": [], "main_observations": "", "representative": null, "submitted_email_sent": false, "section": null, "approved_by_supervisor": false, "opportunities": "", "approved_date": null, "from_date": "2016-01-01", "ta_drafted": false, "ta_drafted_date": null, "travel_type": "technical_support", "driver_trip": null, "status": "planned", "lessons_learned": "", "security_granted": false, "vision_approver": null, "purpose_of_travel": "bring bb-8 to d'qar", "international_travel": false, "driver": null, "representative_approval": null, "approved_by_budget_owner": false, "security_clearance_required": false, "pcas": [], "travel_assistant": null, "transport_booked": false, "date_supervisor_approved": null, "date_representative_approved": null, "ta_trip_took_place_as_planned": false, "created_date": "2016-02-15T15:40:19.491Z", "cancelled_reason": "", "ta_trip_final_claim": false, "constraints": ""}, "model": "trips.trip", "pk": 8}]	2016/8-0   2016-01-01 - 2016-04-22: bring bb-8 to d'qar	83	23
24	8	8	json	[{"fields": {"ta_trip_repay_travel_allowance": false, "programme_assistant": null, "office": null, "date_human_resources_approved": null, "budget_owner": null, "date_budget_owner_approved": null, "human_resources": null, "ta_required": false, "pending_ta_amendment": false, "to_date": "2016-04-22", "approved_email_sent": false, "owner": 4, "supervisor": 2, "ta_reference": "", "approved_by_human_resources": null, "driver_supervisor": null, "partners": [], "main_observations": "", "representative": null, "submitted_email_sent": true, "section": null, "approved_by_supervisor": false, "opportunities": "", "approved_date": null, "from_date": "2016-01-01", "ta_drafted": false, "ta_drafted_date": null, "travel_type": "technical_support", "driver_trip": null, "status": "submitted", "lessons_learned": "", "security_granted": false, "vision_approver": null, "purpose_of_travel": "bring bb-8 to d'qar", "international_travel": false, "driver": null, "representative_approval": null, "approved_by_budget_owner": false, "security_clearance_required": false, "pcas": [], "travel_assistant": null, "transport_booked": false, "date_supervisor_approved": null, "date_representative_approved": null, "ta_trip_took_place_as_planned": false, "created_date": "2016-02-15T15:40:19.491Z", "cancelled_reason": "", "ta_trip_final_claim": false, "constraints": ""}, "model": "trips.trip", "pk": 8}]	2016/8-1   2016-01-01 - 2016-04-22: bring bb-8 to d'qar	83	24
25	8	8	json	[{"fields": {"ta_trip_repay_travel_allowance": false, "programme_assistant": null, "office": null, "date_human_resources_approved": null, "budget_owner": null, "date_budget_owner_approved": null, "human_resources": null, "ta_required": false, "pending_ta_amendment": false, "to_date": "2016-12-31", "approved_email_sent": true, "owner": 4, "supervisor": 2, "ta_reference": "", "approved_by_human_resources": null, "driver_supervisor": null, "partners": [], "main_observations": "", "representative": null, "submitted_email_sent": true, "section": null, "approved_by_supervisor": true, "opportunities": "", "approved_date": "2016-02-15", "from_date": "2016-01-01", "ta_drafted": false, "ta_drafted_date": null, "travel_type": "technical_support", "driver_trip": null, "status": "approved", "lessons_learned": "", "security_granted": false, "vision_approver": null, "purpose_of_travel": "bring bb-8 to d'qar", "international_travel": false, "driver": null, "representative_approval": null, "approved_by_budget_owner": false, "security_clearance_required": false, "pcas": [], "travel_assistant": null, "transport_booked": false, "date_supervisor_approved": "2016-01-01", "date_representative_approved": null, "ta_trip_took_place_as_planned": false, "created_date": "2016-02-15T15:40:19.491Z", "cancelled_reason": "", "ta_trip_final_claim": false, "constraints": ""}, "model": "trips.trip", "pk": 8}]	2016/8-2   2016-01-01 - 2016-12-31: bring bb-8 to d'qar	83	25
26	8	8	json	[{"fields": {"ta_trip_repay_travel_allowance": false, "programme_assistant": null, "office": null, "date_human_resources_approved": null, "budget_owner": null, "date_budget_owner_approved": null, "human_resources": null, "ta_required": false, "pending_ta_amendment": false, "to_date": "2016-12-31", "approved_email_sent": false, "owner": 4, "supervisor": 2, "ta_reference": "", "approved_by_human_resources": null, "driver_supervisor": null, "partners": [], "main_observations": "", "representative": null, "submitted_email_sent": true, "section": null, "approved_by_supervisor": false, "opportunities": "", "approved_date": null, "from_date": "2016-01-01", "ta_drafted": false, "ta_drafted_date": null, "travel_type": "technical_support", "driver_trip": null, "status": "submitted", "lessons_learned": "", "security_granted": false, "vision_approver": null, "purpose_of_travel": "bring bb-8 to d'qar", "international_travel": false, "driver": null, "representative_approval": null, "approved_by_budget_owner": false, "security_clearance_required": false, "pcas": [], "travel_assistant": null, "transport_booked": false, "date_supervisor_approved": null, "date_representative_approved": null, "ta_trip_took_place_as_planned": false, "created_date": "2016-02-15T15:40:19.491Z", "cancelled_reason": "", "ta_trip_final_claim": false, "constraints": ""}, "model": "trips.trip", "pk": 8}]	2016/8-3   2016-01-01 - 2016-12-31: bring bb-8 to d'qar	83	26
27	1	1	json	[{"fields": {"origin": "NYC", "depart": "2016-04-19T21:45:00+03:00", "destination": "LDN", "remarks": "", "arrive": "2016-04-20T08:05:00+03:00", "trip": 8}, "model": "trips.travelroutes", "pk": 1}]	TravelRoutes object	86	26
28	8	8	json	[{"fields": {"ta_trip_repay_travel_allowance": false, "programme_assistant": null, "office": null, "date_human_resources_approved": null, "budget_owner": null, "date_budget_owner_approved": null, "human_resources": null, "ta_required": false, "pending_ta_amendment": false, "to_date": "2016-12-31", "approved_email_sent": true, "owner": 4, "supervisor": 2, "ta_reference": "", "approved_by_human_resources": null, "driver_supervisor": null, "partners": [], "main_observations": "", "representative": null, "submitted_email_sent": true, "section": null, "approved_by_supervisor": true, "opportunities": "", "approved_date": "2016-04-20", "from_date": "2016-01-01", "ta_drafted": false, "ta_drafted_date": null, "travel_type": "technical_support", "driver_trip": null, "status": "approved", "lessons_learned": "", "security_granted": false, "vision_approver": null, "purpose_of_travel": "bring bb-8 to d'qar", "international_travel": false, "driver": null, "representative_approval": null, "approved_by_budget_owner": false, "security_clearance_required": false, "pcas": [], "travel_assistant": null, "transport_booked": false, "date_supervisor_approved": "2016-04-19", "date_representative_approved": null, "ta_trip_took_place_as_planned": false, "created_date": "2016-02-15T15:40:19.491Z", "cancelled_reason": "", "ta_trip_final_claim": false, "constraints": ""}, "model": "trips.trip", "pk": 8}]	2016/8-4   2016-01-01 - 2016-12-31: bring bb-8 to d'qar	83	27
29	1	1	json	[{"fields": {"origin": "NYC", "depart": "2016-04-19T18:45:00Z", "destination": "LDN", "remarks": "", "arrive": "2016-04-20T05:05:00Z", "trip": 8}, "model": "trips.travelroutes", "pk": 1}]	TravelRoutes object	86	27
30	1	1	json	[{"fields": {"submission_date": null, "unicef_manager": null, "review_date": null, "updated_at": "2016-05-24T02:27:36.335Z", "number": null, "project_type": null, "partner": 4, "partner_manager": null, "title": "Praesent congue erat at massa", "signed_by_partner_date": null, "current": true, "initiation_date": "2016-05-23", "start_date": null, "status": "in_process", "end_date": null, "agreement": 1, "signed_by_unicef_date": null, "partnership_type": "SSFA", "unicef_managers": [], "result_structure": null, "fr_number": "", "sectors": null, "created_at": "2016-05-24T02:27:36.335Z", "planned_visits": 0, "partner_focal_point": null}, "model": "partners.pca", "pk": 1}]	Elise: /SSFA201601	70	28
31	1	1	json	[{"fields": {"submission_date": null, "unicef_manager": null, "review_date": null, "updated_at": "2016-05-24T02:27:44.924Z", "number": null, "project_type": null, "partner": 4, "partner_manager": null, "title": "Praesent congue erat at massa", "signed_by_partner_date": null, "current": true, "initiation_date": "2016-05-23", "start_date": null, "status": "active", "end_date": null, "agreement": 1, "signed_by_unicef_date": null, "partnership_type": "SSFA", "unicef_managers": [], "result_structure": null, "fr_number": "", "sectors": null, "created_at": "2016-05-24T02:27:36.335Z", "planned_visits": 0, "partner_focal_point": null}, "model": "partners.pca", "pk": 1}]	Elise: /SSFA201601	70	29
32	1	1	json	[{"fields": {"submission_date": null, "unicef_manager": null, "review_date": null, "updated_at": "2016-05-24T02:27:54.790Z", "number": null, "project_type": null, "partner": 4, "partner_manager": null, "title": "Praesent congue erat at massa", "signed_by_partner_date": null, "current": true, "initiation_date": "2016-05-23", "start_date": null, "status": "active", "end_date": null, "agreement": 1, "signed_by_unicef_date": null, "partnership_type": "SSFA", "unicef_managers": [], "result_structure": 5, "fr_number": "", "sectors": null, "created_at": "2016-05-24T02:27:36.335Z", "planned_visits": 0, "partner_focal_point": null}, "model": "partners.pca", "pk": 1}]	Elise: /SSFA201601	70	30
33	1	1	json	[{"fields": {"submission_date": null, "unicef_manager": null, "review_date": null, "updated_at": "2016-05-24T02:28:32.931Z", "number": null, "project_type": null, "partner": 4, "partner_manager": null, "title": "Praesent congue erat at massa", "signed_by_partner_date": null, "current": true, "initiation_date": "2016-05-23", "start_date": null, "status": "active", "end_date": null, "agreement": 1, "signed_by_unicef_date": null, "partnership_type": "SSFA", "unicef_managers": [], "result_structure": 5, "fr_number": "", "sectors": null, "created_at": "2016-05-24T02:27:36.335Z", "planned_visits": 0, "partner_focal_point": null}, "model": "partners.pca", "pk": 1}]	Elise: /SSFA201601	70	31
34	1	1	json	[{"fields": {"sector": 5, "locality": null, "governorate": null, "region": null, "tpm_visit": false, "location": 2, "pca": 1}, "model": "partners.gwpcalocation", "pk": 1}]	 -> Cras (Ciara PCode: )	74	31
35	2	2	json	[{"fields": {"submission_date": null, "unicef_manager": null, "review_date": null, "updated_at": "2016-05-24T02:29:22.089Z", "number": null, "project_type": null, "partner": 2, "partner_manager": null, "title": "Duis lobortis massa imperdiet quam", "signed_by_partner_date": null, "current": true, "initiation_date": "2016-05-23", "start_date": null, "status": "active", "end_date": null, "agreement": 2, "signed_by_unicef_date": null, "partnership_type": "AWP", "unicef_managers": [], "result_structure": null, "fr_number": "", "sectors": null, "created_at": "2016-05-24T02:29:22.089Z", "planned_visits": 0, "partner_focal_point": null}, "model": "partners.pca", "pk": 2}]	Ellsworth: /AWP201601/AWP201601	70	32
36	2	2	json	[{"fields": {"submission_date": null, "unicef_manager": null, "review_date": null, "updated_at": "2016-05-24T02:29:36.505Z", "number": null, "project_type": null, "partner": 2, "partner_manager": null, "title": "Duis lobortis massa imperdiet quam", "signed_by_partner_date": null, "current": true, "initiation_date": "2016-05-23", "start_date": null, "status": "active", "end_date": null, "agreement": 2, "signed_by_unicef_date": null, "partnership_type": "AWP", "unicef_managers": [], "result_structure": null, "fr_number": "", "sectors": null, "created_at": "2016-05-24T02:29:22.089Z", "planned_visits": 0, "partner_focal_point": null}, "model": "partners.pca", "pk": 2}]	Ellsworth: /AWP201601/AWP201601	70	33
37	2	2	json	[{"fields": {"sector": 1, "locality": null, "governorate": null, "region": null, "tpm_visit": false, "location": 3, "pca": 2}, "model": "partners.gwpcalocation", "pk": 2}]	 -> Phasellus (Eladio PCode: )	74	33
38	2	2	json	[{"fields": {"submission_date": null, "unicef_manager": null, "review_date": null, "updated_at": "2016-05-24T02:30:52.862Z", "number": null, "project_type": null, "partner": 2, "partner_manager": null, "title": "Duis lobortis massa imperdiet quam", "signed_by_partner_date": null, "current": true, "initiation_date": "2016-05-23", "start_date": null, "status": "active", "end_date": null, "agreement": 2, "signed_by_unicef_date": null, "partnership_type": "AWP", "unicef_managers": [], "result_structure": 2, "fr_number": "", "sectors": null, "created_at": "2016-05-24T02:29:22.089Z", "planned_visits": 0, "partner_focal_point": null}, "model": "partners.pca", "pk": 2}]	Ellsworth: /AWP201601/AWP201601	70	34
39	2	2	json	[{"fields": {"sector": 1, "locality": null, "governorate": null, "region": null, "tpm_visit": false, "location": 3, "pca": 2}, "model": "partners.gwpcalocation", "pk": 2}]	 -> Phasellus (Eladio PCode: )	74	34
40	3	3	json	[{"fields": {"submission_date": null, "unicef_manager": null, "review_date": null, "updated_at": "2016-05-24T02:32:57.443Z", "number": null, "project_type": null, "partner": 1, "partner_manager": null, "title": "Sed fringilla mauris sit", "signed_by_partner_date": null, "current": true, "initiation_date": "2016-05-23", "start_date": null, "status": "in_process", "end_date": null, "agreement": 3, "signed_by_unicef_date": null, "partnership_type": "AWP", "unicef_managers": [], "result_structure": 5, "fr_number": "", "sectors": null, "created_at": "2016-05-24T02:32:57.443Z", "planned_visits": 0, "partner_focal_point": null}, "model": "partners.pca", "pk": 3}]	Jettie: /AWP201602/AWP201601	70	35
41	3	3	json	[{"fields": {"submission_date": null, "unicef_manager": null, "review_date": null, "updated_at": "2016-05-24T02:33:25.822Z", "number": null, "project_type": null, "partner": 1, "partner_manager": null, "title": "Sed fringilla mauris sit", "signed_by_partner_date": null, "current": true, "initiation_date": "2016-05-23", "start_date": null, "status": "in_process", "end_date": null, "agreement": 3, "signed_by_unicef_date": null, "partnership_type": "AWP", "unicef_managers": [], "result_structure": 5, "fr_number": "", "sectors": null, "created_at": "2016-05-24T02:32:57.443Z", "planned_visits": 0, "partner_focal_point": null}, "model": "partners.pca", "pk": 3}]	Jettie: /AWP201602/AWP201601	70	36
42	3	3	json	[{"fields": {"sector": 3, "locality": null, "governorate": null, "region": null, "tpm_visit": false, "location": 2, "pca": 3}, "model": "partners.gwpcalocation", "pk": 3}]	 -> Cras (Ciara PCode: )	74	36
43	1	1	json	[{"fields": {"item": 1, "partnership": 2, "quantity": 10}, "model": "partners.supplyplan", "pk": 1}]	SupplyPlan object	81	37
44	2	2	json	[{"fields": {"submission_date": null, "unicef_manager": null, "review_date": null, "updated_at": "2016-05-24T02:34:27.378Z", "number": null, "project_type": null, "partner": 2, "partner_manager": null, "title": "Duis lobortis massa imperdiet quam", "signed_by_partner_date": null, "current": true, "initiation_date": "2016-05-23", "start_date": null, "status": "active", "end_date": null, "agreement": 2, "signed_by_unicef_date": null, "partnership_type": "AWP", "unicef_managers": [], "result_structure": 2, "fr_number": "", "sectors": null, "created_at": "2016-05-24T02:29:22.089Z", "planned_visits": 0, "partner_focal_point": null}, "model": "partners.pca", "pk": 2}]	Ellsworth: /AWP201601/AWP201601	70	37
45	2	2	json	[{"fields": {"sector": 1, "locality": null, "governorate": null, "region": null, "tpm_visit": false, "location": 3, "pca": 2}, "model": "partners.gwpcalocation", "pk": 2}]	 -> Phasellus (Eladio PCode: )	74	37
46	1	1	json	[{"fields": {"delivered": 0, "partnership": 2, "site": 2, "send": false, "item": 1, "document": null, "sent": false, "quantity": 5}, "model": "partners.distributionplan", "pk": 1}]	Ellsworth: /AWP201601/AWP201601-Praesent egestas tristique-Cras (Ciara PCode: )-5	82	38
47	2	2	json	[{"fields": {"submission_date": null, "unicef_manager": null, "review_date": null, "updated_at": "2016-05-24T02:34:48.169Z", "number": null, "project_type": null, "partner": 2, "partner_manager": null, "title": "Duis lobortis massa imperdiet quam", "signed_by_partner_date": null, "current": true, "initiation_date": "2016-05-23", "start_date": null, "status": "active", "end_date": null, "agreement": 2, "signed_by_unicef_date": null, "partnership_type": "AWP", "unicef_managers": [], "result_structure": 2, "fr_number": "", "sectors": null, "created_at": "2016-05-24T02:29:22.089Z", "planned_visits": 0, "partner_focal_point": null}, "model": "partners.pca", "pk": 2}]	Ellsworth: /AWP201601/AWP201601	70	38
48	2	2	json	[{"fields": {"sector": 1, "locality": null, "governorate": null, "region": null, "tpm_visit": false, "location": 3, "pca": 2}, "model": "partners.gwpcalocation", "pk": 2}]	 -> Phasellus (Eladio PCode: )	74	38
49	1	1	json	[{"fields": {"item": 1, "partnership": 2, "quantity": 10}, "model": "partners.supplyplan", "pk": 1}]	SupplyPlan object	81	38
50	1	1	json	[{"fields": {"submission_date": null, "unicef_manager": null, "review_date": null, "updated_at": "2016-05-24T02:35:36.396Z", "number": null, "project_type": null, "partner": 4, "partner_manager": null, "title": "Praesent congue erat at massa", "signed_by_partner_date": null, "current": true, "initiation_date": "2016-05-23", "start_date": null, "status": "active", "end_date": null, "agreement": 1, "signed_by_unicef_date": null, "partnership_type": "SSFA", "unicef_managers": [], "result_structure": 5, "fr_number": "", "sectors": null, "created_at": "2016-05-24T02:27:36.335Z", "planned_visits": 0, "partner_focal_point": null}, "model": "partners.pca", "pk": 1}]	Elise: /SSFA201601	70	39
51	2	2	json	[{"fields": {"item": 1, "partnership": 1, "quantity": 10}, "model": "partners.supplyplan", "pk": 2}]	SupplyPlan object	81	39
52	1	1	json	[{"fields": {"sector": 5, "locality": null, "governorate": null, "region": null, "tpm_visit": false, "location": 2, "pca": 1}, "model": "partners.gwpcalocation", "pk": 1}]	 -> Cras (Ciara PCode: )	74	39
53	1	1	json	[{"fields": {"submission_date": null, "unicef_manager": null, "review_date": null, "updated_at": "2016-05-24T02:35:51.592Z", "number": null, "project_type": null, "partner": 4, "partner_manager": null, "title": "Praesent congue erat at massa", "signed_by_partner_date": null, "current": true, "initiation_date": "2016-05-23", "start_date": null, "status": "active", "end_date": null, "agreement": 1, "signed_by_unicef_date": null, "partnership_type": "SSFA", "unicef_managers": [], "result_structure": 5, "fr_number": "", "sectors": null, "created_at": "2016-05-24T02:27:36.335Z", "planned_visits": 0, "partner_focal_point": null}, "model": "partners.pca", "pk": 1}]	Elise: /SSFA201601	70	40
54	2	2	json	[{"fields": {"delivered": 0, "partnership": 1, "site": 2, "send": false, "item": 1, "document": null, "sent": false, "quantity": 5}, "model": "partners.distributionplan", "pk": 2}]	Elise: /SSFA201601-Praesent egestas tristique-Cras (Ciara PCode: )-5	82	40
55	2	2	json	[{"fields": {"item": 1, "partnership": 1, "quantity": 10}, "model": "partners.supplyplan", "pk": 2}]	SupplyPlan object	81	40
56	1	1	json	[{"fields": {"sector": 5, "locality": null, "governorate": null, "region": null, "tpm_visit": false, "location": 2, "pca": 1}, "model": "partners.gwpcalocation", "pk": 1}]	 -> Cras (Ciara PCode: )	74	40
57	1	1	json	[{"fields": {"submission_date": null, "unicef_manager": null, "review_date": null, "updated_at": "2016-05-24T02:36:50.079Z", "number": null, "project_type": null, "partner": 4, "partner_manager": null, "title": "Praesent congue erat at massa", "signed_by_partner_date": null, "current": true, "initiation_date": "2016-05-23", "start_date": null, "status": "active", "end_date": null, "agreement": 1, "signed_by_unicef_date": null, "partnership_type": "SSFA", "unicef_managers": [], "result_structure": 5, "fr_number": "", "sectors": null, "created_at": "2016-05-24T02:27:36.335Z", "planned_visits": 0, "partner_focal_point": null}, "model": "partners.pca", "pk": 1}]	Elise: /SSFA201601	70	41
58	2	2	json	[{"fields": {"item": 1, "partnership": 1, "quantity": 10}, "model": "partners.supplyplan", "pk": 2}]	SupplyPlan object	81	41
59	1	1	json	[{"fields": {"sector": 5, "locality": null, "governorate": null, "region": null, "tpm_visit": false, "location": 2, "pca": 1}, "model": "partners.gwpcalocation", "pk": 1}]	 -> Cras (Ciara PCode: )	74	41
60	2	2	json	[{"fields": {"delivered": 0, "partnership": 1, "site": 2, "send": false, "item": 1, "document": null, "sent": false, "quantity": 5}, "model": "partners.distributionplan", "pk": 2}]	Elise: /SSFA201601-Praesent egestas tristique-Cras (Ciara PCode: )-5	82	41
61	1	1	json	[{"fields": {"sector": 5, "amendment": null, "pca": 1, "modified": "2016-05-24T02:36:50.106Z", "created": "2016-05-24T02:36:49.971Z"}, "model": "partners.pcasector", "pk": 1}]	Elise: None: Centralized object-oriented data-warehouse	75	41
\.


--
-- Name: reversion_version_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('reversion_version_id_seq', 61, true);


--
-- Data for Name: socialaccount_socialaccount; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY socialaccount_socialaccount (id, provider, uid, last_login, date_joined, extra_data, user_id) FROM stdin;
\.


--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('socialaccount_socialaccount_id_seq', 1, false);


--
-- Data for Name: socialaccount_socialapp; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY socialaccount_socialapp (id, provider, name, client_id, secret, key) FROM stdin;
\.


--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('socialaccount_socialapp_id_seq', 1, false);


--
-- Data for Name: socialaccount_socialapp_sites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY socialaccount_socialapp_sites (id, socialapp_id, site_id) FROM stdin;
\.


--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('socialaccount_socialapp_sites_id_seq', 1, false);


--
-- Data for Name: socialaccount_socialtoken; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY socialaccount_socialtoken (id, token, token_secret, expires_at, account_id, app_id) FROM stdin;
\.


--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('socialaccount_socialtoken_id_seq', 1, false);


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: chris
--

COPY spatial_ref_sys  FROM stdin;
\.


--
-- Data for Name: users_country; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users_country (id, domain_url, schema_name, name, business_area_code, initial_zoom, latitude, longitude, country_short_code, vision_sync_enabled, vision_last_synced) FROM stdin;
1	hoth	hoth	hoth		8	\N	\N	\N	t	\N
\.


--
-- Name: users_country_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_country_id_seq', 1, true);


--
-- Data for Name: users_country_offices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users_country_offices (id, country_id, office_id) FROM stdin;
\.


--
-- Name: users_country_offices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_country_offices_id_seq', 1, false);


--
-- Data for Name: users_country_sections; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users_country_sections (id, country_id, section_id) FROM stdin;
\.


--
-- Name: users_country_sections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_country_sections_id_seq', 1, false);


--
-- Data for Name: users_office; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users_office (id, name, zonal_chief_id) FROM stdin;
\.


--
-- Name: users_office_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_office_id_seq', 1, false);


--
-- Data for Name: users_section; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users_section (id, name) FROM stdin;
\.


--
-- Name: users_section_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_section_id_seq', 1, false);


--
-- Data for Name: users_userprofile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users_userprofile (id, job_title, phone_number, installation_id, country_id, office_id, section_id, user_id, country_override_id, partner_staff_member) FROM stdin;
5			\N	1	\N	\N	5	\N	\N
4			\N	1	\N	\N	4	\N	\N
3			\N	1	\N	\N	3	\N	\N
2			\N	1	\N	\N	2	\N	\N
1			\N	1	\N	\N	1	\N	\N
6			\N	1	\N	\N	6	\N	\N
\.


--
-- Data for Name: users_userprofile_countries_available; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users_userprofile_countries_available (id, userprofile_id, country_id) FROM stdin;
\.


--
-- Name: users_userprofile_countries_available_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_userprofile_countries_available_id_seq', 1, false);


--
-- Name: users_userprofile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_userprofile_id_seq', 6, true);


--
-- Data for Name: vision_visionsynclog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY vision_visionsynclog (id, handler_name, total_records, total_processed, successful, exception_message, date_processed, country_id) FROM stdin;
\.


--
-- Name: vision_visionsynclog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('vision_visionsynclog_id_seq', 1, false);


SET search_path = topology, pg_catalog;

--
-- Data for Name: topology; Type: TABLE DATA; Schema: topology; Owner: chris
--

COPY topology  FROM stdin;
\.


--
-- Data for Name: layer; Type: TABLE DATA; Schema: topology; Owner: chris
--

COPY layer  FROM stdin;
\.


SET search_path = hoth, pg_catalog;

--
-- Name: activityinfo_activity_ai_id_key; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY activityinfo_activity
    ADD CONSTRAINT activityinfo_activity_ai_id_key UNIQUE (ai_id);


--
-- Name: activityinfo_activity_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY activityinfo_activity
    ADD CONSTRAINT activityinfo_activity_pkey PRIMARY KEY (id);


--
-- Name: activityinfo_attribute_ai_id_key; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY activityinfo_attribute
    ADD CONSTRAINT activityinfo_attribute_ai_id_key UNIQUE (ai_id);


--
-- Name: activityinfo_attribute_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY activityinfo_attribute
    ADD CONSTRAINT activityinfo_attribute_pkey PRIMARY KEY (id);


--
-- Name: activityinfo_attributegroup_ai_id_key; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY activityinfo_attributegroup
    ADD CONSTRAINT activityinfo_attributegroup_ai_id_key UNIQUE (ai_id);


--
-- Name: activityinfo_attributegroup_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY activityinfo_attributegroup
    ADD CONSTRAINT activityinfo_attributegroup_pkey PRIMARY KEY (id);


--
-- Name: activityinfo_database_ai_id_key; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY activityinfo_database
    ADD CONSTRAINT activityinfo_database_ai_id_key UNIQUE (ai_id);


--
-- Name: activityinfo_database_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY activityinfo_database
    ADD CONSTRAINT activityinfo_database_pkey PRIMARY KEY (id);


--
-- Name: activityinfo_indicator_ai_id_key; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY activityinfo_indicator
    ADD CONSTRAINT activityinfo_indicator_ai_id_key UNIQUE (ai_id);


--
-- Name: activityinfo_indicator_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY activityinfo_indicator
    ADD CONSTRAINT activityinfo_indicator_pkey PRIMARY KEY (id);


--
-- Name: activityinfo_partner_ai_id_key; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY activityinfo_partner
    ADD CONSTRAINT activityinfo_partner_ai_id_key UNIQUE (ai_id);


--
-- Name: activityinfo_partner_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY activityinfo_partner
    ADD CONSTRAINT activityinfo_partner_pkey PRIMARY KEY (id);


--
-- Name: django_migrations_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: funds_donor_name_key; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY funds_donor
    ADD CONSTRAINT funds_donor_name_key UNIQUE (name);


--
-- Name: funds_donor_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY funds_donor
    ADD CONSTRAINT funds_donor_pkey PRIMARY KEY (id);


--
-- Name: funds_grant_name_key; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY funds_grant
    ADD CONSTRAINT funds_grant_name_key UNIQUE (name);


--
-- Name: funds_grant_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY funds_grant
    ADD CONSTRAINT funds_grant_pkey PRIMARY KEY (id);


--
-- Name: locations_cartodbtable_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_cartodbtable
    ADD CONSTRAINT locations_cartodbtable_pkey PRIMARY KEY (id);


--
-- Name: locations_gatewaytype_name_key; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_gatewaytype
    ADD CONSTRAINT locations_gatewaytype_name_key UNIQUE (name);


--
-- Name: locations_gatewaytype_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_gatewaytype
    ADD CONSTRAINT locations_gatewaytype_pkey PRIMARY KEY (id);


--
-- Name: locations_governorate_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_governorate
    ADD CONSTRAINT locations_governorate_pkey PRIMARY KEY (id);


--
-- Name: locations_linkedlocation_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_linkedlocation
    ADD CONSTRAINT locations_linkedlocation_pkey PRIMARY KEY (id);


--
-- Name: locations_locality_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_locality
    ADD CONSTRAINT locations_locality_pkey PRIMARY KEY (id);


--
-- Name: locations_location_name_a61f6e4197569d0_uniq; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_location
    ADD CONSTRAINT locations_location_name_a61f6e4197569d0_uniq UNIQUE (name, gateway_id, p_code);


--
-- Name: locations_location_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_location
    ADD CONSTRAINT locations_location_pkey PRIMARY KEY (id);


--
-- Name: locations_region_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_region
    ADD CONSTRAINT locations_region_pkey PRIMARY KEY (id);


--
-- Name: partners_agreement_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_agreement
    ADD CONSTRAINT partners_agreement_pkey PRIMARY KEY (id);


--
-- Name: partners_agreementamendmentlog_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_agreementamendmentlog
    ADD CONSTRAINT partners_agreementamendmentlog_pkey PRIMARY KEY (id);


--
-- Name: partners_amendmentlog_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_amendmentlog
    ADD CONSTRAINT partners_amendmentlog_pkey PRIMARY KEY (id);


--
-- Name: partners_assessment_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_assessment
    ADD CONSTRAINT partners_assessment_pkey PRIMARY KEY (id);


--
-- Name: partners_authorizedofficer_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_authorizedofficer
    ADD CONSTRAINT partners_authorizedofficer_pkey PRIMARY KEY (id);


--
-- Name: partners_bankdetails_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_bankdetails
    ADD CONSTRAINT partners_bankdetails_pkey PRIMARY KEY (id);


--
-- Name: partners_directcashtransfer_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_directcashtransfer
    ADD CONSTRAINT partners_directcashtransfer_pkey PRIMARY KEY (id);


--
-- Name: partners_distributionplan_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_distributionplan
    ADD CONSTRAINT partners_distributionplan_pkey PRIMARY KEY (id);


--
-- Name: partners_filetype_name_key; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_filetype
    ADD CONSTRAINT partners_filetype_name_key UNIQUE (name);


--
-- Name: partners_filetype_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_filetype
    ADD CONSTRAINT partners_filetype_pkey PRIMARY KEY (id);


--
-- Name: partners_fundingcommitment_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_fundingcommitment
    ADD CONSTRAINT partners_fundingcommitment_pkey PRIMARY KEY (id);


--
-- Name: partners_governmentinterventi_governmentinterventionresult__key; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_governmentinterventionresult_unicef_managers
    ADD CONSTRAINT partners_governmentinterventi_governmentinterventionresult__key UNIQUE (governmentinterventionresult_id, user_id);


--
-- Name: partners_governmentinterventi_governmentinterventionresult_key1; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_governmentinterventionresult_activities_list
    ADD CONSTRAINT partners_governmentinterventi_governmentinterventionresult_key1 UNIQUE (governmentinterventionresult_id, result_id);


--
-- Name: partners_governmentintervention_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_governmentintervention
    ADD CONSTRAINT partners_governmentintervention_pkey PRIMARY KEY (id);


--
-- Name: partners_governmentinterventionresult_activities_list_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_governmentinterventionresult_activities_list
    ADD CONSTRAINT partners_governmentinterventionresult_activities_list_pkey PRIMARY KEY (id);


--
-- Name: partners_governmentinterventionresult_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_governmentinterventionresult
    ADD CONSTRAINT partners_governmentinterventionresult_pkey PRIMARY KEY (id);


--
-- Name: partners_governmentinterventionresult_unicef_managers_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_governmentinterventionresult_unicef_managers
    ADD CONSTRAINT partners_governmentinterventionresult_unicef_managers_pkey PRIMARY KEY (id);


--
-- Name: partners_gwpcalocation_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_gwpcalocation
    ADD CONSTRAINT partners_gwpcalocation_pkey PRIMARY KEY (id);


--
-- Name: partners_indicatorduedates_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_indicatorduedates
    ADD CONSTRAINT partners_indicatorduedates_pkey PRIMARY KEY (id);


--
-- Name: partners_indicatorreport_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_indicatorreport
    ADD CONSTRAINT partners_indicatorreport_pkey PRIMARY KEY (id);


--
-- Name: partners_partnerorganization_name_586ea92c4b5abec3_uniq; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_partnerorganization
    ADD CONSTRAINT partners_partnerorganization_name_586ea92c4b5abec3_uniq UNIQUE (name, vendor_number);


--
-- Name: partners_partnerorganization_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_partnerorganization
    ADD CONSTRAINT partners_partnerorganization_pkey PRIMARY KEY (id);


--
-- Name: partners_partnerorganization_vendor_number_f6bb409b9a59687_uniq; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_partnerorganization
    ADD CONSTRAINT partners_partnerorganization_vendor_number_f6bb409b9a59687_uniq UNIQUE (vendor_number);


--
-- Name: partners_partnershipbudget_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_partnershipbudget
    ADD CONSTRAINT partners_partnershipbudget_pkey PRIMARY KEY (id);


--
-- Name: partners_partnerstaffmember_email_43987186332a0687_uniq; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_partnerstaffmember
    ADD CONSTRAINT partners_partnerstaffmember_email_43987186332a0687_uniq UNIQUE (email);


--
-- Name: partners_partnerstaffmember_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_partnerstaffmember
    ADD CONSTRAINT partners_partnerstaffmember_pkey PRIMARY KEY (id);


--
-- Name: partners_pca_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pca
    ADD CONSTRAINT partners_pca_pkey PRIMARY KEY (id);


--
-- Name: partners_pca_unicef_managers_pca_id_user_id_key; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pca_unicef_managers
    ADD CONSTRAINT partners_pca_unicef_managers_pca_id_user_id_key UNIQUE (pca_id, user_id);


--
-- Name: partners_pca_unicef_managers_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pca_unicef_managers
    ADD CONSTRAINT partners_pca_unicef_managers_pkey PRIMARY KEY (id);


--
-- Name: partners_pcafile_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pcafile
    ADD CONSTRAINT partners_pcafile_pkey PRIMARY KEY (id);


--
-- Name: partners_pcagrant_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pcagrant
    ADD CONSTRAINT partners_pcagrant_pkey PRIMARY KEY (id);


--
-- Name: partners_pcasector_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pcasector
    ADD CONSTRAINT partners_pcasector_pkey PRIMARY KEY (id);


--
-- Name: partners_pcasectorgoal_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pcasectorgoal
    ADD CONSTRAINT partners_pcasectorgoal_pkey PRIMARY KEY (id);


--
-- Name: partners_ramindicator_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_ramindicator
    ADD CONSTRAINT partners_ramindicator_pkey PRIMARY KEY (id);


--
-- Name: partners_resultchain_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_resultchain
    ADD CONSTRAINT partners_resultchain_pkey PRIMARY KEY (id);


--
-- Name: partners_supplyplan_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_supplyplan
    ADD CONSTRAINT partners_supplyplan_pkey PRIMARY KEY (id);


--
-- Name: reports_goal_name_key; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_goal
    ADD CONSTRAINT reports_goal_name_key UNIQUE (name);


--
-- Name: reports_goal_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_goal
    ADD CONSTRAINT reports_goal_pkey PRIMARY KEY (id);


--
-- Name: reports_indicator_activity_in_from_indicator_id_to_indicato_key; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_indicator_activity_info_indicators
    ADD CONSTRAINT reports_indicator_activity_in_from_indicator_id_to_indicato_key UNIQUE (from_indicator_id, to_indicator_id);


--
-- Name: reports_indicator_activity_info_indicators_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_indicator_activity_info_indicators
    ADD CONSTRAINT reports_indicator_activity_info_indicators_pkey PRIMARY KEY (id);


--
-- Name: reports_indicator_name_1d24d491a9c00847_uniq; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_indicator
    ADD CONSTRAINT reports_indicator_name_1d24d491a9c00847_uniq UNIQUE (name, result_id, sector_id);


--
-- Name: reports_indicator_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_indicator
    ADD CONSTRAINT reports_indicator_pkey PRIMARY KEY (id);


--
-- Name: reports_result_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_result
    ADD CONSTRAINT reports_result_pkey PRIMARY KEY (id);


--
-- Name: reports_resultstructure_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_resultstructure
    ADD CONSTRAINT reports_resultstructure_pkey PRIMARY KEY (id);


--
-- Name: reports_resulttype_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_resulttype
    ADD CONSTRAINT reports_resulttype_pkey PRIMARY KEY (id);


--
-- Name: reports_sector_name_key; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_sector
    ADD CONSTRAINT reports_sector_name_key UNIQUE (name);


--
-- Name: reports_sector_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_sector
    ADD CONSTRAINT reports_sector_pkey PRIMARY KEY (id);


--
-- Name: reports_unit_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_unit
    ADD CONSTRAINT reports_unit_pkey PRIMARY KEY (id);


--
-- Name: reports_unit_type_key; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_unit
    ADD CONSTRAINT reports_unit_type_key UNIQUE (type);


--
-- Name: supplies_supplyitem_name_key; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY supplies_supplyitem
    ADD CONSTRAINT supplies_supplyitem_name_key UNIQUE (name);


--
-- Name: supplies_supplyitem_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY supplies_supplyitem
    ADD CONSTRAINT supplies_supplyitem_pkey PRIMARY KEY (id);


--
-- Name: tpm_tpmvisit_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY tpm_tpmvisit
    ADD CONSTRAINT tpm_tpmvisit_pkey PRIMARY KEY (id);


--
-- Name: trips_actionpoint_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_actionpoint
    ADD CONSTRAINT trips_actionpoint_pkey PRIMARY KEY (id);


--
-- Name: trips_fileattachment_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_fileattachment
    ADD CONSTRAINT trips_fileattachment_pkey PRIMARY KEY (id);


--
-- Name: trips_linkedpartner_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_linkedpartner
    ADD CONSTRAINT trips_linkedpartner_pkey PRIMARY KEY (id);


--
-- Name: trips_travelroutes_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_travelroutes
    ADD CONSTRAINT trips_travelroutes_pkey PRIMARY KEY (id);


--
-- Name: trips_trip_partners_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_trip_partners
    ADD CONSTRAINT trips_trip_partners_pkey PRIMARY KEY (id);


--
-- Name: trips_trip_partners_trip_id_partnerorganization_id_key; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_trip_partners
    ADD CONSTRAINT trips_trip_partners_trip_id_partnerorganization_id_key UNIQUE (trip_id, partnerorganization_id);


--
-- Name: trips_trip_pcas_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_trip_pcas
    ADD CONSTRAINT trips_trip_pcas_pkey PRIMARY KEY (id);


--
-- Name: trips_trip_pcas_trip_id_pca_id_key; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_trip_pcas
    ADD CONSTRAINT trips_trip_pcas_trip_id_pca_id_key UNIQUE (trip_id, pca_id);


--
-- Name: trips_trip_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_trip
    ADD CONSTRAINT trips_trip_pkey PRIMARY KEY (id);


--
-- Name: trips_tripfunds_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_tripfunds
    ADD CONSTRAINT trips_tripfunds_pkey PRIMARY KEY (id);


--
-- Name: trips_triplocation_pkey; Type: CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_triplocation
    ADD CONSTRAINT trips_triplocation_pkey PRIMARY KEY (id);


SET search_path = public, pg_catalog;

--
-- Name: account_emailaddress_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY account_emailaddress
    ADD CONSTRAINT account_emailaddress_email_key UNIQUE (email);


--
-- Name: account_emailaddress_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY account_emailaddress
    ADD CONSTRAINT account_emailaddress_pkey PRIMARY KEY (id);


--
-- Name: account_emailconfirmation_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY account_emailconfirmation
    ADD CONSTRAINT account_emailconfirmation_key_key UNIQUE (key);


--
-- Name: account_emailconfirmation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY account_emailconfirmation
    ADD CONSTRAINT account_emailconfirmation_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_key UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_codename_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_key UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_user_id_group_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_key UNIQUE (user_id, group_id);


--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_user_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_key UNIQUE (user_id, permission_id);


--
-- Name: auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: authtoken_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY authtoken_token
    ADD CONSTRAINT authtoken_token_pkey PRIMARY KEY (key);


--
-- Name: authtoken_token_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_key UNIQUE (user_id);


--
-- Name: celery_taskmeta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY celery_taskmeta
    ADD CONSTRAINT celery_taskmeta_pkey PRIMARY KEY (id);


--
-- Name: celery_taskmeta_task_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY celery_taskmeta
    ADD CONSTRAINT celery_taskmeta_task_id_key UNIQUE (task_id);


--
-- Name: celery_tasksetmeta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY celery_tasksetmeta
    ADD CONSTRAINT celery_tasksetmeta_pkey PRIMARY KEY (id);


--
-- Name: celery_tasksetmeta_taskset_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY celery_tasksetmeta
    ADD CONSTRAINT celery_tasksetmeta_taskset_id_key UNIQUE (taskset_id);


--
-- Name: corsheaders_corsmodel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY corsheaders_corsmodel
    ADD CONSTRAINT corsheaders_corsmodel_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_45f3b1d93ec8c61c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_45f3b1d93ec8c61c_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site_domain_a2e37b91_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_domain_a2e37b91_uniq UNIQUE (domain);


--
-- Name: django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: djcelery_crontabschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY djcelery_crontabschedule
    ADD CONSTRAINT djcelery_crontabschedule_pkey PRIMARY KEY (id);


--
-- Name: djcelery_intervalschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY djcelery_intervalschedule
    ADD CONSTRAINT djcelery_intervalschedule_pkey PRIMARY KEY (id);


--
-- Name: djcelery_periodictask_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY djcelery_periodictask
    ADD CONSTRAINT djcelery_periodictask_name_key UNIQUE (name);


--
-- Name: djcelery_periodictask_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY djcelery_periodictask
    ADD CONSTRAINT djcelery_periodictask_pkey PRIMARY KEY (id);


--
-- Name: djcelery_periodictasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY djcelery_periodictasks
    ADD CONSTRAINT djcelery_periodictasks_pkey PRIMARY KEY (ident);


--
-- Name: djcelery_taskstate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY djcelery_taskstate
    ADD CONSTRAINT djcelery_taskstate_pkey PRIMARY KEY (id);


--
-- Name: djcelery_taskstate_task_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY djcelery_taskstate
    ADD CONSTRAINT djcelery_taskstate_task_id_key UNIQUE (task_id);


--
-- Name: djcelery_workerstate_hostname_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY djcelery_workerstate
    ADD CONSTRAINT djcelery_workerstate_hostname_key UNIQUE (hostname);


--
-- Name: djcelery_workerstate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY djcelery_workerstate
    ADD CONSTRAINT djcelery_workerstate_pkey PRIMARY KEY (id);


--
-- Name: easy_thumbnails_source_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY easy_thumbnails_source
    ADD CONSTRAINT easy_thumbnails_source_pkey PRIMARY KEY (id);


--
-- Name: easy_thumbnails_source_storage_hash_40116450c1e4f2ed_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY easy_thumbnails_source
    ADD CONSTRAINT easy_thumbnails_source_storage_hash_40116450c1e4f2ed_uniq UNIQUE (storage_hash, name);


--
-- Name: easy_thumbnails_thumbnail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY easy_thumbnails_thumbnail
    ADD CONSTRAINT easy_thumbnails_thumbnail_pkey PRIMARY KEY (id);


--
-- Name: easy_thumbnails_thumbnail_storage_hash_66cc758d07ef9fce_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY easy_thumbnails_thumbnail
    ADD CONSTRAINT easy_thumbnails_thumbnail_storage_hash_66cc758d07ef9fce_uniq UNIQUE (storage_hash, name, source_id);


--
-- Name: easy_thumbnails_thumbnaildimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY easy_thumbnails_thumbnaildimensions
    ADD CONSTRAINT easy_thumbnails_thumbnaildimensions_pkey PRIMARY KEY (id);


--
-- Name: easy_thumbnails_thumbnaildimensions_thumbnail_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY easy_thumbnails_thumbnaildimensions
    ADD CONSTRAINT easy_thumbnails_thumbnaildimensions_thumbnail_id_key UNIQUE (thumbnail_id);


--
-- Name: filer_clipboard_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY filer_clipboard
    ADD CONSTRAINT filer_clipboard_pkey PRIMARY KEY (id);


--
-- Name: filer_clipboarditem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY filer_clipboarditem
    ADD CONSTRAINT filer_clipboarditem_pkey PRIMARY KEY (id);


--
-- Name: filer_file_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY filer_file
    ADD CONSTRAINT filer_file_pkey PRIMARY KEY (id);


--
-- Name: filer_folder_parent_id_30ad83e34d901e49_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY filer_folder
    ADD CONSTRAINT filer_folder_parent_id_30ad83e34d901e49_uniq UNIQUE (parent_id, name);


--
-- Name: filer_folder_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY filer_folder
    ADD CONSTRAINT filer_folder_pkey PRIMARY KEY (id);


--
-- Name: filer_folderpermission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY filer_folderpermission
    ADD CONSTRAINT filer_folderpermission_pkey PRIMARY KEY (id);


--
-- Name: filer_image_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY filer_image
    ADD CONSTRAINT filer_image_pkey PRIMARY KEY (file_ptr_id);


--
-- Name: generic_links_genericlink_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY generic_links_genericlink
    ADD CONSTRAINT generic_links_genericlink_pkey PRIMARY KEY (id);


--
-- Name: post_office_attachment_emails_attachment_id_email_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY post_office_attachment_emails
    ADD CONSTRAINT post_office_attachment_emails_attachment_id_email_id_key UNIQUE (attachment_id, email_id);


--
-- Name: post_office_attachment_emails_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY post_office_attachment_emails
    ADD CONSTRAINT post_office_attachment_emails_pkey PRIMARY KEY (id);


--
-- Name: post_office_attachment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY post_office_attachment
    ADD CONSTRAINT post_office_attachment_pkey PRIMARY KEY (id);


--
-- Name: post_office_email_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY post_office_email
    ADD CONSTRAINT post_office_email_pkey PRIMARY KEY (id);


--
-- Name: post_office_emailtemplate_language_29c8606d390b61ee_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY post_office_emailtemplate
    ADD CONSTRAINT post_office_emailtemplate_language_29c8606d390b61ee_uniq UNIQUE (language, default_template_id);


--
-- Name: post_office_emailtemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY post_office_emailtemplate
    ADD CONSTRAINT post_office_emailtemplate_pkey PRIMARY KEY (id);


--
-- Name: post_office_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY post_office_log
    ADD CONSTRAINT post_office_log_pkey PRIMARY KEY (id);


--
-- Name: reversion_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reversion_revision
    ADD CONSTRAINT reversion_revision_pkey PRIMARY KEY (id);


--
-- Name: reversion_version_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reversion_version
    ADD CONSTRAINT reversion_version_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialaccount_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialaccount_provider_36eec1734f431f56_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_provider_36eec1734f431f56_uniq UNIQUE (provider, uid);


--
-- Name: socialaccount_socialapp_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY socialaccount_socialapp
    ADD CONSTRAINT socialaccount_socialapp_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialapp_sites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_socialapp_sites_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialapp_sites_socialapp_id_site_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_socialapp_sites_socialapp_id_site_id_key UNIQUE (socialapp_id, site_id);


--
-- Name: socialaccount_socialtoken_app_id_697928748c2e1968_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_socialtoken_app_id_697928748c2e1968_uniq UNIQUE (app_id, account_id);


--
-- Name: socialaccount_socialtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_socialtoken_pkey PRIMARY KEY (id);


--
-- Name: users_country_domain_url_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_country
    ADD CONSTRAINT users_country_domain_url_key UNIQUE (domain_url);


--
-- Name: users_country_offices_country_id_office_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_country_offices
    ADD CONSTRAINT users_country_offices_country_id_office_id_key UNIQUE (country_id, office_id);


--
-- Name: users_country_offices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_country_offices
    ADD CONSTRAINT users_country_offices_pkey PRIMARY KEY (id);


--
-- Name: users_country_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_country
    ADD CONSTRAINT users_country_pkey PRIMARY KEY (id);


--
-- Name: users_country_schema_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_country
    ADD CONSTRAINT users_country_schema_name_key UNIQUE (schema_name);


--
-- Name: users_country_sections_country_id_section_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_country_sections
    ADD CONSTRAINT users_country_sections_country_id_section_id_key UNIQUE (country_id, section_id);


--
-- Name: users_country_sections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_country_sections
    ADD CONSTRAINT users_country_sections_pkey PRIMARY KEY (id);


--
-- Name: users_office_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_office
    ADD CONSTRAINT users_office_pkey PRIMARY KEY (id);


--
-- Name: users_section_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_section
    ADD CONSTRAINT users_section_name_key UNIQUE (name);


--
-- Name: users_section_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_section
    ADD CONSTRAINT users_section_pkey PRIMARY KEY (id);


--
-- Name: users_userprofile_countries_avail_userprofile_id_country_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_userprofile_countries_available
    ADD CONSTRAINT users_userprofile_countries_avail_userprofile_id_country_id_key UNIQUE (userprofile_id, country_id);


--
-- Name: users_userprofile_countries_available_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_userprofile_countries_available
    ADD CONSTRAINT users_userprofile_countries_available_pkey PRIMARY KEY (id);


--
-- Name: users_userprofile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_userprofile
    ADD CONSTRAINT users_userprofile_pkey PRIMARY KEY (id);


--
-- Name: users_userprofile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_userprofile
    ADD CONSTRAINT users_userprofile_user_id_key UNIQUE (user_id);


--
-- Name: vision_visionsynclog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vision_visionsynclog
    ADD CONSTRAINT vision_visionsynclog_pkey PRIMARY KEY (id);


SET search_path = hoth, pg_catalog;

--
-- Name: activityinfo_activity_c9eff1bf; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX activityinfo_activity_c9eff1bf ON activityinfo_activity USING btree (database_id);


--
-- Name: activityinfo_attribute_76e9940e; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX activityinfo_attribute_76e9940e ON activityinfo_attribute USING btree (attribute_group_id);


--
-- Name: activityinfo_attributegroup_f8a3193a; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX activityinfo_attributegroup_f8a3193a ON activityinfo_attributegroup USING btree (activity_id);


--
-- Name: activityinfo_indicator_f8a3193a; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX activityinfo_indicator_f8a3193a ON activityinfo_indicator USING btree (activity_id);


--
-- Name: activityinfo_partner_c9eff1bf; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX activityinfo_partner_c9eff1bf ON activityinfo_partner USING btree (database_id);


--
-- Name: funds_donor_name_347b008d094b839e_like; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX funds_donor_name_347b008d094b839e_like ON funds_donor USING btree (name varchar_pattern_ops);


--
-- Name: funds_grant_029df19e; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX funds_grant_029df19e ON funds_grant USING btree (donor_id);


--
-- Name: funds_grant_name_291034affa96d44_like; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX funds_grant_name_291034affa96d44_like ON funds_grant USING btree (name varchar_pattern_ops);


--
-- Name: locations_cartodbtable_3cfbd988; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX locations_cartodbtable_3cfbd988 ON locations_cartodbtable USING btree (rght);


--
-- Name: locations_cartodbtable_61737a71; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX locations_cartodbtable_61737a71 ON locations_cartodbtable USING btree (location_type_id);


--
-- Name: locations_cartodbtable_656442a0; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX locations_cartodbtable_656442a0 ON locations_cartodbtable USING btree (tree_id);


--
-- Name: locations_cartodbtable_6be37982; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX locations_cartodbtable_6be37982 ON locations_cartodbtable USING btree (parent_id);


--
-- Name: locations_cartodbtable_c9e9a848; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX locations_cartodbtable_c9e9a848 ON locations_cartodbtable USING btree (level);


--
-- Name: locations_cartodbtable_caf7cc51; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX locations_cartodbtable_caf7cc51 ON locations_cartodbtable USING btree (lft);


--
-- Name: locations_gatewaytype_name_6a01c5a6210b012_like; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX locations_gatewaytype_name_6a01c5a6210b012_like ON locations_gatewaytype USING btree (name varchar_pattern_ops);


--
-- Name: locations_governorate_1e9cd8d4; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX locations_governorate_1e9cd8d4 ON locations_governorate USING btree (gateway_id);


--
-- Name: locations_governorate_geom_id; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX locations_governorate_geom_id ON locations_governorate USING gist (geom);


--
-- Name: locations_linkedlocation_0f442f96; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX locations_linkedlocation_0f442f96 ON locations_linkedlocation USING btree (region_id);


--
-- Name: locations_linkedlocation_417f1b1c; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX locations_linkedlocation_417f1b1c ON locations_linkedlocation USING btree (content_type_id);


--
-- Name: locations_linkedlocation_7e3ea948; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX locations_linkedlocation_7e3ea948 ON locations_linkedlocation USING btree (locality_id);


--
-- Name: locations_linkedlocation_e274a5da; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX locations_linkedlocation_e274a5da ON locations_linkedlocation USING btree (location_id);


--
-- Name: locations_linkedlocation_f8d00aa6; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX locations_linkedlocation_f8d00aa6 ON locations_linkedlocation USING btree (governorate_id);


--
-- Name: locations_locality_0f442f96; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX locations_locality_0f442f96 ON locations_locality USING btree (region_id);


--
-- Name: locations_locality_1e9cd8d4; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX locations_locality_1e9cd8d4 ON locations_locality USING btree (gateway_id);


--
-- Name: locations_locality_geom_id; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX locations_locality_geom_id ON locations_locality USING gist (geom);


--
-- Name: locations_location_1e9cd8d4; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX locations_location_1e9cd8d4 ON locations_location USING btree (gateway_id);


--
-- Name: locations_location_3cfbd988; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX locations_location_3cfbd988 ON locations_location USING btree (rght);


--
-- Name: locations_location_656442a0; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX locations_location_656442a0 ON locations_location USING btree (tree_id);


--
-- Name: locations_location_6be37982; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX locations_location_6be37982 ON locations_location USING btree (parent_id);


--
-- Name: locations_location_7e3ea948; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX locations_location_7e3ea948 ON locations_location USING btree (locality_id);


--
-- Name: locations_location_c9e9a848; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX locations_location_c9e9a848 ON locations_location USING btree (level);


--
-- Name: locations_location_caf7cc51; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX locations_location_caf7cc51 ON locations_location USING btree (lft);


--
-- Name: locations_location_geom_id; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX locations_location_geom_id ON locations_location USING gist (geom);


--
-- Name: locations_location_point_id; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX locations_location_point_id ON locations_location USING gist (point);


--
-- Name: locations_region_1e9cd8d4; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX locations_region_1e9cd8d4 ON locations_region USING btree (gateway_id);


--
-- Name: locations_region_f8d00aa6; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX locations_region_f8d00aa6 ON locations_region USING btree (governorate_id);


--
-- Name: locations_region_geom_id; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX locations_region_geom_id ON locations_region USING gist (geom);


--
-- Name: partners_agreement_4e98b6eb; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_agreement_4e98b6eb ON partners_agreement USING btree (partner_id);


--
-- Name: partners_agreement_7dad813f; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_agreement_7dad813f ON partners_agreement USING btree (partner_manager_id);


--
-- Name: partners_agreement_9f081af4; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_agreement_9f081af4 ON partners_agreement USING btree (signed_by_id);


--
-- Name: partners_agreementamendmentlog_410cd312; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_agreementamendmentlog_410cd312 ON partners_agreementamendmentlog USING btree (agreement_id);


--
-- Name: partners_amendmentlog_cd976882; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_amendmentlog_cd976882 ON partners_amendmentlog USING btree (partnership_id);


--
-- Name: partners_assessment_4e98b6eb; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_assessment_4e98b6eb ON partners_assessment USING btree (partner_id);


--
-- Name: partners_assessment_cd7afc21; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_assessment_cd7afc21 ON partners_assessment USING btree (approving_officer_id);


--
-- Name: partners_assessment_d268de14; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_assessment_d268de14 ON partners_assessment USING btree (requesting_officer_id);


--
-- Name: partners_authorizedofficer_410cd312; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_authorizedofficer_410cd312 ON partners_authorizedofficer USING btree (agreement_id);


--
-- Name: partners_authorizedofficer_5b253451; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_authorizedofficer_5b253451 ON partners_authorizedofficer USING btree (amendment_id);


--
-- Name: partners_authorizedofficer_e1d6855c; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_authorizedofficer_e1d6855c ON partners_authorizedofficer USING btree (officer_id);


--
-- Name: partners_bankdetails_410cd312; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_bankdetails_410cd312 ON partners_bankdetails USING btree (agreement_id);


--
-- Name: partners_bankdetails_5b253451; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_bankdetails_5b253451 ON partners_bankdetails USING btree (amendment_id);


--
-- Name: partners_distributionplan_82bfda79; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_distributionplan_82bfda79 ON partners_distributionplan USING btree (item_id);


--
-- Name: partners_distributionplan_9365d6e7; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_distributionplan_9365d6e7 ON partners_distributionplan USING btree (site_id);


--
-- Name: partners_distributionplan_cd976882; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_distributionplan_cd976882 ON partners_distributionplan USING btree (partnership_id);


--
-- Name: partners_filetype_name_15345b22407d8a1b_like; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_filetype_name_15345b22407d8a1b_like ON partners_filetype USING btree (name varchar_pattern_ops);


--
-- Name: partners_fundingcommitment_123a1ce7; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_fundingcommitment_123a1ce7 ON partners_fundingcommitment USING btree (intervention_id);


--
-- Name: partners_fundingcommitment_c2418e07; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_fundingcommitment_c2418e07 ON partners_fundingcommitment USING btree (grant_id);


--
-- Name: partners_governmentintervention_4e98b6eb; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_governmentintervention_4e98b6eb ON partners_governmentintervention USING btree (partner_id);


--
-- Name: partners_governmentintervention_51f26604; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_governmentintervention_51f26604 ON partners_governmentintervention USING btree (result_structure_id);


--
-- Name: partners_governmentinterventionresult_123a1ce7; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_governmentinterventionresult_123a1ce7 ON partners_governmentinterventionresult USING btree (intervention_id);


--
-- Name: partners_governmentinterventionresult_57f06544; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_governmentinterventionresult_57f06544 ON partners_governmentinterventionresult USING btree (result_id);


--
-- Name: partners_governmentinterventionresult_5b1d2adf; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_governmentinterventionresult_5b1d2adf ON partners_governmentinterventionresult USING btree (sector_id);


--
-- Name: partners_governmentinterventionresult_730f6511; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_governmentinterventionresult_730f6511 ON partners_governmentinterventionresult USING btree (section_id);


--
-- Name: partners_governmentinterventionresult_activities_list_57f06544; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_governmentinterventionresult_activities_list_57f06544 ON partners_governmentinterventionresult_activities_list USING btree (result_id);


--
-- Name: partners_governmentinterventionresult_activities_list_57f68559; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_governmentinterventionresult_activities_list_57f68559 ON partners_governmentinterventionresult_activities_list USING btree (governmentinterventionresult_id);


--
-- Name: partners_governmentinterventionresult_unicef_managers_57f68559; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_governmentinterventionresult_unicef_managers_57f68559 ON partners_governmentinterventionresult_unicef_managers USING btree (governmentinterventionresult_id);


--
-- Name: partners_governmentinterventionresult_unicef_managers_e8701ad4; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_governmentinterventionresult_unicef_managers_e8701ad4 ON partners_governmentinterventionresult_unicef_managers USING btree (user_id);


--
-- Name: partners_gwpcalocation_0f442f96; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_gwpcalocation_0f442f96 ON partners_gwpcalocation USING btree (region_id);


--
-- Name: partners_gwpcalocation_2c72a097; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_gwpcalocation_2c72a097 ON partners_gwpcalocation USING btree (pca_id);


--
-- Name: partners_gwpcalocation_5b1d2adf; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_gwpcalocation_5b1d2adf ON partners_gwpcalocation USING btree (sector_id);


--
-- Name: partners_gwpcalocation_7e3ea948; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_gwpcalocation_7e3ea948 ON partners_gwpcalocation USING btree (locality_id);


--
-- Name: partners_gwpcalocation_e274a5da; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_gwpcalocation_e274a5da ON partners_gwpcalocation USING btree (location_id);


--
-- Name: partners_gwpcalocation_f8d00aa6; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_gwpcalocation_f8d00aa6 ON partners_gwpcalocation USING btree (governorate_id);


--
-- Name: partners_indicatorduedates_123a1ce7; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_indicatorduedates_123a1ce7 ON partners_indicatorduedates USING btree (intervention_id);


--
-- Name: partners_indicatorreport_11f5c585; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_indicatorreport_11f5c585 ON partners_indicatorreport USING btree (partner_staff_member_id);


--
-- Name: partners_indicatorreport_a82bd466; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_indicatorreport_a82bd466 ON partners_indicatorreport USING btree (indicator_id);


--
-- Name: partners_indicatorreport_c7acdb49; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_indicatorreport_c7acdb49 ON partners_indicatorreport USING btree (result_chain_id);


--
-- Name: partners_indicatorreport_e274a5da; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_indicatorreport_e274a5da ON partners_indicatorreport USING btree (location_id);


--
-- Name: partners_partnershipbudget_5b253451; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_partnershipbudget_5b253451 ON partners_partnershipbudget USING btree (amendment_id);


--
-- Name: partners_partnershipbudget_cd976882; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_partnershipbudget_cd976882 ON partners_partnershipbudget USING btree (partnership_id);


--
-- Name: partners_partnerstaffmember_4e98b6eb; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_partnerstaffmember_4e98b6eb ON partners_partnerstaffmember USING btree (partner_id);


--
-- Name: partners_pca_01cbd458; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_pca_01cbd458 ON partners_pca USING btree (partner_focal_point_id);


--
-- Name: partners_pca_410cd312; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_pca_410cd312 ON partners_pca USING btree (agreement_id);


--
-- Name: partners_pca_4e98b6eb; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_pca_4e98b6eb ON partners_pca USING btree (partner_id);


--
-- Name: partners_pca_51f26604; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_pca_51f26604 ON partners_pca USING btree (result_structure_id);


--
-- Name: partners_pca_7dad813f; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_pca_7dad813f ON partners_pca USING btree (partner_manager_id);


--
-- Name: partners_pca_ca5e329c; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_pca_ca5e329c ON partners_pca USING btree (unicef_manager_id);


--
-- Name: partners_pca_unicef_managers_2c72a097; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_pca_unicef_managers_2c72a097 ON partners_pca_unicef_managers USING btree (pca_id);


--
-- Name: partners_pca_unicef_managers_e8701ad4; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_pca_unicef_managers_e8701ad4 ON partners_pca_unicef_managers USING btree (user_id);


--
-- Name: partners_pcafile_2c72a097; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_pcafile_2c72a097 ON partners_pcafile USING btree (pca_id);


--
-- Name: partners_pcafile_94757cae; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_pcafile_94757cae ON partners_pcafile USING btree (type_id);


--
-- Name: partners_pcagrant_5b253451; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_pcagrant_5b253451 ON partners_pcagrant USING btree (amendment_id);


--
-- Name: partners_pcagrant_c2418e07; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_pcagrant_c2418e07 ON partners_pcagrant USING btree (grant_id);


--
-- Name: partners_pcagrant_cd976882; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_pcagrant_cd976882 ON partners_pcagrant USING btree (partnership_id);


--
-- Name: partners_pcasector_2c72a097; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_pcasector_2c72a097 ON partners_pcasector USING btree (pca_id);


--
-- Name: partners_pcasector_5b1d2adf; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_pcasector_5b1d2adf ON partners_pcasector USING btree (sector_id);


--
-- Name: partners_pcasector_5b253451; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_pcasector_5b253451 ON partners_pcasector USING btree (amendment_id);


--
-- Name: partners_pcasectorgoal_6315bdf2; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_pcasectorgoal_6315bdf2 ON partners_pcasectorgoal USING btree (pca_sector_id);


--
-- Name: partners_pcasectorgoal_b730706b; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_pcasectorgoal_b730706b ON partners_pcasectorgoal USING btree (goal_id);


--
-- Name: partners_ramindicator_123a1ce7; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_ramindicator_123a1ce7 ON partners_ramindicator USING btree (intervention_id);


--
-- Name: partners_ramindicator_57f06544; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_ramindicator_57f06544 ON partners_ramindicator USING btree (result_id);


--
-- Name: partners_ramindicator_a82bd466; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_ramindicator_a82bd466 ON partners_ramindicator USING btree (indicator_id);


--
-- Name: partners_resultchain_57f06544; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_resultchain_57f06544 ON partners_resultchain USING btree (result_id);


--
-- Name: partners_resultchain_a82bd466; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_resultchain_a82bd466 ON partners_resultchain USING btree (indicator_id);


--
-- Name: partners_resultchain_cd976882; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_resultchain_cd976882 ON partners_resultchain USING btree (partnership_id);


--
-- Name: partners_resultchain_fc36e3fa; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_resultchain_fc36e3fa ON partners_resultchain USING btree (result_type_id);


--
-- Name: partners_supplyplan_82bfda79; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_supplyplan_82bfda79 ON partners_supplyplan USING btree (item_id);


--
-- Name: partners_supplyplan_cd976882; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX partners_supplyplan_cd976882 ON partners_supplyplan USING btree (partnership_id);


--
-- Name: reports_goal_51f26604; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX reports_goal_51f26604 ON reports_goal USING btree (result_structure_id);


--
-- Name: reports_goal_5b1d2adf; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX reports_goal_5b1d2adf ON reports_goal USING btree (sector_id);


--
-- Name: reports_goal_name_7fda9483bd93a1ef_like; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX reports_goal_name_7fda9483bd93a1ef_like ON reports_goal USING btree (name varchar_pattern_ops);


--
-- Name: reports_indicator_51f26604; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX reports_indicator_51f26604 ON reports_indicator USING btree (result_structure_id);


--
-- Name: reports_indicator_57f06544; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX reports_indicator_57f06544 ON reports_indicator USING btree (result_id);


--
-- Name: reports_indicator_5b1d2adf; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX reports_indicator_5b1d2adf ON reports_indicator USING btree (sector_id);


--
-- Name: reports_indicator_activity_info_indicators_11c69367; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX reports_indicator_activity_info_indicators_11c69367 ON reports_indicator_activity_info_indicators USING btree (from_indicator_id);


--
-- Name: reports_indicator_activity_info_indicators_bcf27b20; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX reports_indicator_activity_info_indicators_bcf27b20 ON reports_indicator_activity_info_indicators USING btree (to_indicator_id);


--
-- Name: reports_indicator_e8175980; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX reports_indicator_e8175980 ON reports_indicator USING btree (unit_id);


--
-- Name: reports_result_3cfbd988; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX reports_result_3cfbd988 ON reports_result USING btree (rght);


--
-- Name: reports_result_51f26604; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX reports_result_51f26604 ON reports_result USING btree (result_structure_id);


--
-- Name: reports_result_5b1d2adf; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX reports_result_5b1d2adf ON reports_result USING btree (sector_id);


--
-- Name: reports_result_656442a0; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX reports_result_656442a0 ON reports_result USING btree (tree_id);


--
-- Name: reports_result_6be37982; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX reports_result_6be37982 ON reports_result USING btree (parent_id);


--
-- Name: reports_result_c9e9a848; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX reports_result_c9e9a848 ON reports_result USING btree (level);


--
-- Name: reports_result_caf7cc51; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX reports_result_caf7cc51 ON reports_result USING btree (lft);


--
-- Name: reports_result_fc36e3fa; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX reports_result_fc36e3fa ON reports_result USING btree (result_type_id);


--
-- Name: reports_sector_name_70bf85d5e17f5cb0_like; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX reports_sector_name_70bf85d5e17f5cb0_like ON reports_sector USING btree (name varchar_pattern_ops);


--
-- Name: reports_unit_type_111e83d6c65ff8e3_like; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX reports_unit_type_111e83d6c65ff8e3_like ON reports_unit USING btree (type varchar_pattern_ops);


--
-- Name: supplies_supplyitem_name_41fa01b33c88909f_like; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX supplies_supplyitem_name_41fa01b33c88909f_like ON supplies_supplyitem USING btree (name varchar_pattern_ops);


--
-- Name: tpm_tpmvisit_2c72a097; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX tpm_tpmvisit_2c72a097 ON tpm_tpmvisit USING btree (pca_id);


--
-- Name: tpm_tpmvisit_a38a7228; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX tpm_tpmvisit_a38a7228 ON tpm_tpmvisit USING btree (assigned_by_id);


--
-- Name: tpm_tpmvisit_c716b707; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX tpm_tpmvisit_c716b707 ON tpm_tpmvisit USING btree (pca_location_id);


--
-- Name: trips_actionpoint_18844eba; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_actionpoint_18844eba ON trips_actionpoint USING btree (person_responsible_id);


--
-- Name: trips_actionpoint_c65d32e5; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_actionpoint_c65d32e5 ON trips_actionpoint USING btree (trip_id);


--
-- Name: trips_fileattachment_417f1b1c; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_fileattachment_417f1b1c ON trips_fileattachment USING btree (content_type_id);


--
-- Name: trips_fileattachment_94757cae; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_fileattachment_94757cae ON trips_fileattachment USING btree (type_id);


--
-- Name: trips_fileattachment_c65d32e5; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_fileattachment_c65d32e5 ON trips_fileattachment USING btree (trip_id);


--
-- Name: trips_linkedpartner_123a1ce7; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_linkedpartner_123a1ce7 ON trips_linkedpartner USING btree (intervention_id);


--
-- Name: trips_linkedpartner_4e98b6eb; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_linkedpartner_4e98b6eb ON trips_linkedpartner USING btree (partner_id);


--
-- Name: trips_linkedpartner_57f06544; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_linkedpartner_57f06544 ON trips_linkedpartner USING btree (result_id);


--
-- Name: trips_linkedpartner_c65d32e5; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_linkedpartner_c65d32e5 ON trips_linkedpartner USING btree (trip_id);


--
-- Name: trips_travelroutes_c65d32e5; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_travelroutes_c65d32e5 ON trips_travelroutes USING btree (trip_id);


--
-- Name: trips_trip_1258742e; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_trip_1258742e ON trips_trip USING btree (budget_owner_id);


--
-- Name: trips_trip_17565772; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_trip_17565772 ON trips_trip USING btree (driver_id);


--
-- Name: trips_trip_1f2c177a; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_trip_1f2c177a ON trips_trip USING btree (programme_assistant_id);


--
-- Name: trips_trip_5e7b1936; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_trip_5e7b1936 ON trips_trip USING btree (owner_id);


--
-- Name: trips_trip_730f6511; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_trip_730f6511 ON trips_trip USING btree (section_id);


--
-- Name: trips_trip_82a0aa35; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_trip_82a0aa35 ON trips_trip USING btree (representative_id);


--
-- Name: trips_trip_84f68ceb; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_trip_84f68ceb ON trips_trip USING btree (travel_assistant_id);


--
-- Name: trips_trip_91ce675c; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_trip_91ce675c ON trips_trip USING btree (driver_supervisor_id);


--
-- Name: trips_trip_ab5dba3a; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_trip_ab5dba3a ON trips_trip USING btree (driver_trip_id);


--
-- Name: trips_trip_c0264d08; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_trip_c0264d08 ON trips_trip USING btree (human_resources_id);


--
-- Name: trips_trip_cc247b05; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_trip_cc247b05 ON trips_trip USING btree (office_id);


--
-- Name: trips_trip_d70d33ab; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_trip_d70d33ab ON trips_trip USING btree (vision_approver_id);


--
-- Name: trips_trip_eae0a89e; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_trip_eae0a89e ON trips_trip USING btree (supervisor_id);


--
-- Name: trips_trip_partners_37462f00; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_trip_partners_37462f00 ON trips_trip_partners USING btree (partnerorganization_id);


--
-- Name: trips_trip_partners_c65d32e5; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_trip_partners_c65d32e5 ON trips_trip_partners USING btree (trip_id);


--
-- Name: trips_trip_pcas_2c72a097; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_trip_pcas_2c72a097 ON trips_trip_pcas USING btree (pca_id);


--
-- Name: trips_trip_pcas_c65d32e5; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_trip_pcas_c65d32e5 ON trips_trip_pcas USING btree (trip_id);


--
-- Name: trips_tripfunds_78655e45; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_tripfunds_78655e45 ON trips_tripfunds USING btree (wbs_id);


--
-- Name: trips_tripfunds_c2418e07; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_tripfunds_c2418e07 ON trips_tripfunds USING btree (grant_id);


--
-- Name: trips_tripfunds_c65d32e5; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_tripfunds_c65d32e5 ON trips_tripfunds USING btree (trip_id);


--
-- Name: trips_triplocation_0f442f96; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_triplocation_0f442f96 ON trips_triplocation USING btree (region_id);


--
-- Name: trips_triplocation_7e3ea948; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_triplocation_7e3ea948 ON trips_triplocation USING btree (locality_id);


--
-- Name: trips_triplocation_c65d32e5; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_triplocation_c65d32e5 ON trips_triplocation USING btree (trip_id);


--
-- Name: trips_triplocation_e274a5da; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_triplocation_e274a5da ON trips_triplocation USING btree (location_id);


--
-- Name: trips_triplocation_f8d00aa6; Type: INDEX; Schema: hoth; Owner: postgres
--

CREATE INDEX trips_triplocation_f8d00aa6 ON trips_triplocation USING btree (governorate_id);


SET search_path = public, pg_catalog;

--
-- Name: account_emailaddress_e8701ad4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_emailaddress_e8701ad4 ON account_emailaddress USING btree (user_id);


--
-- Name: account_emailaddress_email_206527469d8e1918_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_emailaddress_email_206527469d8e1918_like ON account_emailaddress USING btree (email varchar_pattern_ops);


--
-- Name: account_emailconfirmation_6f1edeac; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_emailconfirmation_6f1edeac ON account_emailconfirmation USING btree (email_address_id);


--
-- Name: account_emailconfirmation_key_7033a271201d424f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_emailconfirmation_key_7033a271201d424f_like ON account_emailconfirmation USING btree (key varchar_pattern_ops);


--
-- Name: auth_group_name_253ae2a6331666e8_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_253ae2a6331666e8_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_0e939a4f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_0e939a4f ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_8373b171; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_8373b171 ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_417f1b1c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_417f1b1c ON auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_0e939a4f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_0e939a4f ON auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_e8701ad4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_e8701ad4 ON auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_8373b171; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_8373b171 ON auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_e8701ad4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_e8701ad4 ON auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_51b3b110094b8aae_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_username_51b3b110094b8aae_like ON auth_user USING btree (username varchar_pattern_ops);


--
-- Name: authtoken_token_key_7222ec672cd32dcd_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX authtoken_token_key_7222ec672cd32dcd_like ON authtoken_token USING btree (key varchar_pattern_ops);


--
-- Name: celery_taskmeta_662f707d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX celery_taskmeta_662f707d ON celery_taskmeta USING btree (hidden);


--
-- Name: celery_taskmeta_task_id_1efd6ed1da631331_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX celery_taskmeta_task_id_1efd6ed1da631331_like ON celery_taskmeta USING btree (task_id varchar_pattern_ops);


--
-- Name: celery_tasksetmeta_662f707d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX celery_tasksetmeta_662f707d ON celery_tasksetmeta USING btree (hidden);


--
-- Name: celery_tasksetmeta_taskset_id_24b26c359742c9ab_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX celery_tasksetmeta_taskset_id_24b26c359742c9ab_like ON celery_tasksetmeta USING btree (taskset_id varchar_pattern_ops);


--
-- Name: django_admin_log_417f1b1c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_417f1b1c ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_e8701ad4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_e8701ad4 ON django_admin_log USING btree (user_id);


--
-- Name: django_session_de54fa62; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_de54fa62 ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_461cfeaa630ca218_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_461cfeaa630ca218_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: django_site_domain_a2e37b91_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_site_domain_a2e37b91_like ON django_site USING btree (domain varchar_pattern_ops);


--
-- Name: djcelery_periodictask_1dcd7040; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_periodictask_1dcd7040 ON djcelery_periodictask USING btree (interval_id);


--
-- Name: djcelery_periodictask_f3f0d72a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_periodictask_f3f0d72a ON djcelery_periodictask USING btree (crontab_id);


--
-- Name: djcelery_periodictask_name_47c621f8dc029d22_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_periodictask_name_47c621f8dc029d22_like ON djcelery_periodictask USING btree (name varchar_pattern_ops);


--
-- Name: djcelery_taskstate_662f707d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_taskstate_662f707d ON djcelery_taskstate USING btree (hidden);


--
-- Name: djcelery_taskstate_863bb2ee; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_taskstate_863bb2ee ON djcelery_taskstate USING btree (tstamp);


--
-- Name: djcelery_taskstate_9ed39e2e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_taskstate_9ed39e2e ON djcelery_taskstate USING btree (state);


--
-- Name: djcelery_taskstate_b068931c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_taskstate_b068931c ON djcelery_taskstate USING btree (name);


--
-- Name: djcelery_taskstate_ce77e6ef; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_taskstate_ce77e6ef ON djcelery_taskstate USING btree (worker_id);


--
-- Name: djcelery_taskstate_name_4337b4449e8827d_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_taskstate_name_4337b4449e8827d_like ON djcelery_taskstate USING btree (name varchar_pattern_ops);


--
-- Name: djcelery_taskstate_state_19cb9b39780e399c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_taskstate_state_19cb9b39780e399c_like ON djcelery_taskstate USING btree (state varchar_pattern_ops);


--
-- Name: djcelery_taskstate_task_id_29366bc6dcd6fd60_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_taskstate_task_id_29366bc6dcd6fd60_like ON djcelery_taskstate USING btree (task_id varchar_pattern_ops);


--
-- Name: djcelery_workerstate_f129901a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_workerstate_f129901a ON djcelery_workerstate USING btree (last_heartbeat);


--
-- Name: djcelery_workerstate_hostname_3900851044588416_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_workerstate_hostname_3900851044588416_like ON djcelery_workerstate USING btree (hostname varchar_pattern_ops);


--
-- Name: easy_thumbnails_source_b068931c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX easy_thumbnails_source_b068931c ON easy_thumbnails_source USING btree (name);


--
-- Name: easy_thumbnails_source_b454e115; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX easy_thumbnails_source_b454e115 ON easy_thumbnails_source USING btree (storage_hash);


--
-- Name: easy_thumbnails_source_name_30f1630fdb723040_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX easy_thumbnails_source_name_30f1630fdb723040_like ON easy_thumbnails_source USING btree (name varchar_pattern_ops);


--
-- Name: easy_thumbnails_source_storage_hash_67630ca484c5f723_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX easy_thumbnails_source_storage_hash_67630ca484c5f723_like ON easy_thumbnails_source USING btree (storage_hash varchar_pattern_ops);


--
-- Name: easy_thumbnails_thumbnail_0afd9202; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX easy_thumbnails_thumbnail_0afd9202 ON easy_thumbnails_thumbnail USING btree (source_id);


--
-- Name: easy_thumbnails_thumbnail_b068931c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX easy_thumbnails_thumbnail_b068931c ON easy_thumbnails_thumbnail USING btree (name);


--
-- Name: easy_thumbnails_thumbnail_b454e115; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX easy_thumbnails_thumbnail_b454e115 ON easy_thumbnails_thumbnail USING btree (storage_hash);


--
-- Name: easy_thumbnails_thumbnail_name_6faf8e189302c6aa_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX easy_thumbnails_thumbnail_name_6faf8e189302c6aa_like ON easy_thumbnails_thumbnail USING btree (name varchar_pattern_ops);


--
-- Name: easy_thumbnails_thumbnail_storage_hash_31873c4cca5ed053_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX easy_thumbnails_thumbnail_storage_hash_31873c4cca5ed053_like ON easy_thumbnails_thumbnail USING btree (storage_hash varchar_pattern_ops);


--
-- Name: filer_clipboard_e8701ad4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX filer_clipboard_e8701ad4 ON filer_clipboard USING btree (user_id);


--
-- Name: filer_clipboarditem_2655b062; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX filer_clipboarditem_2655b062 ON filer_clipboarditem USING btree (clipboard_id);


--
-- Name: filer_clipboarditem_814552b9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX filer_clipboarditem_814552b9 ON filer_clipboarditem USING btree (file_id);


--
-- Name: filer_file_5e7b1936; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX filer_file_5e7b1936 ON filer_file USING btree (owner_id);


--
-- Name: filer_file_a8a44dbb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX filer_file_a8a44dbb ON filer_file USING btree (folder_id);


--
-- Name: filer_file_d3e32c49; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX filer_file_d3e32c49 ON filer_file USING btree (polymorphic_ctype_id);


--
-- Name: filer_folder_3cfbd988; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX filer_folder_3cfbd988 ON filer_folder USING btree (rght);


--
-- Name: filer_folder_5e7b1936; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX filer_folder_5e7b1936 ON filer_folder USING btree (owner_id);


--
-- Name: filer_folder_656442a0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX filer_folder_656442a0 ON filer_folder USING btree (tree_id);


--
-- Name: filer_folder_6be37982; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX filer_folder_6be37982 ON filer_folder USING btree (parent_id);


--
-- Name: filer_folder_c9e9a848; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX filer_folder_c9e9a848 ON filer_folder USING btree (level);


--
-- Name: filer_folder_caf7cc51; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX filer_folder_caf7cc51 ON filer_folder USING btree (lft);


--
-- Name: filer_folderpermission_0e939a4f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX filer_folderpermission_0e939a4f ON filer_folderpermission USING btree (group_id);


--
-- Name: filer_folderpermission_a8a44dbb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX filer_folderpermission_a8a44dbb ON filer_folderpermission USING btree (folder_id);


--
-- Name: filer_folderpermission_e8701ad4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX filer_folderpermission_e8701ad4 ON filer_folderpermission USING btree (user_id);


--
-- Name: generic_links_genericlink_417f1b1c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX generic_links_genericlink_417f1b1c ON generic_links_genericlink USING btree (content_type_id);


--
-- Name: generic_links_genericlink_af31437c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX generic_links_genericlink_af31437c ON generic_links_genericlink USING btree (object_id);


--
-- Name: generic_links_genericlink_e8701ad4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX generic_links_genericlink_e8701ad4 ON generic_links_genericlink USING btree (user_id);


--
-- Name: generic_links_genericlink_eb4ac4d6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX generic_links_genericlink_eb4ac4d6 ON generic_links_genericlink USING btree (is_external);


--
-- Name: generic_links_genericlink_fde81f11; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX generic_links_genericlink_fde81f11 ON generic_links_genericlink USING btree (created_at);


--
-- Name: post_office_attachment_emails_07ba63f5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX post_office_attachment_emails_07ba63f5 ON post_office_attachment_emails USING btree (attachment_id);


--
-- Name: post_office_attachment_emails_fdfd0ebf; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX post_office_attachment_emails_fdfd0ebf ON post_office_attachment_emails USING btree (email_id);


--
-- Name: post_office_email_3acc0b7a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX post_office_email_3acc0b7a ON post_office_email USING btree (last_updated);


--
-- Name: post_office_email_74f53564; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX post_office_email_74f53564 ON post_office_email USING btree (template_id);


--
-- Name: post_office_email_9acb4454; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX post_office_email_9acb4454 ON post_office_email USING btree (status);


--
-- Name: post_office_email_e2fa5388; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX post_office_email_e2fa5388 ON post_office_email USING btree (created);


--
-- Name: post_office_email_ed24d584; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX post_office_email_ed24d584 ON post_office_email USING btree (scheduled_time);


--
-- Name: post_office_emailtemplate_dea6f63e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX post_office_emailtemplate_dea6f63e ON post_office_emailtemplate USING btree (default_template_id);


--
-- Name: post_office_log_fdfd0ebf; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX post_office_log_fdfd0ebf ON post_office_log USING btree (email_id);


--
-- Name: reversion_revision_b16b0f06; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reversion_revision_b16b0f06 ON reversion_revision USING btree (manager_slug);


--
-- Name: reversion_revision_c69e55a4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reversion_revision_c69e55a4 ON reversion_revision USING btree (date_created);


--
-- Name: reversion_revision_e8701ad4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reversion_revision_e8701ad4 ON reversion_revision USING btree (user_id);


--
-- Name: reversion_revision_manager_slug_54d21219582503b1_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reversion_revision_manager_slug_54d21219582503b1_like ON reversion_revision USING btree (manager_slug varchar_pattern_ops);


--
-- Name: reversion_version_0c9ba3a3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reversion_version_0c9ba3a3 ON reversion_version USING btree (object_id_int);


--
-- Name: reversion_version_417f1b1c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reversion_version_417f1b1c ON reversion_version USING btree (content_type_id);


--
-- Name: reversion_version_5de09a8d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reversion_version_5de09a8d ON reversion_version USING btree (revision_id);


--
-- Name: socialaccount_socialaccount_e8701ad4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX socialaccount_socialaccount_e8701ad4 ON socialaccount_socialaccount USING btree (user_id);


--
-- Name: socialaccount_socialapp_sites_9365d6e7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX socialaccount_socialapp_sites_9365d6e7 ON socialaccount_socialapp_sites USING btree (site_id);


--
-- Name: socialaccount_socialapp_sites_fe95b0a0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX socialaccount_socialapp_sites_fe95b0a0 ON socialaccount_socialapp_sites USING btree (socialapp_id);


--
-- Name: socialaccount_socialtoken_8a089c2a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX socialaccount_socialtoken_8a089c2a ON socialaccount_socialtoken USING btree (account_id);


--
-- Name: socialaccount_socialtoken_f382adfe; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX socialaccount_socialtoken_f382adfe ON socialaccount_socialtoken USING btree (app_id);


--
-- Name: users_country_domain_url_713208db75d5deb7_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_country_domain_url_713208db75d5deb7_like ON users_country USING btree (domain_url varchar_pattern_ops);


--
-- Name: users_country_offices_93bfec8a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_country_offices_93bfec8a ON users_country_offices USING btree (country_id);


--
-- Name: users_country_offices_cc247b05; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_country_offices_cc247b05 ON users_country_offices USING btree (office_id);


--
-- Name: users_country_schema_name_7ef5cec0a33e4061_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_country_schema_name_7ef5cec0a33e4061_like ON users_country USING btree (schema_name varchar_pattern_ops);


--
-- Name: users_country_sections_730f6511; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_country_sections_730f6511 ON users_country_sections USING btree (section_id);


--
-- Name: users_country_sections_93bfec8a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_country_sections_93bfec8a ON users_country_sections USING btree (country_id);


--
-- Name: users_office_bd59e407; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_office_bd59e407 ON users_office USING btree (zonal_chief_id);


--
-- Name: users_section_name_fe821db5f4eb631_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_section_name_fe821db5f4eb631_like ON users_section USING btree (name varchar_pattern_ops);


--
-- Name: users_userprofile_730f6511; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_userprofile_730f6511 ON users_userprofile USING btree (section_id);


--
-- Name: users_userprofile_93bfec8a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_userprofile_93bfec8a ON users_userprofile USING btree (country_id);


--
-- Name: users_userprofile_cc247b05; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_userprofile_cc247b05 ON users_userprofile USING btree (office_id);


--
-- Name: users_userprofile_countries_available_93bfec8a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_userprofile_countries_available_93bfec8a ON users_userprofile_countries_available USING btree (country_id);


--
-- Name: users_userprofile_countries_available_9c2a73e9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_userprofile_countries_available_9c2a73e9 ON users_userprofile_countries_available USING btree (userprofile_id);


--
-- Name: users_userprofile_f99684b8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_userprofile_f99684b8 ON users_userprofile USING btree (country_override_id);


--
-- Name: vision_visionsynclog_93bfec8a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX vision_visionsynclog_93bfec8a ON vision_visionsynclog USING btree (country_id);


SET search_path = hoth, pg_catalog;

--
-- Name: D093f4d23cc8218cfe190b0f31310ca6; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_authorizedofficer
    ADD CONSTRAINT "D093f4d23cc8218cfe190b0f31310ca6" FOREIGN KEY (amendment_id) REFERENCES partners_agreementamendmentlog(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D1945ae4cf01cc91320c6f1bada3f5a5; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_result
    ADD CONSTRAINT "D1945ae4cf01cc91320c6f1bada3f5a5" FOREIGN KEY (result_structure_id) REFERENCES reports_resultstructure(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D1c5e6141468cd38344b8889b3f45146; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_indicatorreport
    ADD CONSTRAINT "D1c5e6141468cd38344b8889b3f45146" FOREIGN KEY (partner_staff_member_id) REFERENCES partners_partnerstaffmember(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D4c9a2de2573d599733c127da34f3460; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_governmentinterventionresult_activities_list
    ADD CONSTRAINT "D4c9a2de2573d599733c127da34f3460" FOREIGN KEY (governmentinterventionresult_id) REFERENCES partners_governmentinterventionresult(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D4fdc5b3ad3f8e1bc4292c0645e060ad; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_trip_partners
    ADD CONSTRAINT "D4fdc5b3ad3f8e1bc4292c0645e060ad" FOREIGN KEY (partnerorganization_id) REFERENCES partners_partnerorganization(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D5c492549784cde8555bda5143c4d738; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_governmentinterventionresult_unicef_managers
    ADD CONSTRAINT "D5c492549784cde8555bda5143c4d738" FOREIGN KEY (governmentinterventionresult_id) REFERENCES partners_governmentinterventionresult(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D5f7fe000fa89487f2ffccabb9df0066; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pca
    ADD CONSTRAINT "D5f7fe000fa89487f2ffccabb9df0066" FOREIGN KEY (partner_manager_id) REFERENCES partners_partnerstaffmember(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D82934fd0d4b4e3520abfe2d384ffa43; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pca
    ADD CONSTRAINT "D82934fd0d4b4e3520abfe2d384ffa43" FOREIGN KEY (result_structure_id) REFERENCES reports_resultstructure(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D9bcf20b4dbb779d95203fda3e58bce3; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_bankdetails
    ADD CONSTRAINT "D9bcf20b4dbb779d95203fda3e58bce3" FOREIGN KEY (amendment_id) REFERENCES partners_agreementamendmentlog(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: aa9840d0768cd98e1c1b3a417d3f6835; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_goal
    ADD CONSTRAINT aa9840d0768cd98e1c1b3a417d3f6835 FOREIGN KEY (result_structure_id) REFERENCES reports_resultstructure(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: activi_activity_id_355516228ea8ff21_fk_activityinfo_activity_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY activityinfo_attributegroup
    ADD CONSTRAINT activi_activity_id_355516228ea8ff21_fk_activityinfo_activity_id FOREIGN KEY (activity_id) REFERENCES activityinfo_activity(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: activi_activity_id_43b0ced859f45ade_fk_activityinfo_activity_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY activityinfo_indicator
    ADD CONSTRAINT activi_activity_id_43b0ced859f45ade_fk_activityinfo_activity_id FOREIGN KEY (activity_id) REFERENCES activityinfo_activity(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: activi_database_id_7558eb395c7ee6b9_fk_activityinfo_database_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY activityinfo_partner
    ADD CONSTRAINT activi_database_id_7558eb395c7ee6b9_fk_activityinfo_database_id FOREIGN KEY (database_id) REFERENCES activityinfo_database(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: activi_database_id_7f087dffaa09a041_fk_activityinfo_database_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY activityinfo_activity
    ADD CONSTRAINT activi_database_id_7f087dffaa09a041_fk_activityinfo_database_id FOREIGN KEY (database_id) REFERENCES activityinfo_database(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: b9b1f974274dd2960754cfdb9429c223; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY activityinfo_attribute
    ADD CONSTRAINT b9b1f974274dd2960754cfdb9429c223 FOREIGN KEY (attribute_group_id) REFERENCES activityinfo_attributegroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: bc22146072b6e2f0786686faea6790fe; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_indicator
    ADD CONSTRAINT bc22146072b6e2f0786686faea6790fe FOREIGN KEY (result_structure_id) REFERENCES reports_resultstructure(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: c1475976cc0844bee222348e9fd2aeb8; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pca
    ADD CONSTRAINT c1475976cc0844bee222348e9fd2aeb8 FOREIGN KEY (partner_focal_point_id) REFERENCES partners_partnerstaffmember(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: d933c1d039111004dfca25d35ee658cd; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_governmentintervention
    ADD CONSTRAINT d933c1d039111004dfca25d35ee658cd FOREIGN KEY (result_structure_id) REFERENCES reports_resultstructure(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: e36b79af9b3e9a38a291e222f089daf9; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_agreement
    ADD CONSTRAINT e36b79af9b3e9a38a291e222f089daf9 FOREIGN KEY (partner_manager_id) REFERENCES partners_partnerstaffmember(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: efec5d360b6557ac8ec20c62ff2c6fc5; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_governmentinterventionresult
    ADD CONSTRAINT efec5d360b6557ac8ec20c62ff2c6fc5 FOREIGN KEY (intervention_id) REFERENCES partners_governmentintervention(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: funds_grant_donor_id_466726817cbada51_fk_funds_donor_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY funds_grant
    ADD CONSTRAINT funds_grant_donor_id_466726817cbada51_fk_funds_donor_id FOREIGN KEY (donor_id) REFERENCES funds_donor(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: l_location_type_id_4380537fa7572295_fk_locations_gatewaytype_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_cartodbtable
    ADD CONSTRAINT l_location_type_id_4380537fa7572295_fk_locations_gatewaytype_id FOREIGN KEY (location_type_id) REFERENCES locations_gatewaytype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: loc_governorate_id_1ced1bf2e66e9622_fk_locations_governorate_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_linkedlocation
    ADD CONSTRAINT loc_governorate_id_1ced1bf2e66e9622_fk_locations_governorate_id FOREIGN KEY (governorate_id) REFERENCES locations_governorate(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: loc_governorate_id_4c47666da9de0674_fk_locations_governorate_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_region
    ADD CONSTRAINT loc_governorate_id_4c47666da9de0674_fk_locations_governorate_id FOREIGN KEY (governorate_id) REFERENCES locations_governorate(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: loca_content_type_id_5e7fbc3bd173e247_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_linkedlocation
    ADD CONSTRAINT loca_content_type_id_5e7fbc3bd173e247_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: locatio_gateway_id_43c1adb1865a6129_fk_locations_gatewaytype_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_locality
    ADD CONSTRAINT locatio_gateway_id_43c1adb1865a6129_fk_locations_gatewaytype_id FOREIGN KEY (gateway_id) REFERENCES locations_gatewaytype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: locatio_gateway_id_5ae135f74bb19520_fk_locations_gatewaytype_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_region
    ADD CONSTRAINT locatio_gateway_id_5ae135f74bb19520_fk_locations_gatewaytype_id FOREIGN KEY (gateway_id) REFERENCES locations_gatewaytype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: locatio_gateway_id_680016608f9989d7_fk_locations_gatewaytype_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_governorate
    ADD CONSTRAINT locatio_gateway_id_680016608f9989d7_fk_locations_gatewaytype_id FOREIGN KEY (gateway_id) REFERENCES locations_gatewaytype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: locatio_gateway_id_7eb9f250008aeb71_fk_locations_gatewaytype_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_location
    ADD CONSTRAINT locatio_gateway_id_7eb9f250008aeb71_fk_locations_gatewaytype_id FOREIGN KEY (gateway_id) REFERENCES locations_gatewaytype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: locatio_parent_id_2c4d8587a5747250_fk_locations_cartodbtable_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_cartodbtable
    ADD CONSTRAINT locatio_parent_id_2c4d8587a5747250_fk_locations_cartodbtable_id FOREIGN KEY (parent_id) REFERENCES locations_cartodbtable(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: locations_l_parent_id_517a0dd9d8ce9d04_fk_locations_location_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_location
    ADD CONSTRAINT locations_l_parent_id_517a0dd9d8ce9d04_fk_locations_location_id FOREIGN KEY (parent_id) REFERENCES locations_location(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: locations_lin_region_id_6a4ad8b0e3863567_fk_locations_region_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_linkedlocation
    ADD CONSTRAINT locations_lin_region_id_6a4ad8b0e3863567_fk_locations_region_id FOREIGN KEY (region_id) REFERENCES locations_region(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: locations_loc_region_id_57b47339e5b9d972_fk_locations_region_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_locality
    ADD CONSTRAINT locations_loc_region_id_57b47339e5b9d972_fk_locations_region_id FOREIGN KEY (region_id) REFERENCES locations_region(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: locations_locality_id_3a084d9471b652e8_fk_locations_locality_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_linkedlocation
    ADD CONSTRAINT locations_locality_id_3a084d9471b652e8_fk_locations_locality_id FOREIGN KEY (locality_id) REFERENCES locations_locality(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: locations_locality_id_5e174822ad43f719_fk_locations_locality_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_location
    ADD CONSTRAINT locations_locality_id_5e174822ad43f719_fk_locations_locality_id FOREIGN KEY (locality_id) REFERENCES locations_locality(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: locations_location_id_405f21e1a5cec5b2_fk_locations_location_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY locations_linkedlocation
    ADD CONSTRAINT locations_location_id_405f21e1a5cec5b2_fk_locations_location_id FOREIGN KEY (location_id) REFERENCES locations_location(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: p_officer_id_2df846afbfe87b72_fk_partners_partnerstaffmember_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_authorizedofficer
    ADD CONSTRAINT p_officer_id_2df846afbfe87b72_fk_partners_partnerstaffmember_id FOREIGN KEY (officer_id) REFERENCES partners_partnerstaffmember(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: p_partner_id_badde5228f933b6_fk_partners_partnerorganization_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_partnerstaffmember
    ADD CONSTRAINT p_partner_id_badde5228f933b6_fk_partners_partnerorganization_id FOREIGN KEY (partner_id) REFERENCES partners_partnerorganization(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: p_partner_id_ed2933e73be0fa6_fk_partners_partnerorganization_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_assessment
    ADD CONSTRAINT p_partner_id_ed2933e73be0fa6_fk_partners_partnerorganization_id FOREIGN KEY (partner_id) REFERENCES partners_partnerorganization(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: par_governorate_id_71172960c781c8ca_fk_locations_governorate_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_gwpcalocation
    ADD CONSTRAINT par_governorate_id_71172960c781c8ca_fk_locations_governorate_id FOREIGN KEY (governorate_id) REFERENCES locations_governorate(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: par_result_chain_id_22422544f8a243b6_fk_partners_resultchain_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_indicatorreport
    ADD CONSTRAINT par_result_chain_id_22422544f8a243b6_fk_partners_resultchain_id FOREIGN KEY (result_chain_id) REFERENCES partners_resultchain(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partn_amendment_id_1bdcf5c911051482_fk_partners_amendmentlog_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pcasector
    ADD CONSTRAINT partn_amendment_id_1bdcf5c911051482_fk_partners_amendmentlog_id FOREIGN KEY (amendment_id) REFERENCES partners_amendmentlog(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partn_amendment_id_38deb7ae3fca4b3d_fk_partners_amendmentlog_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pcagrant
    ADD CONSTRAINT partn_amendment_id_38deb7ae3fca4b3d_fk_partners_amendmentlog_id FOREIGN KEY (amendment_id) REFERENCES partners_amendmentlog(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partne_amendment_id_9649f56d3f55bb3_fk_partners_amendmentlog_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_partnershipbudget
    ADD CONSTRAINT partne_amendment_id_9649f56d3f55bb3_fk_partners_amendmentlog_id FOREIGN KEY (amendment_id) REFERENCES partners_amendmentlog(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partne_result_type_id_6cf4907867e3483d_fk_reports_resulttype_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_resultchain
    ADD CONSTRAINT partne_result_type_id_6cf4907867e3483d_fk_reports_resulttype_id FOREIGN KEY (result_type_id) REFERENCES reports_resulttype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partner_id_1a3efc89825ec0a3_fk_partners_partnerorganization_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_agreement
    ADD CONSTRAINT partner_id_1a3efc89825ec0a3_fk_partners_partnerorganization_id FOREIGN KEY (partner_id) REFERENCES partners_partnerorganization(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partner_id_2ae94f13b2c2b256_fk_partners_partnerorganization_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_governmentintervention
    ADD CONSTRAINT partner_id_2ae94f13b2c2b256_fk_partners_partnerorganization_id FOREIGN KEY (partner_id) REFERENCES partners_partnerorganization(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partner_id_342380ecb702d4ce_fk_partners_partnerorganization_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_linkedpartner
    ADD CONSTRAINT partner_id_342380ecb702d4ce_fk_partners_partnerorganization_id FOREIGN KEY (partner_id) REFERENCES partners_partnerorganization(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partner_id_7e980fb6d8a5e729_fk_partners_partnerorganization_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pca
    ADD CONSTRAINT partner_id_7e980fb6d8a5e729_fk_partners_partnerorganization_id FOREIGN KEY (partner_id) REFERENCES partners_partnerorganization(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partner_pca_sector_id_41650f659620abfc_fk_partners_pcasector_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pcasectorgoal
    ADD CONSTRAINT partner_pca_sector_id_41650f659620abfc_fk_partners_pcasector_id FOREIGN KEY (pca_sector_id) REFERENCES partners_pcasector(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners__approving_officer_id_1836af905a615ebf_fk_auth_user_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_assessment
    ADD CONSTRAINT partners__approving_officer_id_1836af905a615ebf_fk_auth_user_id FOREIGN KEY (approving_officer_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners__indicator_id_16882383daabe2a3_fk_reports_indicator_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_indicatorreport
    ADD CONSTRAINT partners__indicator_id_16882383daabe2a3_fk_reports_indicator_id FOREIGN KEY (indicator_id) REFERENCES reports_indicator(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners__indicator_id_1a1e9e4931c883ca_fk_reports_indicator_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_ramindicator
    ADD CONSTRAINT partners__indicator_id_1a1e9e4931c883ca_fk_reports_indicator_id FOREIGN KEY (indicator_id) REFERENCES reports_indicator(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners__indicator_id_4618aa9257641ca6_fk_reports_indicator_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_resultchain
    ADD CONSTRAINT partners__indicator_id_4618aa9257641ca6_fk_reports_indicator_id FOREIGN KEY (indicator_id) REFERENCES reports_indicator(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners__locality_id_7f518e14bc83142c_fk_locations_locality_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_gwpcalocation
    ADD CONSTRAINT partners__locality_id_7f518e14bc83142c_fk_locations_locality_id FOREIGN KEY (locality_id) REFERENCES locations_locality(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners__location_id_3ea5f83178ea4cc6_fk_locations_location_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_gwpcalocation
    ADD CONSTRAINT partners__location_id_3ea5f83178ea4cc6_fk_locations_location_id FOREIGN KEY (location_id) REFERENCES locations_location(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners__location_id_4538c6117ac721da_fk_locations_location_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_indicatorreport
    ADD CONSTRAINT partners__location_id_4538c6117ac721da_fk_locations_location_id FOREIGN KEY (location_id) REFERENCES locations_location(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_agreemen_signed_by_id_354e83b3a247b1e9_fk_auth_user_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_agreement
    ADD CONSTRAINT partners_agreemen_signed_by_id_354e83b3a247b1e9_fk_auth_user_id FOREIGN KEY (signed_by_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_agreement_id_3710a416717ab312_fk_partners_agreement_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_authorizedofficer
    ADD CONSTRAINT partners_agreement_id_3710a416717ab312_fk_partners_agreement_id FOREIGN KEY (agreement_id) REFERENCES partners_agreement(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_agreement_id_40d4173bbbd3bba3_fk_partners_agreement_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pca
    ADD CONSTRAINT partners_agreement_id_40d4173bbbd3bba3_fk_partners_agreement_id FOREIGN KEY (agreement_id) REFERENCES partners_agreement(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_agreement_id_6cf55f50170c31c4_fk_partners_agreement_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_agreementamendmentlog
    ADD CONSTRAINT partners_agreement_id_6cf55f50170c31c4_fk_partners_agreement_id FOREIGN KEY (agreement_id) REFERENCES partners_agreement(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_agreement_id_7f38a7c4f5ecd9c9_fk_partners_agreement_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_bankdetails
    ADD CONSTRAINT partners_agreement_id_7f38a7c4f5ecd9c9_fk_partners_agreement_id FOREIGN KEY (agreement_id) REFERENCES partners_agreement(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_amen_partnership_id_be465573a03924f_fk_partners_pca_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_amendmentlog
    ADD CONSTRAINT partners_amen_partnership_id_be465573a03924f_fk_partners_pca_id FOREIGN KEY (partnership_id) REFERENCES partners_pca(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_dist_item_id_3bc9946345378a3_fk_supplies_supplyitem_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_distributionplan
    ADD CONSTRAINT partners_dist_item_id_3bc9946345378a3_fk_supplies_supplyitem_id FOREIGN KEY (item_id) REFERENCES supplies_supplyitem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_dist_partnership_id_68b117966c691b1_fk_partners_pca_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_distributionplan
    ADD CONSTRAINT partners_dist_partnership_id_68b117966c691b1_fk_partners_pca_id FOREIGN KEY (partnership_id) REFERENCES partners_pca(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_dist_site_id_759ec76219f47b61_fk_locations_location_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_distributionplan
    ADD CONSTRAINT partners_dist_site_id_759ec76219f47b61_fk_locations_location_id FOREIGN KEY (site_id) REFERENCES locations_location(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_fu_intervention_id_63d7226fdb1f1b51_fk_partners_pca_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_fundingcommitment
    ADD CONSTRAINT partners_fu_intervention_id_63d7226fdb1f1b51_fk_partners_pca_id FOREIGN KEY (intervention_id) REFERENCES partners_pca(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_fundingcom_grant_id_776ec148259f5c7f_fk_funds_grant_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_fundingcommitment
    ADD CONSTRAINT partners_fundingcom_grant_id_776ec148259f5c7f_fk_funds_grant_id FOREIGN KEY (grant_id) REFERENCES funds_grant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_govern_result_id_2734b63559022f5d_fk_reports_result_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_governmentinterventionresult
    ADD CONSTRAINT partners_govern_result_id_2734b63559022f5d_fk_reports_result_id FOREIGN KEY (result_id) REFERENCES reports_result(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_govern_result_id_572bfc108de611ac_fk_reports_result_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_governmentinterventionresult_activities_list
    ADD CONSTRAINT partners_govern_result_id_572bfc108de611ac_fk_reports_result_id FOREIGN KEY (result_id) REFERENCES reports_result(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_govern_section_id_437cb9a400f170b0_fk_users_section_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_governmentinterventionresult
    ADD CONSTRAINT partners_govern_section_id_437cb9a400f170b0_fk_users_section_id FOREIGN KEY (section_id) REFERENCES public.users_section(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_governm_sector_id_95eae6a501031c2_fk_reports_sector_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_governmentinterventionresult
    ADD CONSTRAINT partners_governm_sector_id_95eae6a501031c2_fk_reports_sector_id FOREIGN KEY (sector_id) REFERENCES reports_sector(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_governmentint_user_id_79976e851bc26ee1_fk_auth_user_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_governmentinterventionresult_unicef_managers
    ADD CONSTRAINT partners_governmentint_user_id_79976e851bc26ee1_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_gwpc_region_id_6d2b3812d6406385_fk_locations_region_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_gwpcalocation
    ADD CONSTRAINT partners_gwpc_region_id_6d2b3812d6406385_fk_locations_region_id FOREIGN KEY (region_id) REFERENCES locations_region(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_gwpcal_sector_id_37254c04ae39ee4b_fk_reports_sector_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_gwpcalocation
    ADD CONSTRAINT partners_gwpcal_sector_id_37254c04ae39ee4b_fk_reports_sector_id FOREIGN KEY (sector_id) REFERENCES reports_sector(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_gwpcalocati_pca_id_2d730d33b4feef98_fk_partners_pca_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_gwpcalocation
    ADD CONSTRAINT partners_gwpcalocati_pca_id_2d730d33b4feef98_fk_partners_pca_id FOREIGN KEY (pca_id) REFERENCES partners_pca(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_in_intervention_id_4a5af923c10d7f6b_fk_partners_pca_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_indicatorduedates
    ADD CONSTRAINT partners_in_intervention_id_4a5af923c10d7f6b_fk_partners_pca_id FOREIGN KEY (intervention_id) REFERENCES partners_pca(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_par_partnership_id_31a8485d92dcd260_fk_partners_pca_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_partnershipbudget
    ADD CONSTRAINT partners_par_partnership_id_31a8485d92dcd260_fk_partners_pca_id FOREIGN KEY (partnership_id) REFERENCES partners_pca(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_pca_partnership_id_1d7e76f5a945c64a_fk_partners_pca_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pcagrant
    ADD CONSTRAINT partners_pca_partnership_id_1d7e76f5a945c64a_fk_partners_pca_id FOREIGN KEY (partnership_id) REFERENCES partners_pca(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_pca_unicef__pca_id_6fa568249574cee9_fk_partners_pca_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pca_unicef_managers
    ADD CONSTRAINT partners_pca_unicef__pca_id_6fa568249574cee9_fk_partners_pca_id FOREIGN KEY (pca_id) REFERENCES partners_pca(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_pca_unicef_ma_user_id_30b9c27ede09dff1_fk_auth_user_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pca_unicef_managers
    ADD CONSTRAINT partners_pca_unicef_ma_user_id_30b9c27ede09dff1_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_pca_unicef_manager_id_4e98cdc81943354_fk_auth_user_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pca
    ADD CONSTRAINT partners_pca_unicef_manager_id_4e98cdc81943354_fk_auth_user_id FOREIGN KEY (unicef_manager_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_pcafi_type_id_57edde389d9bbb14_fk_partners_filetype_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pcafile
    ADD CONSTRAINT partners_pcafi_type_id_57edde389d9bbb14_fk_partners_filetype_id FOREIGN KEY (type_id) REFERENCES partners_filetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_pcafile_pca_id_26db76311cb33b4f_fk_partners_pca_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pcafile
    ADD CONSTRAINT partners_pcafile_pca_id_26db76311cb33b4f_fk_partners_pca_id FOREIGN KEY (pca_id) REFERENCES partners_pca(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_pcagrant_grant_id_48c5d5ac0c32cf86_fk_funds_grant_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pcagrant
    ADD CONSTRAINT partners_pcagrant_grant_id_48c5d5ac0c32cf86_fk_funds_grant_id FOREIGN KEY (grant_id) REFERENCES funds_grant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_pcasec_sector_id_62ae292c476fda7e_fk_reports_sector_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pcasector
    ADD CONSTRAINT partners_pcasec_sector_id_62ae292c476fda7e_fk_reports_sector_id FOREIGN KEY (sector_id) REFERENCES reports_sector(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_pcasector_pca_id_13e6444a8f241b61_fk_partners_pca_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pcasector
    ADD CONSTRAINT partners_pcasector_pca_id_13e6444a8f241b61_fk_partners_pca_id FOREIGN KEY (pca_id) REFERENCES partners_pca(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_pcasectorg_goal_id_487a8ba4816a9cbe_fk_reports_goal_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_pcasectorgoal
    ADD CONSTRAINT partners_pcasectorg_goal_id_487a8ba4816a9cbe_fk_reports_goal_id FOREIGN KEY (goal_id) REFERENCES reports_goal(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_ra_intervention_id_48cb4a4acf640507_fk_partners_pca_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_ramindicator
    ADD CONSTRAINT partners_ra_intervention_id_48cb4a4acf640507_fk_partners_pca_id FOREIGN KEY (intervention_id) REFERENCES partners_pca(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_ramind_result_id_551d55f95d1ac9b3_fk_reports_result_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_ramindicator
    ADD CONSTRAINT partners_ramind_result_id_551d55f95d1ac9b3_fk_reports_result_id FOREIGN KEY (result_id) REFERENCES reports_result(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_requesting_officer_id_4bfdb786f5ba44a9_fk_auth_user_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_assessment
    ADD CONSTRAINT partners_requesting_officer_id_4bfdb786f5ba44a9_fk_auth_user_id FOREIGN KEY (requesting_officer_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_resul_partnership_id_4878b627b2f837_fk_partners_pca_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_resultchain
    ADD CONSTRAINT partners_resul_partnership_id_4878b627b2f837_fk_partners_pca_id FOREIGN KEY (partnership_id) REFERENCES partners_pca(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_result_result_id_39b7eb723f690e89_fk_reports_result_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_resultchain
    ADD CONSTRAINT partners_result_result_id_39b7eb723f690e89_fk_reports_result_id FOREIGN KEY (result_id) REFERENCES reports_result(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_sup_item_id_43fd03e7ddfe85e8_fk_supplies_supplyitem_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_supplyplan
    ADD CONSTRAINT partners_sup_item_id_43fd03e7ddfe85e8_fk_supplies_supplyitem_id FOREIGN KEY (item_id) REFERENCES supplies_supplyitem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_sup_partnership_id_1339f6b547f438b2_fk_partners_pca_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY partners_supplyplan
    ADD CONSTRAINT partners_sup_partnership_id_1339f6b547f438b2_fk_partners_pca_id FOREIGN KEY (partnership_id) REFERENCES partners_pca(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: re_to_indicator_id_fbde3cd4f0a4044_fk_activityinfo_indicator_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_indicator_activity_info_indicators
    ADD CONSTRAINT re_to_indicator_id_fbde3cd4f0a4044_fk_activityinfo_indicator_id FOREIGN KEY (to_indicator_id) REFERENCES activityinfo_indicator(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: repo_from_indicator_id_360a01af91be285f_fk_reports_indicator_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_indicator_activity_info_indicators
    ADD CONSTRAINT repo_from_indicator_id_360a01af91be285f_fk_reports_indicator_id FOREIGN KEY (from_indicator_id) REFERENCES reports_indicator(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: report_result_type_id_545f7d3c1ac9fc52_fk_reports_resulttype_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_result
    ADD CONSTRAINT report_result_type_id_545f7d3c1ac9fc52_fk_reports_resulttype_id FOREIGN KEY (result_type_id) REFERENCES reports_resulttype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reports_goal_sector_id_131146e7c9918dc9_fk_reports_sector_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_goal
    ADD CONSTRAINT reports_goal_sector_id_131146e7c9918dc9_fk_reports_sector_id FOREIGN KEY (sector_id) REFERENCES reports_sector(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reports_indicat_result_id_6f41076cfb8129e7_fk_reports_result_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_indicator
    ADD CONSTRAINT reports_indicat_result_id_6f41076cfb8129e7_fk_reports_result_id FOREIGN KEY (result_id) REFERENCES reports_result(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reports_indicat_sector_id_5f59b5984c269234_fk_reports_sector_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_indicator
    ADD CONSTRAINT reports_indicat_sector_id_5f59b5984c269234_fk_reports_sector_id FOREIGN KEY (sector_id) REFERENCES reports_sector(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reports_indicator_unit_id_259c7e626cffbda6_fk_reports_unit_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_indicator
    ADD CONSTRAINT reports_indicator_unit_id_259c7e626cffbda6_fk_reports_unit_id FOREIGN KEY (unit_id) REFERENCES reports_unit(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reports_result_parent_id_345f87d4f4a258b5_fk_reports_result_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_result
    ADD CONSTRAINT reports_result_parent_id_345f87d4f4a258b5_fk_reports_result_id FOREIGN KEY (parent_id) REFERENCES reports_result(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reports_result_sector_id_16d5fe9a99010221_fk_reports_sector_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY reports_result
    ADD CONSTRAINT reports_result_sector_id_16d5fe9a99010221_fk_reports_sector_id FOREIGN KEY (sector_id) REFERENCES reports_sector(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: t_pca_location_id_4b87826d7633e776_fk_partners_gwpcalocation_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY tpm_tpmvisit
    ADD CONSTRAINT t_pca_location_id_4b87826d7633e776_fk_partners_gwpcalocation_id FOREIGN KEY (pca_location_id) REFERENCES partners_gwpcalocation(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tpm_tpmvisit_assigned_by_id_30f904d7328c346f_fk_auth_user_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY tpm_tpmvisit
    ADD CONSTRAINT tpm_tpmvisit_assigned_by_id_30f904d7328c346f_fk_auth_user_id FOREIGN KEY (assigned_by_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tpm_tpmvisit_pca_id_1c1ff75e0a4fd95b_fk_partners_pca_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY tpm_tpmvisit
    ADD CONSTRAINT tpm_tpmvisit_pca_id_1c1ff75e0a4fd95b_fk_partners_pca_id FOREIGN KEY (pca_id) REFERENCES partners_pca(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tri_governorate_id_26b088c8dfdb7a56_fk_locations_governorate_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_triplocation
    ADD CONSTRAINT tri_governorate_id_26b088c8dfdb7a56_fk_locations_governorate_id FOREIGN KEY (governorate_id) REFERENCES locations_governorate(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trip_content_type_id_60e8deb760376306_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_fileattachment
    ADD CONSTRAINT trip_content_type_id_60e8deb760376306_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_ac_person_responsible_id_40e40dd320764e4e_fk_auth_user_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_actionpoint
    ADD CONSTRAINT trips_ac_person_responsible_id_40e40dd320764e4e_fk_auth_user_id FOREIGN KEY (person_responsible_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_actionpoint_trip_id_482012648cd5b785_fk_trips_trip_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_actionpoint
    ADD CONSTRAINT trips_actionpoint_trip_id_482012648cd5b785_fk_trips_trip_id FOREIGN KEY (trip_id) REFERENCES trips_trip(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_fileatta_type_id_10cf7d8e15ae132c_fk_partners_filetype_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_fileattachment
    ADD CONSTRAINT trips_fileatta_type_id_10cf7d8e15ae132c_fk_partners_filetype_id FOREIGN KEY (type_id) REFERENCES partners_filetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_fileattachment_trip_id_43d0d11528b46e01_fk_trips_trip_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_fileattachment
    ADD CONSTRAINT trips_fileattachment_trip_id_43d0d11528b46e01_fk_trips_trip_id FOREIGN KEY (trip_id) REFERENCES trips_trip(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_lin_result_id_70e7c7eb577d2d52_fk_partners_resultchain_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_linkedpartner
    ADD CONSTRAINT trips_lin_result_id_70e7c7eb577d2d52_fk_partners_resultchain_id FOREIGN KEY (result_id) REFERENCES partners_resultchain(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_linke_intervention_id_1e008874902fd40c_fk_partners_pca_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_linkedpartner
    ADD CONSTRAINT trips_linke_intervention_id_1e008874902fd40c_fk_partners_pca_id FOREIGN KEY (intervention_id) REFERENCES partners_pca(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_linkedpartner_trip_id_2c8f4c36873228ce_fk_trips_trip_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_linkedpartner
    ADD CONSTRAINT trips_linkedpartner_trip_id_2c8f4c36873228ce_fk_trips_trip_id FOREIGN KEY (trip_id) REFERENCES trips_trip(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_t_programme_assistant_id_34324e3a148407fe_fk_auth_user_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_trip
    ADD CONSTRAINT trips_t_programme_assistant_id_34324e3a148407fe_fk_auth_user_id FOREIGN KEY (programme_assistant_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_travelroutes_trip_id_9d96bf21177824_fk_trips_trip_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_travelroutes
    ADD CONSTRAINT trips_travelroutes_trip_id_9d96bf21177824_fk_trips_trip_id FOREIGN KEY (trip_id) REFERENCES trips_trip(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_tri_locality_id_37ce78e96c739d60_fk_locations_locality_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_triplocation
    ADD CONSTRAINT trips_tri_locality_id_37ce78e96c739d60_fk_locations_locality_id FOREIGN KEY (locality_id) REFERENCES locations_locality(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_tri_location_id_60852cff61c63b3a_fk_locations_location_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_triplocation
    ADD CONSTRAINT trips_tri_location_id_60852cff61c63b3a_fk_locations_location_id FOREIGN KEY (location_id) REFERENCES locations_location(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_trip_budget_owner_id_42571362275623f3_fk_auth_user_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_trip
    ADD CONSTRAINT trips_trip_budget_owner_id_42571362275623f3_fk_auth_user_id FOREIGN KEY (budget_owner_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_trip_driver_id_5187cd479c6e8fa6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_trip
    ADD CONSTRAINT trips_trip_driver_id_5187cd479c6e8fa6_fk_auth_user_id FOREIGN KEY (driver_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_trip_driver_supervisor_id_363302724ee30f0_fk_auth_user_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_trip
    ADD CONSTRAINT trips_trip_driver_supervisor_id_363302724ee30f0_fk_auth_user_id FOREIGN KEY (driver_supervisor_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_trip_driver_trip_id_215529fdec8b3701_fk_trips_trip_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_trip
    ADD CONSTRAINT trips_trip_driver_trip_id_215529fdec8b3701_fk_trips_trip_id FOREIGN KEY (driver_trip_id) REFERENCES trips_trip(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_trip_human_resources_id_7b0d46b1ed044144_fk_auth_user_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_trip
    ADD CONSTRAINT trips_trip_human_resources_id_7b0d46b1ed044144_fk_auth_user_id FOREIGN KEY (human_resources_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_trip_office_id_6e53e5c995df8374_fk_users_office_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_trip
    ADD CONSTRAINT trips_trip_office_id_6e53e5c995df8374_fk_users_office_id FOREIGN KEY (office_id) REFERENCES public.users_office(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_trip_owner_id_7f297675970ebc06_fk_auth_user_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_trip
    ADD CONSTRAINT trips_trip_owner_id_7f297675970ebc06_fk_auth_user_id FOREIGN KEY (owner_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_trip_partners_trip_id_1a92b70afe0442fc_fk_trips_trip_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_trip_partners
    ADD CONSTRAINT trips_trip_partners_trip_id_1a92b70afe0442fc_fk_trips_trip_id FOREIGN KEY (trip_id) REFERENCES trips_trip(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_trip_pcas_pca_id_21e1dec25071fd80_fk_partners_pca_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_trip_pcas
    ADD CONSTRAINT trips_trip_pcas_pca_id_21e1dec25071fd80_fk_partners_pca_id FOREIGN KEY (pca_id) REFERENCES partners_pca(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_trip_pcas_trip_id_7e9b036cc54d8ede_fk_trips_trip_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_trip_pcas
    ADD CONSTRAINT trips_trip_pcas_trip_id_7e9b036cc54d8ede_fk_trips_trip_id FOREIGN KEY (trip_id) REFERENCES trips_trip(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_trip_representative_id_3aa42bcfde8da0e3_fk_auth_user_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_trip
    ADD CONSTRAINT trips_trip_representative_id_3aa42bcfde8da0e3_fk_auth_user_id FOREIGN KEY (representative_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_trip_section_id_8ae9a62831b3e10_fk_users_section_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_trip
    ADD CONSTRAINT trips_trip_section_id_8ae9a62831b3e10_fk_users_section_id FOREIGN KEY (section_id) REFERENCES public.users_section(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_trip_supervisor_id_67d0675f6143105e_fk_auth_user_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_trip
    ADD CONSTRAINT trips_trip_supervisor_id_67d0675f6143105e_fk_auth_user_id FOREIGN KEY (supervisor_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_trip_travel_assistant_id_11792d48cdb297cf_fk_auth_user_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_trip
    ADD CONSTRAINT trips_trip_travel_assistant_id_11792d48cdb297cf_fk_auth_user_id FOREIGN KEY (travel_assistant_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_trip_vision_approver_id_7d82dbaeeb560b67_fk_auth_user_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_trip
    ADD CONSTRAINT trips_trip_vision_approver_id_7d82dbaeeb560b67_fk_auth_user_id FOREIGN KEY (vision_approver_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_tripfunds_grant_id_1d4574d154ac0824_fk_funds_grant_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_tripfunds
    ADD CONSTRAINT trips_tripfunds_grant_id_1d4574d154ac0824_fk_funds_grant_id FOREIGN KEY (grant_id) REFERENCES funds_grant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_tripfunds_trip_id_49f798812a0edb46_fk_trips_trip_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_tripfunds
    ADD CONSTRAINT trips_tripfunds_trip_id_49f798812a0edb46_fk_trips_trip_id FOREIGN KEY (trip_id) REFERENCES trips_trip(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_triploc_region_id_4b533cb28cd75ee1_fk_locations_region_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_triplocation
    ADD CONSTRAINT trips_triploc_region_id_4b533cb28cd75ee1_fk_locations_region_id FOREIGN KEY (region_id) REFERENCES locations_region(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_triplocation_trip_id_1e472a81c5dd03c6_fk_trips_trip_id; Type: FK CONSTRAINT; Schema: hoth; Owner: postgres
--

ALTER TABLE ONLY trips_triplocation
    ADD CONSTRAINT trips_triplocation_trip_id_1e472a81c5dd03c6_fk_trips_trip_id FOREIGN KEY (trip_id) REFERENCES trips_trip(id) DEFERRABLE INITIALLY DEFERRED;


SET search_path = public, pg_catalog;

--
-- Name: D10069961e621a6e7cf05885fc962d37; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY post_office_emailtemplate
    ADD CONSTRAINT "D10069961e621a6e7cf05885fc962d37" FOREIGN KEY (default_template_id) REFERENCES post_office_emailtemplate(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D78b1919611212d5b020ee49187da39e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY filer_file
    ADD CONSTRAINT "D78b1919611212d5b020ee49187da39e" FOREIGN KEY (polymorphic_ctype_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ac_email_address_id_5bcf9f503c32d4d8_fk_account_emailaddress_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY account_emailconfirmation
    ADD CONSTRAINT ac_email_address_id_5bcf9f503c32d4d8_fk_account_emailaddress_id FOREIGN KEY (email_address_id) REFERENCES account_emailaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_emailaddress_user_id_5c85949e40d9a61d_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY account_emailaddress
    ADD CONSTRAINT account_emailaddress_user_id_5c85949e40d9a61d_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_content_type_id_508cf46651277a81_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_content_type_id_508cf46651277a81_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissio_group_id_689710a9a73b7457_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_group_id_689710a9a73b7457_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permission_id_1f49ccbbdc69d2fc_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permission_id_1f49ccbbdc69d2fc_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user__permission_id_384b62483d7071f0_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user__permission_id_384b62483d7071f0_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_group_id_33ac548dcf5f8e37_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_33ac548dcf5f8e37_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_user_id_4b5ed4ffdb8fd9b0_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_4b5ed4ffdb8fd9b0_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permiss_user_id_7f0938558328534a_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permiss_user_id_7f0938558328534a_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authtoken_token_user_id_1d10c57f535fb363_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_1d10c57f535fb363_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dj_interval_id_20cfc1cad060dfad_fk_djcelery_intervalschedule_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY djcelery_periodictask
    ADD CONSTRAINT dj_interval_id_20cfc1cad060dfad_fk_djcelery_intervalschedule_id FOREIGN KEY (interval_id) REFERENCES djcelery_intervalschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: djan_content_type_id_697914295151027a_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT djan_content_type_id_697914295151027a_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_user_id_52fdd58701c5f563_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_52fdd58701c5f563_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: djce_crontab_id_1d8228f5b44b680a_fk_djcelery_crontabschedule_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY djcelery_periodictask
    ADD CONSTRAINT djce_crontab_id_1d8228f5b44b680a_fk_djcelery_crontabschedule_id FOREIGN KEY (crontab_id) REFERENCES djcelery_crontabschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: djcelery__worker_id_30050731b1c3d3d9_fk_djcelery_workerstate_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY djcelery_taskstate
    ADD CONSTRAINT djcelery__worker_id_30050731b1c3d3d9_fk_djcelery_workerstate_id FOREIGN KEY (worker_id) REFERENCES djcelery_workerstate(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: e_thumbnail_id_29ad34faceb3c17c_fk_easy_thumbnails_thumbnail_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY easy_thumbnails_thumbnaildimensions
    ADD CONSTRAINT e_thumbnail_id_29ad34faceb3c17c_fk_easy_thumbnails_thumbnail_id FOREIGN KEY (thumbnail_id) REFERENCES easy_thumbnails_thumbnail(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: easy_th_source_id_50b260de7106e1b7_fk_easy_thumbnails_source_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY easy_thumbnails_thumbnail
    ADD CONSTRAINT easy_th_source_id_50b260de7106e1b7_fk_easy_thumbnails_source_id FOREIGN KEY (source_id) REFERENCES easy_thumbnails_source(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: filer_clipb_clipboard_id_335d159e1aea2cdc_fk_filer_clipboard_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY filer_clipboarditem
    ADD CONSTRAINT filer_clipb_clipboard_id_335d159e1aea2cdc_fk_filer_clipboard_id FOREIGN KEY (clipboard_id) REFERENCES filer_clipboard(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: filer_clipboard_user_id_2b30c76f2cd235df_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY filer_clipboard
    ADD CONSTRAINT filer_clipboard_user_id_2b30c76f2cd235df_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: filer_clipboarditem_file_id_7b1b6a14b5a3f2b1_fk_filer_file_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY filer_clipboarditem
    ADD CONSTRAINT filer_clipboarditem_file_id_7b1b6a14b5a3f2b1_fk_filer_file_id FOREIGN KEY (file_id) REFERENCES filer_file(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: filer_file_folder_id_24318dda71f59785_fk_filer_folder_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY filer_file
    ADD CONSTRAINT filer_file_folder_id_24318dda71f59785_fk_filer_folder_id FOREIGN KEY (folder_id) REFERENCES filer_folder(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: filer_file_owner_id_67317c663ea33283_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY filer_file
    ADD CONSTRAINT filer_file_owner_id_67317c663ea33283_fk_auth_user_id FOREIGN KEY (owner_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: filer_folder_owner_id_6527f5f13a76f3ed_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY filer_folder
    ADD CONSTRAINT filer_folder_owner_id_6527f5f13a76f3ed_fk_auth_user_id FOREIGN KEY (owner_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: filer_folder_parent_id_4170098ac31c2cbf_fk_filer_folder_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY filer_folder
    ADD CONSTRAINT filer_folder_parent_id_4170098ac31c2cbf_fk_filer_folder_id FOREIGN KEY (parent_id) REFERENCES filer_folder(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: filer_folderpermi_folder_id_442a5347ee209a98_fk_filer_folder_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY filer_folderpermission
    ADD CONSTRAINT filer_folderpermi_folder_id_442a5347ee209a98_fk_filer_folder_id FOREIGN KEY (folder_id) REFERENCES filer_folder(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: filer_folderpermissi_group_id_7c2389ac07ebbde2_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY filer_folderpermission
    ADD CONSTRAINT filer_folderpermissi_group_id_7c2389ac07ebbde2_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: filer_folderpermission_user_id_7c6e1a7187a0f15b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY filer_folderpermission
    ADD CONSTRAINT filer_folderpermission_user_id_7c6e1a7187a0f15b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: filer_image_file_ptr_id_1dde9ad32bce39a6_fk_filer_file_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY filer_image
    ADD CONSTRAINT filer_image_file_ptr_id_1dde9ad32bce39a6_fk_filer_file_id FOREIGN KEY (file_ptr_id) REFERENCES filer_file(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gene_content_type_id_222cfb2a075e077e_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY generic_links_genericlink
    ADD CONSTRAINT gene_content_type_id_222cfb2a075e077e_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: generic_links_genericl_user_id_4c7471010d93675b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY generic_links_genericlink
    ADD CONSTRAINT generic_links_genericl_user_id_4c7471010d93675b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: po_template_id_3c48ffa2f1c17f43_fk_post_office_emailtemplate_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY post_office_email
    ADD CONSTRAINT po_template_id_3c48ffa2f1c17f43_fk_post_office_emailtemplate_id FOREIGN KEY (template_id) REFERENCES post_office_emailtemplate(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: post_attachment_id_388fa287a684f8f_fk_post_office_attachment_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY post_office_attachment_emails
    ADD CONSTRAINT post_attachment_id_388fa287a684f8f_fk_post_office_attachment_id FOREIGN KEY (attachment_id) REFERENCES post_office_attachment(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: post_office_at_email_id_f053bb3a1fa4afd_fk_post_office_email_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY post_office_attachment_emails
    ADD CONSTRAINT post_office_at_email_id_f053bb3a1fa4afd_fk_post_office_email_id FOREIGN KEY (email_id) REFERENCES post_office_email(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: post_office_l_email_id_72165efe97e2d836_fk_post_office_email_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY post_office_log
    ADD CONSTRAINT post_office_l_email_id_72165efe97e2d836_fk_post_office_email_id FOREIGN KEY (email_id) REFERENCES post_office_email(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: rever_content_type_id_c01a11926d4c4a9_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reversion_version
    ADD CONSTRAINT rever_content_type_id_c01a11926d4c4a9_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reversion__revision_id_48ec3744916a950_fk_reversion_revision_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reversion_version
    ADD CONSTRAINT reversion__revision_id_48ec3744916a950_fk_reversion_revision_id FOREIGN KEY (revision_id) REFERENCES reversion_revision(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reversion_revision_user_id_53d027e45b2ec55e_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reversion_revision
    ADD CONSTRAINT reversion_revision_user_id_53d027e45b2ec55e_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: s_account_id_3fc809e243dd8c0a_fk_socialaccount_socialaccount_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY socialaccount_socialtoken
    ADD CONSTRAINT s_account_id_3fc809e243dd8c0a_fk_socialaccount_socialaccount_id FOREIGN KEY (account_id) REFERENCES socialaccount_socialaccount(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: soc_socialapp_id_7b02380b6127b1b8_fk_socialaccount_socialapp_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY socialaccount_socialapp_sites
    ADD CONSTRAINT soc_socialapp_id_7b02380b6127b1b8_fk_socialaccount_socialapp_id FOREIGN KEY (socialapp_id) REFERENCES socialaccount_socialapp(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialacco_app_id_2125549785bd662_fk_socialaccount_socialapp_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY socialaccount_socialtoken
    ADD CONSTRAINT socialacco_app_id_2125549785bd662_fk_socialaccount_socialapp_id FOREIGN KEY (app_id) REFERENCES socialaccount_socialapp(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_sociala_site_id_a859406a22be3fe_fk_django_site_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_sociala_site_id_a859406a22be3fe_fk_django_site_id FOREIGN KEY (site_id) REFERENCES django_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialac_user_id_3fd78aac97693583_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialac_user_id_3fd78aac97693583_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users__country_override_id_4de609908747de6b_fk_users_country_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_userprofile
    ADD CONSTRAINT users__country_override_id_4de609908747de6b_fk_users_country_id FOREIGN KEY (country_override_id) REFERENCES users_country(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_country_o_country_id_1e55a08f3bcf03b3_fk_users_country_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_country_offices
    ADD CONSTRAINT users_country_o_country_id_1e55a08f3bcf03b3_fk_users_country_id FOREIGN KEY (country_id) REFERENCES users_country(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_country_off_office_id_52ebc125913460cc_fk_users_office_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_country_offices
    ADD CONSTRAINT users_country_off_office_id_52ebc125913460cc_fk_users_office_id FOREIGN KEY (office_id) REFERENCES users_office(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_country_s_country_id_4bb5146e7cc75a59_fk_users_country_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_country_sections
    ADD CONSTRAINT users_country_s_country_id_4bb5146e7cc75a59_fk_users_country_id FOREIGN KEY (country_id) REFERENCES users_country(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_country_s_section_id_43a688ba89de99dc_fk_users_section_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_country_sections
    ADD CONSTRAINT users_country_s_section_id_43a688ba89de99dc_fk_users_section_id FOREIGN KEY (section_id) REFERENCES users_section(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_office_zonal_chief_id_2f404077b36e0282_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_office
    ADD CONSTRAINT users_office_zonal_chief_id_2f404077b36e0282_fk_auth_user_id FOREIGN KEY (zonal_chief_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_u_userprofile_id_35fe3e2d262bf6c6_fk_users_userprofile_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_userprofile_countries_available
    ADD CONSTRAINT users_u_userprofile_id_35fe3e2d262bf6c6_fk_users_userprofile_id FOREIGN KEY (userprofile_id) REFERENCES users_userprofile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_userprofi_country_id_1ce0e19bda636668_fk_users_country_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_userprofile_countries_available
    ADD CONSTRAINT users_userprofi_country_id_1ce0e19bda636668_fk_users_country_id FOREIGN KEY (country_id) REFERENCES users_country(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_userprofi_country_id_2357c4275868743b_fk_users_country_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_userprofile
    ADD CONSTRAINT users_userprofi_country_id_2357c4275868743b_fk_users_country_id FOREIGN KEY (country_id) REFERENCES users_country(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_userprofi_section_id_64e2ddb82a93a7c8_fk_users_section_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_userprofile
    ADD CONSTRAINT users_userprofi_section_id_64e2ddb82a93a7c8_fk_users_section_id FOREIGN KEY (section_id) REFERENCES users_section(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_userprofile_office_id_7b50fef57c0f044_fk_users_office_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_userprofile
    ADD CONSTRAINT users_userprofile_office_id_7b50fef57c0f044_fk_users_office_id FOREIGN KEY (office_id) REFERENCES users_office(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_userprofile_user_id_5c10ccd727779b5d_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_userprofile
    ADD CONSTRAINT users_userprofile_user_id_5c10ccd727779b5d_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vision_visionsy_country_id_33d90378f535050f_fk_users_country_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vision_visionsynclog
    ADD CONSTRAINT vision_visionsy_country_id_33d90378f535050f_fk_users_country_id FOREIGN KEY (country_id) REFERENCES users_country(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: public; Type: ACL; Schema: -; Owner: chris
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM chris;
GRANT ALL ON SCHEMA public TO chris;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


--
-- PostgreSQL database dump
--

-- Dumped from database version 13.20
-- Dumped by pg_dump version 17.4

-- Started on 2025-04-11 18:07:44

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 7 (class 2615 OID 4971681)
-- Name: info; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA info;


--
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- *not* creating schema, since initdb creates it


--
-- TOC entry 2 (class 3079 OID 4969031)
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- TOC entry 3318 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


--
-- TOC entry 247 (class 1255 OID 4970049)
-- Name: slugify(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.slugify(value text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
BEGIN
  RETURN trim(BOTH '-' FROM regexp_replace(lower(public.unaccent(trim(value))), '[^a-z0-9\\-_\.]+', '-', 'gi'));
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 204 (class 1259 OID 4970057)
-- Name: model; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.model (
    created_date timestamp(6) without time zone,
    id bigint NOT NULL,
    last_modified_date timestamp(6) without time zone,
    steward_id bigint NOT NULL,
    category character varying(255),
    created_by character varying(255),
    description character varying(255),
    developer character varying(255),
    full_name character varying(255),
    keywords character varying(255),
    last_modified_by character varying(255),
    objective character varying(255),
    purpose character varying(255),
    repo character varying(255),
    short_name character varying(255) NOT NULL,
    subjects character varying(255),
    website character varying(255),
    CONSTRAINT model_category_check CHECK (((category)::text = ANY (ARRAY[('reference'::character varying)::text, ('message'::character varying)::text, ('other'::character varying)::text]))),
    CONSTRAINT model_objective_check CHECK (((objective)::text = ANY (ARRAY[('implementation'::character varying)::text, ('example'::character varying)::text, ('test'::character varying)::text, ('other'::character varying)::text])))
);


--
-- TOC entry 205 (class 1259 OID 4970065)
-- Name: namespace; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.namespace (
    is_deprecated boolean NOT NULL,
    created_date timestamp(6) without time zone,
    id bigint NOT NULL,
    last_modified_date timestamp(6) without time zone,
    next_id bigint,
    original_id bigint,
    prev_id bigint,
    version_id bigint NOT NULL,
    category character varying(255),
    created_by character varying(255),
    definition text,
    draft character varying(255),
    filename character varying(255),
    filepath character varying(255),
    generation character varying(255),
    last_modified_by character varying(255),
    name character varying(255),
    prefix character varying(255) NOT NULL,
    target character varying(255),
    uri character varying(255),
    CONSTRAINT namespace_category_check CHECK (((category)::text = ANY (ARRAY[('core'::character varying)::text, ('domain'::character varying)::text, ('code'::character varying)::text, ('adapter'::character varying)::text, ('auxiliary'::character varying)::text, ('external'::character varying)::text, ('utility'::character varying)::text, ('core_supplement'::character varying)::text, ('domain_update'::character varying)::text, ('extension'::character varying)::text, ('exchange'::character varying)::text, ('built_in'::character varying)::text, ('other'::character varying)::text]))),
    CONSTRAINT namespace_generation_check CHECK (((generation)::text = ANY (ARRAY[('build'::character varying)::text, ('static_file'::character varying)::text, ('none'::character varying)::text]))),
    CONSTRAINT namespace_target_check CHECK (((target)::text = ANY (ARRAY[('REF'::character varying)::text, ('EXT'::character varying)::text])))
);


--
-- TOC entry 206 (class 1259 OID 4970074)
-- Name: steward; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.steward (
    created_date timestamp(6) without time zone,
    id bigint NOT NULL,
    last_modified_date timestamp(6) without time zone,
    address character varying(255),
    category character varying(255),
    contact_name character varying(255),
    country character varying(255),
    created_by character varying(255),
    description text,
    email character varying(255),
    full_name character varying(255),
    last_modified_by character varying(255),
    phone character varying(255),
    short_name character varying(255) NOT NULL,
    subunit character varying(255),
    unit character varying(255),
    website character varying(255),
    CONSTRAINT steward_category_check CHECK (((category)::text = ANY (ARRAY[('Federal'::character varying)::text, ('State'::character varying)::text, ('Local'::character varying)::text, ('Tribal'::character varying)::text, ('Territorial'::character varying)::text, ('International'::character varying)::text, ('Industry'::character varying)::text, ('Nonprofit'::character varying)::text, ('SDO'::character varying)::text, ('Educational'::character varying)::text, ('Person'::character varying)::text, ('Other'::character varying)::text]))),
    CONSTRAINT steward_country_check CHECK (((country)::text = ANY (ARRAY[('USA'::character varying)::text, ('ABW'::character varying)::text, ('AFG'::character varying)::text, ('AGO'::character varying)::text, ('AIA'::character varying)::text, ('ALB'::character varying)::text, ('AND'::character varying)::text, ('ARE'::character varying)::text, ('ARG'::character varying)::text, ('ARM'::character varying)::text, ('ASM'::character varying)::text, ('ATA'::character varying)::text, ('ATF'::character varying)::text, ('ATG'::character varying)::text, ('AUS'::character varying)::text, ('AUT'::character varying)::text, ('AX1'::character varying)::text, ('AX2'::character varying)::text, ('AX3'::character varying)::text, ('AZE'::character varying)::text, ('BDI'::character varying)::text, ('BEL'::character varying)::text, ('BEN'::character varying)::text, ('BES'::character varying)::text, ('BFA'::character varying)::text, ('BGD'::character varying)::text, ('BGR'::character varying)::text, ('BHR'::character varying)::text, ('BHS'::character varying)::text, ('BIH'::character varying)::text, ('BLM'::character varying)::text, ('BLR'::character varying)::text, ('BLZ'::character varying)::text, ('BMU'::character varying)::text, ('BOL'::character varying)::text, ('BRA'::character varying)::text, ('BRB'::character varying)::text, ('BRN'::character varying)::text, ('BTN'::character varying)::text, ('BVT'::character varying)::text, ('BWA'::character varying)::text, ('CAF'::character varying)::text, ('CAN'::character varying)::text, ('CCK'::character varying)::text, ('CHE'::character varying)::text, ('CHL'::character varying)::text, ('CHN'::character varying)::text, ('CIV'::character varying)::text, ('CMR'::character varying)::text, ('COD'::character varying)::text, ('COG'::character varying)::text, ('COK'::character varying)::text, ('COL'::character varying)::text, ('COM'::character varying)::text, ('CPT'::character varying)::text, ('CPV'::character varying)::text, ('CRI'::character varying)::text, ('CUB'::character varying)::text, ('CUW'::character varying)::text, ('CXR'::character varying)::text, ('CYM'::character varying)::text, ('CYP'::character varying)::text, ('CZE'::character varying)::text, ('DEU'::character varying)::text, ('DGA'::character varying)::text, ('DJI'::character varying)::text, ('DMA'::character varying)::text, ('DNK'::character varying)::text, ('DOM'::character varying)::text, ('DZA'::character varying)::text, ('ECU'::character varying)::text, ('EGY'::character varying)::text, ('ERI'::character varying)::text, ('ESH'::character varying)::text, ('ESP'::character varying)::text, ('EST'::character varying)::text, ('ETH'::character varying)::text, ('FIN'::character varying)::text, ('FJI'::character varying)::text, ('FLK'::character varying)::text, ('FRA'::character varying)::text, ('FRO'::character varying)::text, ('FSM'::character varying)::text, ('GAB'::character varying)::text, ('GBR'::character varying)::text, ('GEO'::character varying)::text, ('GGY'::character varying)::text, ('GHA'::character varying)::text, ('GIB'::character varying)::text, ('GIN'::character varying)::text, ('GLP'::character varying)::text, ('GMB'::character varying)::text, ('GNB'::character varying)::text, ('GNQ'::character varying)::text, ('GRC'::character varying)::text, ('GRD'::character varying)::text, ('GRL'::character varying)::text, ('GTM'::character varying)::text, ('GUF'::character varying)::text, ('GUM'::character varying)::text, ('GUY'::character varying)::text, ('HKG'::character varying)::text, ('HMD'::character varying)::text, ('HND'::character varying)::text, ('HRV'::character varying)::text, ('HTI'::character varying)::text, ('HUN'::character varying)::text, ('IDN'::character varying)::text, ('IMN'::character varying)::text, ('IND'::character varying)::text, ('IOT'::character varying)::text, ('IRL'::character varying)::text, ('IRN'::character varying)::text, ('IRQ'::character varying)::text, ('ISL'::character varying)::text, ('ISR'::character varying)::text, ('ITA'::character varying)::text, ('JAM'::character varying)::text, ('JEY'::character varying)::text, ('JOR'::character varying)::text, ('JPN'::character varying)::text, ('KAZ'::character varying)::text, ('KEN'::character varying)::text, ('KGZ'::character varying)::text, ('KHM'::character varying)::text, ('KIR'::character varying)::text, ('KNA'::character varying)::text, ('KOR'::character varying)::text, ('KWT'::character varying)::text, ('LAO'::character varying)::text, ('LBN'::character varying)::text, ('LBR'::character varying)::text, ('LBY'::character varying)::text, ('LCA'::character varying)::text, ('LIE'::character varying)::text, ('LKA'::character varying)::text, ('LSO'::character varying)::text, ('LTU'::character varying)::text, ('LUX'::character varying)::text, ('LVA'::character varying)::text, ('MAC'::character varying)::text, ('MAF'::character varying)::text, ('MAR'::character varying)::text, ('MCO'::character varying)::text, ('MDA'::character varying)::text, ('MDG'::character varying)::text, ('MDV'::character varying)::text, ('MEX'::character varying)::text, ('MHL'::character varying)::text, ('MKD'::character varying)::text, ('MLI'::character varying)::text, ('MLT'::character varying)::text, ('MMR'::character varying)::text, ('MNE'::character varying)::text, ('MNG'::character varying)::text, ('MNP'::character varying)::text, ('MOZ'::character varying)::text, ('MRT'::character varying)::text, ('MSR'::character varying)::text, ('MTQ'::character varying)::text, ('MUS'::character varying)::text, ('MWI'::character varying)::text, ('MYS'::character varying)::text, ('MYT'::character varying)::text, ('NAM'::character varying)::text, ('NCL'::character varying)::text, ('NER'::character varying)::text, ('NFK'::character varying)::text, ('NGA'::character varying)::text, ('NIC'::character varying)::text, ('NIU'::character varying)::text, ('NLD'::character varying)::text, ('NOR'::character varying)::text, ('NPL'::character varying)::text, ('NRU'::character varying)::text, ('NZL'::character varying)::text, ('OMN'::character varying)::text, ('PAK'::character varying)::text, ('PAN'::character varying)::text, ('PCN'::character varying)::text, ('PER'::character varying)::text, ('PHL'::character varying)::text, ('PLW'::character varying)::text, ('PNG'::character varying)::text, ('POL'::character varying)::text, ('PRI'::character varying)::text, ('PRK'::character varying)::text, ('PRT'::character varying)::text, ('PRY'::character varying)::text, ('PYF'::character varying)::text, ('QAT'::character varying)::text, ('REU'::character varying)::text, ('ROU'::character varying)::text, ('RUS'::character varying)::text, ('RWA'::character varying)::text, ('SAU'::character varying)::text, ('SDN'::character varying)::text, ('SEN'::character varying)::text, ('SGP'::character varying)::text, ('SGS'::character varying)::text, ('SHN'::character varying)::text, ('SLB'::character varying)::text, ('SLE'::character varying)::text, ('SLV'::character varying)::text, ('SMR'::character varying)::text, ('SOM'::character varying)::text, ('SPM'::character varying)::text, ('SRB'::character varying)::text, ('SSD'::character varying)::text, ('STP'::character varying)::text, ('SUR'::character varying)::text, ('SVK'::character varying)::text, ('SVN'::character varying)::text, ('SWE'::character varying)::text, ('SWZ'::character varying)::text, ('SXM'::character varying)::text, ('SYC'::character varying)::text, ('SYR'::character varying)::text, ('TCA'::character varying)::text, ('TCD'::character varying)::text, ('TGO'::character varying)::text, ('THA'::character varying)::text, ('TJK'::character varying)::text, ('TKL'::character varying)::text, ('TKM'::character varying)::text, ('TLS'::character varying)::text, ('TON'::character varying)::text, ('TTO'::character varying)::text, ('TUN'::character varying)::text, ('TUR'::character varying)::text, ('TUV'::character varying)::text, ('TWN'::character varying)::text, ('TZA'::character varying)::text, ('UGA'::character varying)::text, ('UKR'::character varying)::text, ('URY'::character varying)::text, ('UZB'::character varying)::text, ('VAT'::character varying)::text, ('VCT'::character varying)::text, ('VEN'::character varying)::text, ('VGB'::character varying)::text, ('VIR'::character varying)::text, ('VNM'::character varying)::text, ('VUT'::character varying)::text, ('WLF'::character varying)::text, ('WSM'::character varying)::text, ('XAC'::character varying)::text, ('XAZ'::character varying)::text, ('XBI'::character varying)::text, ('XBK'::character varying)::text, ('XCR'::character varying)::text, ('XCS'::character varying)::text, ('XCY'::character varying)::text, ('XEU'::character varying)::text, ('XGL'::character varying)::text, ('XGZ'::character varying)::text, ('XHO'::character varying)::text, ('XJA'::character varying)::text, ('XJM'::character varying)::text, ('XJN'::character varying)::text, ('XJV'::character varying)::text, ('XKM'::character varying)::text, ('XKN'::character varying)::text, ('XKR'::character varying)::text, ('XKS'::character varying)::text, ('XMW'::character varying)::text, ('XNV'::character varying)::text, ('XPL'::character varying)::text, ('XPR'::character varying)::text, ('XQZ'::character varying)::text, ('XSP'::character varying)::text, ('XSV'::character varying)::text, ('XTR'::character varying)::text, ('XWB'::character varying)::text, ('XWK'::character varying)::text, ('XXD'::character varying)::text, ('YEM'::character varying)::text, ('ZAF'::character varying)::text, ('ZMB'::character varying)::text, ('ZWE'::character varying)::text])))
);


--
-- TOC entry 203 (class 1259 OID 4970050)
-- Name: version; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.version (
    is_current boolean NOT NULL,
    is_published boolean NOT NULL,
    created_date timestamp(6) without time zone,
    id bigint NOT NULL,
    last_modified_date timestamp(6) without time zone,
    model_id bigint NOT NULL,
    next_id bigint,
    niem_version_id bigint,
    prev_id bigint,
    category character varying(255),
    conformance_targets character varying(255),
    created_by character varying(255),
    draft character varying(255),
    exchange_partners character varying(255),
    exchange_pattern character varying(255),
    last_modified_by character varying(255),
    revised character varying(255),
    status character varying(255),
    uri character varying(255),
    version_number character varying(255) NOT NULL,
    CONSTRAINT version_category_check CHECK (((category)::text = ANY (ARRAY[('major'::character varying)::text, ('minor'::character varying)::text, ('patch'::character varying)::text, ('core_supplement'::character varying)::text, ('domain_update'::character varying)::text, ('other'::character varying)::text])))
);


--
-- TOC entry 231 (class 1259 OID 4971682)
-- Name: namespace_extras; Type: VIEW; Schema: info; Owner: -
--

CREATE VIEW info.namespace_extras AS
 SELECT model.steward_id,
    version.model_id,
    namespace.version_id,
    namespace.id,
    public.slugify((steward.short_name)::text) AS steward_key,
    public.slugify((model.short_name)::text) AS model_key,
    version.version_number,
    ((((((public.slugify((steward.short_name)::text) || '/'::text) || public.slugify((model.short_name)::text)) || '/'::text) || (version.version_number)::text) || '/'::text) || (namespace.prefix)::text) AS id_string,
    namespace.category,
    namespace.prefix,
    namespace.name,
    namespace.draft,
    namespace.next_id,
    namespace.prev_id,
    namespace.filename,
    namespace.filepath,
    namespace.generation,
    namespace.target,
    namespace.uri,
    namespace.original_id,
    namespace.definition
   FROM (((public.namespace
     JOIN public.version ON ((namespace.version_id = version.id)))
     JOIN public.model ON ((version.model_id = model.id)))
     JOIN public.steward ON ((model.steward_id = steward.id)))
  ORDER BY namespace.prefix;


--
-- TOC entry 207 (class 1259 OID 4970083)
-- Name: type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.type (
    is_deprecated boolean NOT NULL,
    base_id bigint,
    created_date timestamp(6) without time zone,
    id bigint NOT NULL,
    last_modified_date timestamp(6) without time zone,
    namespace_id bigint NOT NULL,
    next_id bigint,
    original_id bigint,
    prev_id bigint,
    category character varying(255),
    created_by character varying(255),
    definition text,
    derivation character varying(255),
    last_modified_by character varying(255),
    name character varying(255),
    pattern character varying(255),
    CONSTRAINT type_category_check CHECK (((category)::text = ANY (ARRAY[('complex_object'::character varying)::text, ('complex_value'::character varying)::text, ('simple_value'::character varying)::text]))),
    CONSTRAINT type_derivation_check CHECK (((derivation)::text = ANY (ARRAY[('extension'::character varying)::text, ('restriction'::character varying)::text]))),
    CONSTRAINT type_pattern_check CHECK (((pattern)::text = ANY (ARRAY[('object'::character varying)::text, ('adapter'::character varying)::text, ('association'::character varying)::text, ('augmentation'::character varying)::text, ('metadata'::character varying)::text, ('complex_value'::character varying)::text, ('simple_value'::character varying)::text, ('simple_list'::character varying)::text, ('simple_union'::character varying)::text])))
);


--
-- TOC entry 233 (class 1259 OID 4971692)
-- Name: type_extras; Type: VIEW; Schema: info; Owner: -
--

CREATE VIEW info.type_extras AS
 SELECT ns.steward_id,
    ns.model_id,
    ns.version_id,
    ns.version_number,
    ns.category AS namespace_category,
    ns.id AS namespace_id,
    ns.prefix,
    t.id,
    t.name,
    t.category,
    t.pattern,
    t.base_id,
    t.prev_id,
    t.next_id,
    t.derivation,
    (((ns.prefix)::text || ':'::text) || (t.name)::text) AS qname,
    ((ns.id_string || ':'::text) || (t.name)::text) AS id_string,
    t.definition
   FROM (public.type t
     JOIN info.namespace_extras ns ON ((t.namespace_id = ns.id)))
  ORDER BY ns.id_string, t.name;


--
-- TOC entry 208 (class 1259 OID 4970092)
-- Name: facet; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.facet (
    is_deprecated boolean NOT NULL,
    created_date timestamp(6) without time zone,
    id bigint NOT NULL,
    last_modified_date timestamp(6) without time zone,
    next_id bigint,
    original_id bigint,
    prev_id bigint,
    type_id bigint,
    category character varying(255),
    created_by character varying(255),
    definition character varying(255),
    last_modified_by character varying(255),
    value character varying(255),
    CONSTRAINT facet_category_check CHECK (((category)::text = ANY (ARRAY[('enumeration'::character varying)::text, ('pattern'::character varying)::text, ('length'::character varying)::text, ('minLength'::character varying)::text, ('maxLength'::character varying)::text, ('minExclusive'::character varying)::text, ('maxExclusive'::character varying)::text, ('minInclusive'::character varying)::text, ('maxInclusive'::character varying)::text, ('fractionDigits'::character varying)::text, ('totalDigits'::character varying)::text, ('whiteSpace'::character varying)::text])))
);


--
-- TOC entry 237 (class 1259 OID 4971712)
-- Name: facet_rels; Type: VIEW; Schema: info; Owner: -
--

CREATE VIEW info.facet_rels AS
 SELECT t.steward_id,
    t.model_id,
    t.version_id,
    t.version_number,
    facet.id,
    facet.type_id,
    t.qname AS type_qname,
    facet.category,
    facet.value,
    facet.definition,
    t.namespace_id AS type_namespace_id,
    t.namespace_category AS type_namespace_category,
    t.prefix AS type_prefix,
    facet.prev_id,
    facet.next_id,
    ((((t.id_string || '/'::text) || (facet.category)::text) || '/'::text) || (facet.value)::text) AS id_string
   FROM (public.facet
     JOIN info.type_extras t ON ((facet.type_id = t.id)))
  ORDER BY t.id_string, facet.category, facet.value;


--
-- TOC entry 242 (class 1259 OID 4971737)
-- Name: facet_migrations; Type: VIEW; Schema: info; Owner: -
--

CREATE VIEW info.facet_migrations AS
 SELECT tbl.version_id,
    tbl.version_number,
    tbl.type_namespace_category,
    tbl.prev_id,
    prev_tbl.id_string AS prev_id_string,
    tbl.id,
    tbl.id_string,
    tbl.next_id,
    next_tbl.id_string AS next_id_string
   FROM ((info.facet_rels tbl
     LEFT JOIN info.facet_rels prev_tbl ON ((tbl.prev_id = prev_tbl.id)))
     LEFT JOIN info.facet_rels next_tbl ON ((tbl.next_id = next_tbl.id)))
  ORDER BY tbl.id_string;


--
-- TOC entry 238 (class 1259 OID 4971717)
-- Name: namespace_migrations; Type: VIEW; Schema: info; Owner: -
--

CREATE VIEW info.namespace_migrations AS
 SELECT tbl.version_id,
    tbl.version_number,
    tbl.id,
    tbl.id_string,
    tbl.category,
    tbl.prefix,
    tbl.prev_id,
    prev_tbl.id_string AS prev_id_string,
    tbl.next_id,
    next_tbl.id_string AS next_id_string,
    tbl.uri
   FROM ((info.namespace_extras tbl
     LEFT JOIN info.namespace_extras prev_tbl ON ((tbl.prev_id = prev_tbl.id)))
     LEFT JOIN info.namespace_extras next_tbl ON ((tbl.next_id = next_tbl.id)))
  ORDER BY tbl.prefix, tbl.version_number;


--
-- TOC entry 209 (class 1259 OID 4970099)
-- Name: property; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.property (
    is_deprecated boolean NOT NULL,
    created_date timestamp(6) without time zone,
    group_id bigint,
    id bigint NOT NULL,
    last_modified_date timestamp(6) without time zone,
    namespace_id bigint NOT NULL,
    next_id bigint,
    original_id bigint,
    prev_id bigint,
    type_id bigint,
    alias character varying(255),
    category character varying(255),
    created_by character varying(255),
    definition text,
    example_content text,
    keywords character varying(255),
    last_modified_by character varying(255),
    name character varying(255),
    usage_info text,
    CONSTRAINT property_category_check CHECK (((category)::text = ANY (ARRAY[('element'::character varying)::text, ('abstract_element'::character varying)::text, ('attribute'::character varying)::text])))
);


--
-- TOC entry 232 (class 1259 OID 4971687)
-- Name: property_extras; Type: VIEW; Schema: info; Owner: -
--

CREATE VIEW info.property_extras AS
 SELECT ns.steward_id,
    ns.model_id,
    ns.version_id,
    ns.version_number,
    ns.category AS namespace_category,
    ns.id AS namespace_id,
    ns.prefix,
    property.id,
    property.name,
    property.category,
    property.group_id,
    property.type_id,
    property.prev_id,
    property.next_id,
    property.alias,
    property.definition,
    property.keywords,
    property.example_content,
    property.usage_info,
    (((ns.prefix)::text || ':'::text) || (property.name)::text) AS qname,
    ((ns.id_string || ':'::text) || (property.name)::text) AS id_string
   FROM (public.property
     JOIN info.namespace_extras ns ON ((property.namespace_id = ns.id)))
  ORDER BY ns.id_string, property.name;


--
-- TOC entry 239 (class 1259 OID 4971722)
-- Name: property_migrations; Type: VIEW; Schema: info; Owner: -
--

CREATE VIEW info.property_migrations AS
 SELECT tbl.version_id,
    tbl.version_number,
    tbl.namespace_category,
    tbl.prev_id,
    prev_tbl.id_string AS prev_id_string,
    tbl.id,
    tbl.id_string,
    tbl.next_id,
    next_tbl.id_string AS next_id_string
   FROM ((info.property_extras tbl
     LEFT JOIN info.property_extras prev_tbl ON ((tbl.prev_id = prev_tbl.id)))
     LEFT JOIN info.property_extras next_tbl ON ((tbl.next_id = next_tbl.id)))
  ORDER BY tbl.id_string;


--
-- TOC entry 234 (class 1259 OID 4971697)
-- Name: property_rels; Type: VIEW; Schema: info; Owner: -
--

CREATE VIEW info.property_rels AS
 SELECT tbl.version_number,
    tbl.namespace_category,
    tbl.id,
    tbl.id_string,
    tbl.type_id,
    type_tbl.id_string AS type_id_string,
    tbl.group_id,
    group_tbl.id_string AS group_id_string,
    tbl.category,
    tbl.steward_id,
    tbl.model_id,
    tbl.version_id,
    tbl.prefix,
    tbl.name,
    type_tbl.category AS type_category,
    type_tbl.prefix AS type_prefix,
    type_tbl.name AS type_name,
    group_tbl.category AS group_category,
    group_tbl.prefix AS group_prefix,
    group_tbl.name AS group_name,
    tbl.prev_id,
    tbl.next_id,
    tbl.qname,
    type_tbl.qname AS type_qname,
    group_tbl.qname AS group_qname,
    tbl.definition,
    tbl.alias,
    tbl.keywords,
    tbl.example_content,
    tbl.usage_info
   FROM ((info.property_extras tbl
     LEFT JOIN info.property_extras group_tbl ON ((tbl.group_id = group_tbl.id)))
     LEFT JOIN info.type_extras type_tbl ON ((tbl.type_id = type_tbl.id)))
  ORDER BY tbl.id_string;


--
-- TOC entry 210 (class 1259 OID 4970106)
-- Name: subproperty; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.subproperty (
    is_deprecated boolean NOT NULL,
    sequence integer NOT NULL,
    created_date timestamp(6) without time zone,
    id bigint NOT NULL,
    last_modified_date timestamp(6) without time zone,
    next_id bigint,
    original_id bigint,
    prev_id bigint,
    property_id bigint,
    type_id bigint,
    created_by character varying(255),
    definition character varying(255),
    last_modified_by character varying(255),
    max character varying(255),
    min character varying(255)
);


--
-- TOC entry 236 (class 1259 OID 4971707)
-- Name: subproperty_rels; Type: VIEW; Schema: info; Owner: -
--

CREATE VIEW info.subproperty_rels AS
 SELECT t.steward_id,
    t.model_id,
    t.version_id,
    t.version_number,
    subproperty.id,
    t.qname AS type_qname,
    subproperty.sequence,
    p.qname AS property_qname,
    subproperty.definition,
    t.namespace_id AS type_namespace_id,
    t.namespace_category AS type_namespace_category,
    t.prefix AS type_prefix,
    subproperty.type_id,
    t.name AS type_name,
    t.category AS type_category,
    t.pattern AS type_pattern,
    t.base_id AS type_base_id,
    p.namespace_id AS property_namespace_id,
    p.namespace_category AS property_namespace_category,
    p.prefix AS property_prefix,
    subproperty.property_id,
    p.name AS property_name,
    p.category AS property_category,
    subproperty.prev_id,
    subproperty.next_id,
    ((t.id_string || '/'::text) || p.qname) AS id_string
   FROM ((public.subproperty
     JOIN info.type_extras t ON ((subproperty.type_id = t.id)))
     JOIN info.property_extras p ON ((subproperty.property_id = p.id)))
  ORDER BY t.id_string, subproperty.sequence;


--
-- TOC entry 241 (class 1259 OID 4971732)
-- Name: subproperty_migrations; Type: VIEW; Schema: info; Owner: -
--

CREATE VIEW info.subproperty_migrations AS
 SELECT tbl.version_id,
    tbl.version_number,
    tbl.type_namespace_category,
    tbl.prev_id,
    prev_tbl.id_string AS prev_id_string,
    tbl.id,
    tbl.id_string,
    tbl.next_id,
    next_tbl.id_string AS next_id_string
   FROM ((info.subproperty_rels tbl
     LEFT JOIN info.subproperty_rels prev_tbl ON ((tbl.prev_id = prev_tbl.id)))
     LEFT JOIN info.subproperty_rels next_tbl ON ((tbl.next_id = next_tbl.id)))
  ORDER BY tbl.id_string;


--
-- TOC entry 240 (class 1259 OID 4971727)
-- Name: type_migrations; Type: VIEW; Schema: info; Owner: -
--

CREATE VIEW info.type_migrations AS
 SELECT tbl.version_id,
    tbl.version_number,
    tbl.namespace_category,
    tbl.prev_id,
    prev_tbl.id_string AS prev_id_string,
    tbl.id,
    tbl.id_string,
    tbl.next_id,
    next_tbl.id_string AS next_id_string
   FROM ((info.type_extras tbl
     LEFT JOIN info.type_extras prev_tbl ON ((tbl.prev_id = prev_tbl.id)))
     LEFT JOIN info.type_extras next_tbl ON ((tbl.next_id = next_tbl.id)))
  ORDER BY tbl.id_string;


--
-- TOC entry 235 (class 1259 OID 4971702)
-- Name: type_rels; Type: VIEW; Schema: info; Owner: -
--

CREATE VIEW info.type_rels AS
 SELECT tbl.version_number,
    tbl.namespace_category,
    tbl.id,
    tbl.id_string,
    tbl.base_id,
    base_tbl.id_string AS type_id_string,
    tbl.category,
    tbl.steward_id,
    tbl.model_id,
    tbl.version_id,
    tbl.prefix,
    tbl.name,
    tbl.pattern,
    tbl.derivation,
    base_tbl.category AS type_category,
    base_tbl.prefix AS type_prefix,
    base_tbl.name AS type_name,
    tbl.prev_id,
    tbl.next_id,
    tbl.qname,
    base_tbl.qname AS base_qname,
    tbl.definition
   FROM (info.type_extras tbl
     LEFT JOIN info.type_extras base_tbl ON ((tbl.base_id = base_tbl.id)))
  ORDER BY tbl.id_string;


--
-- TOC entry 211 (class 1259 OID 4970112)
-- Name: facet_aud; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.facet_aud (
    is_deprecated boolean,
    rev integer NOT NULL,
    revtype smallint,
    created_date timestamp(6) without time zone,
    id bigint NOT NULL,
    last_modified_date timestamp(6) without time zone,
    next_id bigint,
    original_id bigint,
    prev_id bigint,
    type_id bigint,
    category character varying(255),
    created_by character varying(255),
    definition character varying(255),
    last_modified_by character varying(255),
    value character varying(255),
    CONSTRAINT facet_aud_category_check CHECK (((category)::text = ANY (ARRAY[('enumeration'::character varying)::text, ('pattern'::character varying)::text, ('length'::character varying)::text, ('minLength'::character varying)::text, ('maxLength'::character varying)::text, ('minExclusive'::character varying)::text, ('maxExclusive'::character varying)::text, ('minInclusive'::character varying)::text, ('maxInclusive'::character varying)::text, ('fractionDigits'::character varying)::text, ('totalDigits'::character varying)::text, ('whiteSpace'::character varying)::text])))
);


--
-- TOC entry 212 (class 1259 OID 4970119)
-- Name: facet_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.facet_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3319 (class 0 OID 0)
-- Dependencies: 212
-- Name: facet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.facet_id_seq OWNED BY public.facet.id;


--
-- TOC entry 213 (class 1259 OID 4970121)
-- Name: model_aud; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.model_aud (
    rev integer NOT NULL,
    revtype smallint,
    created_date timestamp(6) without time zone,
    id bigint NOT NULL,
    last_modified_date timestamp(6) without time zone,
    steward_id bigint,
    category character varying(255),
    created_by character varying(255),
    description character varying(255),
    developer character varying(255),
    full_name character varying(255),
    keywords character varying(255),
    last_modified_by character varying(255),
    objective character varying(255),
    purpose character varying(255),
    repo character varying(255),
    short_name character varying(255),
    subjects character varying(255),
    website character varying(255),
    CONSTRAINT model_aud_category_check CHECK (((category)::text = ANY (ARRAY[('reference'::character varying)::text, ('message'::character varying)::text, ('other'::character varying)::text]))),
    CONSTRAINT model_aud_objective_check CHECK (((objective)::text = ANY (ARRAY[('implementation'::character varying)::text, ('example'::character varying)::text, ('test'::character varying)::text, ('other'::character varying)::text])))
);


--
-- TOC entry 214 (class 1259 OID 4970129)
-- Name: model_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.model_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3320 (class 0 OID 0)
-- Dependencies: 214
-- Name: model_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.model_id_seq OWNED BY public.model.id;


--
-- TOC entry 215 (class 1259 OID 4970131)
-- Name: namespace_aud; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.namespace_aud (
    is_deprecated boolean,
    rev integer NOT NULL,
    revtype smallint,
    created_date timestamp(6) without time zone,
    id bigint NOT NULL,
    last_modified_date timestamp(6) without time zone,
    next_id bigint,
    original_id bigint,
    prev_id bigint,
    version_id bigint,
    category character varying(255),
    created_by character varying(255),
    definition text,
    draft character varying(255),
    filename character varying(255),
    filepath character varying(255),
    generation character varying(255),
    last_modified_by character varying(255),
    name character varying(255),
    prefix character varying(255),
    target character varying(255),
    uri character varying(255),
    CONSTRAINT namespace_aud_category_check CHECK (((category)::text = ANY (ARRAY[('core'::character varying)::text, ('domain'::character varying)::text, ('code'::character varying)::text, ('adapter'::character varying)::text, ('auxiliary'::character varying)::text, ('external'::character varying)::text, ('utility'::character varying)::text, ('core_supplement'::character varying)::text, ('domain_update'::character varying)::text, ('extension'::character varying)::text, ('exchange'::character varying)::text, ('built_in'::character varying)::text, ('other'::character varying)::text]))),
    CONSTRAINT namespace_aud_generation_check CHECK (((generation)::text = ANY (ARRAY[('build'::character varying)::text, ('static_file'::character varying)::text, ('none'::character varying)::text]))),
    CONSTRAINT namespace_aud_target_check CHECK (((target)::text = ANY (ARRAY[('REF'::character varying)::text, ('EXT'::character varying)::text])))
);


--
-- TOC entry 216 (class 1259 OID 4970140)
-- Name: namespace_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.namespace_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3321 (class 0 OID 0)
-- Dependencies: 216
-- Name: namespace_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.namespace_id_seq OWNED BY public.namespace.id;


--
-- TOC entry 217 (class 1259 OID 4970142)
-- Name: property_aud; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.property_aud (
    is_deprecated boolean,
    rev integer NOT NULL,
    revtype smallint,
    created_date timestamp(6) without time zone,
    group_id bigint,
    id bigint NOT NULL,
    last_modified_date timestamp(6) without time zone,
    namespace_id bigint,
    next_id bigint,
    original_id bigint,
    prev_id bigint,
    type_id bigint,
    alias character varying(255),
    category character varying(255),
    created_by character varying(255),
    definition text,
    example_content text,
    keywords character varying(255),
    last_modified_by character varying(255),
    name character varying(255),
    usage_info text,
    CONSTRAINT property_aud_category_check CHECK (((category)::text = ANY (ARRAY[('element'::character varying)::text, ('abstract_element'::character varying)::text, ('attribute'::character varying)::text])))
);


--
-- TOC entry 218 (class 1259 OID 4970149)
-- Name: property_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.property_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3322 (class 0 OID 0)
-- Dependencies: 218
-- Name: property_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.property_id_seq OWNED BY public.property.id;


--
-- TOC entry 219 (class 1259 OID 4970151)
-- Name: revinfo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.revinfo (
    rev integer NOT NULL,
    revtstmp bigint
);


--
-- TOC entry 220 (class 1259 OID 4970154)
-- Name: revinfo_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.revinfo_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 221 (class 1259 OID 4970156)
-- Name: steward_aud; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.steward_aud (
    rev integer NOT NULL,
    revtype smallint,
    created_date timestamp(6) without time zone,
    id bigint NOT NULL,
    last_modified_date timestamp(6) without time zone,
    address character varying(255),
    category character varying(255),
    contact_name character varying(255),
    country character varying(255),
    created_by character varying(255),
    description text,
    email character varying(255),
    full_name character varying(255),
    last_modified_by character varying(255),
    phone character varying(255),
    short_name character varying(255),
    subunit character varying(255),
    unit character varying(255),
    website character varying(255),
    CONSTRAINT steward_aud_category_check CHECK (((category)::text = ANY (ARRAY[('Federal'::character varying)::text, ('State'::character varying)::text, ('Local'::character varying)::text, ('Tribal'::character varying)::text, ('Territorial'::character varying)::text, ('International'::character varying)::text, ('Industry'::character varying)::text, ('Nonprofit'::character varying)::text, ('SDO'::character varying)::text, ('Educational'::character varying)::text, ('Person'::character varying)::text, ('Other'::character varying)::text]))),
    CONSTRAINT steward_aud_country_check CHECK (((country)::text = ANY (ARRAY[('USA'::character varying)::text, ('ABW'::character varying)::text, ('AFG'::character varying)::text, ('AGO'::character varying)::text, ('AIA'::character varying)::text, ('ALB'::character varying)::text, ('AND'::character varying)::text, ('ARE'::character varying)::text, ('ARG'::character varying)::text, ('ARM'::character varying)::text, ('ASM'::character varying)::text, ('ATA'::character varying)::text, ('ATF'::character varying)::text, ('ATG'::character varying)::text, ('AUS'::character varying)::text, ('AUT'::character varying)::text, ('AX1'::character varying)::text, ('AX2'::character varying)::text, ('AX3'::character varying)::text, ('AZE'::character varying)::text, ('BDI'::character varying)::text, ('BEL'::character varying)::text, ('BEN'::character varying)::text, ('BES'::character varying)::text, ('BFA'::character varying)::text, ('BGD'::character varying)::text, ('BGR'::character varying)::text, ('BHR'::character varying)::text, ('BHS'::character varying)::text, ('BIH'::character varying)::text, ('BLM'::character varying)::text, ('BLR'::character varying)::text, ('BLZ'::character varying)::text, ('BMU'::character varying)::text, ('BOL'::character varying)::text, ('BRA'::character varying)::text, ('BRB'::character varying)::text, ('BRN'::character varying)::text, ('BTN'::character varying)::text, ('BVT'::character varying)::text, ('BWA'::character varying)::text, ('CAF'::character varying)::text, ('CAN'::character varying)::text, ('CCK'::character varying)::text, ('CHE'::character varying)::text, ('CHL'::character varying)::text, ('CHN'::character varying)::text, ('CIV'::character varying)::text, ('CMR'::character varying)::text, ('COD'::character varying)::text, ('COG'::character varying)::text, ('COK'::character varying)::text, ('COL'::character varying)::text, ('COM'::character varying)::text, ('CPT'::character varying)::text, ('CPV'::character varying)::text, ('CRI'::character varying)::text, ('CUB'::character varying)::text, ('CUW'::character varying)::text, ('CXR'::character varying)::text, ('CYM'::character varying)::text, ('CYP'::character varying)::text, ('CZE'::character varying)::text, ('DEU'::character varying)::text, ('DGA'::character varying)::text, ('DJI'::character varying)::text, ('DMA'::character varying)::text, ('DNK'::character varying)::text, ('DOM'::character varying)::text, ('DZA'::character varying)::text, ('ECU'::character varying)::text, ('EGY'::character varying)::text, ('ERI'::character varying)::text, ('ESH'::character varying)::text, ('ESP'::character varying)::text, ('EST'::character varying)::text, ('ETH'::character varying)::text, ('FIN'::character varying)::text, ('FJI'::character varying)::text, ('FLK'::character varying)::text, ('FRA'::character varying)::text, ('FRO'::character varying)::text, ('FSM'::character varying)::text, ('GAB'::character varying)::text, ('GBR'::character varying)::text, ('GEO'::character varying)::text, ('GGY'::character varying)::text, ('GHA'::character varying)::text, ('GIB'::character varying)::text, ('GIN'::character varying)::text, ('GLP'::character varying)::text, ('GMB'::character varying)::text, ('GNB'::character varying)::text, ('GNQ'::character varying)::text, ('GRC'::character varying)::text, ('GRD'::character varying)::text, ('GRL'::character varying)::text, ('GTM'::character varying)::text, ('GUF'::character varying)::text, ('GUM'::character varying)::text, ('GUY'::character varying)::text, ('HKG'::character varying)::text, ('HMD'::character varying)::text, ('HND'::character varying)::text, ('HRV'::character varying)::text, ('HTI'::character varying)::text, ('HUN'::character varying)::text, ('IDN'::character varying)::text, ('IMN'::character varying)::text, ('IND'::character varying)::text, ('IOT'::character varying)::text, ('IRL'::character varying)::text, ('IRN'::character varying)::text, ('IRQ'::character varying)::text, ('ISL'::character varying)::text, ('ISR'::character varying)::text, ('ITA'::character varying)::text, ('JAM'::character varying)::text, ('JEY'::character varying)::text, ('JOR'::character varying)::text, ('JPN'::character varying)::text, ('KAZ'::character varying)::text, ('KEN'::character varying)::text, ('KGZ'::character varying)::text, ('KHM'::character varying)::text, ('KIR'::character varying)::text, ('KNA'::character varying)::text, ('KOR'::character varying)::text, ('KWT'::character varying)::text, ('LAO'::character varying)::text, ('LBN'::character varying)::text, ('LBR'::character varying)::text, ('LBY'::character varying)::text, ('LCA'::character varying)::text, ('LIE'::character varying)::text, ('LKA'::character varying)::text, ('LSO'::character varying)::text, ('LTU'::character varying)::text, ('LUX'::character varying)::text, ('LVA'::character varying)::text, ('MAC'::character varying)::text, ('MAF'::character varying)::text, ('MAR'::character varying)::text, ('MCO'::character varying)::text, ('MDA'::character varying)::text, ('MDG'::character varying)::text, ('MDV'::character varying)::text, ('MEX'::character varying)::text, ('MHL'::character varying)::text, ('MKD'::character varying)::text, ('MLI'::character varying)::text, ('MLT'::character varying)::text, ('MMR'::character varying)::text, ('MNE'::character varying)::text, ('MNG'::character varying)::text, ('MNP'::character varying)::text, ('MOZ'::character varying)::text, ('MRT'::character varying)::text, ('MSR'::character varying)::text, ('MTQ'::character varying)::text, ('MUS'::character varying)::text, ('MWI'::character varying)::text, ('MYS'::character varying)::text, ('MYT'::character varying)::text, ('NAM'::character varying)::text, ('NCL'::character varying)::text, ('NER'::character varying)::text, ('NFK'::character varying)::text, ('NGA'::character varying)::text, ('NIC'::character varying)::text, ('NIU'::character varying)::text, ('NLD'::character varying)::text, ('NOR'::character varying)::text, ('NPL'::character varying)::text, ('NRU'::character varying)::text, ('NZL'::character varying)::text, ('OMN'::character varying)::text, ('PAK'::character varying)::text, ('PAN'::character varying)::text, ('PCN'::character varying)::text, ('PER'::character varying)::text, ('PHL'::character varying)::text, ('PLW'::character varying)::text, ('PNG'::character varying)::text, ('POL'::character varying)::text, ('PRI'::character varying)::text, ('PRK'::character varying)::text, ('PRT'::character varying)::text, ('PRY'::character varying)::text, ('PYF'::character varying)::text, ('QAT'::character varying)::text, ('REU'::character varying)::text, ('ROU'::character varying)::text, ('RUS'::character varying)::text, ('RWA'::character varying)::text, ('SAU'::character varying)::text, ('SDN'::character varying)::text, ('SEN'::character varying)::text, ('SGP'::character varying)::text, ('SGS'::character varying)::text, ('SHN'::character varying)::text, ('SLB'::character varying)::text, ('SLE'::character varying)::text, ('SLV'::character varying)::text, ('SMR'::character varying)::text, ('SOM'::character varying)::text, ('SPM'::character varying)::text, ('SRB'::character varying)::text, ('SSD'::character varying)::text, ('STP'::character varying)::text, ('SUR'::character varying)::text, ('SVK'::character varying)::text, ('SVN'::character varying)::text, ('SWE'::character varying)::text, ('SWZ'::character varying)::text, ('SXM'::character varying)::text, ('SYC'::character varying)::text, ('SYR'::character varying)::text, ('TCA'::character varying)::text, ('TCD'::character varying)::text, ('TGO'::character varying)::text, ('THA'::character varying)::text, ('TJK'::character varying)::text, ('TKL'::character varying)::text, ('TKM'::character varying)::text, ('TLS'::character varying)::text, ('TON'::character varying)::text, ('TTO'::character varying)::text, ('TUN'::character varying)::text, ('TUR'::character varying)::text, ('TUV'::character varying)::text, ('TWN'::character varying)::text, ('TZA'::character varying)::text, ('UGA'::character varying)::text, ('UKR'::character varying)::text, ('URY'::character varying)::text, ('UZB'::character varying)::text, ('VAT'::character varying)::text, ('VCT'::character varying)::text, ('VEN'::character varying)::text, ('VGB'::character varying)::text, ('VIR'::character varying)::text, ('VNM'::character varying)::text, ('VUT'::character varying)::text, ('WLF'::character varying)::text, ('WSM'::character varying)::text, ('XAC'::character varying)::text, ('XAZ'::character varying)::text, ('XBI'::character varying)::text, ('XBK'::character varying)::text, ('XCR'::character varying)::text, ('XCS'::character varying)::text, ('XCY'::character varying)::text, ('XEU'::character varying)::text, ('XGL'::character varying)::text, ('XGZ'::character varying)::text, ('XHO'::character varying)::text, ('XJA'::character varying)::text, ('XJM'::character varying)::text, ('XJN'::character varying)::text, ('XJV'::character varying)::text, ('XKM'::character varying)::text, ('XKN'::character varying)::text, ('XKR'::character varying)::text, ('XKS'::character varying)::text, ('XMW'::character varying)::text, ('XNV'::character varying)::text, ('XPL'::character varying)::text, ('XPR'::character varying)::text, ('XQZ'::character varying)::text, ('XSP'::character varying)::text, ('XSV'::character varying)::text, ('XTR'::character varying)::text, ('XWB'::character varying)::text, ('XWK'::character varying)::text, ('XXD'::character varying)::text, ('YEM'::character varying)::text, ('ZAF'::character varying)::text, ('ZMB'::character varying)::text, ('ZWE'::character varying)::text])))
);


--
-- TOC entry 222 (class 1259 OID 4970165)
-- Name: steward_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.steward_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3323 (class 0 OID 0)
-- Dependencies: 222
-- Name: steward_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.steward_id_seq OWNED BY public.steward.id;


--
-- TOC entry 223 (class 1259 OID 4970167)
-- Name: subproperty_aud; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.subproperty_aud (
    is_deprecated boolean,
    rev integer NOT NULL,
    revtype smallint,
    sequence integer,
    created_date timestamp(6) without time zone,
    id bigint NOT NULL,
    last_modified_date timestamp(6) without time zone,
    next_id bigint,
    original_id bigint,
    prev_id bigint,
    property_id bigint,
    type_id bigint,
    created_by character varying(255),
    definition character varying(255),
    last_modified_by character varying(255),
    max character varying(255),
    min character varying(255)
);


--
-- TOC entry 224 (class 1259 OID 4970173)
-- Name: subproperty_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.subproperty_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3324 (class 0 OID 0)
-- Dependencies: 224
-- Name: subproperty_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.subproperty_id_seq OWNED BY public.subproperty.id;


--
-- TOC entry 202 (class 1259 OID 4903769)
-- Name: testing; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.testing (
    is_deprecated boolean NOT NULL,
    created_date timestamp(6) without time zone,
    id bigint NOT NULL,
    last_modified_date timestamp(6) without time zone,
    next_id bigint,
    original_id bigint,
    prev_id bigint,
    type_id bigint,
    category character varying(255),
    created_by character varying(255),
    definition character varying(255),
    last_modified_by character varying(255),
    value character varying(255),
    CONSTRAINT facet_category_check CHECK (((category)::text = ANY (ARRAY[('enumeration'::character varying)::text, ('pattern'::character varying)::text, ('length'::character varying)::text, ('minLength'::character varying)::text, ('maxLength'::character varying)::text, ('minExclusive'::character varying)::text, ('maxExclusive'::character varying)::text, ('minInclusive'::character varying)::text, ('maxInclusive'::character varying)::text, ('fractionDigits'::character varying)::text, ('totalDigits'::character varying)::text, ('whiteSpace'::character varying)::text])))
);


--
-- TOC entry 225 (class 1259 OID 4970175)
-- Name: type_aud; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.type_aud (
    is_deprecated boolean,
    rev integer NOT NULL,
    revtype smallint,
    base_id bigint,
    created_date timestamp(6) without time zone,
    id bigint NOT NULL,
    last_modified_date timestamp(6) without time zone,
    namespace_id bigint,
    next_id bigint,
    original_id bigint,
    prev_id bigint,
    category character varying(255),
    created_by character varying(255),
    definition text,
    derivation character varying(255),
    last_modified_by character varying(255),
    name character varying(255),
    pattern character varying(255),
    CONSTRAINT type_aud_category_check CHECK (((category)::text = ANY (ARRAY[('complex_object'::character varying)::text, ('complex_value'::character varying)::text, ('simple_value'::character varying)::text]))),
    CONSTRAINT type_aud_derivation_check CHECK (((derivation)::text = ANY (ARRAY[('extension'::character varying)::text, ('restriction'::character varying)::text]))),
    CONSTRAINT type_aud_pattern_check CHECK (((pattern)::text = ANY (ARRAY[('object'::character varying)::text, ('adapter'::character varying)::text, ('association'::character varying)::text, ('augmentation'::character varying)::text, ('metadata'::character varying)::text, ('complex_value'::character varying)::text, ('simple_value'::character varying)::text, ('simple_list'::character varying)::text, ('simple_union'::character varying)::text])))
);


--
-- TOC entry 226 (class 1259 OID 4970184)
-- Name: type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3325 (class 0 OID 0)
-- Dependencies: 226
-- Name: type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.type_id_seq OWNED BY public.type.id;


--
-- TOC entry 227 (class 1259 OID 4970186)
-- Name: version_aud; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.version_aud (
    is_current boolean,
    is_published boolean,
    rev integer NOT NULL,
    revtype smallint,
    created_date timestamp(6) without time zone,
    id bigint NOT NULL,
    last_modified_date timestamp(6) without time zone,
    model_id bigint,
    next_id bigint,
    niem_version_id bigint,
    prev_id bigint,
    category character varying(255),
    conformance_targets character varying(255),
    created_by character varying(255),
    draft character varying(255),
    exchange_partners character varying(255),
    exchange_pattern character varying(255),
    last_modified_by character varying(255),
    revised character varying(255),
    status character varying(255),
    uri character varying(255),
    version_number character varying(255),
    CONSTRAINT version_aud_category_check CHECK (((category)::text = ANY (ARRAY[('major'::character varying)::text, ('minor'::character varying)::text, ('patch'::character varying)::text, ('core_supplement'::character varying)::text, ('domain_update'::character varying)::text, ('other'::character varying)::text])))
);


--
-- TOC entry 228 (class 1259 OID 4970193)
-- Name: version_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.version_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3326 (class 0 OID 0)
-- Dependencies: 228
-- Name: version_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.version_id_seq OWNED BY public.version.id;


--
-- TOC entry 229 (class 1259 OID 4970195)
-- Name: version_message_roots; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.version_message_roots (
    message_roots_id bigint NOT NULL,
    version_id bigint NOT NULL
);


--
-- TOC entry 230 (class 1259 OID 4970198)
-- Name: version_message_roots_aud; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.version_message_roots_aud (
    rev integer NOT NULL,
    revtype smallint,
    message_roots_id bigint NOT NULL,
    version_id bigint NOT NULL
);


--
-- TOC entry 3013 (class 2604 OID 4970201)
-- Name: facet id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.facet ALTER COLUMN id SET DEFAULT nextval('public.facet_id_seq'::regclass);


--
-- TOC entry 3009 (class 2604 OID 4970202)
-- Name: model id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.model ALTER COLUMN id SET DEFAULT nextval('public.model_id_seq'::regclass);


--
-- TOC entry 3010 (class 2604 OID 4970203)
-- Name: namespace id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.namespace ALTER COLUMN id SET DEFAULT nextval('public.namespace_id_seq'::regclass);


--
-- TOC entry 3014 (class 2604 OID 4970204)
-- Name: property id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.property ALTER COLUMN id SET DEFAULT nextval('public.property_id_seq'::regclass);


--
-- TOC entry 3011 (class 2604 OID 4970205)
-- Name: steward id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.steward ALTER COLUMN id SET DEFAULT nextval('public.steward_id_seq'::regclass);


--
-- TOC entry 3015 (class 2604 OID 4970206)
-- Name: subproperty id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subproperty ALTER COLUMN id SET DEFAULT nextval('public.subproperty_id_seq'::regclass);


--
-- TOC entry 3012 (class 2604 OID 4970207)
-- Name: type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.type ALTER COLUMN id SET DEFAULT nextval('public.type_id_seq'::regclass);


--
-- TOC entry 3008 (class 2604 OID 4970208)
-- Name: version id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.version ALTER COLUMN id SET DEFAULT nextval('public.version_id_seq'::regclass);


--
-- TOC entry 3108 (class 2606 OID 4970210)
-- Name: facet_aud facet_aud_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.facet_aud
    ADD CONSTRAINT facet_aud_pkey PRIMARY KEY (rev, id);


--
-- TOC entry 3088 (class 2606 OID 4970212)
-- Name: facet facet_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.facet
    ADD CONSTRAINT facet_pkey PRIMARY KEY (id);


--
-- TOC entry 3110 (class 2606 OID 4970214)
-- Name: model_aud model_aud_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.model_aud
    ADD CONSTRAINT model_aud_pkey PRIMARY KEY (rev, id);


--
-- TOC entry 3059 (class 2606 OID 4970216)
-- Name: model model_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.model
    ADD CONSTRAINT model_pkey PRIMARY KEY (id);


--
-- TOC entry 3062 (class 2606 OID 4970218)
-- Name: model model_steward_short_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.model
    ADD CONSTRAINT model_steward_short_name_key UNIQUE (steward_id, short_name);


--
-- TOC entry 3112 (class 2606 OID 4970220)
-- Name: namespace_aud namespace_aud_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.namespace_aud
    ADD CONSTRAINT namespace_aud_pkey PRIMARY KEY (rev, id);


--
-- TOC entry 3067 (class 2606 OID 4970222)
-- Name: namespace namespace_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.namespace
    ADD CONSTRAINT namespace_pkey PRIMARY KEY (id);


--
-- TOC entry 3071 (class 2606 OID 4970224)
-- Name: namespace namespace_version_prefix_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.namespace
    ADD CONSTRAINT namespace_version_prefix_key UNIQUE (version_id, prefix);


--
-- TOC entry 3114 (class 2606 OID 4970226)
-- Name: property_aud property_aud_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.property_aud
    ADD CONSTRAINT property_aud_pkey PRIMARY KEY (rev, id);


--
-- TOC entry 3094 (class 2606 OID 4970228)
-- Name: property property_namespace_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.property
    ADD CONSTRAINT property_namespace_name_key UNIQUE (namespace_id, name);


--
-- TOC entry 3096 (class 2606 OID 4970230)
-- Name: property property_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.property
    ADD CONSTRAINT property_pkey PRIMARY KEY (id);


--
-- TOC entry 3116 (class 2606 OID 4970232)
-- Name: revinfo revinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.revinfo
    ADD CONSTRAINT revinfo_pkey PRIMARY KEY (rev);


--
-- TOC entry 3118 (class 2606 OID 4970234)
-- Name: steward_aud steward_aud_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.steward_aud
    ADD CONSTRAINT steward_aud_pkey PRIMARY KEY (rev, id);


--
-- TOC entry 3075 (class 2606 OID 4970236)
-- Name: steward steward_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.steward
    ADD CONSTRAINT steward_pkey PRIMARY KEY (id);


--
-- TOC entry 3078 (class 2606 OID 4970238)
-- Name: steward steward_short_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.steward
    ADD CONSTRAINT steward_short_name_key UNIQUE (short_name);


--
-- TOC entry 3120 (class 2606 OID 4970240)
-- Name: subproperty_aud subproperty_aud_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subproperty_aud
    ADD CONSTRAINT subproperty_aud_pkey PRIMARY KEY (rev, id);


--
-- TOC entry 3102 (class 2606 OID 4970242)
-- Name: subproperty subproperty_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subproperty
    ADD CONSTRAINT subproperty_pkey PRIMARY KEY (id);


--
-- TOC entry 3106 (class 2606 OID 4970244)
-- Name: subproperty subproperty_type_property_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subproperty
    ADD CONSTRAINT subproperty_type_property_key UNIQUE (property_id, type_id);


--
-- TOC entry 3122 (class 2606 OID 4970246)
-- Name: type_aud type_aud_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.type_aud
    ADD CONSTRAINT type_aud_pkey PRIMARY KEY (rev, id);


--
-- TOC entry 3083 (class 2606 OID 4970248)
-- Name: type type_namespace_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.type
    ADD CONSTRAINT type_namespace_name_key UNIQUE (namespace_id, name);


--
-- TOC entry 3085 (class 2606 OID 4970250)
-- Name: type type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.type
    ADD CONSTRAINT type_pkey PRIMARY KEY (id);


--
-- TOC entry 3124 (class 2606 OID 4970252)
-- Name: version_aud version_aud_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.version_aud
    ADD CONSTRAINT version_aud_pkey PRIMARY KEY (rev, id);


--
-- TOC entry 3130 (class 2606 OID 4970254)
-- Name: version_message_roots_aud version_message_roots_aud_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.version_message_roots_aud
    ADD CONSTRAINT version_message_roots_aud_pkey PRIMARY KEY (rev, message_roots_id, version_id);


--
-- TOC entry 3126 (class 2606 OID 4970256)
-- Name: version_message_roots version_message_roots_message_roots_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.version_message_roots
    ADD CONSTRAINT version_message_roots_message_roots_id_key UNIQUE (message_roots_id);


--
-- TOC entry 3128 (class 2606 OID 4970258)
-- Name: version_message_roots version_message_roots_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.version_message_roots
    ADD CONSTRAINT version_message_roots_pkey PRIMARY KEY (message_roots_id, version_id);


--
-- TOC entry 3046 (class 2606 OID 4970260)
-- Name: version version_model_number_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.version
    ADD CONSTRAINT version_model_number_key UNIQUE (model_id, version_number);


--
-- TOC entry 3048 (class 2606 OID 4970262)
-- Name: version version_next_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.version
    ADD CONSTRAINT version_next_id_key UNIQUE (next_id);


--
-- TOC entry 3050 (class 2606 OID 4970264)
-- Name: version version_niem_version_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.version
    ADD CONSTRAINT version_niem_version_id_key UNIQUE (niem_version_id);


--
-- TOC entry 3052 (class 2606 OID 4970266)
-- Name: version version_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.version
    ADD CONSTRAINT version_pkey PRIMARY KEY (id);


--
-- TOC entry 3054 (class 2606 OID 4970268)
-- Name: version version_prev_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.version
    ADD CONSTRAINT version_prev_id_key UNIQUE (prev_id);


--
-- TOC entry 3086 (class 1259 OID 4970269)
-- Name: facet_category_key; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX facet_category_key ON public.facet USING btree (category);


--
-- TOC entry 3089 (class 1259 OID 4970270)
-- Name: facet_type_key; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX facet_type_key ON public.facet USING btree (type_id);


--
-- TOC entry 3090 (class 1259 OID 4970271)
-- Name: facet_value_key; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX facet_value_key ON public.facet USING btree (value);


--
-- TOC entry 3056 (class 1259 OID 4970272)
-- Name: model_category_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX model_category_idx ON public.model USING btree (category);


--
-- TOC entry 3057 (class 1259 OID 4970273)
-- Name: model_objective_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX model_objective_idx ON public.model USING btree (objective);


--
-- TOC entry 3060 (class 1259 OID 4970274)
-- Name: model_short_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX model_short_name_idx ON public.model USING btree (short_name);


--
-- TOC entry 3063 (class 1259 OID 4970275)
-- Name: model_subjects_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX model_subjects_idx ON public.model USING btree (subjects);


--
-- TOC entry 3064 (class 1259 OID 4970276)
-- Name: namespace_category_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX namespace_category_idx ON public.namespace USING btree (category);


--
-- TOC entry 3065 (class 1259 OID 4970277)
-- Name: namespace_draft_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX namespace_draft_idx ON public.namespace USING btree (draft);


--
-- TOC entry 3068 (class 1259 OID 4970278)
-- Name: namespace_prefix_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX namespace_prefix_idx ON public.namespace USING btree (prefix);


--
-- TOC entry 3069 (class 1259 OID 4970279)
-- Name: namespace_uri_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX namespace_uri_idx ON public.namespace USING btree (uri);


--
-- TOC entry 3091 (class 1259 OID 4970280)
-- Name: property_category_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX property_category_idx ON public.property USING btree (category);


--
-- TOC entry 3092 (class 1259 OID 4970281)
-- Name: property_group_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX property_group_id_idx ON public.property USING btree (group_id);


--
-- TOC entry 3097 (class 1259 OID 4970282)
-- Name: property_type_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX property_type_id_idx ON public.property USING btree (type_id);


--
-- TOC entry 3072 (class 1259 OID 4970283)
-- Name: steward_category_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX steward_category_idx ON public.steward USING btree (category);


--
-- TOC entry 3073 (class 1259 OID 4970284)
-- Name: steward_country_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX steward_country_idx ON public.steward USING btree (country);


--
-- TOC entry 3076 (class 1259 OID 4970285)
-- Name: steward_short_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX steward_short_name_idx ON public.steward USING btree (short_name);


--
-- TOC entry 3079 (class 1259 OID 4970286)
-- Name: steward_unit_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX steward_unit_idx ON public.steward USING btree (unit);


--
-- TOC entry 3098 (class 1259 OID 4970287)
-- Name: subproperty_definition_key; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX subproperty_definition_key ON public.subproperty USING btree (definition);


--
-- TOC entry 3099 (class 1259 OID 4970288)
-- Name: subproperty_max_key; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX subproperty_max_key ON public.subproperty USING btree (max);


--
-- TOC entry 3100 (class 1259 OID 4970289)
-- Name: subproperty_min_key; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX subproperty_min_key ON public.subproperty USING btree (min);


--
-- TOC entry 3103 (class 1259 OID 4970290)
-- Name: subproperty_property_key; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX subproperty_property_key ON public.subproperty USING btree (property_id);


--
-- TOC entry 3104 (class 1259 OID 4970291)
-- Name: subproperty_type_key; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX subproperty_type_key ON public.subproperty USING btree (type_id);


--
-- TOC entry 3080 (class 1259 OID 4970292)
-- Name: type_base_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX type_base_id_idx ON public.type USING btree (base_id);


--
-- TOC entry 3081 (class 1259 OID 4970293)
-- Name: type_category_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX type_category_idx ON public.type USING btree (category);


--
-- TOC entry 3043 (class 1259 OID 4970294)
-- Name: version_category_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX version_category_idx ON public.version USING btree (category);


--
-- TOC entry 3044 (class 1259 OID 4970295)
-- Name: version_is_published_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX version_is_published_idx ON public.version USING btree (is_published);


--
-- TOC entry 3055 (class 1259 OID 4970296)
-- Name: version_version_number_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX version_version_number_idx ON public.version USING btree (version_number);


--
-- TOC entry 3131 (class 2606 OID 4970297)
-- Name: version fk1vovmw7bamqjfl9ociagworht; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.version
    ADD CONSTRAINT fk1vovmw7bamqjfl9ociagworht FOREIGN KEY (prev_id) REFERENCES public.version(id);


--
-- TOC entry 3132 (class 2606 OID 4970302)
-- Name: version fk25og93a21cdb4q23wx4oagess; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.version
    ADD CONSTRAINT fk25og93a21cdb4q23wx4oagess FOREIGN KEY (niem_version_id) REFERENCES public.version(id);


--
-- TOC entry 3155 (class 2606 OID 4970307)
-- Name: subproperty fk2q10dsx97i9mwccsmjpjjf0og; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subproperty
    ADD CONSTRAINT fk2q10dsx97i9mwccsmjpjjf0og FOREIGN KEY (original_id) REFERENCES public.subproperty(id);


--
-- TOC entry 3165 (class 2606 OID 4970312)
-- Name: subproperty_aud fk4kx78j6eqn370ktyme0s4vu92; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subproperty_aud
    ADD CONSTRAINT fk4kx78j6eqn370ktyme0s4vu92 FOREIGN KEY (rev) REFERENCES public.revinfo(rev);


--
-- TOC entry 3149 (class 2606 OID 4970317)
-- Name: property fk5w8b6myfkolujvenmfcyq63vg; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.property
    ADD CONSTRAINT fk5w8b6myfkolujvenmfcyq63vg FOREIGN KEY (prev_id) REFERENCES public.property(id);


--
-- TOC entry 3145 (class 2606 OID 4970322)
-- Name: facet fk6d4xjpv2qb59i3f0i9mgb8vuf; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.facet
    ADD CONSTRAINT fk6d4xjpv2qb59i3f0i9mgb8vuf FOREIGN KEY (prev_id) REFERENCES public.facet(id);


--
-- TOC entry 3140 (class 2606 OID 4970327)
-- Name: type fk6enl407l6u9ti6meprl5aaimg; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.type
    ADD CONSTRAINT fk6enl407l6u9ti6meprl5aaimg FOREIGN KEY (next_id) REFERENCES public.type(id);


--
-- TOC entry 3161 (class 2606 OID 4970332)
-- Name: model_aud fk7m0fmhb7gkp4nvq5g5aa9sh6b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.model_aud
    ADD CONSTRAINT fk7m0fmhb7gkp4nvq5g5aa9sh6b FOREIGN KEY (rev) REFERENCES public.revinfo(rev);


--
-- TOC entry 3167 (class 2606 OID 4970337)
-- Name: version_aud fka9s4qx9k3ymtq97qashhdfqmq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.version_aud
    ADD CONSTRAINT fka9s4qx9k3ymtq97qashhdfqmq FOREIGN KEY (rev) REFERENCES public.revinfo(rev);


--
-- TOC entry 3163 (class 2606 OID 4970342)
-- Name: property_aud fkbax3qj40a4fxbpk03gaqswe57; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.property_aud
    ADD CONSTRAINT fkbax3qj40a4fxbpk03gaqswe57 FOREIGN KEY (rev) REFERENCES public.revinfo(rev);


--
-- TOC entry 3168 (class 2606 OID 4970347)
-- Name: version_message_roots fkbyxgxh5r8usksoyokcqwlgi11; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.version_message_roots
    ADD CONSTRAINT fkbyxgxh5r8usksoyokcqwlgi11 FOREIGN KEY (version_id) REFERENCES public.version(id);


--
-- TOC entry 3170 (class 2606 OID 4970352)
-- Name: version_message_roots_aud fkcbqtoybcy4n9spdqqftdl7klm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.version_message_roots_aud
    ADD CONSTRAINT fkcbqtoybcy4n9spdqqftdl7klm FOREIGN KEY (rev) REFERENCES public.revinfo(rev);


--
-- TOC entry 3133 (class 2606 OID 4970357)
-- Name: version fkce3cnhwctnh1n8tca1i5ufq30; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.version
    ADD CONSTRAINT fkce3cnhwctnh1n8tca1i5ufq30 FOREIGN KEY (next_id) REFERENCES public.version(id);


--
-- TOC entry 3146 (class 2606 OID 4970362)
-- Name: facet fke5rlmtmgsfu53oif94r1pl62j; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.facet
    ADD CONSTRAINT fke5rlmtmgsfu53oif94r1pl62j FOREIGN KEY (next_id) REFERENCES public.facet(id);


--
-- TOC entry 3150 (class 2606 OID 4970367)
-- Name: property fkeb1jiqk27jckh1q38va5bec74; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.property
    ADD CONSTRAINT fkeb1jiqk27jckh1q38va5bec74 FOREIGN KEY (original_id) REFERENCES public.property(id);


--
-- TOC entry 3136 (class 2606 OID 4970372)
-- Name: namespace fkernlra2fp83u45bkjp4xm4vlu; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.namespace
    ADD CONSTRAINT fkernlra2fp83u45bkjp4xm4vlu FOREIGN KEY (original_id) REFERENCES public.namespace(id);


--
-- TOC entry 3141 (class 2606 OID 4970377)
-- Name: type fkf39e3ugvhkqihiud29u57j12c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.type
    ADD CONSTRAINT fkf39e3ugvhkqihiud29u57j12c FOREIGN KEY (prev_id) REFERENCES public.type(id);


--
-- TOC entry 3151 (class 2606 OID 4970382)
-- Name: property fkgqgjnle5s0ha7dohfnoeqq75c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.property
    ADD CONSTRAINT fkgqgjnle5s0ha7dohfnoeqq75c FOREIGN KEY (type_id) REFERENCES public.type(id);


--
-- TOC entry 3164 (class 2606 OID 4970387)
-- Name: steward_aud fkgxlqj290sm4q7tbua1hwnhx21; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.steward_aud
    ADD CONSTRAINT fkgxlqj290sm4q7tbua1hwnhx21 FOREIGN KEY (rev) REFERENCES public.revinfo(rev);


--
-- TOC entry 3162 (class 2606 OID 4970392)
-- Name: namespace_aud fkh9i5w8yilss5s61xjbxu3dfke; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.namespace_aud
    ADD CONSTRAINT fkh9i5w8yilss5s61xjbxu3dfke FOREIGN KEY (rev) REFERENCES public.revinfo(rev);


--
-- TOC entry 3137 (class 2606 OID 4970397)
-- Name: namespace fkhdctdf2037mwgyqov9216xtsm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.namespace
    ADD CONSTRAINT fkhdctdf2037mwgyqov9216xtsm FOREIGN KEY (next_id) REFERENCES public.namespace(id);


--
-- TOC entry 3156 (class 2606 OID 4970402)
-- Name: subproperty fki3yp147p2w1e83q66kfdignti; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subproperty
    ADD CONSTRAINT fki3yp147p2w1e83q66kfdignti FOREIGN KEY (prev_id) REFERENCES public.subproperty(id);


--
-- TOC entry 3142 (class 2606 OID 4970407)
-- Name: type fkii85ni2samg5y07f9mxpg1416; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.type
    ADD CONSTRAINT fkii85ni2samg5y07f9mxpg1416 FOREIGN KEY (original_id) REFERENCES public.type(id);


--
-- TOC entry 3143 (class 2606 OID 4970412)
-- Name: type fkjamrh0v37v9s7f5n3akvcvjy2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.type
    ADD CONSTRAINT fkjamrh0v37v9s7f5n3akvcvjy2 FOREIGN KEY (base_id) REFERENCES public.type(id);


--
-- TOC entry 3147 (class 2606 OID 4970417)
-- Name: facet fkjjxs7w1ymp5gmvx6juv9kj0ie; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.facet
    ADD CONSTRAINT fkjjxs7w1ymp5gmvx6juv9kj0ie FOREIGN KEY (original_id) REFERENCES public.facet(id);


--
-- TOC entry 3152 (class 2606 OID 4970422)
-- Name: property fkjrp9nj2u40qnfk9wwus3w58h2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.property
    ADD CONSTRAINT fkjrp9nj2u40qnfk9wwus3w58h2 FOREIGN KEY (next_id) REFERENCES public.property(id);


--
-- TOC entry 3166 (class 2606 OID 4970427)
-- Name: type_aud fkkgostd6sjmqo1ddve74irk4xt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.type_aud
    ADD CONSTRAINT fkkgostd6sjmqo1ddve74irk4xt FOREIGN KEY (rev) REFERENCES public.revinfo(rev);


--
-- TOC entry 3157 (class 2606 OID 4970432)
-- Name: subproperty fknm18chvaecggfe4csrtnwyi2u; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subproperty
    ADD CONSTRAINT fknm18chvaecggfe4csrtnwyi2u FOREIGN KEY (next_id) REFERENCES public.subproperty(id);


--
-- TOC entry 3153 (class 2606 OID 4970437)
-- Name: property fkoli7wpmd5pei7vwgqq9j2fl64; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.property
    ADD CONSTRAINT fkoli7wpmd5pei7vwgqq9j2fl64 FOREIGN KEY (group_id) REFERENCES public.property(id);


--
-- TOC entry 3138 (class 2606 OID 4970442)
-- Name: namespace fkprt2e3h2bis7kv2s4u31vmhyw; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.namespace
    ADD CONSTRAINT fkprt2e3h2bis7kv2s4u31vmhyw FOREIGN KEY (prev_id) REFERENCES public.namespace(id);


--
-- TOC entry 3169 (class 2606 OID 4970447)
-- Name: version_message_roots fkr3wbvpsqx3y7jk7sj988ea4ob; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.version_message_roots
    ADD CONSTRAINT fkr3wbvpsqx3y7jk7sj988ea4ob FOREIGN KEY (message_roots_id) REFERENCES public.property(id);


--
-- TOC entry 3160 (class 2606 OID 4970452)
-- Name: facet_aud fkr9wjw852jdu0b0phey01tfthk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.facet_aud
    ADD CONSTRAINT fkr9wjw852jdu0b0phey01tfthk FOREIGN KEY (rev) REFERENCES public.revinfo(rev);


--
-- TOC entry 3134 (class 2606 OID 4970457)
-- Name: version model_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.version
    ADD CONSTRAINT model_fkey FOREIGN KEY (model_id) REFERENCES public.model(id);


--
-- TOC entry 3154 (class 2606 OID 4970462)
-- Name: property namespace_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.property
    ADD CONSTRAINT namespace_fkey FOREIGN KEY (namespace_id) REFERENCES public.namespace(id);


--
-- TOC entry 3144 (class 2606 OID 4970467)
-- Name: type namespace_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.type
    ADD CONSTRAINT namespace_fkey FOREIGN KEY (namespace_id) REFERENCES public.namespace(id);


--
-- TOC entry 3158 (class 2606 OID 4970472)
-- Name: subproperty property_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subproperty
    ADD CONSTRAINT property_fkey FOREIGN KEY (property_id) REFERENCES public.property(id);


--
-- TOC entry 3135 (class 2606 OID 4970477)
-- Name: model steward_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.model
    ADD CONSTRAINT steward_fkey FOREIGN KEY (steward_id) REFERENCES public.steward(id);


--
-- TOC entry 3148 (class 2606 OID 4970482)
-- Name: facet type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.facet
    ADD CONSTRAINT type_fkey FOREIGN KEY (type_id) REFERENCES public.type(id);


--
-- TOC entry 3159 (class 2606 OID 4970487)
-- Name: subproperty type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subproperty
    ADD CONSTRAINT type_fkey FOREIGN KEY (type_id) REFERENCES public.type(id);


--
-- TOC entry 3139 (class 2606 OID 4970492)
-- Name: namespace version_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.namespace
    ADD CONSTRAINT version_fkey FOREIGN KEY (version_id) REFERENCES public.version(id);


-- Completed on 2025-04-11 18:07:46

--
-- PostgreSQL database dump complete
--


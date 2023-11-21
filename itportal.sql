--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.25
-- Dumped by pg_dump version 9.5.25

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounting_items; Type: TABLE; Schema: public; Owner: mike
--

CREATE TABLE public.accounting_items (
    id bigint NOT NULL,
    uid character varying NOT NULL,
    slug character varying,
    name character varying,
    description character varying,
    options json,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.accounting_items OWNER TO mike;

--
-- Name: accounting_items_id_seq; Type: SEQUENCE; Schema: public; Owner: mike
--

CREATE SEQUENCE public.accounting_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounting_items_id_seq OWNER TO mike;

--
-- Name: accounting_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mike
--

ALTER SEQUENCE public.accounting_items_id_seq OWNED BY public.accounting_items.id;


--
-- Name: accounts; Type: TABLE; Schema: public; Owner: mike
--

CREATE TABLE public.accounts (
    id bigint NOT NULL,
    code character varying,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.accounts OWNER TO mike;

--
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: mike
--

CREATE SEQUENCE public.accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_id_seq OWNER TO mike;

--
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mike
--

ALTER SEQUENCE public.accounts_id_seq OWNED BY public.accounts.id;


--
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: mike
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.active_storage_attachments OWNER TO mike;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: mike
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_attachments_id_seq OWNER TO mike;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mike
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: mike
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    service_name character varying NOT NULL,
    byte_size bigint NOT NULL,
    checksum character varying NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.active_storage_blobs OWNER TO mike;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: mike
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_blobs_id_seq OWNER TO mike;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mike
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: active_storage_variant_records; Type: TABLE; Schema: public; Owner: mike
--

CREATE TABLE public.active_storage_variant_records (
    id bigint NOT NULL,
    blob_id bigint NOT NULL,
    variation_digest character varying NOT NULL
);


ALTER TABLE public.active_storage_variant_records OWNER TO mike;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE; Schema: public; Owner: mike
--

CREATE SEQUENCE public.active_storage_variant_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_variant_records_id_seq OWNER TO mike;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mike
--

ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNED BY public.active_storage_variant_records.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: mike
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO mike;

--
-- Name: assets; Type: TABLE; Schema: public; Owner: mike
--

CREATE TABLE public.assets (
    id bigint NOT NULL,
    uid character varying NOT NULL,
    name character varying,
    description character varying,
    cost double precision,
    date timestamp without time zone,
    status integer,
    inventory_number character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    slug character varying,
    code character varying,
    start_date timestamp without time zone,
    useful_life integer,
    location_id bigint,
    count integer,
    account_id bigint,
    organization_id bigint,
    mol_id bigint
);


ALTER TABLE public.assets OWNER TO mike;

--
-- Name: assets_id_seq; Type: SEQUENCE; Schema: public; Owner: mike
--

CREATE SEQUENCE public.assets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.assets_id_seq OWNER TO mike;

--
-- Name: assets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mike
--

ALTER SEQUENCE public.assets_id_seq OWNED BY public.assets.id;


--
-- Name: friendly_id_slugs; Type: TABLE; Schema: public; Owner: mike
--

CREATE TABLE public.friendly_id_slugs (
    id bigint NOT NULL,
    slug character varying NOT NULL,
    sluggable_id integer NOT NULL,
    sluggable_type character varying(50),
    scope character varying,
    created_at timestamp without time zone
);


ALTER TABLE public.friendly_id_slugs OWNER TO mike;

--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE; Schema: public; Owner: mike
--

CREATE SEQUENCE public.friendly_id_slugs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.friendly_id_slugs_id_seq OWNER TO mike;

--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mike
--

ALTER SEQUENCE public.friendly_id_slugs_id_seq OWNED BY public.friendly_id_slugs.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: mike
--

CREATE TABLE public.locations (
    id bigint NOT NULL,
    code character varying,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.locations OWNER TO mike;

--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: mike
--

CREATE SEQUENCE public.locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.locations_id_seq OWNER TO mike;

--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mike
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- Name: mols; Type: TABLE; Schema: public; Owner: mike
--

CREATE TABLE public.mols (
    id bigint NOT NULL,
    code character varying,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.mols OWNER TO mike;

--
-- Name: mols_id_seq; Type: SEQUENCE; Schema: public; Owner: mike
--

CREATE SEQUENCE public.mols_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mols_id_seq OWNER TO mike;

--
-- Name: mols_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mike
--

ALTER SEQUENCE public.mols_id_seq OWNED BY public.mols.id;


--
-- Name: organizations; Type: TABLE; Schema: public; Owner: mike
--

CREATE TABLE public.organizations (
    id bigint NOT NULL,
    code character varying,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.organizations OWNER TO mike;

--
-- Name: organizations_id_seq; Type: SEQUENCE; Schema: public; Owner: mike
--

CREATE SEQUENCE public.organizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.organizations_id_seq OWNER TO mike;

--
-- Name: organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mike
--

ALTER SEQUENCE public.organizations_id_seq OWNED BY public.organizations.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: mike
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO mike;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mike
--

ALTER TABLE ONLY public.accounting_items ALTER COLUMN id SET DEFAULT nextval('public.accounting_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mike
--

ALTER TABLE ONLY public.accounts ALTER COLUMN id SET DEFAULT nextval('public.accounts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mike
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mike
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mike
--

ALTER TABLE ONLY public.active_storage_variant_records ALTER COLUMN id SET DEFAULT nextval('public.active_storage_variant_records_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mike
--

ALTER TABLE ONLY public.assets ALTER COLUMN id SET DEFAULT nextval('public.assets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mike
--

ALTER TABLE ONLY public.friendly_id_slugs ALTER COLUMN id SET DEFAULT nextval('public.friendly_id_slugs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mike
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mike
--

ALTER TABLE ONLY public.mols ALTER COLUMN id SET DEFAULT nextval('public.mols_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mike
--

ALTER TABLE ONLY public.organizations ALTER COLUMN id SET DEFAULT nextval('public.organizations_id_seq'::regclass);


--
-- Data for Name: accounting_items; Type: TABLE DATA; Schema: public; Owner: mike
--

COPY public.accounting_items (id, uid, slug, name, description, options, created_at, updated_at) FROM stdin;
41	9ff6784d	9ff6784d	Системный блок Intel Xeon E5-4655 v3		{"inventory_number":"1101340046"}	2022-02-02 13:56:48.534026	2022-02-02 13:56:48.534026
42	092d8d2c	092d8d2c	Системный блок Intel Xeon E5-4655 v3		{"inventory_number":"1101340047"}	2022-02-02 13:56:51.709473	2022-02-02 13:56:51.709473
43	9a473163	9a473163	Системный блок Intel Xeon E5-4655 v3		{"inventory_number":"1101340048"}	2022-02-02 13:56:55.245971	2022-02-02 13:56:55.245971
1	21450cee	21450cee	Проектор Optima ZU506Te		{"inventory_number":"1101340033"}	2021-12-10 09:04:52.043371	2021-12-28 12:47:52.274401
2	3971d2f2	3971d2f2	Ноутбук Lenovo ThinkBook 15G2	Новый тест	{"inventory_number":"1101340032"}	2021-12-10 13:44:34.825613	2021-12-28 12:48:09.331556
3	c2b60705	c2b60705	Видеосервер Domination IP-128P-24-HSR		{"inventory_number":"1101340031"}	2021-12-28 13:03:31.268173	2021-12-28 13:03:31.268173
4	8aa86cf6	8aa86cf6	Видеосервер Domination IP-128P-24-HSR		{"inventory_number":"1101340030"}	2021-12-28 13:03:52.30572	2021-12-28 13:03:52.30572
5	6f16a3e3	6f16a3e3	Модем 4G MikroTik RBSXTR&R11e-LTE6		{"inventory_number":"1101340029"}	2021-12-28 13:04:19.210062	2021-12-28 13:04:19.210062
6	758fd212	758fd212	Модем 4G MikroTik RBSXTR&R11e-LTE6		{"inventory_number":"1101340028"}	2021-12-28 13:04:29.502668	2021-12-28 13:04:29.502668
7	21d0e17e	21d0e17e	Коммутатор Huawei S6730-H28Y4C		{"inventory_number":"1101340027"}	2021-12-28 13:04:42.890188	2021-12-28 13:04:42.890188
8	2946bace	2946bace	Коммутатор Huawei S6730-H28Y4C		{"inventory_number":"1101340026"}	2021-12-28 13:04:47.436937	2021-12-28 13:04:47.436937
9	a81c1312	a81c1312	Сканер планшетный Mustek A3 USB 1200S		{"inventory_number":"1101340025"}	2021-12-28 13:05:08.77414	2021-12-28 13:05:08.77414
10	6224a83c	6224a83c	ИБП NewLine Energy		{"inventory_number":"1101340024"}	2021-12-28 13:05:23.323517	2021-12-28 13:05:23.323517
11	f6300778	f6300778	Ноутбук Lenovo IdeaPad L340-17IRH Gaming		{"inventory_number":"1101340023"}	2021-12-28 13:05:43.515459	2021-12-28 13:05:43.515459
12	f88f9692	f88f9692	Ноутбук Lenovo IdeaPad L340-17IRH Gaming		{"inventory_number":"1101340022"}	2021-12-28 13:05:48.206479	2021-12-28 13:05:48.206479
13	04cbd5f2	04cbd5f2	Ноутбук Lenovo IdeaPad L340-17IRH Gaming		{"inventory_number":"1101340021"}	2021-12-28 13:05:51.37265	2021-12-28 13:05:51.37265
14	6ef7c335	6ef7c335	Многофункциональное устройство (МФУ) Pantum M6800FDW		{"inventory_number":"1101340020"}	2021-12-28 13:06:07.212332	2021-12-28 13:06:07.212332
15	e43dc17c	e43dc17c	Многофункциональное устройство (МФУ) Pantum M6800FDW		{"inventory_number":"1101340019"}	2021-12-28 13:06:12.326876	2021-12-28 13:06:12.326876
16	81f8544f	81f8544f	Многофункциональное устройство (МФУ) Pantum M6800FDW		{"inventory_number":"1101340018"}	2021-12-28 13:06:19.793496	2021-12-28 13:06:19.793496
17	d4abf7ce	d4abf7ce	Сканер Avision AD130		{"inventory_number":"1101340017"}	2021-12-28 13:06:34.698083	2021-12-28 13:06:34.698083
18	388619c9	388619c9	Сканер Avision AD130		{"inventory_number":"1101340016"}	2021-12-28 13:06:41.25972	2021-12-28 13:06:41.25972
19	d50cc741	d50cc741	МФУ KYOCERA ECOSYS M6230cidn		{"inventory_number":"1101340012"}	2021-12-28 13:06:57.016896	2021-12-28 13:06:57.016896
20	77ea67d0	77ea67d0	МФУ KYOCERA ECOSYS M6230cidn		{"inventory_number":"1101340011"}	2021-12-28 13:07:03.711781	2021-12-28 13:07:03.711781
21	5a7556d0	5a7556d0	МФУ KYOCERA ECOSYS M6230cidn		{"inventory_number":"1101340010"}	2021-12-28 13:07:07.528294	2021-12-28 13:07:07.528294
22	ad19fbd3	ad19fbd3	Планшетгый компьютер Samsung Galaxy Tab S5e (2019)		{"inventory_number":"1101340009"}	2021-12-28 13:07:25.627027	2021-12-28 13:07:25.627027
23	953c2250	953c2250	Моноблок Asus V241FFK		{"inventory_number":"1101340008"}	2021-12-28 13:07:35.424721	2021-12-28 13:07:35.424721
24	ca0155fb	ca0155fb	Веб-камера Logitech HD Conference Cam BCC950		{"inventory_number":"1101340007"}	2021-12-28 13:07:45.962575	2021-12-28 13:07:45.962575
25	32e33c01	32e33c01	Моноблок HP ProOne 440 G5 23.8		{"inventory_number":"1101340006"}	2021-12-28 13:08:15.042605	2021-12-28 13:08:15.042605
26	3729401e	3729401e	Планшет Samsung Galaxy Tab S6(SM-T865NZAASER)		{"inventory_number":"1101340005"}	2021-12-28 13:08:26.673578	2021-12-28 13:08:26.673578
27	ecb46136	ecb46136	Источник бесперебойного питания EATON 9SX5KIRT		{"inventory_number":"1101340002"}	2021-12-28 13:08:37.014637	2021-12-28 13:08:37.014637
28	e3826444	e3826444	Источник бесперебойного питания EATON 9SX5KIRT		{"inventory_number":"1101340001"}	2021-12-28 13:08:40.25322	2021-12-28 13:08:40.25322
44	180bafef	180bafef	Системный блок Intel Xeon E5-4655 v3		{"inventory_number":"1101340049"}	2022-02-02 13:56:58.005125	2022-02-02 13:56:58.005125
45	dc595d3c	dc595d3c	Системный блок Intel Xeon E5-4655 v3		{"inventory_number":"1101340050"}	2022-02-02 13:57:01.603079	2022-02-02 13:57:01.603079
29	bd36837d	bd36837d	Системный блок Intel Xeon E5-4655 v3		{"inventory_number":"1101340034"}	2022-02-02 13:51:51.382815	2022-02-02 13:55:28.1806
30	db49be4a	db49be4a	Системный блок Intel Xeon E5-4655 v3		{"inventory_number":"1101340035"}	2022-02-02 13:55:58.897769	2022-02-02 13:55:58.897769
31	b7026f7e	b7026f7e	Системный блок Intel Xeon E5-4655 v3		{"inventory_number":"1101340036"}	2022-02-02 13:56:09.740255	2022-02-02 13:56:09.740255
32	2b5b04c0	2b5b04c0	Системный блок Intel Xeon E5-4655 v3		{"inventory_number":"1101340037"}	2022-02-02 13:56:13.222574	2022-02-02 13:56:13.222574
33	6ed2d5e5	6ed2d5e5	Системный блок Intel Xeon E5-4655 v3		{"inventory_number":"1101340038"}	2022-02-02 13:56:16.498811	2022-02-02 13:56:16.498811
34	db24c9b3	db24c9b3	Системный блок Intel Xeon E5-4655 v3		{"inventory_number":"1101340039"}	2022-02-02 13:56:20.058497	2022-02-02 13:56:20.058497
35	37242d35	37242d35	Системный блок Intel Xeon E5-4655 v3		{"inventory_number":"1101340040"}	2022-02-02 13:56:27.182415	2022-02-02 13:56:27.182415
36	04143a26	04143a26	Системный блок Intel Xeon E5-4655 v3		{"inventory_number":"1101340041"}	2022-02-02 13:56:31.480749	2022-02-02 13:56:31.480749
37	df153de9	df153de9	Системный блок Intel Xeon E5-4655 v3		{"inventory_number":"1101340042"}	2022-02-02 13:56:34.229623	2022-02-02 13:56:34.229623
38	e825f9ec	e825f9ec	Системный блок Intel Xeon E5-4655 v3		{"inventory_number":"1101340043"}	2022-02-02 13:56:37.161078	2022-02-02 13:56:37.161078
39	b983d896	b983d896	Системный блок Intel Xeon E5-4655 v3		{"inventory_number":"1101340044"}	2022-02-02 13:56:42.263164	2022-02-02 13:56:42.263164
40	47367342	47367342	Системный блок Intel Xeon E5-4655 v3		{"inventory_number":"1101340045"}	2022-02-02 13:56:45.189354	2022-02-02 13:56:45.189354
46	aee45a8b	aee45a8b	Системный блок Intel Xeon E5-4655 v3		{"inventory_number":"1101340051"}	2022-07-11 11:30:26.533927	2022-07-11 11:30:26.533927
47	7a8807b3	7a8807b3	Системный блок Intel Xeon E5-4655 v3		{"inventory_number":"1101340052"}	2022-07-11 11:30:30.63811	2022-07-11 11:30:30.63811
48	925712ec	925712ec	Системный блок Intel Xeon E5-4655 v3		{"inventory_number":"1101340063"}	2022-07-11 11:30:47.474507	2022-07-11 11:30:47.474507
49	87d9bac9	87d9bac9	Системный блок Intel Xeon E5-4655 v3		{"inventory_number":"1101340064"}	2022-07-11 11:30:51.01921	2022-07-11 11:30:51.01921
50	3927d180	3927d180	Системный блок Intel Xeon E5-4655 v3		{"inventory_number":"1101340065"}	2022-07-11 11:31:00.171596	2022-07-11 11:31:00.171596
51	da9b2d2c	da9b2d2c	Системный блок Intel Xeon E5-4655 v3		{"inventory_number":"1101340066"}	2022-07-11 11:31:03.664564	2022-07-11 11:31:03.664564
\.


--
-- Name: accounting_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mike
--

SELECT pg_catalog.setval('public.accounting_items_id_seq', 51, true);


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: mike
--

COPY public.accounts (id, code, name, created_at, updated_at) FROM stdin;
1	21.36	21.36	2023-10-31 14:53:29.83454	2023-10-31 14:53:29.83454
\.


--
-- Name: accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mike
--

SELECT pg_catalog.setval('public.accounts_id_seq', 1, true);


--
-- Data for Name: active_storage_attachments; Type: TABLE DATA; Schema: public; Owner: mike
--

COPY public.active_storage_attachments (id, name, record_type, record_id, blob_id, created_at) FROM stdin;
22	images	Asset	54	22	2023-10-18 14:03:25.081793
23	images	Asset	55	23	2023-10-18 14:04:35.992681
24	images	Asset	56	24	2023-10-18 14:05:03.575917
25	images	Asset	57	25	2023-10-18 14:05:21.021108
26	images	Asset	58	26	2023-10-18 14:05:49.696474
30	images	Asset	11	30	2023-10-30 10:24:33.38387
31	images	Asset	11	31	2023-10-30 10:24:39.135189
32	images	Asset	10	32	2023-10-30 10:24:56.056825
33	images	Asset	10	33	2023-10-30 10:24:56.068153
\.


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mike
--

SELECT pg_catalog.setval('public.active_storage_attachments_id_seq', 33, true);


--
-- Data for Name: active_storage_blobs; Type: TABLE DATA; Schema: public; Owner: mike
--

COPY public.active_storage_blobs (id, key, filename, content_type, metadata, service_name, byte_size, checksum, created_at) FROM stdin;
22	56azlbn7b1cofdn9a03xfol5cwhs	Eltex ESR-21 - 1101340067.jpg	image/jpeg	{"identified":true,"analyzed":true}	local	759913	WxS1+uhbHqdUBesVStGinQ==	2023-10-18 14:03:25.076994
23	351m6fsvk6kalru3gwjj6vrgjilu	МФУ - 1101340068.jpg	image/jpeg	{"identified":true,"analyzed":true}	local	780045	MhCXx6AOY+7OVNTEVMctCw==	2023-10-18 14:04:35.987184
24	7kplr5r66s16ml4nxnpsb761tmaw	МФУ - 1101340069.jpg	image/jpeg	{"identified":true,"analyzed":true}	local	378033	G000BiGucuOspyf5CG6qnA==	2023-10-18 14:05:03.57118
25	jbraf4qak0ruzze2w5vwlcqriabx	МФУ - 1101340070.jpg	image/jpeg	{"identified":true,"analyzed":true}	local	1113963	zy6i26YmIrchpPSLlHTJqA==	2023-10-18 14:05:21.016862
26	8ie8b7lu3eh4mnbipzl6f8g4webr	Сервер - 1101340072.jpg	image/jpeg	{"identified":true,"analyzed":true}	local	1096858	iw92a+jK+uZLXTTNMN1E6w==	2023-10-18 14:05:49.691935
30	np78vbdiqavi9vzy19hvpgiu15xp	IMG_20231025_171535.jpg	image/jpeg	{"identified":true,"analyzed":true}	local	577630	AKWbEEuxFFf/g8NxBJcc8g==	2023-10-30 10:24:33.374684
31	8uzck2z2cl536bxv0qik8lmkg7xw	IMG_20231025_171512.jpg	image/jpeg	{"identified":true,"analyzed":true}	local	463606	uETqvuTKzQpojgp/kXkp4w==	2023-10-30 10:24:39.12998
32	lmyo41pq6ushhrsljv52t24dgevs	IMG_20231025_171535.jpg	image/jpeg	{"identified":true,"analyzed":true}	local	577630	AKWbEEuxFFf/g8NxBJcc8g==	2023-10-30 10:24:56.051719
33	473rpn92iwdrm4pndxgt2qleho9a	IMG_20231025_171512.jpg	image/jpeg	{"identified":true,"analyzed":true}	local	463606	uETqvuTKzQpojgp/kXkp4w==	2023-10-30 10:24:56.062631
\.


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mike
--

SELECT pg_catalog.setval('public.active_storage_blobs_id_seq', 33, true);


--
-- Data for Name: active_storage_variant_records; Type: TABLE DATA; Schema: public; Owner: mike
--

COPY public.active_storage_variant_records (id, blob_id, variation_digest) FROM stdin;
\.


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mike
--

SELECT pg_catalog.setval('public.active_storage_variant_records_id_seq', 1, false);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: mike
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2021-12-09 14:48:53.870798	2021-12-09 14:48:53.870798
\.


--
-- Data for Name: assets; Type: TABLE DATA; Schema: public; Owner: mike
--

COPY public.assets (id, uid, name, description, cost, date, status, inventory_number, created_at, updated_at, slug, code, start_date, useful_life, location_id, count, account_id, organization_id, mol_id) FROM stdin;
3	a3c34de2	Системный блок Intel Xeon E5-4655 v3	\N	951589	2022-10-30 13:19:01.380589	1	1101340048	2023-10-13 13:19:01.470581	2023-10-13 13:19:01.470581	a3c34de2	\N	\N	\N	\N	\N	\N	\N	\N
5	263b30b3	Ноутбук Lenovo ThinkBook 15G2	\N	582809	2023-03-13 13:19:01.380858	0	1101340032	2023-10-13 13:19:01.502335	2023-10-13 13:19:01.502335	263b30b3	\N	\N	\N	\N	\N	\N	\N	\N
6	bbda057c	Видеосервер Domination IP-128P-24-HSR	\N	329620	2023-09-28 13:19:01.380995	0	1101340031	2023-10-13 13:19:01.518335	2023-10-13 13:19:01.518335	bbda057c	\N	\N	\N	\N	\N	\N	\N	\N
7	8b15ac10	Видеосервер Domination IP-128P-24-HSR	\N	949659	2020-10-26 13:19:01.381129	0	1101340030	2023-10-13 13:19:01.534357	2023-10-13 13:19:01.534357	8b15ac10	\N	\N	\N	\N	\N	\N	\N	\N
8	e8d60fae	Модем 4G MikroTik RBSXTR&R11e-LTE6	\N	823894	2021-11-30 13:19:01.381262	2	1101340029	2023-10-13 13:19:01.550265	2023-10-13 13:19:01.550265	e8d60fae	\N	\N	\N	\N	\N	\N	\N	\N
9	c020a92a	Модем 4G MikroTik RBSXTR&R11e-LTE6	\N	213102	2021-02-19 13:19:01.381394	1	1101340028	2023-10-13 13:19:01.566326	2023-10-13 13:19:01.566326	c020a92a	\N	\N	\N	\N	\N	\N	\N	\N
12	5473fb52	Сканер планшетный Mustek A3 USB 1200S	\N	125176	2022-01-06 13:19:01.381797	2	1101340025	2023-10-13 13:19:01.614195	2023-10-13 13:19:01.614195	5473fb52	\N	\N	\N	\N	\N	\N	\N	\N
13	0a1e78ba	ИБП NewLine Energy	\N	167784	2021-04-07 13:19:01.381929	1	1101340024	2023-10-13 13:19:01.630144	2023-10-13 13:19:01.630144	0a1e78ba	\N	\N	\N	\N	\N	\N	\N	\N
14	ab659b86	Ноутбук Lenovo IdeaPad L340-17IRH Gaming	\N	251130	2022-07-04 13:19:01.382061	0	1101340023	2023-10-13 13:19:01.646152	2023-10-13 13:19:01.646152	ab659b86	\N	\N	\N	\N	\N	\N	\N	\N
15	e6856758	Ноутбук Lenovo IdeaPad L340-17IRH Gaming	\N	333666	2023-05-19 13:19:01.382194	1	1101340022	2023-10-13 13:19:01.664443	2023-10-13 13:19:01.664443	e6856758	\N	\N	\N	\N	\N	\N	\N	\N
16	81221c1c	Ноутбук Lenovo IdeaPad L340-17IRH Gaming	\N	155501	2023-02-23 13:19:01.382333	2	1101340021	2023-10-13 13:19:01.687443	2023-10-13 13:19:01.687443	81221c1c	\N	\N	\N	\N	\N	\N	\N	\N
17	ec5f2969	Многофункциональное устройство (МФУ) Pantum M6800FDW	\N	266002	2021-03-11 13:19:01.382466	1	1101340020	2023-10-13 13:19:01.704361	2023-10-13 13:19:01.704361	ec5f2969	\N	\N	\N	\N	\N	\N	\N	\N
18	b5f70925	Многофункциональное устройство (МФУ) Pantum M6800FDW	\N	457060	2021-04-27 13:19:01.382608	0	1101340019	2023-10-13 13:19:01.724022	2023-10-13 13:19:01.724022	b5f70925	\N	\N	\N	\N	\N	\N	\N	\N
19	f2ec4d59	Многофункциональное устройство (МФУ) Pantum M6800FDW	\N	547086	2023-06-19 13:19:01.38274	0	1101340018	2023-10-13 13:19:01.739655	2023-10-13 13:19:01.739655	f2ec4d59	\N	\N	\N	\N	\N	\N	\N	\N
20	ea0e6591	Сканер Avision AD130	\N	771651	2022-06-13 13:19:01.382872	1	1101340017	2023-10-13 13:19:01.755654	2023-10-13 13:19:01.755654	ea0e6591	\N	\N	\N	\N	\N	\N	\N	\N
21	21cdc1a6	Сканер Avision AD130	\N	992068	2022-11-22 13:19:01.383045	1	1101340016	2023-10-13 13:19:01.771511	2023-10-13 13:19:01.771511	21cdc1a6	\N	\N	\N	\N	\N	\N	\N	\N
22	92306ccf	МФУ KYOCERA ECOSYS M6230cidn	\N	33938	2021-06-15 13:19:01.383179	2	1101340012	2023-10-13 13:19:01.787426	2023-10-13 13:19:01.787426	92306ccf	\N	\N	\N	\N	\N	\N	\N	\N
23	cb5c9e10	МФУ KYOCERA ECOSYS M6230cidn	\N	776534	2021-07-23 13:19:01.383313	1	1101340011	2023-10-13 13:19:01.807726	2023-10-13 13:19:01.807726	cb5c9e10	\N	\N	\N	\N	\N	\N	\N	\N
24	1f4bd454	МФУ KYOCERA ECOSYS M6230cidn	\N	184701	2021-09-02 13:19:01.383446	0	1101340010	2023-10-13 13:19:01.828064	2023-10-13 13:19:01.828064	1f4bd454	\N	\N	\N	\N	\N	\N	\N	\N
26	0fdea6e4	Моноблок Asus V241FFK	\N	199722	2021-01-09 13:19:01.38374	1	1101340008	2023-10-13 13:19:01.868608	2023-10-13 13:19:01.868608	0fdea6e4	\N	\N	\N	\N	\N	\N	\N	\N
27	a62a36fe	Веб-камера Logitech HD Conference Cam BCC950	\N	654798	2021-09-03 13:19:01.383874	2	1101340007	2023-10-13 13:19:01.912255	2023-10-13 13:19:01.912255	a62a36fe	\N	\N	\N	\N	\N	\N	\N	\N
28	6d62547b	Моноблок HP ProOne 440 G5 23.8	\N	689140	2023-07-05 13:19:01.384007	1	1101340006	2023-10-13 13:19:01.928419	2023-10-13 13:19:01.928419	6d62547b	\N	\N	\N	\N	\N	\N	\N	\N
29	da3be71a	Планшет Samsung Galaxy Tab S6(SM-T865NZAASER)	\N	407045	2023-09-18 13:19:01.38414	0	1101340005	2023-10-13 13:19:01.949504	2023-10-13 13:19:01.949504	da3be71a	\N	\N	\N	\N	\N	\N	\N	\N
30	b30c64fd	Источник бесперебойного питания EATON 9SX5KIRT	\N	346704	2022-09-18 13:19:01.384273	1	1101340002	2023-10-13 13:19:01.967627	2023-10-13 13:19:01.967627	b30c64fd	\N	\N	\N	\N	\N	\N	\N	\N
31	80049eae	Источник бесперебойного питания EATON 9SX5KIRT	\N	567749	2022-09-29 13:19:01.384435	0	1101340001	2023-10-13 13:19:01.987408	2023-10-13 13:19:01.987408	80049eae	\N	\N	\N	\N	\N	\N	\N	\N
32	a50feb1d	Системный блок Intel Xeon E5-4655 v3	\N	540051	2021-07-03 13:19:01.384588	0	1101340049	2023-10-13 13:19:02.012544	2023-10-13 13:19:02.012544	a50feb1d	\N	\N	\N	\N	\N	\N	\N	\N
33	b82b617f	Системный блок Intel Xeon E5-4655 v3	\N	310066	2023-08-09 13:19:01.384723	2	1101340050	2023-10-13 13:19:02.026973	2023-10-13 13:19:02.026973	b82b617f	\N	\N	\N	\N	\N	\N	\N	\N
34	9dddd04d	Системный блок Intel Xeon E5-4655 v3	\N	396840	2022-05-13 13:19:01.384856	2	1101340034	2023-10-13 13:19:02.043159	2023-10-13 13:19:02.043159	9dddd04d	\N	\N	\N	\N	\N	\N	\N	\N
35	2f7725a5	Системный блок Intel Xeon E5-4655 v3	\N	428970	2020-12-28 13:19:01.38499	1	1101340035	2023-10-13 13:19:02.062932	2023-10-13 13:19:02.062932	2f7725a5	\N	\N	\N	\N	\N	\N	\N	\N
36	d2a17d2d	Системный блок Intel Xeon E5-4655 v3	\N	594021	2021-12-27 13:19:01.385165	0	1101340036	2023-10-13 13:19:02.082763	2023-10-13 13:19:02.082763	d2a17d2d	\N	\N	\N	\N	\N	\N	\N	\N
37	5695ff52	Системный блок Intel Xeon E5-4655 v3	\N	565852	2021-04-18 13:19:01.3853	2	1101340037	2023-10-13 13:19:02.10311	2023-10-13 13:19:02.10311	5695ff52	\N	\N	\N	\N	\N	\N	\N	\N
38	41f16499	Системный блок Intel Xeon E5-4655 v3	\N	297468	2023-02-23 13:19:01.385433	1	1101340038	2023-10-13 13:19:02.127024	2023-10-13 13:19:02.127024	41f16499	\N	\N	\N	\N	\N	\N	\N	\N
39	6c361a7a	Системный блок Intel Xeon E5-4655 v3	\N	94738	2021-06-11 13:19:01.385565	0	1101340039	2023-10-13 13:19:02.155074	2023-10-13 13:19:02.155074	6c361a7a	\N	\N	\N	\N	\N	\N	\N	\N
40	4d4c2700	Системный блок Intel Xeon E5-4655 v3	\N	907749	2021-04-27 13:19:01.385698	1	1101340040	2023-10-13 13:19:02.174555	2023-10-13 13:19:02.174555	4d4c2700	\N	\N	\N	\N	\N	\N	\N	\N
41	dde97eef	Системный блок Intel Xeon E5-4655 v3	\N	950984	2022-01-05 13:19:01.385877	0	1101340041	2023-10-13 13:19:02.194549	2023-10-13 13:19:02.194549	dde97eef	\N	\N	\N	\N	\N	\N	\N	\N
42	725c325f	Системный блок Intel Xeon E5-4655 v3	\N	887935	2021-09-15 13:19:01.386011	2	1101340042	2023-10-13 13:19:02.210665	2023-10-13 13:19:02.210665	725c325f	\N	\N	\N	\N	\N	\N	\N	\N
43	0a2073e2	Системный блок Intel Xeon E5-4655 v3	\N	276961	2021-12-01 13:19:01.386139	1	1101340043	2023-10-13 13:19:02.227666	2023-10-13 13:19:02.227666	0a2073e2	\N	\N	\N	\N	\N	\N	\N	\N
44	c1ab5aab	Системный блок Intel Xeon E5-4655 v3	\N	331524	2021-04-25 13:19:01.386267	0	1101340044	2023-10-13 13:19:02.246697	2023-10-13 13:19:02.246697	c1ab5aab	\N	\N	\N	\N	\N	\N	\N	\N
45	b3e19968	Системный блок Intel Xeon E5-4655 v3	\N	400476	2022-05-18 13:19:01.386395	1	1101340045	2023-10-13 13:19:02.270728	2023-10-13 13:19:02.270728	b3e19968	\N	\N	\N	\N	\N	\N	\N	\N
46	3952c96d	Системный блок Intel Xeon E5-4655 v3	\N	132087	2022-04-29 13:19:01.38656	0	1101340051	2023-10-13 13:19:02.290864	2023-10-13 13:19:02.290864	3952c96d	\N	\N	\N	\N	\N	\N	\N	\N
47	70ce14ee	Системный блок Intel Xeon E5-4655 v3	\N	774418	2023-03-18 13:19:01.38669	1	1101340052	2023-10-13 13:19:02.310361	2023-10-13 13:19:02.310361	70ce14ee	\N	\N	\N	\N	\N	\N	\N	\N
25	bb0f96de	Планшетный компьютер Samsung Galaxy Tab S5e (2019)		193265	2023-06-12 13:19:01	1	1101340009	2023-10-13 13:19:01.84792	2023-10-30 10:24:02.194733	bb0f96de	\N	\N	\N	\N	\N	\N	\N	\N
4	8d0e3ddb	Проектор Optima ZU506Te		82380	2022-08-01 13:19:01	0	1101340033	2023-10-13 13:19:01.486463	2023-10-19 15:03:18.672743	8d0e3ddb	\N	\N	\N	\N	\N	\N	\N	\N
2	97897061	Системный блок Intel Xeon E5-4655 v3	\N	861958	2023-07-22 13:19:01.380432	1	1101340047	2023-10-13 13:19:01.459043	2023-10-18 13:49:01.198076	97897061	\N	\N	\N	\N	\N	\N	\N	\N
10	b74377c8	Коммутатор Huawei S6730-H28Y4C	\N	76074	2023-06-25 13:19:01.381527	0	1101340027	2023-10-13 13:19:01.58213	2023-10-30 10:24:56.072502	b74377c8	\N	\N	\N	\N	\N	\N	\N	\N
11	35142f6d	Коммутатор Huawei S6730-H28Y4C	\N	837742	2021-12-16 13:19:01.381664	1	1101340026	2023-10-13 13:19:01.598605	2023-10-30 10:24:39.139005	35142f6d	\N	\N	\N	\N	\N	\N	\N	\N
48	a8270865	Системный блок Intel Xeon E5-4655 v3	\N	930231	2021-08-09 13:19:01.386825	1	1101340063	2023-10-13 13:19:02.326172	2023-10-13 13:19:02.326172	a8270865	\N	\N	\N	\N	\N	\N	\N	\N
49	d0890c8e	Системный блок Intel Xeon E5-4655 v3	\N	145871	2023-09-18 13:19:01.386957	2	1101340064	2023-10-13 13:19:02.342167	2023-10-13 13:19:02.342167	d0890c8e	\N	\N	\N	\N	\N	\N	\N	\N
50	38991a05	Системный блок Intel Xeon E5-4655 v3	\N	957417	2021-03-20 13:19:01.387084	0	1101340065	2023-10-13 13:19:02.357867	2023-10-13 13:19:02.357867	38991a05	\N	\N	\N	\N	\N	\N	\N	\N
51	5cb94615	Системный блок Intel Xeon E5-4655 v3		848112	2022-02-27 13:19:01	0	1101340066	2023-10-13 13:19:02.373675	2023-10-30 10:27:01.202786	5cb94615	\N	\N	\N	\N	\N	\N	\N	\N
57	648f7b1c	МФУ KYOCERA ECOSYS M2060idw		\N	\N	0	1101340070	2023-10-18 14:05:17.29342	2023-10-30 10:27:24.25269	648f7b1c	\N	\N	\N	\N	\N	\N	\N	\N
56	b1e14901	МФУ KYOCERA ECOSYS M2060idw		\N	\N	0	1101340069	2023-10-18 14:05:00.640473	2023-10-30 10:27:30.737351	b1e14901	\N	\N	\N	\N	\N	\N	\N	\N
55	78be145b	МФУ KYOCERA ECOSYS M2060idw		\N	\N	0	1101340068	2023-10-18 14:04:31.248623	2023-10-30 10:27:37.189739	78be145b	\N	\N	\N	\N	\N	\N	\N	\N
54	3fbfcbae	Сервисный маршрутизатор Eltex ESR-21		\N	\N	0	1101340067	2023-10-18 14:03:06.918899	2023-10-30 10:27:48.163788	3fbfcbae	\N	\N	\N	\N	\N	\N	\N	\N
58	989482a4	Сервер Shvacher		\N	2022-08-17 00:00:00	0	1101340072	2023-10-18 14:05:44.212171	2023-10-30 10:30:02.409193	989482a4	\N	\N	\N	\N	\N	\N	\N	\N
1	2ae69799	Системный блок Intel Xeon E5-4655 v3	\N	524286	2021-05-07 13:19:01.376785	2	1101340046	2023-10-13 13:19:01.423733	2023-10-18 14:17:14.124578	2ae69799	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Name: assets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mike
--

SELECT pg_catalog.setval('public.assets_id_seq', 59, true);


--
-- Data for Name: friendly_id_slugs; Type: TABLE DATA; Schema: public; Owner: mike
--

COPY public.friendly_id_slugs (id, slug, sluggable_id, sluggable_type, scope, created_at) FROM stdin;
\.


--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mike
--

SELECT pg_catalog.setval('public.friendly_id_slugs_id_seq', 1, false);


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: mike
--

COPY public.locations (id, code, name, created_at, updated_at) FROM stdin;
\.


--
-- Name: locations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mike
--

SELECT pg_catalog.setval('public.locations_id_seq', 1, true);


--
-- Data for Name: mols; Type: TABLE DATA; Schema: public; Owner: mike
--

COPY public.mols (id, code, name, created_at, updated_at) FROM stdin;
\.


--
-- Name: mols_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mike
--

SELECT pg_catalog.setval('public.mols_id_seq', 4, true);


--
-- Data for Name: organizations; Type: TABLE DATA; Schema: public; Owner: mike
--

COPY public.organizations (id, code, name, created_at, updated_at) FROM stdin;
\.


--
-- Name: organizations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mike
--

SELECT pg_catalog.setval('public.organizations_id_seq', 1, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: mike
--

COPY public.schema_migrations (version) FROM stdin;
20211209144728
20231011132729
20231012091644
20231012095532
20231012095646
20231020063451
20231031140657
20231031140810
20231031140823
20231031140851
20231031141105
\.


--
-- Name: accounting_items_pkey; Type: CONSTRAINT; Schema: public; Owner: mike
--

ALTER TABLE ONLY public.accounting_items
    ADD CONSTRAINT accounting_items_pkey PRIMARY KEY (id);


--
-- Name: accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: mike
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: mike
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: mike
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: active_storage_variant_records_pkey; Type: CONSTRAINT; Schema: public; Owner: mike
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT active_storage_variant_records_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: mike
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: assets_pkey; Type: CONSTRAINT; Schema: public; Owner: mike
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_pkey PRIMARY KEY (id);


--
-- Name: friendly_id_slugs_pkey; Type: CONSTRAINT; Schema: public; Owner: mike
--

ALTER TABLE ONLY public.friendly_id_slugs
    ADD CONSTRAINT friendly_id_slugs_pkey PRIMARY KEY (id);


--
-- Name: locations_pkey; Type: CONSTRAINT; Schema: public; Owner: mike
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: mols_pkey; Type: CONSTRAINT; Schema: public; Owner: mike
--

ALTER TABLE ONLY public.mols
    ADD CONSTRAINT mols_pkey PRIMARY KEY (id);


--
-- Name: organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: mike
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: mike
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: index_accounts_on_code; Type: INDEX; Schema: public; Owner: mike
--

CREATE UNIQUE INDEX index_accounts_on_code ON public.accounts USING btree (code);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: mike
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: mike
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: mike
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_active_storage_variant_records_uniqueness; Type: INDEX; Schema: public; Owner: mike
--

CREATE UNIQUE INDEX index_active_storage_variant_records_uniqueness ON public.active_storage_variant_records USING btree (blob_id, variation_digest);


--
-- Name: index_assets_on_account_id; Type: INDEX; Schema: public; Owner: mike
--

CREATE INDEX index_assets_on_account_id ON public.assets USING btree (account_id);


--
-- Name: index_assets_on_location_id; Type: INDEX; Schema: public; Owner: mike
--

CREATE INDEX index_assets_on_location_id ON public.assets USING btree (location_id);


--
-- Name: index_assets_on_mol_id; Type: INDEX; Schema: public; Owner: mike
--

CREATE INDEX index_assets_on_mol_id ON public.assets USING btree (mol_id);


--
-- Name: index_assets_on_organization_id; Type: INDEX; Schema: public; Owner: mike
--

CREATE INDEX index_assets_on_organization_id ON public.assets USING btree (organization_id);


--
-- Name: index_assets_on_slug; Type: INDEX; Schema: public; Owner: mike
--

CREATE UNIQUE INDEX index_assets_on_slug ON public.assets USING btree (slug);


--
-- Name: index_assets_on_uid; Type: INDEX; Schema: public; Owner: mike
--

CREATE UNIQUE INDEX index_assets_on_uid ON public.assets USING btree (uid);


--
-- Name: index_friendly_id_slugs_on_slug_and_sluggable_type; Type: INDEX; Schema: public; Owner: mike
--

CREATE INDEX index_friendly_id_slugs_on_slug_and_sluggable_type ON public.friendly_id_slugs USING btree (slug, sluggable_type);


--
-- Name: index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope; Type: INDEX; Schema: public; Owner: mike
--

CREATE UNIQUE INDEX index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope ON public.friendly_id_slugs USING btree (slug, sluggable_type, scope);


--
-- Name: index_friendly_id_slugs_on_sluggable_type_and_sluggable_id; Type: INDEX; Schema: public; Owner: mike
--

CREATE INDEX index_friendly_id_slugs_on_sluggable_type_and_sluggable_id ON public.friendly_id_slugs USING btree (sluggable_type, sluggable_id);


--
-- Name: index_locations_on_code; Type: INDEX; Schema: public; Owner: mike
--

CREATE UNIQUE INDEX index_locations_on_code ON public.locations USING btree (code);


--
-- Name: index_mols_on_code; Type: INDEX; Schema: public; Owner: mike
--

CREATE UNIQUE INDEX index_mols_on_code ON public.mols USING btree (code);


--
-- Name: index_organizations_on_code; Type: INDEX; Schema: public; Owner: mike
--

CREATE UNIQUE INDEX index_organizations_on_code ON public.organizations USING btree (code);


--
-- Name: fk_rails_428b9c4193; Type: FK CONSTRAINT; Schema: public; Owner: mike
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT fk_rails_428b9c4193 FOREIGN KEY (mol_id) REFERENCES public.mols(id);


--
-- Name: fk_rails_993965df05; Type: FK CONSTRAINT; Schema: public; Owner: mike
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT fk_rails_993965df05 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: fk_rails_c3b3935057; Type: FK CONSTRAINT; Schema: public; Owner: mike
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_c3b3935057 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: fk_rails_c9c5a2aacc; Type: FK CONSTRAINT; Schema: public; Owner: mike
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT fk_rails_c9c5a2aacc FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: fk_rails_defd9433a8; Type: FK CONSTRAINT; Schema: public; Owner: mike
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT fk_rails_defd9433a8 FOREIGN KEY (organization_id) REFERENCES public.organizations(id);


--
-- Name: fk_rails_eade040b42; Type: FK CONSTRAINT; Schema: public; Owner: mike
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT fk_rails_eade040b42 FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


--
-- PostgreSQL database dump
--

-- Dumped from database version 14.9 (Ubuntu 14.9-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.9 (Ubuntu 14.9-0ubuntu0.22.04.1)

-- Started on 2023-09-12 22:21:50 MSK

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 16386)
-- Name: wb_scheme; Type: SCHEMA; Schema: -; Owner: polinashirinskaya
--

CREATE SCHEMA wb_scheme;


ALTER SCHEMA wb_scheme OWNER TO polinashirinskaya;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 24710)
-- Name: cache; Type: TABLE; Schema: public; Owner: polinashirinskaya
--

CREATE TABLE public.cache (
    id integer NOT NULL,
    app_key character varying(255) NOT NULL,
    order_uid character varying(255) NOT NULL
);


ALTER TABLE public.cache OWNER TO polinashirinskaya;

--
-- TOC entry 218 (class 1259 OID 24709)
-- Name: cache_id_seq; Type: SEQUENCE; Schema: public; Owner: polinashirinskaya
--

CREATE SEQUENCE public.cache_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cache_id_seq OWNER TO polinashirinskaya;

--
-- TOC entry 3418 (class 0 OID 0)
-- Dependencies: 218
-- Name: cache_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: polinashirinskaya
--

ALTER SEQUENCE public.cache_id_seq OWNED BY public.cache.id;


--
-- TOC entry 221 (class 1259 OID 24719)
-- Name: cache; Type: TABLE; Schema: wb_scheme; Owner: polinashirinskaya
--

CREATE TABLE wb_scheme.cache (
    id integer NOT NULL,
    app_key character varying(255) NOT NULL,
    order_uid character varying(255) NOT NULL
);


ALTER TABLE wb_scheme.cache OWNER TO polinashirinskaya;

--
-- TOC entry 220 (class 1259 OID 24718)
-- Name: cache_id_seq; Type: SEQUENCE; Schema: wb_scheme; Owner: polinashirinskaya
--

CREATE SEQUENCE wb_scheme.cache_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE wb_scheme.cache_id_seq OWNER TO polinashirinskaya;

--
-- TOC entry 3419 (class 0 OID 0)
-- Dependencies: 220
-- Name: cache_id_seq; Type: SEQUENCE OWNED BY; Schema: wb_scheme; Owner: polinashirinskaya
--

ALTER SEQUENCE wb_scheme.cache_id_seq OWNED BY wb_scheme.cache.id;


--
-- TOC entry 213 (class 1259 OID 24647)
-- Name: delivery; Type: TABLE; Schema: wb_scheme; Owner: polinashirinskaya
--

CREATE TABLE wb_scheme.delivery (
    id bigint NOT NULL,
    name text NOT NULL,
    phone text NOT NULL,
    zip integer NOT NULL,
    city text NOT NULL,
    address text NOT NULL,
    region text NOT NULL,
    email text NOT NULL
);


ALTER TABLE wb_scheme.delivery OWNER TO polinashirinskaya;

--
-- TOC entry 217 (class 1259 OID 24684)
-- Name: delivery_id_seq; Type: SEQUENCE; Schema: wb_scheme; Owner: polinashirinskaya
--

CREATE SEQUENCE wb_scheme.delivery_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE wb_scheme.delivery_id_seq OWNER TO polinashirinskaya;

--
-- TOC entry 3420 (class 0 OID 0)
-- Dependencies: 217
-- Name: delivery_id_seq; Type: SEQUENCE OWNED BY; Schema: wb_scheme; Owner: polinashirinskaya
--

ALTER SEQUENCE wb_scheme.delivery_id_seq OWNED BY wb_scheme.delivery.id;


--
-- TOC entry 211 (class 1259 OID 24641)
-- Name: items; Type: TABLE; Schema: wb_scheme; Owner: polinashirinskaya
--

CREATE TABLE wb_scheme.items (
    item_id integer DEFAULT nextval('wb_scheme.delivery_id_seq'::regclass) NOT NULL,
    chrt_id integer NOT NULL,
    track_number text NOT NULL,
    price integer NOT NULL,
    rid text NOT NULL,
    name text NOT NULL,
    sale integer NOT NULL,
    size integer NOT NULL,
    total_price integer NOT NULL,
    nm_id integer NOT NULL,
    brand text NOT NULL,
    status integer NOT NULL
);


ALTER TABLE wb_scheme.items OWNER TO polinashirinskaya;

--
-- TOC entry 212 (class 1259 OID 24644)
-- Name: order_items; Type: TABLE; Schema: wb_scheme; Owner: polinashirinskaya
--

CREATE TABLE wb_scheme.order_items (
    id bigint NOT NULL,
    order_uid text NOT NULL,
    item_id integer NOT NULL
);


ALTER TABLE wb_scheme.order_items OWNER TO polinashirinskaya;

--
-- TOC entry 215 (class 1259 OID 24655)
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: wb_scheme; Owner: polinashirinskaya
--

CREATE SEQUENCE wb_scheme.order_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE wb_scheme.order_items_id_seq OWNER TO polinashirinskaya;

--
-- TOC entry 3421 (class 0 OID 0)
-- Dependencies: 215
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: wb_scheme; Owner: polinashirinskaya
--

ALTER SEQUENCE wb_scheme.order_items_id_seq OWNED BY wb_scheme.order_items.id;


--
-- TOC entry 210 (class 1259 OID 24624)
-- Name: orders; Type: TABLE; Schema: wb_scheme; Owner: polinashirinskaya
--

CREATE TABLE wb_scheme.orders (
    order_uid text NOT NULL,
    payment_id integer NOT NULL,
    delivery_id integer NOT NULL,
    track_number text NOT NULL,
    entry text NOT NULL,
    locale text NOT NULL,
    internal_signature text NOT NULL,
    delivery_service text NOT NULL,
    shardkey integer NOT NULL,
    sm_id integer NOT NULL,
    oof_shard integer NOT NULL,
    customer_id integer NOT NULL,
    date_created text NOT NULL
);


ALTER TABLE wb_scheme.orders OWNER TO polinashirinskaya;

--
-- TOC entry 214 (class 1259 OID 24650)
-- Name: payment; Type: TABLE; Schema: wb_scheme; Owner: polinashirinskaya
--

CREATE TABLE wb_scheme.payment (
    id bigint NOT NULL,
    transaction text NOT NULL,
    request_id text,
    currency text NOT NULL,
    provider text NOT NULL,
    amount integer NOT NULL,
    payment_dt integer NOT NULL,
    bank text NOT NULL,
    delivery_cost integer NOT NULL,
    goods_total integer NOT NULL,
    custom_fee integer NOT NULL
);


ALTER TABLE wb_scheme.payment OWNER TO polinashirinskaya;

--
-- TOC entry 216 (class 1259 OID 24676)
-- Name: payment_id_seq; Type: SEQUENCE; Schema: wb_scheme; Owner: polinashirinskaya
--

CREATE SEQUENCE wb_scheme.payment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE wb_scheme.payment_id_seq OWNER TO polinashirinskaya;

--
-- TOC entry 3422 (class 0 OID 0)
-- Dependencies: 216
-- Name: payment_id_seq; Type: SEQUENCE OWNED BY; Schema: wb_scheme; Owner: polinashirinskaya
--

ALTER SEQUENCE wb_scheme.payment_id_seq OWNED BY wb_scheme.payment.id;


--
-- TOC entry 3242 (class 2604 OID 24713)
-- Name: cache id; Type: DEFAULT; Schema: public; Owner: polinashirinskaya
--

ALTER TABLE ONLY public.cache ALTER COLUMN id SET DEFAULT nextval('public.cache_id_seq'::regclass);


--
-- TOC entry 3243 (class 2604 OID 24722)
-- Name: cache id; Type: DEFAULT; Schema: wb_scheme; Owner: polinashirinskaya
--

ALTER TABLE ONLY wb_scheme.cache ALTER COLUMN id SET DEFAULT nextval('wb_scheme.cache_id_seq'::regclass);


--
-- TOC entry 3240 (class 2604 OID 24685)
-- Name: delivery id; Type: DEFAULT; Schema: wb_scheme; Owner: polinashirinskaya
--

ALTER TABLE ONLY wb_scheme.delivery ALTER COLUMN id SET DEFAULT nextval('wb_scheme.delivery_id_seq'::regclass);


--
-- TOC entry 3239 (class 2604 OID 24656)
-- Name: order_items id; Type: DEFAULT; Schema: wb_scheme; Owner: polinashirinskaya
--

ALTER TABLE ONLY wb_scheme.order_items ALTER COLUMN id SET DEFAULT nextval('wb_scheme.order_items_id_seq'::regclass);


--
-- TOC entry 3241 (class 2604 OID 24677)
-- Name: payment id; Type: DEFAULT; Schema: wb_scheme; Owner: polinashirinskaya
--

ALTER TABLE ONLY wb_scheme.payment ALTER COLUMN id SET DEFAULT nextval('wb_scheme.payment_id_seq'::regclass);


--
-- TOC entry 3410 (class 0 OID 24710)
-- Dependencies: 219
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: polinashirinskaya
--

COPY public.cache (id, app_key, order_uid) FROM stdin;
\.


--
-- TOC entry 3412 (class 0 OID 24719)
-- Dependencies: 221
-- Data for Name: cache; Type: TABLE DATA; Schema: wb_scheme; Owner: polinashirinskaya
--

COPY wb_scheme.cache (id, app_key, order_uid) FROM stdin;
1	WB-1	a2c9e9d9-1a33-4eff-8a7f-b843d2c9e4ef
\.


--
-- TOC entry 3404 (class 0 OID 24647)
-- Dependencies: 213
-- Data for Name: delivery; Type: TABLE DATA; Schema: wb_scheme; Owner: polinashirinskaya
--

COPY wb_scheme.delivery (id, name, phone, zip, city, address, region, email) FROM stdin;
21	Roderick	68-270-706-7087	97494262	Lewisview	31 Lemke Village Apt. 966	Senegal	andrew.hane@hotmail.com
23	Jaylen	70-739-911-3806	37213297	Lake Jacklyntown	88567 Kuphal Port Apt. 435	Turkey	imogen.casper@protonmail.com
\.


--
-- TOC entry 3402 (class 0 OID 24641)
-- Dependencies: 211
-- Data for Name: items; Type: TABLE DATA; Schema: wb_scheme; Owner: polinashirinskaya
--

COPY wb_scheme.items (item_id, chrt_id, track_number, price, rid, name, sale, size, total_price, nm_id, brand, status) FROM stdin;
22	7073717	ES4353184776673534325667	2598	AT374863717717722646	Handcrafted Plastic Table	89	5	7472	86172	Christian Braun	472
24	7732894	PT47763648375215362676517	5275	FI3121484161174156	Oriental Fresh Car	23	0	957	99364	Nathan Kelly	550
\.


--
-- TOC entry 3403 (class 0 OID 24644)
-- Dependencies: 212
-- Data for Name: order_items; Type: TABLE DATA; Schema: wb_scheme; Owner: polinashirinskaya
--

COPY wb_scheme.order_items (id, order_uid, item_id) FROM stdin;
1	a2c9e9d9-1a33-4eff-8a7f-b843d2c9e4ef	22
2	bd42b8d9-6f96-4d81-bd9d-e77105b01f09	24
\.


--
-- TOC entry 3401 (class 0 OID 24624)
-- Dependencies: 210
-- Data for Name: orders; Type: TABLE DATA; Schema: wb_scheme; Owner: polinashirinskaya
--

COPY wb_scheme.orders (order_uid, payment_id, delivery_id, track_number, entry, locale, internal_signature, delivery_service, shardkey, sm_id, oof_shard, customer_id, date_created) FROM stdin;
a2c9e9d9-1a33-4eff-8a7f-b843d2c9e4ef	15	21	WBVENIAM	WBILASSUMENDA	hr	aacefb53-7607-455c-964f-d8c92ddef611	Toby Brown	8	22	1	21	Sat Dec  3 12:08:05 MSK 2022
bd42b8d9-6f96-4d81-bd9d-e77105b01f09	16	23	WBDOLOR	WBILAD	yo	3c208a7e-4794-4d9b-be2d-6ab76478aa7e	Finn Leffler	2	98	10	91	Fri Jun  3 20:13:45 MSK 2016
\.


--
-- TOC entry 3405 (class 0 OID 24650)
-- Dependencies: 214
-- Data for Name: payment; Type: TABLE DATA; Schema: wb_scheme; Owner: polinashirinskaya
--

COPY wb_scheme.payment (id, transaction, request_id, currency, provider, amount, payment_dt, bank, delivery_cost, goods_total, custom_fee) FROM stdin;
15	{mxifmcgy	26610088	BBD	Isaac Doyle	3878	60950732	Summer Huel	1796	2711	2669
16	lcxtznnupr	25944436	SYP	Patrick Hayes	842	24585799	Oliver Stewart	763	9726	4257
\.


--
-- TOC entry 3423 (class 0 OID 0)
-- Dependencies: 218
-- Name: cache_id_seq; Type: SEQUENCE SET; Schema: public; Owner: polinashirinskaya
--

SELECT pg_catalog.setval('public.cache_id_seq', 1, false);


--
-- TOC entry 3424 (class 0 OID 0)
-- Dependencies: 220
-- Name: cache_id_seq; Type: SEQUENCE SET; Schema: wb_scheme; Owner: polinashirinskaya
--

SELECT pg_catalog.setval('wb_scheme.cache_id_seq', 1, true);


--
-- TOC entry 3425 (class 0 OID 0)
-- Dependencies: 217
-- Name: delivery_id_seq; Type: SEQUENCE SET; Schema: wb_scheme; Owner: polinashirinskaya
--

SELECT pg_catalog.setval('wb_scheme.delivery_id_seq', 24, true);


--
-- TOC entry 3426 (class 0 OID 0)
-- Dependencies: 215
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: wb_scheme; Owner: polinashirinskaya
--

SELECT pg_catalog.setval('wb_scheme.order_items_id_seq', 2, true);


--
-- TOC entry 3427 (class 0 OID 0)
-- Dependencies: 216
-- Name: payment_id_seq; Type: SEQUENCE SET; Schema: wb_scheme; Owner: polinashirinskaya
--

SELECT pg_catalog.setval('wb_scheme.payment_id_seq', 16, true);


--
-- TOC entry 3255 (class 2606 OID 24717)
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: polinashirinskaya
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (id);


--
-- TOC entry 3257 (class 2606 OID 24726)
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: wb_scheme; Owner: polinashirinskaya
--

ALTER TABLE ONLY wb_scheme.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (id);


--
-- TOC entry 3251 (class 2606 OID 24687)
-- Name: delivery delivery_pkey; Type: CONSTRAINT; Schema: wb_scheme; Owner: polinashirinskaya
--

ALTER TABLE ONLY wb_scheme.delivery
    ADD CONSTRAINT delivery_pkey PRIMARY KEY (id);


--
-- TOC entry 3247 (class 2606 OID 24654)
-- Name: items items_pkey; Type: CONSTRAINT; Schema: wb_scheme; Owner: polinashirinskaya
--

ALTER TABLE ONLY wb_scheme.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (item_id);


--
-- TOC entry 3249 (class 2606 OID 24658)
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: wb_scheme; Owner: polinashirinskaya
--

ALTER TABLE ONLY wb_scheme.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- TOC entry 3245 (class 2606 OID 24630)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: wb_scheme; Owner: polinashirinskaya
--

ALTER TABLE ONLY wb_scheme.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_uid);


--
-- TOC entry 3253 (class 2606 OID 24679)
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: wb_scheme; Owner: polinashirinskaya
--

ALTER TABLE ONLY wb_scheme.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (id);


--
-- TOC entry 3259 (class 2606 OID 24697)
-- Name: orders delivery_id; Type: FK CONSTRAINT; Schema: wb_scheme; Owner: polinashirinskaya
--

ALTER TABLE ONLY wb_scheme.orders
    ADD CONSTRAINT delivery_id FOREIGN KEY (delivery_id) REFERENCES wb_scheme.delivery(id) NOT VALID;


--
-- TOC entry 3261 (class 2606 OID 24671)
-- Name: order_items item_id; Type: FK CONSTRAINT; Schema: wb_scheme; Owner: polinashirinskaya
--

ALTER TABLE ONLY wb_scheme.order_items
    ADD CONSTRAINT item_id FOREIGN KEY (item_id) REFERENCES wb_scheme.items(item_id) NOT VALID;


--
-- TOC entry 3260 (class 2606 OID 24666)
-- Name: order_items order_uid; Type: FK CONSTRAINT; Schema: wb_scheme; Owner: polinashirinskaya
--

ALTER TABLE ONLY wb_scheme.order_items
    ADD CONSTRAINT order_uid FOREIGN KEY (order_uid) REFERENCES wb_scheme.orders(order_uid) NOT VALID;


--
-- TOC entry 3258 (class 2606 OID 24692)
-- Name: orders payment_id; Type: FK CONSTRAINT; Schema: wb_scheme; Owner: polinashirinskaya
--

ALTER TABLE ONLY wb_scheme.orders
    ADD CONSTRAINT payment_id FOREIGN KEY (payment_id) REFERENCES wb_scheme.payment(id) NOT VALID;


-- Completed on 2023-09-12 22:21:50 MSK

--
-- PostgreSQL database dump complete
--



--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2 (Ubuntu 17.2-1.pgdg24.04+1)
-- Dumped by pg_dump version 17.2 (Ubuntu 17.2-1.pgdg22.04+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admins; Type: TABLE; Schema: public; Owner: new_sneaker_api
--

CREATE TABLE public.admins (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    remember_created_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    username character varying
);


ALTER TABLE public.admins OWNER TO new_sneaker_api;

--
-- Name: admins_id_seq; Type: SEQUENCE; Schema: public; Owner: new_sneaker_api
--

CREATE SEQUENCE public.admins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admins_id_seq OWNER TO new_sneaker_api;

--
-- Name: admins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: new_sneaker_api
--

ALTER SEQUENCE public.admins_id_seq OWNED BY public.admins.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: new_sneaker_api
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO new_sneaker_api;

--
-- Name: carts; Type: TABLE; Schema: public; Owner: new_sneaker_api
--

CREATE TABLE public.carts (
    id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.carts OWNER TO new_sneaker_api;

--
-- Name: carts_id_seq; Type: SEQUENCE; Schema: public; Owner: new_sneaker_api
--

CREATE SEQUENCE public.carts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.carts_id_seq OWNER TO new_sneaker_api;

--
-- Name: carts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: new_sneaker_api
--

ALTER SEQUENCE public.carts_id_seq OWNED BY public.carts.id;


--
-- Name: orderables; Type: TABLE; Schema: public; Owner: new_sneaker_api
--

CREATE TABLE public.orderables (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    cart_id bigint NOT NULL,
    quantity integer,
    image character varying,
    marketing_statement text,
    product_price numeric,
    product_discount numeric,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.orderables OWNER TO new_sneaker_api;

--
-- Name: orderables_id_seq; Type: SEQUENCE; Schema: public; Owner: new_sneaker_api
--

CREATE SEQUENCE public.orderables_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orderables_id_seq OWNER TO new_sneaker_api;

--
-- Name: orderables_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: new_sneaker_api
--

ALTER SEQUENCE public.orderables_id_seq OWNED BY public.orderables.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: new_sneaker_api
--

CREATE TABLE public.payments (
    id bigint NOT NULL,
    stripe_payment_id character varying,
    amount integer,
    status character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    user_id integer
);


ALTER TABLE public.payments OWNER TO new_sneaker_api;

--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: new_sneaker_api
--

CREATE SEQUENCE public.payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_id_seq OWNER TO new_sneaker_api;

--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: new_sneaker_api
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: new_sneaker_api
--

CREATE TABLE public.products (
    id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    name character varying,
    product_price numeric,
    product_discount numeric,
    marketing_statement text,
    stock integer DEFAULT 0
);


ALTER TABLE public.products OWNER TO new_sneaker_api;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: new_sneaker_api
--

CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO new_sneaker_api;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: new_sneaker_api
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: samples; Type: TABLE; Schema: public; Owner: new_sneaker_api
--

CREATE TABLE public.samples (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    image_data text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.samples OWNER TO new_sneaker_api;

--
-- Name: samples_id_seq; Type: SEQUENCE; Schema: public; Owner: new_sneaker_api
--

CREATE SEQUENCE public.samples_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.samples_id_seq OWNER TO new_sneaker_api;

--
-- Name: samples_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: new_sneaker_api
--

ALTER SEQUENCE public.samples_id_seq OWNED BY public.samples.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: new_sneaker_api
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO new_sneaker_api;

--
-- Name: users; Type: TABLE; Schema: public; Owner: new_sneaker_api
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    remember_created_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    username character varying
);


ALTER TABLE public.users OWNER TO new_sneaker_api;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: new_sneaker_api
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO new_sneaker_api;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: new_sneaker_api
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: admins id; Type: DEFAULT; Schema: public; Owner: new_sneaker_api
--

ALTER TABLE ONLY public.admins ALTER COLUMN id SET DEFAULT nextval('public.admins_id_seq'::regclass);


--
-- Name: carts id; Type: DEFAULT; Schema: public; Owner: new_sneaker_api
--

ALTER TABLE ONLY public.carts ALTER COLUMN id SET DEFAULT nextval('public.carts_id_seq'::regclass);


--
-- Name: orderables id; Type: DEFAULT; Schema: public; Owner: new_sneaker_api
--

ALTER TABLE ONLY public.orderables ALTER COLUMN id SET DEFAULT nextval('public.orderables_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: new_sneaker_api
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: new_sneaker_api
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: samples id; Type: DEFAULT; Schema: public; Owner: new_sneaker_api
--

ALTER TABLE ONLY public.samples ALTER COLUMN id SET DEFAULT nextval('public.samples_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: new_sneaker_api
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: admins; Type: TABLE DATA; Schema: public; Owner: new_sneaker_api
--

COPY public.admins (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, created_at, updated_at, username) FROM stdin;
1	johndoe@gmail.com	$2a$12$o8oCwSBdeKZGcdYjkFHCqu4RpYehuVWL.U3uPg2PhPaVVHdl88xIa	\N	\N	\N	2025-07-01 15:16:26.446712	2025-07-01 15:16:26.446712	johndoe
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: new_sneaker_api
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	production	2025-06-30 10:36:28.933726	2025-06-30 10:36:28.933726
\.


--
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: new_sneaker_api
--

COPY public.carts (id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: orderables; Type: TABLE DATA; Schema: public; Owner: new_sneaker_api
--

COPY public.orderables (id, product_id, cart_id, quantity, image, marketing_statement, product_price, product_discount, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: new_sneaker_api
--

COPY public.payments (id, stripe_payment_id, amount, status, created_at, updated_at, user_id) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: new_sneaker_api
--

COPY public.products (id, created_at, updated_at, name, product_price, product_discount, marketing_statement, stock) FROM stdin;
1	2025-07-01 15:17:07.776711	2025-07-01 15:17:07.776711	Nike	300.0	3.0	Best running shoes money can buy.	0
\.


--
-- Data for Name: samples; Type: TABLE DATA; Schema: public; Owner: new_sneaker_api
--

COPY public.samples (id, product_id, image_data, created_at, updated_at) FROM stdin;
1	1	{"id":"856a5086c81d0f4271d098ba0e0a3750.jpg","storage":"store","metadata":{"filename":"nike.jpg","size":33116,"mime_type":"image/jpeg","width":640,"height":427}}	2025-07-01 21:21:46.35224	2025-07-01 21:21:47.541707
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: new_sneaker_api
--

COPY public.schema_migrations (version) FROM stdin;
20230124160747
20230224012456
20230302205938
20230308184111
20230308184443
20230311213421
20230311213439
20230311215807
20230314144722
20241123160920
20241129065144
20241205104220
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: new_sneaker_api
--

COPY public.users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, created_at, updated_at, username) FROM stdin;
\.


--
-- Name: admins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: new_sneaker_api
--

SELECT pg_catalog.setval('public.admins_id_seq', 1, true);


--
-- Name: carts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: new_sneaker_api
--

SELECT pg_catalog.setval('public.carts_id_seq', 1, false);


--
-- Name: orderables_id_seq; Type: SEQUENCE SET; Schema: public; Owner: new_sneaker_api
--

SELECT pg_catalog.setval('public.orderables_id_seq', 1, false);


--
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: new_sneaker_api
--

SELECT pg_catalog.setval('public.payments_id_seq', 1, false);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: new_sneaker_api
--

SELECT pg_catalog.setval('public.products_id_seq', 1, true);


--
-- Name: samples_id_seq; Type: SEQUENCE SET; Schema: public; Owner: new_sneaker_api
--

SELECT pg_catalog.setval('public.samples_id_seq', 1, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: new_sneaker_api
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: admins admins_pkey; Type: CONSTRAINT; Schema: public; Owner: new_sneaker_api
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: new_sneaker_api
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: carts carts_pkey; Type: CONSTRAINT; Schema: public; Owner: new_sneaker_api
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);


--
-- Name: orderables orderables_pkey; Type: CONSTRAINT; Schema: public; Owner: new_sneaker_api
--

ALTER TABLE ONLY public.orderables
    ADD CONSTRAINT orderables_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: new_sneaker_api
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: new_sneaker_api
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: samples samples_pkey; Type: CONSTRAINT; Schema: public; Owner: new_sneaker_api
--

ALTER TABLE ONLY public.samples
    ADD CONSTRAINT samples_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: new_sneaker_api
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: new_sneaker_api
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_admins_on_email; Type: INDEX; Schema: public; Owner: new_sneaker_api
--

CREATE UNIQUE INDEX index_admins_on_email ON public.admins USING btree (email);


--
-- Name: index_admins_on_reset_password_token; Type: INDEX; Schema: public; Owner: new_sneaker_api
--

CREATE UNIQUE INDEX index_admins_on_reset_password_token ON public.admins USING btree (reset_password_token);


--
-- Name: index_orderables_on_cart_id; Type: INDEX; Schema: public; Owner: new_sneaker_api
--

CREATE INDEX index_orderables_on_cart_id ON public.orderables USING btree (cart_id);


--
-- Name: index_orderables_on_product_id; Type: INDEX; Schema: public; Owner: new_sneaker_api
--

CREATE INDEX index_orderables_on_product_id ON public.orderables USING btree (product_id);


--
-- Name: index_samples_on_product_id; Type: INDEX; Schema: public; Owner: new_sneaker_api
--

CREATE INDEX index_samples_on_product_id ON public.samples USING btree (product_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: new_sneaker_api
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: new_sneaker_api
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: orderables fk_rails_1ccd522baf; Type: FK CONSTRAINT; Schema: public; Owner: new_sneaker_api
--

ALTER TABLE ONLY public.orderables
    ADD CONSTRAINT fk_rails_1ccd522baf FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: samples fk_rails_228b1d69fd; Type: FK CONSTRAINT; Schema: public; Owner: new_sneaker_api
--

ALTER TABLE ONLY public.samples
    ADD CONSTRAINT fk_rails_228b1d69fd FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: orderables fk_rails_d9421de196; Type: FK CONSTRAINT; Schema: public; Owner: new_sneaker_api
--

ALTER TABLE ONLY public.orderables
    ADD CONSTRAINT fk_rails_d9421de196 FOREIGN KEY (cart_id) REFERENCES public.carts(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


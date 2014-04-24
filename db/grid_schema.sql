--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: wi_mn_d_ave_t_airs; Type: TABLE; Schema: public; Owner: uwex_agwx; Tablespace: 
--

CREATE TABLE wi_mn_d_ave_t_airs (
    id integer NOT NULL,
    "date" date,
    "timeStamp" time without time zone,
    latitude double precision,
    w980 double precision,
    w976 double precision,
    w972 double precision,
    w968 double precision,
    w964 double precision,
    w960 double precision,
    w956 double precision,
    w952 double precision,
    w948 double precision,
    w944 double precision,
    w940 double precision,
    w936 double precision,
    w932 double precision,
    w928 double precision,
    w924 double precision,
    w920 double precision,
    w916 double precision,
    w912 double precision,
    w908 double precision,
    w904 double precision,
    w900 double precision,
    w896 double precision,
    w892 double precision,
    w888 double precision,
    w884 double precision,
    w880 double precision,
    w876 double precision,
    w872 double precision,
    w868 double precision,
    w864 double precision,
    w860 double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.wi_mn_d_ave_t_airs OWNER TO uwex_agwx;

--
-- Name: wi_mn_d_ave_t_airs_id_seq; Type: SEQUENCE; Schema: public; Owner: uwex_agwx
--

CREATE SEQUENCE wi_mn_d_ave_t_airs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wi_mn_d_ave_t_airs_id_seq OWNER TO uwex_agwx;

--
-- Name: wi_mn_d_ave_t_airs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: uwex_agwx
--

ALTER SEQUENCE wi_mn_d_ave_t_airs_id_seq OWNED BY wi_mn_d_ave_t_airs.id;


--
-- Name: wi_mn_d_max_t_airs; Type: TABLE; Schema: public; Owner: uwex_agwx; Tablespace: 
--

CREATE TABLE wi_mn_d_max_t_airs (
    id integer NOT NULL,
    "date" date,
    "timeStamp" time without time zone,
    latitude double precision,
    w980 double precision,
    w976 double precision,
    w972 double precision,
    w968 double precision,
    w964 double precision,
    w960 double precision,
    w956 double precision,
    w952 double precision,
    w948 double precision,
    w944 double precision,
    w940 double precision,
    w936 double precision,
    w932 double precision,
    w928 double precision,
    w924 double precision,
    w920 double precision,
    w916 double precision,
    w912 double precision,
    w908 double precision,
    w904 double precision,
    w900 double precision,
    w896 double precision,
    w892 double precision,
    w888 double precision,
    w884 double precision,
    w880 double precision,
    w876 double precision,
    w872 double precision,
    w868 double precision,
    w864 double precision,
    w860 double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.wi_mn_d_max_t_airs OWNER TO uwex_agwx;

--
-- Name: wi_mn_d_max_t_airs_id_seq; Type: SEQUENCE; Schema: public; Owner: uwex_agwx
--

CREATE SEQUENCE wi_mn_d_max_t_airs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wi_mn_d_max_t_airs_id_seq OWNER TO uwex_agwx;

--
-- Name: wi_mn_d_max_t_airs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: uwex_agwx
--

ALTER SEQUENCE wi_mn_d_max_t_airs_id_seq OWNED BY wi_mn_d_max_t_airs.id;


--
-- Name: wi_mn_d_min_t_airs; Type: TABLE; Schema: public; Owner: uwex_agwx; Tablespace: 
--

CREATE TABLE wi_mn_d_min_t_airs (
    id integer NOT NULL,
    "date" date,
    "timeStamp" time without time zone,
    latitude double precision,
    w980 double precision,
    w976 double precision,
    w972 double precision,
    w968 double precision,
    w964 double precision,
    w960 double precision,
    w956 double precision,
    w952 double precision,
    w948 double precision,
    w944 double precision,
    w940 double precision,
    w936 double precision,
    w932 double precision,
    w928 double precision,
    w924 double precision,
    w920 double precision,
    w916 double precision,
    w912 double precision,
    w908 double precision,
    w904 double precision,
    w900 double precision,
    w896 double precision,
    w892 double precision,
    w888 double precision,
    w884 double precision,
    w880 double precision,
    w876 double precision,
    w872 double precision,
    w868 double precision,
    w864 double precision,
    w860 double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.wi_mn_d_min_t_airs OWNER TO uwex_agwx;

--
-- Name: wi_mn_d_min_t_airs_id_seq; Type: SEQUENCE; Schema: public; Owner: uwex_agwx
--

CREATE SEQUENCE wi_mn_d_min_t_airs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wi_mn_d_min_t_airs_id_seq OWNER TO uwex_agwx;

--
-- Name: wi_mn_d_min_t_airs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: uwex_agwx
--

ALTER SEQUENCE wi_mn_d_min_t_airs_id_seq OWNED BY wi_mn_d_min_t_airs.id;


--
-- Name: wi_mn_dets; Type: TABLE; Schema: public; Owner: uwex_agwx; Tablespace: 
--

CREATE TABLE wi_mn_dets (
    id integer NOT NULL,
    "date" date,
    "timeStamp" time without time zone,
    latitude double precision,
    w980 double precision,
    w976 double precision,
    w972 double precision,
    w968 double precision,
    w964 double precision,
    w960 double precision,
    w956 double precision,
    w952 double precision,
    w948 double precision,
    w944 double precision,
    w940 double precision,
    w936 double precision,
    w932 double precision,
    w928 double precision,
    w924 double precision,
    w920 double precision,
    w916 double precision,
    w912 double precision,
    w908 double precision,
    w904 double precision,
    w900 double precision,
    w896 double precision,
    w892 double precision,
    w888 double precision,
    w884 double precision,
    w880 double precision,
    w876 double precision,
    w872 double precision,
    w868 double precision,
    w864 double precision,
    w860 double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.wi_mn_dets OWNER TO uwex_agwx;

--
-- Name: wi_mn_dets_id_seq; Type: SEQUENCE; Schema: public; Owner: uwex_agwx
--

CREATE SEQUENCE wi_mn_dets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wi_mn_dets_id_seq OWNER TO uwex_agwx;

--
-- Name: wi_mn_dets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: uwex_agwx
--

ALTER SEQUENCE wi_mn_dets_id_seq OWNED BY wi_mn_dets.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: uwex_agwx
--

ALTER TABLE ONLY wi_mn_d_ave_t_airs ALTER COLUMN id SET DEFAULT nextval('wi_mn_d_ave_t_airs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: uwex_agwx
--

ALTER TABLE ONLY wi_mn_d_max_t_airs ALTER COLUMN id SET DEFAULT nextval('wi_mn_d_max_t_airs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: uwex_agwx
--

ALTER TABLE ONLY wi_mn_d_min_t_airs ALTER COLUMN id SET DEFAULT nextval('wi_mn_d_min_t_airs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: uwex_agwx
--

ALTER TABLE ONLY wi_mn_dets ALTER COLUMN id SET DEFAULT nextval('wi_mn_dets_id_seq'::regclass);


--
-- Name: wi_mn_d_ave_t_airs_pkey; Type: CONSTRAINT; Schema: public; Owner: uwex_agwx; Tablespace: 
--

ALTER TABLE ONLY wi_mn_d_ave_t_airs
    ADD CONSTRAINT wi_mn_d_ave_t_airs_pkey PRIMARY KEY (id);


--
-- Name: wi_mn_d_max_t_airs_pkey; Type: CONSTRAINT; Schema: public; Owner: uwex_agwx; Tablespace: 
--

ALTER TABLE ONLY wi_mn_d_max_t_airs
    ADD CONSTRAINT wi_mn_d_max_t_airs_pkey PRIMARY KEY (id);


--
-- Name: wi_mn_d_min_t_airs_pkey; Type: CONSTRAINT; Schema: public; Owner: uwex_agwx; Tablespace: 
--

ALTER TABLE ONLY wi_mn_d_min_t_airs
    ADD CONSTRAINT wi_mn_d_min_t_airs_pkey PRIMARY KEY (id);


--
-- Name: wi_mn_dets_pkey; Type: CONSTRAINT; Schema: public; Owner: uwex_agwx; Tablespace: 
--

ALTER TABLE ONLY wi_mn_dets
    ADD CONSTRAINT wi_mn_dets_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--


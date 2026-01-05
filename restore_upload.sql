--
-- PostgreSQL database dump
--

\restrict rMcDp6tGEgIwFByrwmxyt4am1gWwiDbZaYsYLifqQlKwhgVoGeePQxuhzFx9p7G

-- Dumped from database version 16.11 (Ubuntu 16.11-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.11 (Ubuntu 16.11-0ubuntu0.24.04.1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: jenkins_audit; Type: TABLE; Schema: public; Owner: jenkins_user
--

CREATE TABLE public.jenkins_audit (
    id integer NOT NULL,
    run_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    message text
);


ALTER TABLE public.jenkins_audit OWNER TO jenkins_user;

--
-- Name: jenkins_audit_id_seq; Type: SEQUENCE; Schema: public; Owner: jenkins_user
--

CREATE SEQUENCE public.jenkins_audit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jenkins_audit_id_seq OWNER TO jenkins_user;

--
-- Name: jenkins_audit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jenkins_user
--

ALTER SEQUENCE public.jenkins_audit_id_seq OWNED BY public.jenkins_audit.id;


--
-- Name: jenkins_audit id; Type: DEFAULT; Schema: public; Owner: jenkins_user
--

ALTER TABLE ONLY public.jenkins_audit ALTER COLUMN id SET DEFAULT nextval('public.jenkins_audit_id_seq'::regclass);


--
-- Data for Name: jenkins_audit; Type: TABLE DATA; Schema: public; Owner: jenkins_user
--

COPY public.jenkins_audit (id, run_date, message) FROM stdin;
1	2026-01-04 12:04:04.497737	Jenkins Pipeline Ran Successfully
2	2026-01-05 21:42:07.777927	Jenkins Pipeline Ran Successfully
3	2026-01-05 21:50:17.625462	Jenkins Pipeline Ran Successfully
\.


--
-- Name: jenkins_audit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jenkins_user
--

SELECT pg_catalog.setval('public.jenkins_audit_id_seq', 3, true);


--
-- Name: jenkins_audit jenkins_audit_pkey; Type: CONSTRAINT; Schema: public; Owner: jenkins_user
--

ALTER TABLE ONLY public.jenkins_audit
    ADD CONSTRAINT jenkins_audit_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

\unrestrict rMcDp6tGEgIwFByrwmxyt4am1gWwiDbZaYsYLifqQlKwhgVoGeePQxuhzFx9p7G


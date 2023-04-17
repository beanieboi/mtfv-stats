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
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: double_pairs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.double_pairs (
    id bigint NOT NULL,
    player_ids integer[]
);


--
-- Name: double_pairs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.double_pairs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: double_pairs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.double_pairs_id_seq OWNED BY public.double_pairs.id;


--
-- Name: double_stats; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.double_stats (
    id bigint NOT NULL,
    player_ids integer[] NOT NULL,
    league_id integer NOT NULL,
    overall_performance_index integer DEFAULT 0,
    overall_score integer DEFAULT 0,
    overall_score_against integer DEFAULT 0,
    overall_goals integer DEFAULT 0,
    overall_goals_against integer DEFAULT 0,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: double_stats_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.double_stats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: double_stats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.double_stats_id_seq OWNED BY public.double_stats.id;


--
-- Name: leagues; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.leagues (
    id bigint NOT NULL,
    season_id integer,
    name text NOT NULL,
    external_mtfv_id integer NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: leagues_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.leagues_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: leagues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.leagues_id_seq OWNED BY public.leagues.id;


--
-- Name: players; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.players (
    id bigint NOT NULL,
    name text NOT NULL,
    team_id integer,
    external_mtfv_id integer NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: lifetime_double_stats; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.lifetime_double_stats AS
 SELECT double_stats.player_ids,
    string_agg(concat(players.id, '---', players.name), '|||'::text) AS player_data,
    sum(double_stats.overall_performance_index) AS overall_performance_index,
    sum(double_stats.overall_score) AS overall_score,
    sum(double_stats.overall_score_against) AS overall_score_against,
    sum(double_stats.overall_goals) AS overall_goals,
    sum(double_stats.overall_goals_against) AS overall_goals_against
   FROM (public.double_stats
     LEFT JOIN public.players ON ((players.id = ANY (double_stats.player_ids))))
  GROUP BY double_stats.player_ids;


--
-- Name: player_stats; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.player_stats (
    id bigint NOT NULL,
    player_id integer NOT NULL,
    league_id integer NOT NULL,
    overall_performance_index integer DEFAULT 0,
    overall_score integer DEFAULT 0,
    overall_score_against integer DEFAULT 0,
    overall_goals integer DEFAULT 0,
    overall_goals_against integer DEFAULT 0,
    single_performance_index integer DEFAULT 0,
    single_score integer DEFAULT 0,
    single_score_against integer DEFAULT 0,
    single_goals integer DEFAULT 0,
    single_goals_against integer DEFAULT 0,
    double_performance_index integer DEFAULT 0,
    double_score integer DEFAULT 0,
    double_score_against integer DEFAULT 0,
    double_goals integer DEFAULT 0,
    double_goals_against integer DEFAULT 0,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: lifetime_player_stats; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.lifetime_player_stats AS
 SELECT player_stats.player_id,
    sum(player_stats.overall_performance_index) AS overall_performance_index,
    sum(player_stats.overall_score) AS overall_score,
    sum(player_stats.overall_score_against) AS overall_score_against,
    sum(player_stats.overall_goals) AS overall_goals,
    sum(player_stats.overall_goals_against) AS overall_goals_against,
    sum(player_stats.single_performance_index) AS single_performance_index,
    sum(player_stats.single_score) AS single_score,
    sum(player_stats.single_score_against) AS single_score_against,
    sum(player_stats.single_goals) AS single_goals,
    sum(player_stats.single_goals_against) AS single_goals_against,
    sum(player_stats.double_performance_index) AS double_performance_index,
    sum(player_stats.double_score) AS double_score,
    sum(player_stats.double_score_against) AS double_score_against,
    sum(player_stats.double_goals) AS double_goals,
    sum(player_stats.double_goals_against) AS double_goals_against
   FROM public.player_stats
  GROUP BY player_stats.player_id;


--
-- Name: matches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.matches (
    id bigint NOT NULL,
    home_team_id integer,
    away_team_id integer,
    played_at timestamp without time zone,
    league_id integer NOT NULL,
    external_mtfv_id integer NOT NULL,
    home_goals integer,
    away_goals integer,
    home_score integer,
    away_score integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: matches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.matches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: matches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.matches_id_seq OWNED BY public.matches.id;


--
-- Name: player_stats_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.player_stats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: player_stats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.player_stats_id_seq OWNED BY public.player_stats.id;


--
-- Name: players_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.players_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: players_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.players_id_seq OWNED BY public.players.id;


--
-- Name: results; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.results (
    id bigint NOT NULL,
    match_id integer NOT NULL,
    home_player_ids integer[] NOT NULL,
    away_player_ids integer[] NOT NULL,
    home_goals integer NOT NULL,
    away_goals integer NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: results_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.results_id_seq OWNED BY public.results.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: seasons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.seasons (
    id bigint NOT NULL,
    name character varying NOT NULL,
    teams integer[],
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: seasons_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.seasons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: seasons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.seasons_id_seq OWNED BY public.seasons.id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teams (
    id bigint NOT NULL,
    name text NOT NULL,
    league_id integer,
    external_mtfv_id integer NOT NULL,
    goals integer,
    goals_against integer,
    score integer,
    score_against integer,
    matches_won integer,
    matches_draw integer,
    matches_lost integer,
    points integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.teams_id_seq OWNED BY public.teams.id;


--
-- Name: double_pairs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.double_pairs ALTER COLUMN id SET DEFAULT nextval('public.double_pairs_id_seq'::regclass);


--
-- Name: double_stats id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.double_stats ALTER COLUMN id SET DEFAULT nextval('public.double_stats_id_seq'::regclass);


--
-- Name: leagues id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leagues ALTER COLUMN id SET DEFAULT nextval('public.leagues_id_seq'::regclass);


--
-- Name: matches id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matches ALTER COLUMN id SET DEFAULT nextval('public.matches_id_seq'::regclass);


--
-- Name: player_stats id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.player_stats ALTER COLUMN id SET DEFAULT nextval('public.player_stats_id_seq'::regclass);


--
-- Name: players id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.players ALTER COLUMN id SET DEFAULT nextval('public.players_id_seq'::regclass);


--
-- Name: results id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.results ALTER COLUMN id SET DEFAULT nextval('public.results_id_seq'::regclass);


--
-- Name: seasons id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seasons ALTER COLUMN id SET DEFAULT nextval('public.seasons_id_seq'::regclass);


--
-- Name: teams id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams ALTER COLUMN id SET DEFAULT nextval('public.teams_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: double_pairs double_pairs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.double_pairs
    ADD CONSTRAINT double_pairs_pkey PRIMARY KEY (id);


--
-- Name: double_stats double_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.double_stats
    ADD CONSTRAINT double_stats_pkey PRIMARY KEY (id);


--
-- Name: leagues leagues_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leagues
    ADD CONSTRAINT leagues_pkey PRIMARY KEY (id);


--
-- Name: matches matches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_pkey PRIMARY KEY (id);


--
-- Name: player_stats player_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.player_stats
    ADD CONSTRAINT player_stats_pkey PRIMARY KEY (id);


--
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (id);


--
-- Name: results results_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.results
    ADD CONSTRAINT results_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: seasons seasons_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seasons
    ADD CONSTRAINT seasons_pkey PRIMARY KEY (id);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: matches fk_rails_4d24712928; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT fk_rails_4d24712928 FOREIGN KEY (league_id) REFERENCES public.leagues(id) ON DELETE CASCADE;


--
-- Name: results fk_rails_ace205692e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.results
    ADD CONSTRAINT fk_rails_ace205692e FOREIGN KEY (match_id) REFERENCES public.matches(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20190408093151'),
('20190408093202'),
('20190408093206'),
('20190408093308'),
('20190408093312'),
('20190408093854'),
('20190411213202'),
('20190412093050'),
('20190412141436'),
('20190412142258'),
('20190415150107'),
('20230417052201');



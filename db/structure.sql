SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: courses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.courses (
    id bigint NOT NULL,
    name character varying,
    teacher_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: courses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.courses_id_seq OWNED BY public.courses.id;


--
-- Name: courses_students; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.courses_students (
    course_id bigint NOT NULL,
    student_id bigint NOT NULL
);


--
-- Name: notes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notes (
    id bigint NOT NULL,
    note numeric,
    test_id bigint,
    student_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT check_note CHECK (((note >= 1.0) AND (note <= 7.0)))
);


--
-- Name: students; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.students (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: tests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tests (
    id bigint NOT NULL,
    name character varying,
    course_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: notes_by_students; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.notes_by_students AS
 SELECT t.course_id,
    n.student_id,
    avg(n.note) AS average
   FROM ((public.notes n
     LEFT JOIN public.tests t ON ((t.id = n.test_id)))
     LEFT JOIN public.students s ON ((s.id = n.student_id)))
  GROUP BY t.course_id, n.student_id
  ORDER BY t.course_id;


--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notes_id_seq OWNED BY public.notes.id;


--
-- Name: red_students; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.red_students AS
 SELECT stu.id,
    stu.name,
    stu.created_at,
    stu.updated_at
   FROM (public.students stu
     LEFT JOIN ( SELECT st.id,
            count(a.course_id) AS number_of_courses
           FROM (public.students st
             LEFT JOIN public.notes_by_students a ON ((a.student_id = st.id)))
          WHERE (a.average < (4)::numeric)
          GROUP BY st.id
          ORDER BY st.id) b ON ((b.id = stu.id)))
  WHERE (b.number_of_courses > 1);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: students_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.students_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.students_id_seq OWNED BY public.students.id;


--
-- Name: teachers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teachers (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: teachers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.teachers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: teachers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.teachers_id_seq OWNED BY public.teachers.id;


--
-- Name: tests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tests_id_seq OWNED BY public.tests.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.courses ALTER COLUMN id SET DEFAULT nextval('public.courses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notes ALTER COLUMN id SET DEFAULT nextval('public.notes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.students ALTER COLUMN id SET DEFAULT nextval('public.students_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teachers ALTER COLUMN id SET DEFAULT nextval('public.teachers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tests ALTER COLUMN id SET DEFAULT nextval('public.tests_id_seq'::regclass);


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: courses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- Name: notes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: students_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- Name: teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_pkey PRIMARY KEY (id);


--
-- Name: tests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tests
    ADD CONSTRAINT tests_pkey PRIMARY KEY (id);


--
-- Name: index_courses_on_teacher_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_courses_on_teacher_id ON public.courses USING btree (teacher_id);


--
-- Name: index_courses_students_on_course_id_and_student_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_courses_students_on_course_id_and_student_id ON public.courses_students USING btree (course_id, student_id);


--
-- Name: index_notes_on_student_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notes_on_student_id ON public.notes USING btree (student_id);


--
-- Name: index_notes_on_test_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notes_on_test_id ON public.notes USING btree (test_id);


--
-- Name: index_tests_on_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tests_on_course_id ON public.tests USING btree (course_id);


--
-- Name: fk_rails_41852ccb67; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tests
    ADD CONSTRAINT fk_rails_41852ccb67 FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- Name: fk_rails_99c95e08d1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT fk_rails_99c95e08d1 FOREIGN KEY (test_id) REFERENCES public.tests(id);


--
-- Name: fk_rails_a68eff6aff; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT fk_rails_a68eff6aff FOREIGN KEY (teacher_id) REFERENCES public.teachers(id);


--
-- Name: fk_rails_c171a9785d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT fk_rails_c171a9785d FOREIGN KEY (student_id) REFERENCES public.students(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20180720012936'),
('20180720013008'),
('20180720013128'),
('20180720013320'),
('20180720013447'),
('20180720014118'),
('20180721170728'),
('20180721171841'),
('20180721171957'),
('20180721172438');



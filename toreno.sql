-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public.equipo
(
    id_equipo bigint NOT NULL DEFAULT nextval('equipo_id_equipo_seq'::regclass),
    nombre_equipo character varying(30) COLLATE pg_catalog."default" NOT NULL,
    pais_procedencia character varying(30) COLLATE pg_catalog."default" NOT NULL,
    id_grupo bigint NOT NULL,
    CONSTRAINT equipo_pkey PRIMARY KEY (id_equipo)
);

CREATE TABLE IF NOT EXISTS public.equipo_partido
(
    id_equipo bigint NOT NULL,
    id_partido bigint NOT NULL,
    CONSTRAINT equipo_partido_pkey PRIMARY KEY (id_equipo, id_partido)
);

CREATE TABLE IF NOT EXISTS public.fase
(
    id_fase bigint NOT NULL DEFAULT nextval('fase_id_fase_seq'::regclass),
    fase_actual character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT fase_pkey PRIMARY KEY (id_fase),
    CONSTRAINT "UC_fase_actual" UNIQUE (fase_actual)
);

CREATE TABLE IF NOT EXISTS public.grupo
(
    id_grupo bigint NOT NULL DEFAULT nextval('grupo_id_grupo_seq'::regclass),
    id_fase bigint NOT NULL,
    grupo bigint NOT NULL,
    CONSTRAINT grupo_pkey PRIMARY KEY (id_fase),
    CONSTRAINT "UC_grupo" UNIQUE (grupo)
);

CREATE TABLE IF NOT EXISTS public.partido
(
    id_partido bigint NOT NULL DEFAULT nextval('partido_id_partido_seq'::regclass),
    equipo_local character varying(50) COLLATE pg_catalog."default" NOT NULL,
    equipo_visitante character varying(50) COLLATE pg_catalog."default" NOT NULL,
    id_resultado bigint,
    CONSTRAINT pk_id_partido PRIMARY KEY (id_partido),
    CONSTRAINT uc_id_resultado UNIQUE (id_resultado)
);

CREATE TABLE IF NOT EXISTS public.resultado
(
    marcador_final character varying(6) COLLATE pg_catalog."default",
    estado character varying(20) COLLATE pg_catalog."default" NOT NULL DEFAULT 'NO JUGADO'::character varying,
    id_resultado bigint NOT NULL DEFAULT nextval('resultado_id_resultado_seq'::regclass),
    CONSTRAINT pk_id_resultado PRIMARY KEY (id_resultado)
);

ALTER TABLE IF EXISTS public.equipo
    ADD CONSTRAINT "FK_grupo" FOREIGN KEY (id_grupo)
    REFERENCES public.grupo (id_grupo) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.equipo_partido
    ADD CONSTRAINT "FK_id_equipo" FOREIGN KEY (id_equipo)
    REFERENCES public.equipo (id_equipo) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.equipo_partido
    ADD CONSTRAINT "FK_id_partido" FOREIGN KEY (id_partido)
    REFERENCES public.partido (id_partido) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.grupo
    ADD CONSTRAINT "FK_id_fase" FOREIGN KEY (id_fase)
    REFERENCES public.fase (id_fase) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.partido
    ADD CONSTRAINT fk_id_resultado FOREIGN KEY (id_resultado)
    REFERENCES public.resultado (id_resultado) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
CREATE INDEX IF NOT EXISTS uc_id_resultado
    ON public.partido(id_resultado);

END;
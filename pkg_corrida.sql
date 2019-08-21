CREATE OR REPLACE PACKAGE pkg_corrida AS
/*
NAME: PKG_CORRIDA
DESCRICAO: FUNCOES CRIADAS PARA DESCRIMINAR PROCESSOS DA CORRIDA
DATA CRIACAO: 21/08/2019
CRIADO POR: FLAVIO MONTIM 
*/
-- TYPES USADOS NO BODY DA PKG
  TYPE t_corrida IS RECORD(
    posicao           NUMBER,
    cod_piloto        NUMBER,
    nome              VARCHAR2(50),
    numero_voltas     NUMBER,
    tempo_total_prova VARCHAR2(30));

  TYPE t_table_corrida IS TABLE OF t_corrida;

  TYPE t_melhor_volta IS RECORD(
    nome        VARCHAR2(50),
    tempo_volta VARCHAR2(50));

  TYPE t_table_volta IS TABLE OF t_melhor_volta;

  TYPE t_vel_media IS RECORD(
    nome             VARCHAR2(50),
    velocidade_media NUMBER(5, 2));

  TYPE t_table_vel_media IS TABLE OF t_vel_media;

  TYPE t_apos_vencedor IS RECORD(
    nome                VARCHAR2(50),
    tempo_prova         VARCHAR2(50),
    tempo_apos_vencedor VARCHAR2(50));

  TYPE t_table_apos_vencedor IS TABLE OF t_apos_vencedor;

-- FUNCAO PARA TRAZER A COLOCACAO DA CORRIDA
  FUNCTION fc_retorna_posicoes RETURN t_table_corrida
    PIPELINED;

-- FUNCAO PARA TRAZER A MELHOR VOLTA DOS PILOTOS
  FUNCTION fc_melhor_volta_piloto RETURN t_table_volta
    PIPELINED;

-- FUNCAO PARA TRAZER A VELOCIDADE MEDIA DOS PILOTOS
  FUNCTION fc_vel_media_piloto RETURN t_table_vel_media
    PIPELINED;

-- FUNCAO PARA TRAZER A MELHOR VOLTA DA CORRIDA
  FUNCTION fc_melhor_volta_corrida RETURN VARCHAR2;

-- FUNCAO PARA TRAZER O TEMPO DO CORREDOR COMPARADO COM O PRIMEIRO LUGAR
  FUNCTION fc_tempo_apos_vencedor RETURN t_table_apos_vencedor
    PIPELINED;

END pkg_corrida;
/
CREATE OR REPLACE PACKAGE BODY pkg_corrida AS
/*
NAME: PKG_CORRIDA
DESCRICAO: FUNCOES CRIADAS PARA DESCRIMINAR PROCESSOS DA CORRIDA
DATA CRIACAO: 21/08/2019
CRIADO POR: FLAVIO MONTIM 
*/


-- FUNCAO PARA TRAZER A COLOCACAO DA CORRIDA
  FUNCTION fc_retorna_posicoes RETURN t_table_corrida
    PIPELINED IS
    v_posicao t_table_corrida := t_table_corrida();
    v_indice  NUMBER := 1;
  
    CURSOR c_posicao IS
      SELECT rownum posicao, b.*
        FROM (SELECT a.cod_piloto,
                     a.nm_piloto nome,
                     MAX(a.n_volta) numero_voltas,
                     to_char('0' ||
                             floor(SUM(tmp_volta_miliseconds) / 1000 / 60 / 60) || ':0' ||
                             floor(MOD(SUM(tmp_volta_miliseconds) / 1000 / 60,
                                       60)) || ':' ||
                             floor(MOD(SUM(tmp_volta_miliseconds) / 1000, 60))) AS tempo_total_prova
                FROM (SELECT SUM(extract(SECOND FROM a.tmp_volta) * 1000) +
                             SUM(extract(minute FROM a.tmp_volta) * 60 * 1000) tmp_volta_miliseconds,
                             a.cod_piloto,
                             a.nm_piloto,
                             a.n_volta,
                             a.hora,
                             a.velocidade,
                             a.tmp_volta
                        FROM corrida_kart a
                       GROUP BY a.cod_piloto,
                                a.nm_piloto,
                                a.n_volta,
                                a.hora,
                                a.velocidade,
                                a.tmp_volta
                       ORDER BY 1) a
               GROUP BY a.cod_piloto, a.nm_piloto
               ORDER BY 4) b;
  
  BEGIN
    FOR i IN c_posicao LOOP
      v_posicao.EXTEND;
      v_posicao(v_indice) := i;
    
      PIPE ROW(v_posicao(v_indice));
      v_indice := v_indice + 1;
    END LOOP;
    RETURN;
  END fc_retorna_posicoes;

-- FUNCAO PARA TRAZER A MELHOR VOLTA DOS PILOTOS
  FUNCTION fc_melhor_volta_piloto RETURN t_table_volta
    PIPELINED IS
    v_melhor_volta t_table_volta := t_table_volta();
    v_indice       NUMBER := 1;
  
    CURSOR c_melhor_volta IS
      SELECT a.nm_piloto,
             to_char(min(a.tmp_volta), 'HH24:MI:SS.FF') tempo_volta
        FROM corrida_kart a
       GROUP BY a.nm_piloto
       order by 2;
  
  BEGIN
    FOR i IN c_melhor_volta LOOP
      v_melhor_volta.EXTEND;
      v_melhor_volta(v_indice) := i;
    
      PIPE ROW(v_melhor_volta(v_indice));
      v_indice := v_indice + 1;
    END LOOP;
    RETURN;
  END fc_melhor_volta_piloto;

-- FUNCAO PARA TRAZER A VELOCIDADE MEDIA DOS PILOTOS
  FUNCTION fc_vel_media_piloto RETURN t_table_vel_media
    PIPELINED IS
    v_vel_media t_table_vel_media := t_table_vel_media();
    v_indice    NUMBER := 1;
  
    CURSOR c_vel_media IS
      SELECT a.nm_piloto, round(avg(a.velocidade), 2) velocidade_media
        FROM corrida_kart a
       GROUP BY a.nm_piloto
       ORDER BY 2 DESC;
  
  BEGIN
    FOR i IN c_vel_media LOOP
      v_vel_media.EXTEND;
      v_vel_media(v_indice) := i;
    
      PIPE ROW(v_vel_media(v_indice));
      v_indice := v_indice + 1;
    END LOOP;
    RETURN;
  END fc_vel_media_piloto;

-- FUNCAO PARA TRAZER A MELHOR VOLTA DA CORRIDA
  FUNCTION fc_melhor_volta_corrida RETURN VARCHAR2 AS
    v_volta VARCHAR2(30) := 0;
  
  BEGIN
    SELECT to_char(a.tmp_volta, 'HH24:MI:SS.FF')
      INTO v_volta
      FROM corrida_kart a
     WHERE a.tmp_volta = (SELECT MIN(b.tmp_volta) FROM corrida_kart b)
     GROUP BY a.cod_piloto,
              a.nm_piloto,
              a.n_volta,
              a.hora,
              a.velocidade,
              a.tmp_volta
     ORDER BY 1;
  
    RETURN v_volta;
  
  END fc_melhor_volta_corrida;

-- FUNCAO PARA TRAZER O TEMPO DO CORREDOR COMPARADO COM O PRIMEIRO LUGAR
  FUNCTION fc_tempo_apos_vencedor RETURN t_table_apos_vencedor
    PIPELINED IS
    v_apos_vencedor t_table_apos_vencedor := t_table_apos_vencedor();
    v_indice        NUMBER := 1;
  
    CURSOR c_tempo_apos_vencedor IS
      SELECT b.nome,
             to_char(b.tempo_total_prova, 'HH24:MI:SS.FF') tempo_prova,
             to_char(b.tempo_total_prova -
                     (SELECT MIN(tempo_total_prova)
                        FROM (SELECT a.nm_piloto nome,
                                     TO_TIMESTAMP('0' ||
                                                  floor(SUM(tmp_volta_miliseconds) / 1000 / 60 / 60) || ':0' ||
                                                  floor(MOD(SUM(tmp_volta_miliseconds) / 1000 / 60,
                                                            60)) || ':' ||
                                                  floor(MOD(SUM(tmp_volta_miliseconds) / 1000,
                                                            60)),
                                                  'HH24:MI:SS.FF') AS tempo_total_prova
                                FROM (SELECT SUM(extract(SECOND FROM
                                                         a.tmp_volta) * 1000) +
                                             SUM(extract(minute FROM
                                                         a.tmp_volta) * 60 * 1000) tmp_volta_miliseconds,
                                             a.cod_piloto,
                                             a.nm_piloto,
                                             a.n_volta,
                                             a.hora,
                                             a.velocidade,
                                             a.tmp_volta
                                        FROM corrida_kart a
                                       GROUP BY a.cod_piloto,
                                                a.nm_piloto,
                                                a.n_volta,
                                                a.hora,
                                                a.velocidade,
                                                a.tmp_volta
                                       ORDER BY 1) a
                               GROUP BY a.nm_piloto))) TEMPO_APOS_VENCEDOR
        FROM (SELECT a.cod_piloto,
                     a.nm_piloto nome,
                     MAX(a.n_volta) numero_voltas,
                     TO_TIMESTAMP('0' ||
                                  floor(SUM(tmp_volta_miliseconds) / 1000 / 60 / 60) || ':0' ||
                                  floor(MOD(SUM(tmp_volta_miliseconds) / 1000 / 60,
                                            60)) || ':' ||
                                  floor(MOD(SUM(tmp_volta_miliseconds) / 1000,
                                            60)),
                                  'HH24:MI:SS.FF') AS tempo_total_prova
                FROM (SELECT SUM(extract(SECOND FROM a.tmp_volta) * 1000) +
                             SUM(extract(minute FROM a.tmp_volta) * 60 * 1000) tmp_volta_miliseconds,
                             a.cod_piloto,
                             a.nm_piloto,
                             a.n_volta,
                             a.hora,
                             a.velocidade,
                             a.tmp_volta
                        FROM corrida_kart a
                       GROUP BY a.cod_piloto,
                                a.nm_piloto,
                                a.n_volta,
                                a.hora,
                                a.velocidade,
                                a.tmp_volta
                       ORDER BY 1) a
               GROUP BY a.cod_piloto, a.nm_piloto
               ORDER BY 4) b;
  
  BEGIN
    FOR i IN c_tempo_apos_vencedor LOOP
      v_apos_vencedor.EXTEND;
      v_apos_vencedor(v_indice) := i;
    
      PIPE ROW(v_apos_vencedor(v_indice));
      v_indice := v_indice + 1;
    END LOOP;
    RETURN;
  END fc_tempo_apos_vencedor;

END pkg_corrida;
/

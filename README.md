# PLSQL
PLSQL criacao de PKG com functions de retorno type

Projeto em Oracle PL/SQL, necessario de alguma ferramenta que rode o BD oracle

1 - Executar o script QUERY.sql onde estão a criacao da tabela e os inserts

2 - Executar a PACKAGE pkg_corrida.sql

As chamadas das functions sao essas:

select * from table(pkg_corrida.fc_retorna_posicoes);

select * from table(pkg_corrida.fc_melhor_volta_piloto);

select pkg_corrida.fc_melhor_volta_corrida() from dual;

select * from table(pkg_corrida.fc_vel_media_piloto);

select * from table(pkg_corrida.fc_tempo_apos_vencedor);

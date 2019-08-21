--drop table corrida_kart;
create table corrida_kart(hora timestamp, cod_piloto number, nm_piloto varchar2(50), n_volta number, tmp_volta timestamp, velocidade number(5,3));

insert into corrida_kart(hora,cod_piloto,nm_piloto,n_volta,tmp_volta,velocidade) values(to_timestamp('23:49:08.277','HH24:MI:SS.FF'),38,'F.MASSA',1,to_timestamp('1:02.852','MI:SS.FF'),44.275);
insert into corrida_kart(hora,cod_piloto,nm_piloto,n_volta,tmp_volta,velocidade) values(to_timestamp('23:49:10.858','HH24:MI:SS.FF'),33,'R.BARRICHELLO',1,to_timestamp('1:04.352','MI:SS.FF'),43.243);
insert into corrida_kart(hora,cod_piloto,nm_piloto,n_volta,tmp_volta,velocidade) values(to_timestamp('23:49:11.075','HH24:MI:SS.FF'),2,'K.RAIKKONEN',1,to_timestamp('1:04.108','MI:SS.FF'),43.408);
insert into corrida_kart(hora,cod_piloto,nm_piloto,n_volta,tmp_volta,velocidade) values(to_timestamp('23:49:12.667','HH24:MI:SS.FF'),23,'M.WEBBER',1,to_timestamp('1:04.414','MI:SS.FF'),43.202);
insert into corrida_kart(hora,cod_piloto,nm_piloto,n_volta,tmp_volta,velocidade) values(to_timestamp('23:49:30.976','HH24:MI:SS.FF'),15,'F.ALONSO',1,to_timestamp('1:18.456','MI:SS.FF'),35.47);
insert into corrida_kart(hora,cod_piloto,nm_piloto,n_volta,tmp_volta,velocidade) values(to_timestamp('23:50:11.447','HH24:MI:SS.FF'),38,'F.MASSA',2,to_timestamp('1:03.170','MI:SS.FF'),44.053);
insert into corrida_kart(hora,cod_piloto,nm_piloto,n_volta,tmp_volta,velocidade) values(to_timestamp('23:50:14.860','HH24:MI:SS.FF'),33,'R.BARRICHELLO',2,to_timestamp('1:04.002','MI:SS.FF'),43.48);
insert into corrida_kart(hora,cod_piloto,nm_piloto,n_volta,tmp_volta,velocidade) values(to_timestamp('23:50:15.057','HH24:MI:SS.FF'),2,'K.RAIKKONEN',2,to_timestamp('1:03.982','MI:SS.FF'),43.493);
insert into corrida_kart(hora,cod_piloto,nm_piloto,n_volta,tmp_volta,velocidade) values(to_timestamp('23:50:17.472','HH24:MI:SS.FF'),23,'M.WEBBER',2,to_timestamp('1:04.805','MI:SS.FF'),42.941);
insert into corrida_kart(hora,cod_piloto,nm_piloto,n_volta,tmp_volta,velocidade) values(to_timestamp('23:50:37.987','HH24:MI:SS.FF'),15,'F.ALONSO',2,to_timestamp('1:07.011','MI:SS.FF'),41.528);
insert into corrida_kart(hora,cod_piloto,nm_piloto,n_volta,tmp_volta,velocidade) values(to_timestamp('23:51:14.216','HH24:MI:SS.FF'),38,'F.MASSA',3,to_timestamp('1:02.769','MI:SS.FF'),44.334);
insert into corrida_kart(hora,cod_piloto,nm_piloto,n_volta,tmp_volta,velocidade) values(to_timestamp('23:51:18.576','HH24:MI:SS.FF'),33,'R.BARRICHELLO',3,to_timestamp('1:03.716','MI:SS.FF'),43.675);
insert into corrida_kart(hora,cod_piloto,nm_piloto,n_volta,tmp_volta,velocidade) values(to_timestamp('23:51:19.044','HH24:MI:SS.FF'),2,'K.RAIKKONEN',3,to_timestamp('1:03.987','MI:SS.FF'),43.49);
insert into corrida_kart(hora,cod_piloto,nm_piloto,n_volta,tmp_volta,velocidade) values(to_timestamp('23:51:21.759','HH24:MI:SS.FF'),23,'M.WEBBER',3,to_timestamp('1:04.287','MI:SS.FF'),43.287);
insert into corrida_kart(hora,cod_piloto,nm_piloto,n_volta,tmp_volta,velocidade) values(to_timestamp('23:51:46.691','HH24:MI:SS.FF'),15,'F.ALONSO',3,to_timestamp('1:08.704','MI:SS.FF'),40.504);
insert into corrida_kart(hora,cod_piloto,nm_piloto,n_volta,tmp_volta,velocidade) values(to_timestamp('23:52:01.796','HH24:MI:SS.FF'),11,'S.VETTEL',1,to_timestamp('3:31.315','MI:SS.FF'),13.169);
insert into corrida_kart(hora,cod_piloto,nm_piloto,n_volta,tmp_volta,velocidade) values(to_timestamp('23:52:17.003','HH24:MI:SS.FF'),38,'F.MASSA',4,to_timestamp('1:02.787','MI:SS.FF'),44.321);
insert into corrida_kart(hora,cod_piloto,nm_piloto,n_volta,tmp_volta,velocidade) values(to_timestamp('23:52:22.586','HH24:MI:SS.FF'),33,'R.BARRICHELLO',4,to_timestamp('1:04.010','MI:SS.FF'),43.474);
insert into corrida_kart(hora,cod_piloto,nm_piloto,n_volta,tmp_volta,velocidade) values(to_timestamp('23:52:22.120','HH24:MI:SS.FF'),2,'K.RAIKKONEN',4,to_timestamp('1:03.076','MI:SS.FF'),44.118);
insert into corrida_kart(hora,cod_piloto,nm_piloto,n_volta,tmp_volta,velocidade) values(to_timestamp('23:52:25.975','HH24:MI:SS.FF'),23,'M.WEBBER',4,to_timestamp('1:04.216','MI:SS.FF'),43.335);
insert into corrida_kart(hora,cod_piloto,nm_piloto,n_volta,tmp_volta,velocidade) values(to_timestamp('23:53:06.741','HH24:MI:SS.FF'),15,'F.ALONSO',4,to_timestamp('1:20.050','MI:SS.FF'),34.763);
insert into corrida_kart(hora,cod_piloto,nm_piloto,n_volta,tmp_volta,velocidade) values(to_timestamp('23:53:39.660','HH24:MI:SS.FF'),11,'S.VETTEL',2,to_timestamp('1:37.864','MI:SS.FF'),28.435);
insert into corrida_kart(hora,cod_piloto,nm_piloto,n_volta,tmp_volta,velocidade) values(to_timestamp('23:54:57.757','HH24:MI:SS.FF'),11,'S.VETTEL',3,to_timestamp('1:18.097','MI:SS.FF'),35.633);

commit;

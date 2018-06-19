-- =============================================================================
-- BUILD TUITION TABLE
select * from tuition;
--drop table tuition;
commit;   
drop table tuition;
create table tuition (	
    groupid	varchar2(500),
    date_joined	varchar2(500),
    institution_name	varchar2(500),
    campus_name	varchar2(500),
    type_inst varchar2(500),
    city	varchar2(500),
    state	varchar2(500),
    zip	varchar2(500),
    work_ph	varchar2(500),
    cell_ph	varchar2(500),
    home_ph	varchar2(500),
    fte_count	varchar2(500),
    net_student_tuition	varchar2(500),
    federal03	varchar2(500),
    state03	varchar2(500),
    state_local_app	varchar2(500),
    federal07	varchar2(500),
    federal07_net_pell	varchar2(500),
    state06	varchar2(500),
    local06	varchar2(500),
    state_local_grant_contract	varchar2(500),
    federal10	varchar2(500),
    federal10_net_pell	varchar2(500),
    state09	varchar2(500),
    fed_state_loc_grants_con	varchar2(500),
    private03	varchar2(500),
    endowment03	varchar2(500),
    priv_invest_endow	varchar2(500),
    auxother_rev	varchar2(500),
    stable_operating_rev	varchar2(500),
    total03_revenue	varchar2(500)
    );	

select * from tuition;

select * from all_tab_columns
where lower(table_name) like '%tuition%'; 

-- IMPORT DATA : TUITION.CSV
select * from tuition;
-- =============================================================================
-- STATES TABLE
select * from states;
--drop table states;
create table states
( st_id integer primary key, 
  state varchar2(20),
  st    char(2),
  region varchar2(15));

insert into states values ('1', 'Alabama', 'AL', 'South');
insert into states values ('2', 'Alaska', 'AK', 'West');
insert into states values ('3', 'Arizona', 'AZ', 'West');
insert into states values ('4', 'Arkansas', 'AR', 'South');
insert into states values ('5', 'California', 'CA', 'West');
insert into states values ('6', 'Colorado', 'CO', 'West');
insert into states values ('7', 'Connecticut', 'CT', 'North East');
insert into states values ('8', 'Delaware', 'DE', 'South');
insert into states values ('9', 'Florida', 'FL', 'South');
insert into states values ('10', 'Georgia', 'GA', 'South');
insert into states values ('11', 'Hawaii', 'HI', 'West');
insert into states values ('12', 'Idaho', 'ID', 'West');
insert into states values ('13', 'Illinois', 'IL', 'Midwest');
insert into states values ('14', 'Indiana', 'IN', 'Midwest');
insert into states values ('15', 'Iowa', 'IA', 'Midwest');
insert into states values ('16', 'Kansas', 'KS', 'Midwest');
insert into states values ('17', 'Kentucky', 'KY', 'South');
insert into states values ('18', 'Louisiana', 'LA', 'South');
insert into states values ('19', 'Maine', 'ME', 'North East');
insert into states values ('20', 'Maryland', 'MD', 'South');
insert into states values ('21', 'Massachusetts', 'MA', 'North East');
insert into states values ('22', 'Michigan', 'MI', 'Midwest');
insert into states values ('23', 'Minnesota', 'MN', 'Midwest');
insert into states values ('24', 'Mississippi', 'MO', 'South');
insert into states values ('25', 'Missouri', 'MS', 'Midwest');
insert into states values ('26', 'Montana', 'MT', 'West');
insert into states values ('27', 'Nebraska', 'NE', 'Midwest');
insert into states values ('28', 'Nevada', 'NV', 'West');
insert into states values ('29', 'New Hampshire', 'NH', 'North East');
insert into states values ('30', 'New Jersey', 'NJ', 'North East');
insert into states values ('31', 'New Mexico', 'NM', 'West');
insert into states values ('32', 'New York', 'NY', 'North East');
insert into states values ('33', 'North Carolina', 'NC', 'South');
insert into states values ('34', 'North Dakota', 'ND', 'Midwest');
insert into states values ('35', 'Ohio', 'OH', 'Midwest');
insert into states values ('36', 'Oklahoma', 'OK', 'South');
insert into states values ('37', 'Oregon', 'OR', 'West');
insert into states values ('38', 'Pennsylvania', 'PA', 'North East');
insert into states values ('39', 'Rhode Island', 'RI', 'North East');
insert into states values ('40', 'South Carolina', 'SC', 'South');
insert into states values ('41', 'South Dakota', 'SD', 'Midwest');
insert into states values ('42', 'Tennessee', 'TN', 'South');
insert into states values ('43', 'Texas', 'TX', 'South');
insert into states values ('44', 'Utah', 'UT', 'West');
insert into states values ('45', 'Vermont', 'VA', 'North East');
insert into states values ('46', 'Virginia', 'VT', 'South');
insert into states values ('47', 'Washington', 'WA', 'West');
insert into states values ('48', 'West Virginia', 'WI', 'South');
insert into states values ('49', 'Wisconsin', 'WV', 'Midwest');
insert into states values ('50', 'Wyoming', 'WY', 'West');
commit;

-- =============================================================================
-- SCHOOL_TYPE TABLE
select * from school_type;
-- drop table school_type;
create table school_type
( type_id   integer primary key,
  type_name  varchar2(25));

insert into school_type values (66,	'STATE UNIVERSITY');
insert into school_type values (48,	'STATE COLLEGE');
insert into school_type values (30,	'STATE COMMUNITY COLLEGE');
insert into school_type values (38,	'LOCAL COMMUNITY COLLEGE');
insert into school_type values (69,	'PRIVATE JR COLLEGE');
insert into school_type values (74,	'PRIVATE');
insert into school_type values (84,	'MILITARY');

commit;

select * from tuition;
select * from states;
select * from school_type;

-- ETL
-- 1. Create stage table using character fields
-- 2. Load source into this stage table
-- 3. With each source field
--        clarify business transformation logic
--        write test sql to transform source to target data
-- 4. Place all single column tests into 1 big SQL statement
-- 5. Use output from each transformed source column to type target column
-- 6. Create internal table with correct data types
-- 7. Insert into target using select from source with transformations from chapter 6 

Insert into tuition  values ('-1025','1987','LOMAX-HANNON JC',null,'74','GREENVILLE','AL','36037','5685267073',null,null,'33450','1897808','17068','16124160','16124160','9461724','7265232',null,null,null,'9478792','7282300','16124160','7282300',null,null,null,'4529459','32959139','35155632');
Insert into tuition   values ('1408','1987','SAINT BASILS COLLEGE',null,'74','STAMFORD','CT','6902','3954871873','4924201253',null,'31400','2506282','2440214','17107620','17107620','8994152','6877843','1132421',null,'1132421','11434366','9318057','18240042','10450478','472196',null,'472196','4477017','37005390','39985544');
Insert into tuition   values ('-1025','1987','MERCER U STHN SCHOOL PHAR',null,'74','ATLANTA','GA','30312',null,null,'7006589290','35660','2538398','2480973','19295288','19295288','9114062','6419768','1367943',null,'1367943','11595035','8900741','20663232','10268684','538832',null,'538832','4683969','39853910','43723596');
Insert into tuition   values ('1595','1987','TIFT COLLEGE',null,'74','FORSYTH','GA','31029','8671874153',null,'8607476667','37670','2969939','2582813','19192740','19192740','10168088','7431012','1494454',null,'1494454','12750901','10013825','20687194','11508279','673651',null,'673651','4196788','41255063','45543896');
Insert into tuition   values ('-1593','1987','AERO-SPACE INSTITUTE',null,'84','CHICAGO','IL','60610',null,null,'6962526418','41040','2627916','3061494','19628344','19628344','13633430','10085782','1053452',null,'1053452','16694924','13147276','20681796','14200728','626850',null,'626850','5446271','46086363','51433912');
Insert into tuition   values ('-1595','1987','NATL COLLEGE ED',null,'84','EVANSTON','IL','60201','4119111565','7588607480',null,'44290','4382559','3108942','19744360','19744360','13211605','9654227','1225055',null,'1225055','16320547','12763169','20969416','13988224','1138610',null,'1138610','4905869','47146899','53132084');
Insert into tuition   values ('1755','1987','SHERWOOD CONSV. OF MUSIC',null,'84','CHICAGO','IL','60605','4778392171',null,null,'42830','5461769','2831854','20616852','20616852','13420780','9852430','1264558',null,'1264558','16252634','12684284','21881410','13948842','819068',null,'819068','5135419','49351072','54899880');
Insert into tuition   values ('-1733','1987','SAINT JOHNS COLLEGE',null,'74','WINFIELD','KS','67156',null,'8377247852',null,'47930','6769136','3162155','21909812','21909812','15313054','11759724','774214','3956','778170','18475208','14921879','22687980','15700049','1449519',null,'1449519','6814877','55498820','61979400');
Insert into tuition   values ('2296','1987','MUSKEGON BUSINESS COLLEGE',null,'74','MUSKEGON','MI','49442',null,'9931057732',null,'46460','7949749','2865731','26228420','26228420','15406944','12215577','1534985',null,'1534985','18272676','15081308','27763406','16616293','934017',null,'934017','6757655','61319787','67006852');
Insert into tuition   values ('-1942','1987','SAINT MARYS JR COLLEGE',null,'74','MINNEAPOLIS','MN','55454','8144498167',null,null,'45190','8622004','2591006','25901338','25901338','16006537','12988223','1093179',null,'1093179','18597544','15579229','26994516','16672408','770610',null,'770610','6999907','61788243','67350728');
Insert into tuition   values ('-2296','1987','MISS INDUSTRIAL COLLEGE',null,'74','HOLLY SPRINGS','MS','38635','1828345547','6459500976',null,'44050','7952395','2105692','26519222','26519222','17352488','14199463','1393793',null,'1393793','19458180','16305155','27913016','17698948','702079',null,'702079','8418804','64353049','69968552');
Insert into tuition   values ('-2381','1987','SAINT PAULS COLLEGE',null,'74','CONCORDIA','MO','64020',null,'4256916544',null,'42880','7419683','3126890','27045892','27045892','18674076','14661066','1106002',null,'1106002','21800964','17787956','28151894','18893958','1120947',null,'1120947','8669308','66465320','73831880');
Insert into tuition   values ('-2421','1987','FELICIAN COLLEGE',null,'74','LODI','NJ','7644',null,'2907667634',null,'44570','7134418','3062098','28580108','28580108','18088484','12707816','1578342',null,'1578342','21150582','15769914','30158452','17348256','858819',null,'858819','11148474','70315809','79911920');
Insert into tuition   values ('2662','1987','UNIVERSITY OF ALBUQUERQUE',null,'66','ALBUQUERQUE','NM','87140','752029882',null,'9419564624','100410','15827760',null,'108797072','108797072','65552488','63302199','3263567','512367','3775934','65552488','63302199','112573000','67078133','23794046','485305','24279351','238179634','435052433','463502304');
Insert into tuition   values ('-2610','1987','PARSONS SCHOOL OF DESIGN',null,'74','NEW YORK','NY','10011',null,'2796172576',null,'100850','17359822',null,'112179376','112179376','75264824','72797446','3643796','542343','4186139','75264824','72797446','116365520','76983585','27832632','1016714.125','28849346.13','256850836','468793877','501005504');
Insert into tuition   values ('-2662','1987','FREEMAN JUNIOR COLLEGE',null,'69','FREEMAN','SD','57029','7818185888',null,null,'103840','18185940',null,'127300696','127300696','86413856','83751418','6447689','573590','7021279','86413856','83751418','134321984','90772697','32248624','2368566','34617190','277629148','519885285','559508800');
Insert into tuition   values ('-2793','1987','VIRGINIA COLLEGE',null,'74','LYNCHBURG','VA','24501',null,'8390452324',null,'109020','19958176',null,'125914496','125914496','91294736','88278160','5921215','594710','6515925','91294736','88278160','132430424','94794085','33923532','4397484','38321016','341606044','588788185','632950144');
Insert into tuition   values ('-3462','1987','WISCONSIN CONSV OF MUSIC',null,'74','MILWAUKEE','WI','53202',null,'6930929098',null,'114960','22484069',null,'132478624','132478624','92800552','89588803','6097821','1865351','7963172','92800552','89588803','140441792','97551975','33809456','3769414','37578870','433052648','692449123','736546304');
Insert into tuition   values ('-3762','1987','MADISON AREA TECH COLLEGE',null,'74','MADISON','WI','53703','4999731515','5685267073',null,'119750','25172120',null,'132577648','132577648','109474840','104900742','5145392','2543176','7688568','109474840','104900742','140266208','112589310','42837264','4145718','46982982','489359409','767913691','822950912');
Insert into tuition   values ('-3913','1987','BAKER JUNIOR COLLEGE BUS',null,'69','FLINT','MI','48507',null,null,'4778392171','119600','26788066',null,'137691136','137691136','126217592','122096766','5530606','3489228','9019834','126217592','122096766','146710976','131116600','49677520','4716729','54394249','536412053','841145229','903553664');
Insert into tuition   values ('-4007','1987','BEER SHMUEL TALMUD ACAD',null,'74','BROOKLYN','NY','11219',null,'3945479251',null,'120770','35315660',null,'161185632','161185632','151434384','147203671','4872923','4221711','9094634','151434384','147203671','170280256','156298305','38184560','7255994','45440554','580241031','942033168','996470528');
Insert into tuition   values ('-4673','1987','BETH JOSEPH RAB SEMINARY',null,'74','BROOKLYN','NY','11219','6720847504',null,'7960984482','120270','36267357',null,'161006032','161006032','175198064','170598859','3473405','3541454','7014859','175198064','170598859','168020896','177613718','42407540','4641371','47048911','663708570','1047613376','1104893568');
Insert into tuition   values ('4829','1987','YESH BETH SHEARM RAB INST',null,'74','BROOKLYN','NY','11204',null,'5367549134',null,'119010','36163110',null,'160633584','160633584','192927344','189361125','2914300','4102303','7016603','192927344','189361125','167650192','196377728','46032280','4404216','50436496','704096992','1107552736','1170238848');
Insert into tuition   values ('-5000','1987','FORT STEILACOOM CC',null,'74','TACOMA','WA','98498',null,null,'9022865883','120230','37852258',null,'166245344','166245344','188329776','183060102','2778334','4207328','6985662','188329776','183060102','173231008','190045764','57379132','4755016','62134148','747344496','1152869900','1230152192');
Insert into tuition   values ('5523','1987','BLUE HILLS REG TECH INST',null,'74','CANTON','MA','2021',null,'1270580543',null,'6990','153231',null,'1864583','1864583','398601','208480','24036',null,'24036','398601','208480','1888619','232516',null,null,null,'672415','3112866','3339579');
Insert into tuition   values ('-6741','1987','WESTERN BIBLE COLLEGE',null,'74','MORRISON','CO','80465','5894310652',null,null,'2030','472257',null,'1961667','1961667','523988','338161','39768',null,'39768','523988','338161','2001435','377929',null,null,null,'358901','3373301','3582774');
Insert into tuition   values ('-6775','1987','RAINY RIVER CMTY COLLEGE',null,'74','INTERNATIONAL F','MN','56649',null,'8114930850',null,'3520','492329',null,'2298958','2298958','549277','327194','100779',null,'100779','549277','327194','2399737','427973',null,null,null,'437810','3905690','4152173');
Insert into tuition   values ('-7591','1987','SOUTHEAST COMMUNITY COLLEGE LINCOLN CAMPUS',null,'74','LINCOLN','NE','68520',null,null,'594507920','3920','503557',null,'2347583','2347583','601529','331746','109938',null,'109938','601529','331746','2457521','441684',null,null,null,'345515','3926660','4241693');
Insert into tuition   values ('8192','1987','PIEDMONT AEROSPACE INST',null,'74','WINSTON-SALEM','NC','27156',null,'9022865883',null,'5040','669776',null,'2383434','2383434','611065','411478','127680',null,'127680','611065','411478','2511114','539158',null,null,null,'239382','4052037','4292950');
Insert into tuition   values ('-8915','1987','INST FOR ADV STDIES HUM',null,'74','NEW YORK','NY','10027','1242020857',null,null,'5220','796535',null,'2518017','2518017','533195','248856','220728',null,'220728','533195','248856','2738745','469584',null,null,null,'135412','4225687','4554438');
Insert into tuition   values ('-9008','1987','COLORADO MOUNTAIN COLLEGE EAST CAMPUS',null,'74','LEADVILLE','CO','80461','7124507413',null,null,'3990','602256',null,'2593517','2593805','707659','479586','140864',null,'140864','707659','479586','2734669','620450',null,null,null,'188703','4262677','4531802');
Insert into tuition   values ('-10017','1987','PAYNE THEOLOGICAL SEM',null,'74','WILBERFORCE','OH','45384','4498968918',null,null,'3340','611408',null,'2245254','2245254','447592','286829','170069','65','170134','447592','286829','2415388','456963',null,null,null,'236991','3740279','3954383');
Insert into tuition   values ('-10477','1987','YESHIVA NACHLAS HALEVIYIM',null,'69','BROOKLYN','NY','11219','4870619281',null,null,'2770','493039',null,'2411096','2411096','399566','237841','228123','349','228472','399566','237841','2639568','466313',null,null,null,'161176','3719549','3956513');
Insert into tuition   values ('-10668','1987','DALLAS BIBLE COLLEGE',null,'69','DALLAS','TX','75228',null,'9036219965',null,'2620','431684',null,'2378282','2378282','208712','33280','182739','10484','193223','208712','33280','2571505','226503',null,null,null,'191033','3437565','3743410');
Insert into tuition   values ('-11157','1987','ESSEX AGRL-TECH INST',null,'74','HATHORNE','MA','1937','7864787236',null,null,'2760','492659',null,'2429057','2429057','221079','41076','171944','229','172173','221079','41076','2601230','213249',null,null,null,'221295','3571472','3867231');
Insert into tuition   values ('-11237','1987','SOUTHERN VOCATIONAL COLLEGE',null,'74','TUSKEGEE','AL','36083',null,null,'993667574','31360','-912452',null,'16618212','16618212','7617578','3241768','271274',null,'271274','7617578','3241768','16889486','3513042','94977','250000','344977','60781','200126','529067');
Insert into tuition   values ('-11600','1987','RUTLEDGE C OF GREENSBORO',null,'74','GREENSBORO','NC','27420',null,'9246900775',null,'31060','185548',null,'16995492','16995492','6302744','2977080','318355',null,'318355','6302744','2977080','17313846','3295435','75245',null,'75245','66253','218144','576701');
Insert into tuition   values ('-11669','1987','OHR YISROEL RAB COLLEGE',null,'74','FOREST HILLS','NY','11375','5241697632',null,'9461559730','36230','-135801',null,'18200144','18200144','7131106','2896354','399698',null,'399698','7131106','2896354','18599842','3296052','17623',null,'17623','206875.5767','428519.5767','766228');
Insert into tuition   values ('-11996','1987','STENOTYPE INSTITUTE',null,'74','NEW YORK','NY','10019',null,'4415863813',null,'39590','-431093',null,'18036740','18036740','8801444','3646073','346147',null,'346147','8801444','3646073','18382888','3992220','57382',null,'57382','207016','374545','880767');
Insert into tuition   values ('-12010','1987','DERECH AYSON RAB SEMINARY',null,'74','FAR ROCKAWAY','NY','11691','2923430080',null,null,'39070','2154344.764',null,'18806736','18806736','8165938','3580644','417969',null,'417969','8165938','3580644','19224706','3998613','148793',null,'148793','204067','359356','839226');
Insert into tuition   values ('12257','1987','HEED UNIVERSITY',null,'74','HOLLYWOOD','FL','33020','9828517337','9561407157',null,'44050','1360860',null,'18910460','18910460','9092841','3422431','428053','2000','430053','9092841','3422431','19340512','3852484','153166','41597','194763','17278','214013','1521731');
Insert into tuition   values ('12312','1987','GRAND RAPIDS SCHOOL OF BIBLE AND MUSIC',null,'74','GRAND RAPIDS','MI','49506','1580579589','9429637551',null,'50550','4679701',null,'20246688','20246688','11041722','5095062','356418','4800','361218','11041722','5095062','20607908','5456280','342883','39850','382733','4427','215682','1705398');
Insert into tuition   values ('12632','1987','FLORIDA BEACON COLLEGE',null,'74','LARGO','FL','33541','3373387615',null,null,'51180','4161140',null,'21249334','21249334','10480609','4269167','644888','3400','648288','10480609','4269167','21897622','4917455','264009','16706','280715','23352','311129','1813493');
Insert into tuition   values ('-12857','1987','LUTHER RICE SEMINARY',null,'74','JACKSONVILLE','FL','32207',null,'9275808991',null,'45720','4654208',null,'25782536','25782536','10079139','4586374','496034','2400','498434','10079139','4586374','26280972','5084808','329037',null,'329037','10942','402319','1832295');
Insert into tuition   values ('-29026','1987','BEACON COLLEGE',null,'74','WASHINGTON','DC','20009','7948284923',null,'6038394794','47980','1587137',null,'32310112','32310112','12269640','7252421','662982','2400','665382','12269640','7252421','32975494','7917803','873257',null,'873257','16326','599753','2236725');
Insert into tuition   values ('29083','1987','NYINGMA INSTITUTE',null,'74','BERKELEY','CA','94709',null,'9971320242',null,'48310','5275735',null,'25429592','25429592','11363192','5508845','1916352','2400','1918752','11363192','5508845','27348344','7427597','490198',null,'490198','10061.29004','359450.29','1796802');
Insert into tuition   values ('-29089','1987','CALIFORNIA CHRISTIAN COLLEGE',null,'74','FRESNO','CA','93703','6',null,'8614631566','45600','6270814',null,'26875160','26875160','11952713','5681102','1510941','9036','1519977','11952713','5681102','28395136','7201079','1007872',null,'1007872','4896','781191','1970958');
Insert into tuition   values ('-29146','1987','RABBINICAL C OF TASH',null,'74','BROOKLYN','NY','11219','2863199285',null,'3416067700','47670','4013896.375','47665','27100452','27100452','11892231','4760734','3225686','26856','3252542','11939896','4808399','30352996','8060941','1174098','156650','1330748','103504','1162784','2303761');
Insert into tuition   values ('-29152','1987','BAPT BIBLE C OF DENVER',null,'74','DENVER','CO','80020',null,'2029232006','9027944581','146050','20249012',null,'73837040','73837040','14498483','11406187','1321335','296214','1617549','14498483','11406187','75454584','13023736','6426374','3360501','9786875','4794546','47961573','51729220');
Insert into tuition   values ('-29179','1987','HOREB SEMINARY',null,'74','MIAMI BEACH','FL','33139','9817582839','8648809744',null,'155120','24173001',null,'75894240','75894240','17390730','12771649','2458952','272381','2731333','17390730','12771649','78625568','15502982','6711998','4190285','10902283','5490286','54176777','58318876');
Insert into tuition   values ('29184','1987','WILLIAM CAREY INTRNATL U',null,'74','PASADENA','CA','91104','6999039310',null,null,'168220','31231412',null,'85281368','85281368','17933708','13085650','4289998','257150','4547148','17933708','13085650','89828512','17632798','5484460','4152861','9637321','5932839','63910387','69302128');
Insert into tuition   values ('-29255','1987','PA COLL. OF STRAIGHT CHIRO',null,'74','LEVITTOWN','PA','19058','3877225609','9971320242',null,'177930','34991657',null,'84795744','84795744','18987540','14136020','4863269','277732','5141001','18987540','14136020','89936752','19277021','5853758','4351841','10205599','6235794','69212946','74948088');
Insert into tuition   values ('-29343','1987','HEALD COLLEGE-SANTA CLARA',null,'74','SANTA CLARA','CA','95051','2392435292','6505572655',null,'180190','37111978',null,'87877296','87877296','17559330','12257711','4944235','275339','5219574','17559330','12257711','93096864','17477285','6522694','5164803','11687497','6682567','72389962','77752768');
Insert into tuition   values ('45678','1987','DERECH AYSON RAB SEM',null,'74','FAR ROCKAWAY','NY','11691','6229275501','6433136634','9748349867','-3','2',null,'9','4','2','-3',null,null,'-3',null,null,'0','2','2','0','-1','-1','111.2','0.513068955');
Insert into tuition   values ('29372','1987','OR GRAD SCHL OF PROF PSY',null,'74','MARYLHURST','OR','97036',null,null,'9827220706','2','1','0','6','3','1','40','4','3','8','4','3','0','2','2','0','-1','-1','111.2','0.513068955');
Insert into tuition   values ('100636','1987','Air Force Communty College','CCAF Montgomery','84','Montgomery','AL','36112-661',null,'7168253122','2265438460','2','1','0','6','3','1','40','4','3','8','4','3','0','2','2','0','-1','-1','115.8','0.534293031');
Insert into tuition   values ('100636','1988','Air Force Communty College','CCAF Montgomery','84','Montgomery','AL','36112-661','1586003166',null,'1416247345','2','1','0','6','3','1','40','4','3','8','4','3','0','2','2','0','-1','-1','121.2','0.55920825');
Insert into tuition   values ('100636','1989','Air Force Communty College','CCAF Montgomery','84','Montgomery','AL','36112-661',null,'5337957235',null,'2','1','0','6','3','1','40','4','3','8','4','3','0','2','2','0','-1','-1','127','0.585969041');
Insert into tuition   values ('100636','1990','Air Force Communty College','CCAF Montgomery','84','Montgomery','AL','36112-661',null,'9789515569',null,'2','1','0','6','3','1','40','4','3','8','4','3','0','2','2','0','-1','-1','133.9','0.617805154');
Insert into tuition   values ('100636','1991','Air Force Communty College','CCAF Montgomery','84','Montgomery','AL','36112-661',null,'3017162111',null,'2','1','0','6','3','1','40','4','3','8','4','3','0','2','2','0','-1','-1','138.2','0.63764505');
Insert into tuition   values ('100636','1992','Air Force Communty College','CCAF Montgomery','84','Montgomery','AL','36112-661',null,null,'2528519080','2','1','0','6','3','1','40','4','3','8','4','3','0','2','2','0','-1','-1','142.5','0.657484947');
Insert into tuition   values ('100636','1993','Air Force Communty College','CCAF Montgomery','84','Montgomery','AL','36112-661','1552991404','1382848635','4065155336','2','1','0','6','3','1','40','4','3','8','4','3','0','2','2','0','-1','-1','146.2','0.674556486');
Insert into tuition   values ('100636','1994','Air Force Communty College','CCAF Montgomery','84','Montgomery','AL','36112-661','5471064125',null,'9049688102','2','1','0','6','3','1','40','4','3','8','4','3','0','2','2','0','-1','-1','150.4','0.69393499');
Insert into tuition   values ('100636','1995','Air Force Communty College','CCAF Montgomery','84','Montgomery','AL','36112-661',null,'5385833419',null,'2','1','0','6','3','1','40','4','3','8','4','3','0','2','2','0','-1','-1','154.5','0.7128521');
Insert into tuition   values ('100636','1996','Air Force Communty College','CCAF Montgomery','84','Montgomery','AL','36112-661',null,'8654771515',null,'2','1','0','6','3','1','40','4','3','8','4','3','0','2','2','0','-1','-1','158.9','0.73315339');
Insert into tuition   values ('100636','1997','Air Force Communty College','CCAF Montgomery','84','Montgomery','AL','36112-661',null,null,'6932869471','2','1','0','6','3','1','40','4','3','8','4','3','0','2','2','0','-1','-1','161.7','0.746072393');
Insert into tuition   values ('100636','1998','Air Force Communty College','CCAF Montgomery','84','Montgomery','AL','36112-661','4346406345','9637469991','1983538366','2','1','0','6','3','1','40','4','3','8','4','3','0','2','2','0','-1','-1','164.5','0.758991395');
Insert into tuition   values ('100636','1999','Air Force Communty College','CCAF Montgomery','84','Montgomery','AL','36112-661','3845764968','4753605151',null,'1','1','5','6','3','1','16','1','1','18','2','2','0','1','1','0','-1','-1','111.2','0.513068955');
Insert into tuition   values ('-100654','1987','Alabama A  and M University','AAMU','66','Normal','AL','35762','6685899898','2217726746',null,'1','1','5','6','3','1','16','1','1','18','2','2','0','1','1','0','-1','-1','115.8','0.534293031');
Insert into tuition   values ('-100654','1988','Alabama A  and M University','AAMU','66','Normal','AL','35762','6341375066','5361458188',null,'1','1','5','6','3','1','16','1','1','18','2','2','0','1','1','0','-1','-1','121.2','0.55920825');
Insert into tuition   values ('-100654','1989','Alabama A  and M University','AAMU','66','Normal','AL','35762',null,'8903282373','2024676545','1','1','5','6','3','1','16','1','1','18','2','2','0','1','1','0','-1','-1','127','0.585969041');
Insert into tuition   values ('-100654','1990','Alabama A  and M University','AAMU','66','Normal','AL','35762','2907559378','9211037204','5011705664','1','1','5','6','3','1','16','1','1','18','2','2','0','1','1','0','-1','-1','133.9','0.617805154');
Insert into tuition   values ('-100654','1991','Alabama A  and M University','AAMU','66','Normal','AL','35762','4867068357','2318120631',null,'1','1','5','6','3','1','16','1','1','18','2','2','0','1','1','0','-1','-1','138.2','0.63764505');
Insert into tuition   values ('-100654','1992','Alabama A  and M University','AAMU','66','Normal','AL','35762','4611263866',null,null,'1','1','5','6','3','1','16','1','1','18','2','2','0','1','1','0','-1','-1','142.5','0.657484947');
Insert into tuition   values ('-100654','1993','Alabama A  and M University','AAMU','66','Normal','AL','35762','8194093846','5839049341',null,'1','1','5','6','3','1','16','1','1','18','2','2','0','1','1','0','-1','-1','146.2','0.674556486');
Insert into tuition   values ('-100654','1994','Alabama A  and M University','AAMU','66','Normal','AL','35762','9903223801','9696555312',null,'1','1','5','6','3','1','16','1','1','18','2','2','0','1','1','0','-1','-1','150.4','0.69393499');
Insert into tuition   values ('-100654','1995','Alabama A  and M University','AAMU','66','Normal','AL','35762','1797187308',null,null,'1','1','5','6','3','1','16','1','1','18','2','2','0','1','1','0','-1','-1','154.5','0.7128521');
Insert into tuition   values ('-100654','1996','Alabama A  and M University','AAMU','66','Normal','AL','35762','6166055119','2055667216',null,'1','1','5','6','3','1','16','1','1','18','2','2','0','1','1','0','-1','-1','158.9','0.73315339');
Insert into tuition   values ('-100654','1997','Alabama A  and M University','AAMU','66','Normal','AL','35762','9123878017','9628667847',null,'1','1','5','6','3','1','16','1','1','18','2','2','0','1','1','0','-1','-1','161.7','0.746072393');
Insert into tuition   values ('-100654','1998','Alabama A  and M University','AAMU','66','Normal','AL','35762','1865471090',null,null,'1','1','5','6','3','1','16','1','1','18','2','2','0','1','1','0','-1','-1','164.5','0.758991395');
Insert into tuition   values ('-100654','1999','Alabama A  and M University','AAMU','66','Normal','AL','35762','4162931594','7825751998',null,'1','1','5','6','3','1','15','1','1','15','1','1','0','2','2','0','-1','-1','111.2','0.513068955');
Insert into tuition   values ('-100663','1987','University of Alabama at Birmingham','UA Birmingham','66','Birmingham','AL','35294-011','6264285610','6135376382','8517627585','1','1','5','6','3','1','15','1','1','15','1','1','0','2','2','0','-1','-1','115.8','0.534293031');
Insert into tuition   values ('-100663','1988','University of Alabama at Birmingham','UA Birmingham','66','Birmingham','AL','35294-011','6805293059','8042454497',null,'1','1','5','6','3','1','15','1','1','15','1','1','0','2','2','0','-1','-1','121.2','0.55920825');
Insert into tuition   values ('-100663','1989','University of Alabama at Birmingham','UA Birmingham','66','Birmingham','AL','35294-011','2354211447','3321104470',null,'1','1','5','6','3','1','15','1','1','15','1','1','0','2','2','0','-1','-1','127','0.585969041');
Insert into tuition   values ('-100663','1990','University of Alabama at Birmingham','UA Birmingham','66','Birmingham','AL','35294-011','2144226497','7405812110',null,'1','1','5','6','3','1','15','1','1','15','1','1','0','2','2','0','-1','-1','133.9','0.617805154');
Insert into tuition   values ('-100663','1991','University of Alabama at Birmingham','UA Birmingham','66','Birmingham','AL','35294-011','8787182434',null,null,'1','1','5','6','3','1','15','1','1','15','1','1','0','2','2','0','-1','-1','138.2','0.63764505');
Insert into tuition   values ('-100663','1992','University of Alabama at Birmingham','UA Birmingham','66','Birmingham','AL','35294-011','6036738708','1655322252',null,'1','1','5','6','3','1','15','1','1','15','1','1','0','2','2','0','-1','-1','142.5','0.657484947');
Insert into tuition   values ('-100663','1993','University of Alabama at Birmingham','UA Birmingham','66','Birmingham','AL','35294-011','2148422299','7431339930',null,'1','1','5','6','3','1','15','1','1','15','1','1','0','2','2','0','-1','-1','146.2','0.674556486');
Insert into tuition   values ('-100663','1994','University of Alabama at Birmingham','UA Birmingham','66','Birmingham','AL','35294-011','9217255102','9526373493',null,'1','1','5','6','3','1','15','1','1','15','1','1','0','2','2','0','-1','-1','150.4','0.69393499');
Insert into tuition   values ('-100663','1995','University of Alabama at Birmingham','UA Birmingham','66','Birmingham','AL','35294-011','8673158601',null,'7097858794','1','1','5','6','3','1','15','1','1','15','1','1','0','2','2','0','-1','-1','154.5','0.7128521');
Insert into tuition   values ('-100663','1996','University of Alabama at Birmingham','UA Birmingham','66','Birmingham','AL','35294-011','6334287279','8575156696',null,'1','1','5','6','3','1','15','1','1','15','1','1','0','2','2','0','-1','-1','158.9','0.73315339');
Insert into tuition   values ('-100663','1997','University of Alabama at Birmingham','UA Birmingham','66','Birmingham','AL','35294-011','6195125592','2715250203',null,'1','1','5','6','3','1','15','1','1','15','1','1','0','2','2','0','-1','-1','161.7','0.746072393');
Insert into tuition   values ('-100663','1998','University of Alabama at Birmingham','UA Birmingham','66','Birmingham','AL','35294-011','6076234567','9304852306',null,'1','1','5','6','3','1','15','1','1','15','1','1','0','2','2','0','-1','-1','164.5','0.758991395');
Insert into tuition   values ('-100663','1999','University of Alabama at Birmingham','UA Birmingham','66','Birmingham','AL','35294-011',null,'7546782912',null,'2','1','5','6','3','1','40','4','3','-3',null,null,'0','2','2','0','-1','-1','111.2','0.513068955');
Insert into tuition   values ('2127','1987','ALABAMA AVIATION AND TECHNICAL COLLEGE',null,'74','OZARK','AL','36360',null,'4501002695',null,'2','1','5','6','3','1','40','4','3','-3',null,null,'0','2','2','0','-1','-1','115.8','0.534293031');
Insert into tuition   values ('2127','1988','ALABAMA AVIATION AND TECHNICAL COLLEGE',null,'74','OZARK','AL','36360','7872965654','4441467656',null,'2','1','5','6','3','1','40','4','3','-3',null,null,'0','2','2','0','-1','-1','121.2','0.55920825');
Insert into tuition   values ('2127','1989','ALABAMA AVIATION AND TECHNICAL COLLEGE',null,'74','OZARK','AL','36360','2657215632','9654642456',null,'2','1','5','6','3','1','40','4','3','-3',null,null,'0','2','2','0','-1','-1','127','0.585969041');
Insert into tuition   values ('2127','1990','ALABAMA AVIATION AND TECHNICAL COLLEGE',null,'74','OZARK','AL','36360',null,'8609324044',null,'2','1','5','6','3','1','40','4','3','-3',null,null,'0','2','2','0','-1','-1','133.9','0.617805154');
Insert into tuition   values ('2127','1991','ALABAMA AVIATION AND TECHNICAL COLLEGE',null,'74','OZARK','AL','36360','6766951662','9434451736','3451818768','2','1','5','6','3','1','40','4','3','-3',null,null,'0','2','2','0','-1','-1','138.2','0.63764505');
Insert into tuition   values ('2127','1992','ALABAMA AVIATION AND TECHNICAL COLLEGE',null,'74','OZARK','AL','36360','7639887963',null,'3302006719','2','1','5','6','3','1','40','4','3','-3',null,null,'0','2','2','0','-1','-1','142.5','0.657484947');
Insert into tuition   values ('2127','1993','ALABAMA AVIATION AND TECHNICAL COLLEGE',null,'74','OZARK','AL','36360','6526488538','9363006448','9348712221','2','1','5','6','3','1','40','4','3','-3',null,null,'0','2','2','0','-1','-1','146.2','0.674556486');
Insert into tuition   values ('2127','1994','ALABAMA AVIATION AND TECHNICAL COLLEGE',null,'74','OZARK','AL','36360','3956432125',null,'8292937487','2','1','5','6','3','1','40','4','3','-3',null,null,'0','2','2','0','-1','-1','150.4','0.69393499');
Insert into tuition   values ('2127','1995','ALABAMA AVIATION AND TECHNICAL COLLEGE',null,'74','OZARK','AL','36360','4698026977','8135737940','8702700204','2','1','5','6','3','1','40','4','3','-3',null,null,'0','2','2','0','-1','-1','154.5','0.7128521');
Insert into tuition   values ('2127','1996','ALABAMA AVIATION AND TECHNICAL COLLEGE',null,'74','OZARK','AL','36360',null,'4335222776','5597403556','1','1','5','6','3','1','16','1','1','16','1','1','0','2','2','0','-1','-1','111.2','0.513068955');
Insert into tuition   values ('-100706','1987','University of Alabama in Huntsville','UAlabama Huntsville','66','Huntsville','AL','35899',null,null,'6818512208','1','1','5','6','3','1','16','1','1','16','1','1','0','2','2','0','-1','-1','115.8','0.534293031');
Insert into tuition   values ('-100706','1988','University of Alabama in Huntsville','UAlabama Huntsville','66','Huntsville','AL','35899','8079598430','5696362893','7774384515','1','1','5','6','3','1','16','1','1','16','1','1','0','2','2','0','-1','-1','121.2','0.55920825');
Insert into tuition   values ('-100706','1989','University of Alabama in Huntsville','UAlabama Huntsville','66','Huntsville','AL','35899','2216032594','6497828395','8438695868','1','1','5','6','3','1','16','1','1','16','1','1','0','2','2','0','-1','-1','127','0.585969041');
Insert into tuition   values ('-100706','1990','University of Alabama in Huntsville','UAlabama Huntsville','66','Huntsville','AL','35899','9619904542',null,'6254448803','1','1','5','6','3','1','16','1','1','16','1','1','0','2','2','0','-1','-1','133.9','0.617805154');
Insert into tuition   values ('-100706','1991','University of Alabama in Huntsville','UAlabama Huntsville','66','Huntsville','AL','35899',null,'9161116130','2827425739','1','1','5','6','3','1','16','1','1','16','1','1','0','2','2','0','-1','-1','138.2','0.63764505');
Insert into tuition   values ('-100706','1992','University of Alabama in Huntsville','UAlabama Huntsville','66','Huntsville','AL','35899',null,'6176622307','2606933944','1','1','5','6','3','1','16','1','1','16','1','1','0','2','2','0','-1','-1','142.5','0.657484947');
Insert into tuition   values ('-100706','1993','University of Alabama in Huntsville','UAlabama Huntsville','66','Huntsville','AL','35899','6599597586','2021688103','6705508059','1','1','5','6','3','1','16','1','1','16','1','1','0','2','2','0','-1','-1','146.2','0.674556486');
Insert into tuition   values ('-100706','1994','University of Alabama in Huntsville','UAlabama Huntsville','66','Huntsville','AL','35899','9747713591','9723134518','2728551736','1','1','5','6','3','1','16','1','1','16','1','1','0','2','2','0','-1','-1','150.4','0.69393499');
Insert into tuition   values ('-100706','1995','University of Alabama in Huntsville','UAlabama Huntsville','66','Huntsville','AL','35899','6952530912',null,'6226652556','1','1','5','6','3','1','16','1','1','16','1','1','0','2','2','0','-1','-1','154.5','0.7128521');
Insert into tuition   values ('-100706','1996','University of Alabama in Huntsville','UAlabama Huntsville','66','Huntsville','AL','35899',null,'9419849243','1196727528','1','1','5','6','3','1','16','1','1','16','1','1','0','2','2','0','-1','-1','158.9','0.73315339');
Insert into tuition   values ('-100706','1997','University of Alabama in Huntsville','UAlabama Huntsville','66','Huntsville','AL','35899',null,'2472568504','6598111022','1','1','5','6','3','1','16','1','1','16','1','1','0','2','2','0','-1','-1','161.7','0.746072393');
Insert into tuition   values ('-100706','1998','University of Alabama in Huntsville','UAlabama Huntsville','66','Huntsville','AL','35899','2158760897','6744499700','9732044168','1','1','5','6','3','1','16','1','1','16','1','1','0','2','2','0','-1','-1','164.5','0.758991395');
Insert into tuition   values ('-100706','1999','University of Alabama in Huntsville','UAlabama Huntsville','66','Huntsville','AL','35899',null,null,'2925850753','3','3','5','6','3','1','-3',null,null,'-3',null,null,'0','2','2','0','-1','-1','111.2','0.513068955');
Insert into tuition   values ('-100715','1987','ALABAMA STATE COLLEGE OF BARBER STYLING',null,'48','BIRMINGHAM','AL','35206','6228557524','2461289554','7509451521','3','3','5','6','3','1','-3',null,null,'-3',null,null,'0','2','2','0','-1','-1','115.8','0.534293031');
Insert into tuition   values ('-100715','1988','ALABAMA STATE COLLEGE OF BARBER STYLING',null,'48','BIRMINGHAM','AL','35206','4583924750','1045940639','2428316761','3','3','5','6','3','1','-3',null,null,'-3',null,null,'0','2','2','0','-1','-1','121.2','0.55920825');
Insert into tuition   values ('-100715','1989','ALABAMA STATE COLLEGE OF BARBER STYLING',null,'48','BIRMINGHAM','AL','35206','7955900527','1266763716','3403520825','1','1','5','6','3','1','21','2','2','18','2','2','0','2','1','0','-1','-1','111.2','0.513068955');
Insert into tuition   values ('-100724','1987','Alabama State University','Alabama State','66','Montgomery','AL','36101-027','8423763008',null,'7527591621','1','1','5','6','3','1','21','2','2','18','2','2','0','2','1','0','-1','-1','115.8','0.534293031');
Insert into tuition   values ('-100724','1988','Alabama State University','Alabama State','66','Montgomery','AL','36101-027','3271802176','6652014174','4408366315','1','1','5','6','3','1','21','2','2','18','2','2','0','2','1','0','-1','-1','121.2','0.55920825');
Insert into tuition   values ('-100724','1989','Alabama State University','Alabama State','66','Montgomery','AL','36101-027',null,'4087971690','4258548547','1','1','5','6','3','1','21','2','2','18','2','2','0','2','1','0','-1','-1','127','0.585969041');
Insert into tuition   values ('-100724','1990','Alabama State University','Alabama State','66','Montgomery','AL','36101-027','5989558606','8544241960','1662135553','1','1','5','6','3','1','21','2','2','18','2','2','0','2','1','0','-1','-1','133.9','0.617805154');
Insert into tuition   values ('-100724','1991','Alabama State University','Alabama State','66','Montgomery','AL','36101-027',null,null,'7665737975','1','1','5','6','3','1','21','2','2','18','2','2','0','2','1','0','-1','-1','138.2','0.63764505');
Insert into tuition   values ('-100724','1992','Alabama State University','Alabama State','66','Montgomery','AL','36101-027',null,'3529807897','3959623124','1','1','5','6','3','1','21','2','2','18','2','2','0','2','1','0','-1','-1','142.5','0.657484947');
Insert into tuition   values ('-100724','1993','Alabama State University','Alabama State','66','Montgomery','AL','36101-027',null,'4925929677','8834384551','1','1','5','6','3','1','21','2','2','18','2','2','0','2','1','0','-1','-1','146.2','0.674556486');
Insert into tuition   values ('-100724','1994','Alabama State University','Alabama State','66','Montgomery','AL','36101-027','5019484995','5316645704','7159329918','1','1','5','6','3','1','21','2','2','18','2','2','0','2','1','0','-1','-1','150.4','0.69393499');
Insert into tuition   values ('-100724','1995','Alabama State University','Alabama State','66','Montgomery','AL','36101-027','5726295920','7568527291','6209050383','1','1','5','6','3','1','21','2','2','18','2','2','0','2','1','0','-1','-1','154.5','0.7128521');
Insert into tuition   values ('-100724','1996','Alabama State University','Alabama State','66','Montgomery','AL','36101-027','6006151061','4098341207','8782381745','1','1','5','6','3','1','21','2','2','18','2','2','0','2','1','0','-1','-1','158.9','0.73315339');
Insert into tuition   values ('-100724','1997','Alabama State University','Alabama State','66','Montgomery','AL','36101-027',null,null,'7872813863','1','1','5','6','3','1','21','2','2','18','2','2','0','2','1','0','-1','-1','161.7','0.746072393');
Insert into tuition   values ('-100724','1998','Alabama State University','Alabama State','66','Montgomery','AL','36101-027',null,'7778010639','1363818767','1','1','5','6','3','1','21','2','2','18','2','2','0','2','1','0','-1','-1','164.5','0.758991395');
Insert into tuition   values ('-100724','1999','Alabama State University','Alabama State','66','Montgomery','AL','36101-027','3255209401','4126487154','3415619363','1','1','5','6','3','1','-3',null,null,'-3',null,null,'0','2','2','0','-1','-1','111.2','0.513068955');
Insert into tuition   values ('-100733','1987','University of Alabama System Office',null,'66','Tuscaloosa','AL','35401','2205821833','2086880923','5998375789','1','1','5','6','3','1','-3',null,null,'-3',null,null,'0','2','2','0','-1','-1','115.8','0.534293031');
Insert into tuition   values ('-100733','1988','University of Alabama System Office',null,'66','Tuscaloosa','AL','35401',null,'8164577943','3048641040','1','1','5','6','3','1','-3',null,null,'-3',null,null,'0','2','2','0','-1','-1','121.2','0.55920825');
Insert into tuition   values ('-100733','1989','University of Alabama System Office',null,'66','Tuscaloosa','AL','35401',null,null,'7375371034','1','1','5','6','3','1','-3',null,null,'-3',null,null,'0','2','2','0','-1','-1','127','0.585969041');
Insert into tuition   values ('-100733','1990','University of Alabama System Office',null,'66','Tuscaloosa','AL','35401','2598758981','9235949536','1703010475','1','1','5','6','3','1','-3',null,null,'-3',null,null,'0','2','2','0','-1','-1','133.9','0.617805154');
Insert into tuition   values ('-100733','1991','University of Alabama System Office',null,'66','Tuscaloosa','AL','35401','2451358498','8886525043','4153082387','1','1','5','6','3','1','-3',null,null,'-3',null,null,'0','2','2','0','-1','-1','138.2','0.63764505');
Insert into tuition   values ('-100733','1992','University of Alabama System Office',null,'66','Tuscaloosa','AL','35401',null,'6393705098','7803344802','1','1','5','6','3','1','-3',null,null,'-3',null,null,'0','2','2','0','-1','-1','142.5','0.657484947');
Insert into tuition   values ('-100733','1993','University of Alabama System Office',null,'66','Tuscaloosa','AL','35401','8668097455','9598609277','7573926932','1','1','5','6','3','1','-3',null,null,'-3',null,null,'0','2','2','0','-1','-1','146.2','0.674556486');
Insert into tuition   values ('-100733','1994','University of Alabama System Office',null,'66','Tuscaloosa','AL','35401','3614056086','4509592953','6834093338','1','1','5','6','3','1','-3',null,null,'-3',null,null,'0','2','2','0','-1','-1','150.4','0.69393499');
Insert into tuition   values ('-100733','1995','University of Alabama System Office',null,'66','Tuscaloosa','AL','35401','9066666312','1272774554','7756699168','1','1','5','6','3','1','-3',null,null,'-3',null,null,'0','2','2','0','-1','-1','154.5','0.7128521');
Insert into tuition   values ('-100733','1996','University of Alabama System Office',null,'66','Tuscaloosa','AL','35401','2846848999','9246418566','1285494840','1','1','5','6','3','1','-3',null,null,'-3',null,null,'0','2','2','0','-1','-1','158.9','0.73315339');
Insert into tuition   values ('-100733','1997','University of Alabama System Office',null,'66','Tuscaloosa','AL','35401',null,null,'2448640852','1','1','5','6','3','1','-3',null,null,'-3',null,null,'0','2','2','0','-1','-1','161.7','0.746072393');
Insert into tuition   values ('-100733','1998','University of Alabama System Office',null,'66','Tuscaloosa','AL','35401',null,'7672493196','9749288679','1','1','5','6','3','1','-3',null,null,'-3',null,null,'0','2','2','0','-1','-1','164.5','0.758991395');
Insert into tuition   values ('-100733','1999','University of Alabama System Office',null,'66','Tuscaloosa','AL','35401','4341767493','8044164608','3484470828','2','1','5','6','3','1','-3',null,null,'-3',null,null,'0','2','2','0','-1','-1','111.2','0.513068955');
Insert into tuition   values ('-100742','1987','ALABAMA TECHNICAL COLLEGE',null,'69','GADSDEN','AL','35999','3358054051',null,'5067034794','1','1','5','6','3','1','15','1','1','16','1','1','1','2','2','0','-1','-1','111.2','0.513068955');
Insert into tuition   values ('1733','1987','The University of Alabama','UA Tuscaloosa','66','Tuscaloosa','AL','35487-016',null,'5459908660','2117803253','1','1','5','6','3','1','15','1','1','16','1','1','1','2','2','0','-1','-1','115.8','0.534293031');
Insert into tuition   values ('1733','1988','The University of Alabama','UA Tuscaloosa','66','Tuscaloosa','AL','35487-016',null,'7015514173','9528271531','1','1','5','6','3','1','15','1','1','16','1','1','1','2','2','0','-1','-1','121.2','0.55920825');
Insert into tuition   values ('1733','1989','The University of Alabama','UA Tuscaloosa','66','Tuscaloosa','AL','35487-016','8263396768',null,'8147380709','1','1','5','6','3','1','15','1','1','16','1','1','1','2','2','0','-1','-1','127','0.585969041');
Insert into tuition   values ('1733','1990','The University of Alabama','UA Tuscaloosa','66','Tuscaloosa','AL','35487-016','5366789545','2617161332','5813176690','1','1','5','6','3','1','15','1','1','16','1','1','1','2','2','0','-1','-1','133.9','0.617805154');
Insert into tuition   values ('1733','1991','The University of Alabama','UA Tuscaloosa','66','Tuscaloosa','AL','35487-016',null,'6938872236','4955959315','1','1','5','6','3','1','15','1','1','16','1','1','1','2','2','0','-1','-1','138.2','0.63764505');
Insert into tuition   values ('1733','1992','The University of Alabama','UA Tuscaloosa','66','Tuscaloosa','AL','35487-016','6217916256','4515438585','1927137387','1','1','5','6','3','1','15','1','1','16','1','1','1','2','2','0','-1','-1','142.5','0.657484947');
Insert into tuition   values ('1733','1993','The University of Alabama','UA Tuscaloosa','66','Tuscaloosa','AL','35487-016','1228594502','5512068034','5096004174','1','1','5','6','3','1','15','1','1','16','1','1','1','2','2','0','-1','-1','146.2','0.674556486');
Insert into tuition   values ('1733','1994','The University of Alabama','UA Tuscaloosa','66','Tuscaloosa','AL','35487-016','7265765051','5046066452','5113482151','1','1','5','6','3','1','15','1','1','16','1','1','1','2','2','0','-1','-1','150.4','0.69393499');
Insert into tuition   values ('1733','1995','The University of Alabama','UA Tuscaloosa','66','Tuscaloosa','AL','35487-016',null,'4866617737','9272022769','1','1','5','6','3','1','15','1','1','16','1','1','1','2','2','0','-1','-1','154.5','0.7128521');
Insert into tuition   values ('1733','1996','The University of Alabama','UA Tuscaloosa','66','Tuscaloosa','AL','35487-016','5472708765',null,'2778915639','1','1','5','6','3','1','15','1','1','16','1','1','1','2','2','0','-1','-1','158.9','0.73315339');
Insert into tuition   values ('1733','1997','The University of Alabama','UA Tuscaloosa','66','Tuscaloosa','AL','35487-016','7012979288','5772261862','2672192397','1','1','5','6','3','1','15','1','1','16','1','1','1','2','2','0','-1','-1','161.7','0.746072393');
Insert into tuition   values ('1733','1998','The University of Alabama','UA Tuscaloosa','66','Tuscaloosa','AL','35487-016','6177738352','6973224225','2464512622','1','1','5','6','3','1','15','1','1','16','1','1','1','2','2','0','-1','-1','164.5','0.758991395');
Insert into tuition   values ('1733','1999','The University of Alabama','UA Tuscaloosa','66','Tuscaloosa','AL','35487-016','1436775223','5711481628','6769229358','2','1','5','6','3','1','40','4','3','2','4','3','0','2','2','0','-1','-1','111.2','0.513068955');
Insert into tuition   values ('-100760','1987','Central Alabama Community College','Central Alabama Community College','30','Alexander City','AL','35010',null,'9528371269','9408924624','2','1','5','6','3','1','40','4','3','2','4','3','0','2','2','0','-1','-1','115.8','0.534293031');
Insert into tuition   values ('-100760','1988','Central Alabama Community College','Central Alabama Community College','30','Alexander City','AL','35010','3462798856','5087636817','1091316967','2','1','5','6','3','1','40','4','3','2','4','3','0','2','2','0','-1','-1','121.2','0.55920825');
Insert into tuition   values ('-100760','1989','Central Alabama Community College','Central Alabama Community College','30','Alexander City','AL','35010','1816936332','1721522738','6865618511','2','1','5','6','3','1','40','4','3','2','4','3','0','2','2','0','-1','-1','127','0.585969041');
Insert into tuition   values ('-100760','1990','Central Alabama Community College','Central Alabama Community College','30','Alexander City','AL','35010','2481297627',null,'6983062232','2','1','5','6','3','1','40','4','3','2','4','3','0','2','2','0','-1','-1','133.9','0.617805154');
Insert into tuition   values ('-100760','1991','Central Alabama Community College','Central Alabama Community College','30','Alexander City','AL','35010','1696387540','8777340824','8872088769','2','1','5','6','3','1','40','4','3','2','4','3','0','2','2','0','-1','-1','138.2','0.63764505');
Insert into tuition   values ('-100760','1992','Central Alabama Community College','Central Alabama Community College','30','Alexander City','AL','35010','2645110309','2156776059','1631573059','2','1','5','6','3','1','40','4','3','2','4','3','0','2','2','0','-1','-1','142.5','0.657484947');
Insert into tuition   values ('-100760','1993','Central Alabama Community College','Central Alabama Community College','30','Alexander City','AL','35010','2593007956','4625694224','2518783432','2','1','5','6','3','1','40','4','3','2','4','3','0','2','2','0','-1','-1','146.2','0.674556486');
Insert into tuition   values ('-100760','1994','Central Alabama Community College','Central Alabama Community College','30','Alexander City','AL','35010','1102623663',null,'9985036458','2','1','5','6','3','1','40','4','3','2','4','3','0','2','2','0','-1','-1','150.4','0.69393499');
Insert into tuition   values ('-100760','1995','Central Alabama Community College','Central Alabama Community College','30','Alexander City','AL','35010',null,null,'6875133598','2','1','5','6','3','1','40','4','3','2','4','3','0','2','2','0','-1','-1','154.5','0.7128521');
Insert into tuition   values ('-100760','1996','Central Alabama Community College','Central Alabama Community College','30','Alexander City','AL','35010','5029229452','3079290964','4183834542','2','1','5','6','3','1','40','4','3','2','4','3','0','2','2','0','-1','-1','158.9','0.73315339');
Insert into tuition   values ('-100760','1997','Central Alabama Community College','Central Alabama Community College','30','Alexander City','AL','35010','5483899114','3177334292','7746069131','2','1','5','6','3','1','40','4','3','2','4','3','0','2','2','0','-1','-1','161.7','0.746072393');
Insert into tuition   values ('-100760','1998','Central Alabama Community College','Central Alabama Community College','30','Alexander City','AL','35010','3349414860','5552765329','8795028487','2','1','5','6','3','1','40','4','3','2','4','3','0','2','2','0','-1','-1','164.5','0.758991395');
Insert into tuition   values ('-100760','1999','Central Alabama Community College','Central Alabama Community College','30','Alexander City','AL','35010',null,'2342240238','2024227856','1','2','5','6','3','1','-3',null,null,'-3',null,null,'0','2','2','0','-1','-1','111.2','0.513068955');
Insert into tuition   values ('-100779','1987','AMERICAN INST PSYCHOTHERAPY-GRAD SCH PROF PSYCH',null,'74','HUNTSVILLE','AL','358015611','1934713053','8295699630','9231532000','1','2','5','6','3','1','-3',null,null,'-3',null,null,'0','2','2','0','-1','-1','115.8','0.534293031');
Insert into tuition   values ('-100779','1988','AMERICAN INST PSYCHOTHERAPY-GRAD SCH PROF PSYCH',null,'74','HUNTSVILLE','AL','358015611','8481612725',null,'8665068306','1','2','5','6','3','1','-3',null,null,'-3',null,null,'0','2','2','0','-1','-1','121.2','0.55920825');
Insert into tuition   values ('-100779','1989','AMERICAN INST PSYCHOTHERAPY-GRAD SCH PROF PSYCH',null,'74','HUNTSVILLE','AL','358015611','7065036213','9354270053','8515850118','1','2','5','6','3','1','-3',null,null,'-3',null,null,'0','2','2','0','-1','-1','127','0.585969041');
Insert into tuition   values ('-100779','1990','AMERICAN INST PSYCHOTHERAPY-GRAD SCH PROF PSYCH',null,'74','HUNTSVILLE','AL','358015611','5183144953',null,'2747020567','1','2','5','6','3','1','-3',null,null,'-3',null,null,'0','2','2','0','-1','-1','133.9','0.617805154');
Insert into tuition   values ('-100779','1991','AMERICAN INST PSYCHOTHERAPY-GRAD SCH PROF PSYCH',null,'74','HUNTSVILLE','AL','358015611',null,null,'3054063286','1','2','5','6','3','1','-3',null,null,'-3',null,null,'0','2','2','0','-1','-1','138.2','0.63764505');
Insert into tuition   values ('-100779','1992','AMERICAN INST PSYCHOTHERAPY-GRAD SCH PROF PSYCH',null,'74','HUNTSVILLE','AL','358015611','6786007857','5232302690','7749031350','1','2','5','6','3','1','-3',null,null,'-3',null,null,'0','2','2','0','-1','-1','142.5','0.657484947');





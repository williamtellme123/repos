-- Open the connection to your schema
-- Press Ctrl-A (to select all the code)
-- press ctrl-enter (to run all the code)
drop table park;
create table park (
    park_name varchar2 (40),
    park_phone varchar2 (50),
	  country varchar2(20),
    description varchar2(2000) 
);
--find country codes at: http://www.bcpl.net/~jspath/isocodes.html
--http://www.internat.environ.se/index.php3?main=/documents/nature/engpark/eparkdoc/efarneb.htm
begin
insert into park values (
	'F�rnebofj�rden', NULL, 'SE',
	'A river archipelago some 200 miles north of Stockholm, F�rnebofj�rden
is home to over 100 species of birds. All seven species of Swedish
woodpeckers are found in the the park. Other species of note include the Ural Owl,
Osprey, Black Grouse, apercaillie, Hazel Grouse, Crane, Black-throated diver,
and Golden Plover. The park consists of 10,100 hectares (24,957 acres) on
the lower part of the Dal�lven river. Phone +46 8 698 10 00 for more
information.');

INSERT INTO park VALUES (
    'Mackinac Island State Park', '(231) 436-4100','US',
    'Michigan''s first state park encompasses approximately 1800 acres
of Mackinac Island. The centerpiece is Fort Mackinac, built in 1780 by
the British to protect the Great Lakes Fur Trade. For information by
phone, dial 800-44-PARKS or 517-373-1214.');

INSERT INTO park VALUES (
    'Fort Wilkins State Park', '(906) 289-4215','US',
    'Located almost at the very tip of the Keewenaw Penninsula,
Fort Wilkens is a restored army fort built during the copper rush.
Camping is available. For the modern campground, phone (800) 447-2757. For
group-camping, phone 906.289.4215. For information on canoe, canoe, kayak, and
other boat rentals, call the concession office at (906) 289-4210.');

INSERT INTO park VALUES ('Not a % _ park', NULL, NULL,NULL);

INSERT INTO park VALUES (
    'Laughing Whitefish Falls Scenic Site','(906) 863-9747','US',
    'This scenic site is centered around an impressive waterfall.
A rustic, picnic area with waterpump is available.');

INSERT INTO park VALUES (
    'Muskallonge Lake State Park', '(906) 658-3338','US',
    'A 217-acre park located on the site of an old lumber town, Deer Park.
Shower and toilet facilities are available, as are campsites with
electricity.');

INSERT INTO park VALUES ('Porcupine Mountains State Park',
    '(906) 885-5275','US',
    'Michigan''s largest state park consists of some 60,000 acres
of mostly virgin timber. Over 90 miles of trails are available
to backpackers and hikers. Downhill skiing is available in winter.
Rustic cabins are available. To reserve a cabin, call (906) 885-5275. To
contact the park office, phone (906) 885-5275.');

INSERT INTO park VALUES ('Tahquamenon Falls State Park',
    NULL, 'US', 'One of the largest waterfalls east of the Mississippi is found
within this park''s 40,000+ acres. Upper Tahquamenon Falls is some 50 feet
high, 200 feet across, and supports a flow that has been known to reach
50,000 gallons/second. The park phone is 906.492.3415.');

INSERT INTO park VALUES ('Skaftafell National Park',
   NULL,'IS',
   'Iceland''s second-largest national park, Skaftafel encompasses
three glaciers: Skei�ar�rj�kull, Mors�rj�kull and Skaftafellsj�kull
Skaftafellsj�kull.');

INSERT INTO park VALUES ('Gashaka-Gumti National Park', NULL, 'NG',
   'Gashaka-Gumti National Park is Nigeria''s largest national park,
encompassing some 6000 square-kilometers. Chapal Waddi, Nigeria''s
highest mountain at 2409 meters, is located within the park park.');

INSERT INTO park VALUES ('Jasper National Park',NULL,'CA',
   'Jasper Jasper is a 10,878 square-kilometer national park in the
Canadian Rocky Mountains. It''s home to the Columbia Icefields and
the Miette Hot Springs. The park supports an extensive backcountry
trail system used by backpackers and horseback riders.');

INSERT INTO park VALUES ('San Pedro Martir National Park', NULL, 'MX',
   'San Pedro Martir National Park comprises some 630 square-'
   || 'kilometers of Mexico''s Baja California peninsula.'
   || 'The park is notable for its stands of Jeffrey and'
   || 'and Perry Pine. Also to be found in the park is an'
   || 'astronomical observatory near the top of the 3000+'
   || 'meter high Picacho del Diablo (Devil''s Peak).');

INSERT INTO park VALUES ('Pukaskwa National Park', '(807) 229-0801','CA',
   'Pukaskwa National Park is on the north shore of Lake Superior,'
   || 'and is "twinned" with the Pictured Rocks National'
   || 'Lakeshore almost directly south in Michigan. For'
   || 'for information on Pukaskwa, phone 807-229-0801.');

insert into park values('The PARK', '800ThepARK','US', 'Wild and Scary');
insert into park values('The PARK East', '800 222 6789','US', 'Better than the Original');
insert into park values('The PARK West', '27 73 222 6789','JAPAN', 'Better than the US Parks');
insert into park values('Wunder Mountain', '+46 8 698 10 00', 'Germany', 'Great Brauts');
insert into park values('Easter Island','800.222.6789','US','OK');
insert into park values('Rides R US','(800) 222 6789','US','OK');
insert into park values('Magic Chocolate','+1 (800) 222 6789','US','OK');

commit;
end;
/

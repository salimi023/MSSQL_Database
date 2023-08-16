# TBT ADATBÁZIS

## RENDELTETÉS

Az adatbázis rendeltetése a TBT cégregisztrációs alkalmazás adatainak tárolása és kezelése

## AZ ADATBÁZIS ELEMEI

### Séma

Az adatbázis alapsémáját a **schema.sql** tartalmazza
Az adatbázis az alábbi sémákból és táblákból áll:

### Séma: clearance (Biztonsági ellenőrzöttség szintjei)

1. clearance.clearance: A cégek biztonsági ellenőrzöttségének szintjei (pl. Szigorúan Titkos)

- a tábla tartalmazza a biztonsági ellenőrzöttség szintjének nevét

### Séma: address (Cím és nemzetiségi adatok)

1. address.nationality: nemzetiségek nevei és kódja

2. address.zip_city: Települések v. településrészek nevei a hozzájuk tartozó irányítószámokkal és nemzetiséggel (FK address.nationality)

### Séma: financial (Banki adatok)

1. financial.bank: pénzintézetek nevei és címe

### Séma: business (Cégadatok)

1. business.profile: cégadatok: specifikus cégadatok

2. business.bank_account: cégek bankszámlái

3. business.teaor: TEÁOR kódok és a hozzájuk tartozó tevékenység nevek

4. business.activities: a cégek tevékenységei a főtevékenység megkülönböztetésével

5. business.site_types: cég telephelyek típusai

6. business.sites: cégek telephelyei címekkel és a típus megadásával

7. business.entity_type: cégek partnereinek típusai

8. business.other_entities: cégek partnereink specifikus adatai

9. business.entity_nationality: cégpartnerek nemzetisége

10. business.entity_relation_types: partner kapcsolat típusa

11. business.relations: cégek és más entitások kapcsolatai

### Séma: authorities (Hatóságok, Intézmények)

1. authorities.type: hatóságok típusai

2. authorities.authorities: hatóságok specifikus adatai

### Séma: staff (alkalmazottak)

1. staff.positions: beosztások nevei

2. staff.members: alkalmazottak specifikus adatai

### Séma: users (felhasználók)

1. users.users: az alkalmazás felhasználóinak specifikus adatai

A táblákban alkalmazott **constraint-ek** az alábbiak:

- PRIMARY KEY: mindegyik táblában
- FOREIGN KEY: értelemszerűen a táblák közötti kapcsolatok megvalósítása céljából
- NOT NULL: a kötelezően megadandó adatok esetében
- DEFAULT: bizonyos adatok alapértelmezett értékének meghatározása céljából
- CHECK: bizonyos adatok értékének ellenőrzése céljából
- UNIQUE: adatok egyediségének biztosítása céljából

### Adatok

Az adatbázis példadatokkal történő feltöltése a **data.sql-ből** történik

### Backup&Restore

Az adatbázis mentését és helyreállítását a **backup.sql** és a **backup_scheduled.sql** fájlok tartalmazzák

1. Mentés és helyreállítás

A backup.sql fájlban külön láthatók a következők mentések kódjai:

- adatbázis teljes mentése (full backup)

- adatbázis differenciális mentése (differential backup)

- adatbázis tranzakció mentése (trancactional backup)

A mentések egyben, illetve külön-külön is lefutatthatók

Szintén a backup.sql tartalmazza az adatbázis teljes helyreállítását végző kódot, amelyet a kód az adatbázis teljes mentéséből végez

Az adatbázis időzített napi mentésének kódja a backup_scheduled.sql fájlban található

### Skaláris funkció

A funkciót a **function.sql** fájl tartalmazza

A funkció az alábbi megadott paraméterekből kiválasztja az adott alkalmazott teljes nevét.

Paraméterek:

- cég rövíditett magyar neve,
- alkalmazott pozíciója

### Felhasználói jogok

A felhasználókat és a felhasználói jogokat a **roles.sql** fájl tartalmazza

A fájlban három felhasználó szerepel az alábbi hozzáférési jogokkal

- Teszt Elek: db_owner

- John Doe: db_datawriter

- Jane Doe: db_datareader

A fájl szintén tartalmaz egy applikáció hozzáférést biztosító kódrészletet, amely a business_profile nevű applikációnak biztosít hozzáférést alapértelmezetten a 'business' sémához

### Tárolt eljárások

A tárolt eljárásokat a **stored_procedures.sql** fájl tartalmazza

Az eljárások az alábbiak:

1. 'SELECT' típusú tárolt eljárás

Az eljárás a biztonsági ellenőrzés szintje szerint, amely egy paraméterben kerül megadásra, cégenként a következő adatokat kérdezi le:

- cégnév
- cégjegyzékszám
- cégalapítás dátuma

2. 'INSERT' típusú tárolt eljárás tranzakcióval

Az eljárás a megadott paraméterek alapján menti az adatbázisban egy új alkalmazott adatait. Amennyiben valamelyik paraméterben megadott kötelező adat hiányzik, vagy nem felel meg az adatbázisban tárolt adattípusoknak a tranzakció előtti helyzet visszaállításra kerül

3. 'INSERT' típusú tárolt eljárás hibakezeléssel

Az eljárás a megadott paraméterek alapján elmenti az adott céghez tartozó új bankszámla számát, amennyiben a bankszámla még nem szerepel az adatbázisban. Ha a mentés bármilyen oknál fogva meghiúsul az eljárás a hibára vonatkozó üzenettel tér vissza

### Triggerek

Az adatbázisban tárolt két triggert a **triggers.sql** fájl tartalmazza

A triggerek az alábbiak:

1. CheckAccountNumber

Hatókör: [business].[bank_account]

Esemény: INSERT

A trigger célja, hogy a cégekhez tartozó bankszámlaszámokat az adatbázisba történő mentés előtt ellenőrizze és egyezés esetén a mentést megakadályozza

2. PreventDropTable

Hatókör: teljes adatbázis

Esemény: DROP_TABLE

A trigger célja, hogy megakadályozza a táblák törlését az adatbázisból

### Views

Az adatbázisban tárolt három VIEW-t a **view.sql** tartalmazza

A VIEW-k az alábbiak:

1. FinancialData

Táblák:

- [business].[profile]
- [business].[bank_account]
- [financial].[bank]
- [address].[zip_city]

Szürő:

- biztonsági ellenőrzöttség neve

A VIEW a biztonsági ellenőrzöttség fokának megfelelően lekérdezi a cégek alábbi pénzügyi adatait:

- cég rövidített neve,
- számlavezető pénzintézet neve,
- számlavezető pénzintézet címe,
- számlaszám

2. BusinessActivities

Táblák:

- [business].[profile]
- [business].[activities]
- [business].[teaor]

Szürő:

- főtevékenység

A VIEW a megadott táblák összekapcsolásával cégenként lekérdezi a főtevékenységeket és megjeleníti az alábbi adatokat:

- cég rövidített neve,
- TEÁOR kód,
- tevékenység megnevezése

3. StaffMembers

Táblák:

- [business].[profile]
- [staff].[positions]
- [address].[nationality]
- [address].[zip_city]

A VIEW a megadott táblák összekapcsolásával az alkalmazottak következő adatait kérdezi le:

- cég rövidített neve,
- alkalmazott teljes neve,
- pozíció megnevezése,
- alkalmazott nemzetisége,
- alkalmazott címe,
- alkalmazott telefonszáma,
- alkalmazott email címe

### Indexek

1. Clustered Index

Alapvetően minden tábla tartalmaz INT típusú elsődleges kulcsokat, amelyek Clustered Index-ként is működnek

2. Non-Clustered Index

Az adatbázis három Non-Clustered Index-et tartalmaz, amelyek az alábbiak:

- IX_StaffMembersByBusiness

Tábla: [staff].[members]

Az Index cégenként rendezi az adatbázisban szereplő alkalmazottakat

- IX_BankAccountByBusiness

Tábla: [business].[bank_account]

Az Index cégenként rendezi az adatbázisban szereplő bankszámlaszámokat

- IX_BankAccountByBanks

Tábla: [business].[bank_account]

Az Index bankonként rendezi az adatbázisban szereplő bankszámlaszámokat

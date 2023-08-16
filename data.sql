/* DATA UPLOAD FILE */

USE TBT
GO

/* Schema: clearance */

-- clearance.clearance 
INSERT INTO [clearance].[clearance] (cl_name) VALUES
    ('Szigorúan Titkos!'),
    ('Titkos'),
    ('Bizalmas')
GO

/* Schema: address */

-- address.nationality
INSERT INTO [address].[nationality] (nationality_name, nationality_code) VALUES
    ('magyar', 'HU'),
    ('brit', 'GB'),
    ('szlovák', 'SK'),
    ('német', 'GE')
GO

-- address.zip_city 
INSERT INTO [address].[zip_city] (zip_code, zip_city, nationality_id) VALUES
    ('1132', 'Budapest', 1), -- RRB seat
    ('9200', 'Mosonmagyaróvár', 1), -- RRB bank 1.
    ('9201', 'Győr', 1), -- RRB bank 2
    ('SK-83000', 'Bratislava', 2), -- RRB tag
    ('SK-82102', 'Bratislava', 2), -- RRB member
    ('4026', 'Debrecen', 1), -- RRB member
    ('1138', 'Budapest', 1),-- Naveg Gmbh bank
    ('DE-40477', 'Düsseldorf', 3), -- Naveg member
    ('2142', 'Nagytarcsa', 1), -- Roaster seat
    ('1027', 'Budapest', 1), -- Roaster bank
    ('2120', 'Dunakeszi', 1) -- Roaster member

GO

/* Schema: financial */
INSERT INTO [financial].[bank](bank_name, bank_zip_city, bank_address) VALUES
    ('OTP Bank Nyrt Mosonmagyaróvári Fiók', 2, 'Fő utca 24.'),
    ('OTP Győr-Moson-S.m. Belföldiek Devizái', 3, 'Árpád u. 36.'),
    ('Erste Bank Hungary Nyrt', 7, 'Népfürdő utca 24-26.'),
    ('CIB Bank Zrt', 10, 'Medve utca 4.')
GO

/* Schema: business */

-- business.profile
INSERT INTO [business].[profile](
    bs_clearance,
    bs_fullName_hu,
    bs_shortName_hu,
    bs_fullName_en,
    bs_shortName_en,
    bs_statistical_num,
    bs_tax_number,
    bs_registry_number,
    bs_capital_amount,
    bs_foundation_date,
    bs_seat_city,
    bs_seat_address,
    bs_PO_box,
    bs_phone,
    bs_email,
    bs_nonNATO_nonEU_rel,
    bs_CEO_foreign_rel,
    bs_foreign_inf_attempt,
    bs_mil_project,
    bs_classified_contr,
    bs_other_info
) VALUES
(1, 'RRB Kontrol Magyarország Kft.', 'RRB Kontrol Kft.', 'RRB Control Hungary Ltd.', 'RRB Control Ltd.', '36815036-5322-123-01', '36815036-2-53', '11-19-441750', 3000000.00, '2018-04-11', 1, 'Alkotás utca 53', NULL, '+36-1-553-442000', 'rrb@kontrol.hu', 1, 1, 1, 1, 1, NULL),
(2, 'Naveg Gmbh Magyarország Bt.', 'Naveg Bt.', 'Naveg Gmbh Hungary', 'Naveg Hungary', '38922578-5679-326-11', ' 38922578-3-51', '11-27-102362', 2000000.00, '2018-09-16', 7, 'Váci út 56', '1062', '+36-30-4789-321', 'naveg@gmbh.com', 1, 2, 2, 1, 2, NULL),
(3, 'Roaster Nets Kft.', 'Roaster Kft.', 'Roaster Nets Ltd', 'Roaster Ltd.', '14297051-7222-123-33', ' 23388051-3-23', '23-19-303169', 10000000.00, '2010-01-04', 9, 'Bazalt utca 3.', NULL, '+36-20-999-65412', 'roaster@ltd.inf', 2, 1, 2 , 1, 1, NULL)
GO

-- business.bank_account
INSERT INTO [business].[bank_account](acc_business, acc_bank, acc_number) VALUES
    (1, 1, '11747086-33827447-00000000'),
    (1, 2, '11773388-62135897-00000000'),
    (1, 1, '11747086-33832812-00000000'),
    (2, 3, '11610106-00000000-85264400'),
    (2, 3, '11620306-00000000-96164427'),
    (3, 4, '10710124-34542131-51000015'),
    (3, 4, '10720224-54562801-53101005'),
    (3, 4, '10752824-28536107-56100122')
GO

-- business.teaor
INSERT INTO [business].[teaor](teaor_code, teaor_name) VALUES
    ('4321', 'Villanyszerelés'), -- RRB főtevékenység
    ('4110', 'Épületépítési projekt szervezése'), -- RRB melléktevékenység
    ('4669', 'Egyéb m.n.s. gép, berendezés nagykereskedelme'), -- Naveg főtevékenység
    ('6202', 'Információ-technológiai szaktanácsadás'), -- Roadster főtev
    ('4618', 'Egyéb termék ügynöki nagykereskedelme') -- Roadster mellék
GO

-- business.activities
INSERT INTO [business].[activities](bs_id, teaor_id, act_main) VALUES
    (1, 1, 1),
    (1, 2, 2),
    (2, 3, 1),
    (3, 4, 1),
    (3, 5, 2)
GO

-- business.site_types
INSERT INTO [business].[site_types](type_name) VALUES
    ('telephely'),
    ('fióktelep')
GO

-- business.sites
 /* INSERT INTO [business].[sites](bs_id, zip_id, site_address, site_name, site_type) VALUES
    ()
GO */

-- business.entity_type
INSERT INTO [business].[entity_type](type_name) VALUES
    ('állami szerv'),
    ('önkormányzat'),
    ('magyar állmapolgárságú természetes személy'),
    ('külföldi állampolgárságú természetese személy'),
    ('Magyarországon bejegyzett gazdálkodó szervezet'),
    ('külföldön bejegyzett gazdálkodó szervezet')
GO

-- business.other_entities
INSERT INTO [business].[other_entities]
(
    ent_legal_name,
    ent_first_name,
    ent_last_name,
    ent_type,
    ent_pod,
    ent_dob,
    ent_mother_name,    
    ent_zip_city,
    ent_address,
    ent_reg_number,
    ent_tax_number,
    ent_share
) VALUES
('RRB CONTROL b.t', NULL, NULL, 6, NULL, NULL, NULL, 4, 'Vajnorská utca 147.', '18056174', NULL, 100),
('Naveg Corp', NULL, NULL, 6, NULL, NULL, NULL, 8, 'Schwabstrasse 23.', '2345789', NULL, 100),
('Roaster Nets Zrt.', NULL, NULL, 5, NULL, NULL, NULL, 9, 'Márvány utca 10', '43-40-444042', NULL, 100)
GO

-- business.entity_nationality
INSERT INTO [business].[entity_nationality](ent_id, nationality_id) VALUES
    (1, 3),
    (2, 4)
GO

-- business.relation_types
INSERT INTO [business].[relation_types](type_name) VALUES
    ('alapító'),
    ('tulajdonos - 5% felett'),
    ('tulajdonos'),
    ('érdekeltség')
GO

-- business.relations
INSERT INTO [business].[relations](bs_id, ent_id, type_id) VALUES
    (1, 1, 1),
    (2, 2, 1),
    (3, 3, 1)
GO

/* Schema: authorities */

-- authorities.type
INSERT INTO [authorities].[type](type_name) VALUES
    ('biztonsági'),
    ('jogi'),
    ('pénzügyi')
GO

-- authorities.authorities
INSERT INTO [authorities].[authorities](auth_name, auth_type) VALUES
    ('Alkotmányvédelmi Hivatal', 1),
    ('Nemzetbiztonsági Felügyelet', 1),
    ('Nemzeti Adó- és Vámhivatal', 3),
    ('Pest Megyei Cégbíróság', 2)
GO

/* Schema: staff */

-- staff.positions
INSERT INTO [staff].[positions](pos_name) VALUES
    ('ügyvezető'),
    ('cégvezető'),
    ('biztonsági vezető'),
    ('kapcsolattartó')
GO

-- staff.members
INSERT INTO [staff].[members]
(
    bs_id,
    member_firstname,
    member_lastname,
    member_birth_firstname,
    member_birth_lastname,
    member_position,
    member_pob,
    member_dob,
    member_mother_name,
    member_nationality,
    member_zip_city,
    member_address,
    member_phone,
    member_email,
    member_sec_clearance_date,
    member_sec_clearance_authority
) VALUES
    (1, 'Pavel', 'Hranek', NULL, NULL, 1, 'Bratislava', CAST('1965-04-18' AS DATE), 'Monica Harapova', 3, 5, 'Ostredovková utca 1552', '+421-555-6974', 'pavel@hranek.sk', CAST('2021-06-10' AS DATE), 1),
    (1, 'Béláné', 'Kő', 'Ibolya', 'Ultra', 2, 'Debrecen', CAST('1982-06-20' AS DATE), 'Deli Virág', 1, 6, 'Piac utca 60.', '+36-51-888-7456', 'ko@belane.hu', CAST('2021-04-03' AS DATE), 2),
    (2, 'Ralf', 'Schmidt', NULL, NULL, 1, 'Berlin', CAST('1978-05-04' AS DATE), 'Esther Schwarz', 4, 8, 'Tusmanstrasse 89.', '+49-65231-8889', 'ralf@schmidt.ge', CAST('2020-07-26' AS DATE), 1),
    (3, 'Jakab', 'Gipsz', NULL, NULL, 2, 'Budapest', CAST('1965-02-14' AS DATE), 'Nap Sugár', 1, 11, 'Kodály utca 3', '+36-30-4555-9635', 'gipsz@jakab.hu', CAST('2021-06-07' AS DATE), 2)
GO

/* Schema: users */

-- users.users
INSERT INTO [users].[users](user_firstname, user_lastname, user_login, user_email, user_password) VALUES
    ('Elek', 'Teszt', 'teszt.elek', 'teszt@elek.hu', 'p7Q5E8C4s9A4H4A8C4O5X5b5t'),
    ('John', 'Doe', 'john.doe', 'john@doe.hu', 'S0N3x483D1i651j7S2r4V1A24'),
    ('Jane', 'Doe', 'jane.doe', 'jane@doe.com', 'R4d2A5r5e8d2z5k8J990L6o5X'),
    ('Rémus', 'Kukuruzsnyák', 'remus.kukuruzsnyak', 'remus@kukuruzsnyak.com', 'E22480B3F8t531I1D35YY3d4T')
GO
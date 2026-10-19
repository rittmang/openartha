PRAGMA foreign_keys=ON;
--> statement-breakpoint
INSERT OR IGNORE INTO commentary_sources (id,title,repository_url,commit_sha,license,license_url,corpus_version) VALUES
('gutenberg-2388','The Song Celestial; Or, Bhagavad-Gîtâ (from the Mahâbhârata)','https://www.gutenberg.org/ebooks/2388','85b22401a9d256179f9a2e407215eb516da9b8213f23c32e03d66709d839a9e0','Public domain in the USA','https://www.gutenberg.org/policy/license.html','gita-edwin-arnold-1.0.0');
--> statement-breakpoint
INSERT OR IGNORE INTO commentary_authors (id,source_key,display_name,available_fields,public_fields,rights_status,rights_note) VALUES
('edwin-arnold','gutenberg-2388','Sir Edwin Arnold','["et"]','["et"]','full-text-allowed','Public domain in the USA. Project Gutenberg ebook #2388; First independent model review verified for all 700 canonical references by Gemini 3.8 Flash (google/gemini-3.8-flash) through OpenCode; second review pending.');
--> statement-breakpoint
UPDATE commentary_authors SET rights_note = 'Public domain in the USA. Project Gutenberg ebook #2388; First independent model review verified for all 700 canonical references by Gemini 3.8 Flash (google/gemini-3.8-flash) through OpenCode; second review pending.' WHERE id = 'edwin-arnold';
--> statement-breakpoint
INSERT OR IGNORE INTO commentary_editions (id,author_id,source_id,field_code,language,script,content_type,public_text,rights_status,corpus_version) VALUES
('edwin-arnold-et','edwin-arnold','gutenberg-2388','et','en','Latn','translation',1,'full-text-allowed','gita-edwin-arnold-1.0.0');
--> statement-breakpoint
DELETE FROM commentary_fts WHERE unit_id IN (SELECT id FROM commentary_units WHERE edition_id = 'edwin-arnold-et');
--> statement-breakpoint
DELETE FROM commentary_unit_chunks WHERE unit_id IN (SELECT id FROM commentary_units WHERE edition_id = 'edwin-arnold-et');
--> statement-breakpoint
DELETE FROM commentary_units WHERE edition_id = 'edwin-arnold-et';
--> statement-breakpoint
INSERT INTO commentary_units (id,edition_id,passage_id,source_chapter,source_verse,unit_type,alignment_relation,alignment_status,source_locator,raw_checksum,display_checksum) VALUES
('edwin-arnold-et:gita.1.1','edwin-arnold-et','gita.1.1',1,1,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L175–L179','d91fd8e0f42e33705c09051c2f7e2e3c044b7bfefbd94db6c25f15f25eeddce6','a8e3a7ca4c349cfd31d15f3c914807e5580e8853a2e80a8eb7591fdfaa69c0d3'),
('edwin-arnold-et:gita.1.2','edwin-arnold-et','gita.1.2',1,2,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L180–L183','a6216530026b33d676e7f2b75cb1bbe66752a1aadb415c58cc0439c0bfad96a5','29b70240452adc578a8ad5beedfe68695f9acd3bfd152fef861ce17bade49c57'),
('edwin-arnold-et:gita.1.3','edwin-arnold-et','gita.1.3',1,3,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L183–L186','f8e557d4c6115a140d89b2c1eeb04a1393a4b2274af9f134e6ebd06962b8c916','12335886bbca92a5c6e56ec0f87d56d7ddf684070da2ec3f17025c66eb7a12c1'),
('edwin-arnold-et:gita.1.4','edwin-arnold-et','gita.1.4',1,4,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L186–L189','d91e61fca0b96fe59164f5a29a45efdd2e011b2de443a367a0b885b38d5a1479','b2e6055fd7280421649324d6e8b4587453a3abf01aff90ae7ee7f945a382dd6f'),
('edwin-arnold-et:gita.1.5','edwin-arnold-et','gita.1.5',1,5,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L190–L191','ce2f710d236e733428ede3e3a17c1d3fa38944a9eac4e9b42fbe269697e68b79','585c82d980516ef67678e1c4f1641818bbe7fdbbba3342d78aff41b58fd394f3'),
('edwin-arnold-et:gita.1.6','edwin-arnold-et','gita.1.6',1,6,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L192–L194','d251d2914048cf415c75bcc14100d1e9faa50063b51df3f35ebdf20af8093e59','09a68346a9d50f596b6fbc577126ab53162a524c928b15b411f2b6eef1662715'),
('edwin-arnold-et:gita.1.7','edwin-arnold-et','gita.1.7',1,7,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L195–L197','c4903a051b8ff72aade8d56f3794ac9e4d812f42eec6e2616d95de04e4b80714','460ce5497db8fad66b13330f7d4119f121cef4121923ca12d5122a877d13d03a'),
('edwin-arnold-et:gita.1.8','edwin-arnold-et','gita.1.8',1,8,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L197–L200','3d3ea382a083646eef48650c4803809e6d51849702132b743ded5f375b0bd4ea','5dda72c5986eca1b926afaff9c84a7be266069fa5876f499a727b3d204fc9a83'),
('edwin-arnold-et:gita.1.9','edwin-arnold-et','gita.1.9',1,9,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L200–L203','74ae58a79f990f0a2f75b1da371198b3470a9e5a9a5129aec79780a952261619','a6fd92da2dbe29e8366a7fd57f2fd86a397625bd90546f4c72a51803c716351e'),
('edwin-arnold-et:gita.1.10','edwin-arnold-et','gita.1.10',1,10,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L203–L205','cbd74f6b3dac9be93804dd1dd309cc96a205acac98a784811ce66212d4d4e254','e808a5d2880ceb9f8f5b743d7bafd051e6106d73885eb2a0498497598b9c65dd'),
('edwin-arnold-et:gita.1.11','edwin-arnold-et','gita.1.11',1,11,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L206–L208','d2badb24f730c2e6046fb54edac3113d625bc7fb4cefe3cd5086224a4e5dcb66','a8098b43d5ee2e56a8589c5d696d65a995c80f9cb610885772957552f9503ca5'),
('edwin-arnold-et:gita.1.12','edwin-arnold-et','gita.1.12',1,12,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L209–L212','1630de17e52cb8070b2b2c8c7b3d1aa5e7ad25d6445fa3ada1255ea7a4954964','89a83fbb25ed3f0f0312728da3232ef09dd4ae3d311520b9a09785d00380ebac'),
('edwin-arnold-et:gita.1.13','edwin-arnold-et','gita.1.13',1,13,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L212–L215','5b3c54af0975fcf8dfb2c60d042d8a2e111225ab2521d1d36b45e885a3407d09','367e8562548fb14908111ebc4de2249872a6662b61ac76b419b72c6cc6d3c5d0'),
('edwin-arnold-et:gita.1.14','edwin-arnold-et','gita.1.14',1,14,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L216–L218','e444940d5ad54efce0ff90dd171beeaefe3d93e837d837d57231a10e286eb2bc','e5ca5e1e7c281a9e046d3b3e201ab3da468e2c4d5e9655dc9cf246615394074d'),
('edwin-arnold-et:gita.1.15','edwin-arnold-et','gita.1.15',1,15,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L219–L222','dd11d01c98b3601a5eb62f5ab8572350f7db057a7a814a074c623406925c1477','dead5d26f1624d4bc0a4b95c401d3a4dffe7d99fce096df1cb53381e6390097b'),
('edwin-arnold-et:gita.1.16','edwin-arnold-et','gita.1.16',1,16,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L223–L227','f61ef09ae993c2acecc7fae7d02b0892ca9f2bd31144f1de7b3663e9ec8f99e6','87487f6eb21dfc3eee40ef95a89fb023dba31a941a90b5fec2e012827a7cb7b1'),
('edwin-arnold-et:gita.1.17','edwin-arnold-et','gita.1.17',1,17,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L227–L229','57f0166374b056971b0e5dda31f688a5c3e251557e9e05b918a07bcacaed8c28','938615554cb79ae0f17e905743065e9697860e80466873e54f39942fca27c1eb'),
('edwin-arnold-et:gita.1.18','edwin-arnold-et','gita.1.18',1,18,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L230–L231','ddf28745c786cf18c9d6c844079d58f41cd43e427a8292e10a91fc40c206b969','988b6f0810665f8f941b4464da832ddc7060790d582eeba2d18d86ecd290011d'),
('edwin-arnold-et:gita.1.19','edwin-arnold-et','gita.1.19',1,19,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L232–L234','e392dfd50cb020a1ce41154db053327598fa985879a7e9b8645ca9a7df4a744e','a7141bc27316140c4db682a24ded0f75aae125561d32292662c9de093f6f00d3'),
('edwin-arnold-et:gita.1.20','edwin-arnold-et','gita.1.20',1,20,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L235–L240','1121016145ca98e605507cda74d73adbc819495ef21decbef17f64a1ce1dadaa','42d8fe1f3205f83db506e6b58545e7f4fab351628949e537f94dac2b4668d7fc'),
('edwin-arnold-et:gita.1.21','edwin-arnold-et','gita.1.21',1,21,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L241–L242','77ac613f0d8cb2e811f2ed364af1d063d6e094cb7163b15843da7e8e4f48652a','18e80cddd037c0e7e125b9d5d1d958db9e502fca83b8c198ba8335a5f4666170'),
('edwin-arnold-et:gita.1.22','edwin-arnold-et','gita.1.22',1,22,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L242–L244','fd134fd365a1960a4ceebfcb389dd6574537187946834e2de2c29f5391e79e2a','b597386aeaa402d3e63a151b38654086ca30189b79c14e4f8e736da9e260a35d'),
('edwin-arnold-et:gita.1.23','edwin-arnold-et','gita.1.23',1,23,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L244–L247','d7ab644dd5dc545f7eed1e12b42cb7499f24afa39a0214eb8be4e6440088b7e3','b1b04fff8f3922e6e75cecb61386e56b86c71b7683f58d151fd25bfc598c978a'),
('edwin-arnold-et:gita.1.24','edwin-arnold-et','gita.1.24',1,24,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L248–L250','b7c3d729e9a196b1c205703b603361a992e399d7c429c9eab75af1fb44fed2ee','a22b809ecef1b69a297028fa3384244d2da823b3ebc5cc24dbcf5d38b5ab84f1'),
('edwin-arnold-et:gita.1.25','edwin-arnold-et','gita.1.25',1,25,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L251–L253','edee48a6a56123603da7aa9ef2b1a531197ab01bde3b33f1a214fcd92d22c66e','d2834a2a3bfefca1c70cd13d309402962130f4dee70c288445619dc0ce6bea6e'),
('edwin-arnold-et:gita.1.26','edwin-arnold-et','gita.1.26',1,26,'passage-commentary','shared-source-span','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L253–L261','181b3145ea17f8262a80ed46854199c87af3dc6eecadca171c13c6f457e42e7c','20af944b4f7fbea290853c67d59f0763e7a60f49022d0252612fef439c98bb7b'),
('edwin-arnold-et:gita.1.27','edwin-arnold-et','gita.1.27',1,27,'passage-commentary','shared-source-span','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L253–L261','181b3145ea17f8262a80ed46854199c87af3dc6eecadca171c13c6f457e42e7c','20af944b4f7fbea290853c67d59f0763e7a60f49022d0252612fef439c98bb7b'),
('edwin-arnold-et:gita.1.28','edwin-arnold-et','gita.1.28',1,28,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L262–L264','1668f34d64f30329642cb1b88668d56aed8e17698641e353589b2780b080abbf','5c18ec15048e474dc7adbb633008a1a0dc6a4dbef397b1641696fdb5eb33e59a'),
('edwin-arnold-et:gita.1.29','edwin-arnold-et','gita.1.29',1,29,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L265–L267','1a62d5ada9f1377ce586af83b7c2c1af645666d1c0a1b3246a85589ca032a7b2','24ae11599948b096b1bb1f56ece837f072f19b31263c88ba5f32530263eda141'),
('edwin-arnold-et:gita.1.30','edwin-arnold-et','gita.1.30',1,30,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L267–L270','4a0048bc6ce268564cb18579b20908d0e23ec33afeeb0a3080193a428c99dc3d','7bf79e8f757e323fae3b5baac2a961031c8ff9c0e9fbb338772185502037c169'),
('edwin-arnold-et:gita.1.31','edwin-arnold-et','gita.1.31',1,31,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L271–L273','bb9ba317835cb5ef3376276681ed6d2c5dfbbc807a6ecd1030637c13045b3f77','5537c9122bedfadf7cca6c21a2edfa88641b2dfca6a0deaeb5b3ba0c19c54bbe'),
('edwin-arnold-et:gita.1.32','edwin-arnold-et','gita.1.32',1,32,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L273–L278','a77c5ff1ec356f788a238b5896901c745f46aaed9a101d7180dea163418fcc45','d2e1a3420e0ea7e63cbaf896c8d69d2c4c5aa13da84a047c85f2a8a3a88d4362'),
('edwin-arnold-et:gita.1.33','edwin-arnold-et','gita.1.33',1,33,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L279–L281','f70839dc33c3f7276eaf12a6ef73bb71b70467c4e030ee553cc4db7cc62e81ff','c6068cb49ee6b3053a3ceeb08b3895f5e53f16e1623065e571819acc57c02dce'),
('edwin-arnold-et:gita.1.34','edwin-arnold-et','gita.1.34',1,34,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L281–L283','949db7fd0de048fc6e57a6fecd2529536ff5438638d0de3c6e8e82dbe8cc75fc','d2f35bfcfec2a2fa9e06275a10c261cf4e4238856217cb42fe8fc7b43b18fc6f'),
('edwin-arnold-et:gita.1.35','edwin-arnold-et','gita.1.35',1,35,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L283–L288','35917e41d5dc21eb9db93b6318539bb56f6e599197689145d579b6dc1002552e','32f80c9ad3d7713228c7ddb2f3000be596c43b1e04b166deaed743bd0e22c439'),
('edwin-arnold-et:gita.1.36','edwin-arnold-et','gita.1.36',1,36,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L288–L290','84b8de35e3ad91a9ccb4339e30f5bb5d83c4b6f69f99327eda3461d785980edd','853f36ec870fb38cf54854c9e8044e2663f80d61e634c77fafdcb6e639168ebc'),
('edwin-arnold-et:gita.1.37','edwin-arnold-et','gita.1.37',1,37,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L291–L293','50d5301b8c535772ebd5ef2fd61743fbf62307b600452d77fe3feff57ad6a14f','1b6c6d4abe13d7a102d49ce0d73076645f503fdcc59ae10be3fd93ab62e35f07'),
('edwin-arnold-et:gita.1.38','edwin-arnold-et','gita.1.38',1,38,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L294–L296','41cb60785ddf086704e14ca7a589db41421150417f82d158a48d2153fd5fd811','afb5585e752f3634a7205116b77fbf72f7e097c3c421b1b0df1b7f2bfd686a9a'),
('edwin-arnold-et:gita.1.39','edwin-arnold-et','gita.1.39',1,39,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L297–L299','5b57565cde243cb27cf537a9f8939483092309c2c6e83d782dcc582fb306ff36','a82139da62ed1c2ec5560db6d314d1507e2028625723a647e554d0015edb23fa'),
('edwin-arnold-et:gita.1.40','edwin-arnold-et','gita.1.40',1,40,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L300–L303','84e41fded2d3e80df1c9c89b721af7abc2fdddf39095a39282250647632b90cd','4be7cde371ee8dd2ad25fd20974507fc96c37ad5a7f524a7c2b7b76a11b5574a'),
('edwin-arnold-et:gita.1.41','edwin-arnold-et','gita.1.41',1,41,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L304–L305','694852b8d2897afd5ae7d0c73461d10ebac55fc9386fd809292d925fd4a12251','972b0793179105389fd5b20d6685d2bf1d6d11f22ae2a3d97bde7885be39c002'),
('edwin-arnold-et:gita.1.42','edwin-arnold-et','gita.1.42',1,42,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L306–L311','ef41d0231d5bc6df5dea3c5cc7c0abe19e298def8e0e7f3b69d6359e9a7ec9d7','5b8e77a81b7424e8204b8f5b7262e72f01d59ea05d17b43bd8e1a88f8d4d244f'),
('edwin-arnold-et:gita.1.43','edwin-arnold-et','gita.1.43',1,43,'passage-commentary','source-omission','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:CHAPTER I:source-omission','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'),
('edwin-arnold-et:gita.1.44','edwin-arnold-et','gita.1.44',1,44,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L311–L311','693bed77c7f37f385a43168bdc124ab7bc029357d3788bee50c136f9a6c67de3','4ec0453ccdd5d1251bb0dc652309ec6b91b43cd3601003467727ea1de33f1692'),
('edwin-arnold-et:gita.1.45','edwin-arnold-et','gita.1.45',1,45,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L311–L313','dedd400454b43725ee9ab59fbd612a58d5d7b2d3f66d7d8311f4475ffa81d188','95e44c6a5846c2db0359346da64a9e6ff7b38df2a2c9d99817e9feb9c180069c'),
('edwin-arnold-et:gita.1.46','edwin-arnold-et','gita.1.46',1,46,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L314–L317','35e1c6c8c2c86bcf98e920d67688733c937838a2354f61c8e22811adde820cd0','95ff5bc9b8bbc6602bf45b2ae306a7c43666c1b46df495330b70a2db3be4888a'),
('edwin-arnold-et:gita.1.47','edwin-arnold-et','gita.1.47',1,47,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L318–L321','8659290172c243faa6fb98c431b4deeea1f0a014e1a88efd40b974b3675443ad','47298d93e733d7511c10f2d103501035b7df66e1841cf6caf0727f38a86f6b19'),
('edwin-arnold-et:gita.2.1','edwin-arnold-et','gita.2.1',2,1,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L332–L336','69b7b8f3bbf9cd1ee798d3188d3d8d6fcb8f52eef4ca57d53884eff24fc7251b','f6769b4d780757b03bb46bacdcec82a928944205105f1e64ac4c887c8e93d98d'),
('edwin-arnold-et:gita.2.2','edwin-arnold-et','gita.2.2',2,2,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L337–L340','d9298f4d3d1df81fc575ef002b98a2091a34d485760926d458b971829e8b017e','ef5c1bdc937110e0a2ab6093eef28b28c536a7a428e602570f8bd562e19d68f9'),
('edwin-arnold-et:gita.2.3','edwin-arnold-et','gita.2.3',2,3,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L340–L344','6abae62f50da5d3ff6a76e67fc4baa5d4e0344f121478d693512f19bf2ecc869','ee925471557940e445f2730c346e18d00c3905b8f35a504620d491d64e5b2bb6'),
('edwin-arnold-et:gita.2.4','edwin-arnold-et','gita.2.4',2,4,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L345–L349','702f2b6e5107655844f56841beffde34ccf730127088bd208596a02c490d2138','a0646d3c547972223a3bff43e64c8eeb1c5fbc5f15cbfeddddf2d3e814089b85'),
('edwin-arnold-et:gita.2.5','edwin-arnold-et','gita.2.5',2,5,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L350–L353','7667a7c9f8b59a56a9b654dbc7862c0245a9488902a9fc1d13fcfb7de8cb05fa','9e35b9262065d0e4a4d35415ae2eaf7a3f80446b598cd6889fd04790ba5d3751'),
('edwin-arnold-et:gita.2.6','edwin-arnold-et','gita.2.6',2,6,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L354–L357','0f2dedd207799853c22d1aa65cbc3b5e770bd3d12a228baafeb47b3040b91667','e77d6cd5da9c16433077d54da90e1b80b4e14ad2a4e38fe7ee1cdbc32671b037'),
('edwin-arnold-et:gita.2.7','edwin-arnold-et','gita.2.7',2,7,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L358–L361','ec34c327e06fb158a55130b31c0bb9e26b76651359ccb3a27b57f9c98d04fdda','1ac0d7b55bcadcb95e6805215c396309f29270b2cb4c80d8ec8ce332cdf68e87'),
('edwin-arnold-et:gita.2.8','edwin-arnold-et','gita.2.8',2,8,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L362–L366','70b5d3ae7b510e4d9b148657b3489f4d7d083cf09b236463095daf8299583f82','8112e0a37bee167cb3b49f33072df00448f1adcb6ed429cbabc6b19d58e72b4e'),
('edwin-arnold-et:gita.2.9','edwin-arnold-et','gita.2.9',2,9,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L367–L369','2c1242a3db29545d2f4b31f99fbe6acde1dba0abb12b5ccf814319e04a88109f','225b02832251731b37212d8b6c78b7aa74f5dfd656e0f7af3dca50e8ba6cb956'),
('edwin-arnold-et:gita.2.10','edwin-arnold-et','gita.2.10',2,10,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L370–L373','e490c2835738a594587d38dae6bd0917faa3d92f8fd28b62ad7ea157e4ec9191','cf6020f99773b0595f6de4e350ef9e6a2c841c90bd565192c19b2d2fdcd6caa6'),
('edwin-arnold-et:gita.2.11','edwin-arnold-et','gita.2.11',2,11,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L374–L377','7f32dfe2fb2e9b27579a08f214da66d704e65162b4b39816610ec8d3e3ba658f','48805d79f8be721ebd7d18c3571563258e5040e7d4d7561b9549be2ad3c964f4'),
('edwin-arnold-et:gita.2.12','edwin-arnold-et','gita.2.12',2,12,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L378–L381','bf7e953241e12b6b4c06ed44a53b5b07e84e1ebd70f6f259a42e2edfe6fc6e01','f0aa6aa32b019e1dbf6a9474556ec6581a451cd38d09ee5f669b72a88aaafbcb'),
('edwin-arnold-et:gita.2.13','edwin-arnold-et','gita.2.13',2,13,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L381–L385','ce75d7d909fe46d7a63117de75dc55557173978419e15f98888121c528bccf73','542276f24db05eaf5e2f060440f32e144b5378737f58fb63014c092ee757b935'),
('edwin-arnold-et:gita.2.14','edwin-arnold-et','gita.2.14',2,14,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L385–L389','8cdfdc9e436291b03efa99ff76a0c78c859b657600e9e75a253b648acbf9cfa4','dc1fe9d064bbc877aa68fa1c0987c3bd6221b56fbaf718f2ca4e41fb775c2155'),
('edwin-arnold-et:gita.2.15','edwin-arnold-et','gita.2.15',2,15,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L389–L392','ec957556fe7d36e5bea3cd816dd77b47ff9256ea82d22821f3ab5cad1a6846f8','c63d856ee4e98f1335b242eeaa7da8c3f31e566003dfce99c5e6852b2f6177d6'),
('edwin-arnold-et:gita.2.16','edwin-arnold-et','gita.2.16',2,16,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L392–L396','e5a3888f5f10d0204bca310750149da2e24b96d8560156e97f9e6b6b36c6ec20','52ff2f97365ddbb7838eb14cd0391e02ca381a013d49047e64afbfe7e2596df9'),
('edwin-arnold-et:gita.2.17','edwin-arnold-et','gita.2.17',2,17,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L396–L399','4bf68d4687a957e61516573cbf76ed1fd92267bb96f4a9d86246c1f2d2694efb','cad80c10b13c42c478fe60f3c6062d4d8b2436962f3667edcec0559ab6075ee3'),
('edwin-arnold-et:gita.2.18','edwin-arnold-et','gita.2.18',2,18,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L400–L402','db535013e2e3dab9d4db4770916eec9232f18eb70da1815c20b2453736686160','47dedfa13e785f818bb36441ee9dfa842bc948f3c4a5043372767ac1e5aae912'),
('edwin-arnold-et:gita.2.19','edwin-arnold-et','gita.2.19',2,19,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L403–L405','d7de6324100e46df0a202d8babc4ee9038bbef46b24f0f9319cb7782304a218f','3f2eaa5ed31a5ee0d0fc6fe8931b4a7566f1780d838837995920b9f9c6027524'),
('edwin-arnold-et:gita.2.20','edwin-arnold-et','gita.2.20',2,20,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L406–L410','59e02ee69ebaec0081d474e5b56edc93534a510a8e3fee3e07d8760641576569','42663c0a93e51df81a068db7e06131cfbf6e13cb1201b962da82451216eabd05'),
('edwin-arnold-et:gita.2.21','edwin-arnold-et','gita.2.21',2,21,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L411–L414','e785987c6cc345b943a1d2138e3826e537bb4ec4c9f0b1d53c348ce3e451e5dd','413314e888dc309821493db5a03e6753aac673253687b66c93d1bf37611ec556'),
('edwin-arnold-et:gita.2.22','edwin-arnold-et','gita.2.22',2,22,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L415–L423','5f83f9fd8bc7b36341cbdcc949adc9f290b5269e900405fc3c4bf9ce7cc5a102','a7f12a875c25d0a0aa64c3e763fc9b12b859ae39c6b9a44181a85fb3ccfd7d72'),
('edwin-arnold-et:gita.2.23','edwin-arnold-et','gita.2.23',2,23,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L424–L426','7d3a19952db29ee1279f89aebc7c0213a4569a827d17e49361d8d601bc767134','c8a6a4befbfe424067ca857f2b217a4623403e984b32c2bc9fbb096e3788beb8'),
('edwin-arnold-et:gita.2.24','edwin-arnold-et','gita.2.24',2,24,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L426–L428','c2397698156847516e2923a01338ba65ae2a9a6faa10ae2b9db5287d40924c0b','e0b35fb68a04ac10a908a8bbf3839dcaca5a6eabbc60166b3157b3ebde8013be'),
('edwin-arnold-et:gita.2.25','edwin-arnold-et','gita.2.25',2,25,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L429–L432','89109042d69e533918401e33d24d1c859aa0deb322fc4a77e2f70f88ba95503a','bc2cb2a4a54d19bd01256422403321393346399b837d80769524cf6b90092ba5'),
('edwin-arnold-et:gita.2.26','edwin-arnold-et','gita.2.26',2,26,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L433–L435','536bf55f6810c770a127d21c1d675b4c5a69a9c2f347d98483003765c5ea4368','735f89a9fa67a19d96710d0c7c57d17e22fae4a3928c0223e8d5c07eb3e7d38f'),
('edwin-arnold-et:gita.2.27','edwin-arnold-et','gita.2.27',2,27,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L436–L439','c30b0b4077e7fd8807ccec7f5307e7d88a31521e84685b588540bce6a6750e16','b04ac6c7ecc33cb7082aec4607f9b7a3562f6176f4ea58145d8a16bebcd6fbd8'),
('edwin-arnold-et:gita.2.28','edwin-arnold-et','gita.2.28',2,28,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L439–L443','e120f82e1940f008592c490741b70a815362ff431fbcbaba77d5bcc34b06753a','743555d4b0724cd0150643a1ef7533a19f6496613aedf19eed40721580aba9a4'),
('edwin-arnold-et:gita.2.29','edwin-arnold-et','gita.2.29',2,29,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L444–L450','25364f8353be16419794b57760529d492d47eb9b021a65e4da6ecc53a8237c5d','77f708712da2e3127cf7097d036b7cc4dbb449844ecf3603c1664a62996644eb'),
('edwin-arnold-et:gita.2.30','edwin-arnold-et','gita.2.30',2,30,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L451–L453','93175e566e02a0676c215f25178800f1af93bb3bcef45e8aaad78a7ff08a4b19','2f53c6f17c80d01d074f123f1769743a919cb02a2b7ed464e377f85fe7d802dc'),
('edwin-arnold-et:gita.2.31','edwin-arnold-et','gita.2.31',2,31,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L453–L456','8fd15921fa953444090d2a54347632315eca40bed74fa763cf13b03a8cc0b6dc','5261643b55d5014e40ab57bfcb8845707d8b743b1846bbbf2af36f4909c53f9d'),
('edwin-arnold-et:gita.2.32','edwin-arnold-et','gita.2.32',2,32,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L456–L459','e3033014c83dd133ef4ad03734c90b5ca76deb9483b840f0bda67f63fad4536a','e940f4a161e8592722d52d01bf20c5e5b2db9ea24afb18ffe212d34add2f049b'),
('edwin-arnold-et:gita.2.33','edwin-arnold-et','gita.2.33',2,33,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L459–L462','df0e9a420b7375cedd27458effbee4f22ca88c3def703c1fdfb206fbdf92e1bd','7144b4270e8dac8a3c3d8e6b6ae3f33148daa71810c0b091fcf690d4dbd3eb2f'),
('edwin-arnold-et:gita.2.34','edwin-arnold-et','gita.2.34',2,34,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L463–L465','f2109cd1e3ba0efb83c0161a5a4313b392e8a7b3d3ba6b87699cd571a6ffdbbc','4930705c6446bb7929e27fb1f6f75805876d0993502de3c9b297fd8d869add4a'),
('edwin-arnold-et:gita.2.35','edwin-arnold-et','gita.2.35',2,35,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L466–L469','c14738aa12a037e3f521c3c41f59ac8ad7cb5a24794133e83e739f55ae69a6f6','1254089083434d5ecf2233a32c1facb3515e7634421eb483f7bf92517feaebf1'),
('edwin-arnold-et:gita.2.36','edwin-arnold-et','gita.2.36',2,36,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L469–L472','d2581d5eda069d1271192c0d7e291b303c9579aea9a6c93e0f70552f4024c644','69ddcb4c074d647e908348d789abef6525e3ce8937770508f788cbf1c97a75b9'),
('edwin-arnold-et:gita.2.37','edwin-arnold-et','gita.2.37',2,37,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L472–L476','6e4b44dd3bfed622d31e56e98b6977f918238aadb0cb09e1dbc6483911c81864','1f259602d63032b6e61e939a9abe9b36038dad1e3c04679110482f5497184d7a'),
('edwin-arnold-et:gita.2.38','edwin-arnold-et','gita.2.38',2,38,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L476–L481','6b28a9d330a2bd2fd3adbff46f8ccea7af81d506ac7bf5f421e09785fcbcad52','754368e59e0cb6f7e2f39753a828faca48601c5fb575ca2cd9e465eec2fd0e0a'),
('edwin-arnold-et:gita.2.39','edwin-arnold-et','gita.2.39',2,39,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L482–L486','bf53dd5d0f3c8d7c939f1dfcea25f9d2ef1ec1244e60d3ec5078f2a28c228653','9ddbe1f4402203a5881e630255b7870c8fece81a6fa99b690e546e4140aa3280'),
('edwin-arnold-et:gita.2.40','edwin-arnold-et','gita.2.40',2,40,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L487–L489','a397dcd70d5b4074cfc5c4618068e1a7ad4673b3b5cf7872ef554a8e9a6dc1d7','9fbca78ef088085205c7d6f8382217b86b93a5ce733004183d85ac90b300bb4c'),
('edwin-arnold-et:gita.2.41','edwin-arnold-et','gita.2.41',2,41,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L490–L492','962e75dd8cf2c982e9871dc39e0edacaf7bd2325122e3e361838b2c8bca89601','e480beb0045efe36e4de78ab246de6c85af2b3a5af42e3a69173a7c295c757d9'),
('edwin-arnold-et:gita.2.42','edwin-arnold-et','gita.2.42',2,42,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L492–L495','87edfb1216c80ff52bd7d20c7c68385bc58a97b4bc560ca11301998f0207cffe','5ee5ebc6ab3dcb831c111cbe7d5039a8e4b4a5ebee857e060193e39482e67d7e'),
('edwin-arnold-et:gita.2.43','edwin-arnold-et','gita.2.43',2,43,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L495–L500','dde0974a7e6bc3aa592427fb0fae0e123524b31567ee509b5e96cca413b3b546','1f04a9b0bbc5496c39b04fa9e611742dd86181fe0eb63e3d988bedabbb9839d4'),
('edwin-arnold-et:gita.2.44','edwin-arnold-et','gita.2.44',2,44,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L501–L503','1dcb766c616b554d1cd036d61ffa47662498b65b29b0d2bd26c5822704414dd9','4b3e9598a88d3ebb0e7658ba60411005830d3fedb9a8a394cce1317e027bc120'),
('edwin-arnold-et:gita.2.45','edwin-arnold-et','gita.2.45',2,45,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L503–L508','f86b0511a03c34a8c5d4271aad59ea6a62115391dadac0fed62d8318f7cce92d','27a1080bbe046b4d1e5c535a7c4d76962086845124d1d8344352b90f3def0b63'),
('edwin-arnold-et:gita.2.46','edwin-arnold-et','gita.2.46',2,46,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L509–L511','cfb55320ec9fd587caa3ba0060494927864f7949a4a7c76d24917f0810f11a29','c005001293d0a0028a94e00ef9672ce4a0f5418b4f13f0eb1b1cb48a7767a83a'),
('edwin-arnold-et:gita.2.47','edwin-arnold-et','gita.2.47',2,47,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L512–L515','94d45bfe6fbe7bbd787446fef75327df92d208a7ee55f23288177594ba36d4e2','2a8fcca81b6f21a1cc63833bc80ed0e141a22e73247b5b878c0cb730c3c156ad'),
('edwin-arnold-et:gita.2.48','edwin-arnold-et','gita.2.48',2,48,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L515–L520','77666a401ca25057e67b9ea8e00a9b061535470647d4d36a9bcfd266ddeb05c1','da0975ac0812f0c022c306b77db044e5366b76cc6018539692d5f717ec462c88'),
('edwin-arnold-et:gita.2.49','edwin-arnold-et','gita.2.49',2,49,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L521–L524','9ffd81de1116affd0a0f2d2eb77d038ae62a829a91cbc65744671b94bdb7503c','b440dc508f89892a04c45d409de3ff3e373a8a922f127dccf28bb0beeb838a51'),
('edwin-arnold-et:gita.2.50','edwin-arnold-et','gita.2.50',2,50,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L525–L529','2097ba6ea5196e8939764c44b135018ec21831eb887c184d3894dba5a1ddab8c','62a2586cb67d158d40836ee5ad4fd31130ab5edcf55caeb9a3bbd7c6d2946bc9'),
('edwin-arnold-et:gita.2.51','edwin-arnold-et','gita.2.51',2,51,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L529–L532','06393142ad5d5b0be5ef3d093392bd026aa70812fc1e94831163fc4bc02e1130','8dced627f05180c1b94030a94bf982f4a576aeced75e221b2045fd4b08d3dd05'),
('edwin-arnold-et:gita.2.52','edwin-arnold-et','gita.2.52',2,52,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L532–L536','9be6ad2ba93b08b30d48eadcc39256af981f6e5213025857f53bb8a1f9230b37','21be7fa911b0476088eb1a4ac9cb75ed9394587c1997f7dff672729c9cfeb746'),
('edwin-arnold-et:gita.2.53','edwin-arnold-et','gita.2.53',2,53,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L537–L540','2864553bdcfb4f52e38dc31e851cb99fb2b5eeb7e21138180fb8043d1b6685e9','be25d9347c8035d62b256251ae08f53f1db6a0101381152a085a419a6d1b648d'),
('edwin-arnold-et:gita.2.54','edwin-arnold-et','gita.2.54',2,54,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L541–L546','c12836504b514ff7da1bb52519f185587c7af2ddb0fe2c12823fc5ef51a65997','1e20867b5a8c2852ff1d65b452cb456a17240dd99e736621fa59ab0984d48d3c'),
('edwin-arnold-et:gita.2.55','edwin-arnold-et','gita.2.55',2,55,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L547–L551','b896868f7b2247cf39191212bac62db95d84fbcc2f19e733f2ffa509f4da9c77','a9e8fd3280f48988492f474420b27bfaa0ff46c305ddbcb4b2dee5d3a33d9368'),
('edwin-arnold-et:gita.2.56','edwin-arnold-et','gita.2.56',2,56,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L552–L556','31f4dba4fa1d9c606c9944b698bd412c0d19971529c1524b39e6d5ac563bdc68','7d76b4def57313d10416a663cac2e6428fb6001c7d6f50a701c5a7a090d56be7'),
('edwin-arnold-et:gita.2.57','edwin-arnold-et','gita.2.57',2,57,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L557–L560','3fc061b20d59036c0ff27ab2807db265e6313862ea10fc57a0953e31c908d3f1','67a08239067cd1c0c4df85f76fa8461da9db44d1829f57fbc0ff3e0d128f83d2'),
('edwin-arnold-et:gita.2.58','edwin-arnold-et','gita.2.58',2,58,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L560–L565','b6b0fef4beec04eb7c4a16ab2da252369674a0faa0712c975714bb21341ac0f2','fd18eeeb0bf6fee6b8d2a0c2edd23b1d534b0e55351fd8ff5e03885836527b19'),
('edwin-arnold-et:gita.2.59','edwin-arnold-et','gita.2.59',2,59,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L565–L568','8ba4111cc01f63aa1368cb5ad3e6b7432a0562bfa6ce12dd52ed58017941ca14','17c00f19b55e8b7b30f97e8def2b7e0ed54d7be4d4834af7975fd34c029aa27b'),
('edwin-arnold-et:gita.2.60','edwin-arnold-et','gita.2.60',2,60,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L568–L571','60d538fdddf03e6916d69087b860474b9057665c87cb5403e06ec0ab3a92bab8','b0c9e2e1988996cc21038b6bb0facf7dc88d1a364f247fea3d9b6438b76f7e16'),
('edwin-arnold-et:gita.2.61','edwin-arnold-et','gita.2.61',2,61,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L571–L574','cbc6fb7154d0a89a6c17969f36135e3af590bbf2388cf5773de725b10d576f1f','cf89c981aab5907013a64923f34022df7ad67d7639e1ee28b3e06d2fe7acf147'),
('edwin-arnold-et:gita.2.62','edwin-arnold-et','gita.2.62',2,62,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L574–L577','1edc89e233a3470dd683c120e6dcef27805a1caf99d34306265475e5186c00ec','69c333bd442ded42be3c27079f2f117627baad50c99088b563838d8e81c5a68e'),
('edwin-arnold-et:gita.2.63','edwin-arnold-et','gita.2.63',2,63,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L577–L580','f3b793a947c757321d68cd6c24813ca8ba925db092ba986a258647c882a2f63c','7ce0756c7a29d4cc6133499d494641d60d29d7940b02062e12fb16eacbe306ca'),
('edwin-arnold-et:gita.2.64','edwin-arnold-et','gita.2.64',2,64,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L581–L584','744b4a5fa5061ae18326fa2cf430c34ae596988808afd7f9b6ff8a8db0f1ca49','c136a78aa52ea288da2fca601d3d01e448024f8b6ae4f10cf6ab435f12089550'),
('edwin-arnold-et:gita.2.65','edwin-arnold-et','gita.2.65',2,65,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L585–L587','de5e72d742710df39eabfe69ead1a3d1e83a954c80a9d4d5a65891a34834fcef','86dd89e33f635dcd2bf79a16c4e21bdaf0d9bf881fc3ebd6e89ff50f12cc6074'),
('edwin-arnold-et:gita.2.66','edwin-arnold-et','gita.2.66',2,66,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L588–L592','e96bf17fa627e475307e4e6d1b8cfc5d84252783d17212e2e4c3e73e7e401b7c','2fd03b78b574970702c56e14bf9794c07bc41e69b70055319cf16629f495ab8f'),
('edwin-arnold-et:gita.2.67','edwin-arnold-et','gita.2.67',2,67,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L593–L597','61b9ebe95254fafe80daf5d670a0351492feec68f5d2058f1b4f1af0361696a9','7c6a7f0fee357ec52f5cf61e537bc4873efe445f836565fdd2990f9e599ba600'),
('edwin-arnold-et:gita.2.68','edwin-arnold-et','gita.2.68',2,68,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L597–L600','4f550dd49a7b9f2a7983503b78b7bd60deb3dd4c0320edda2f7910799c9e1eda','45f7e1a4be8435750abeb3f7c71f79db75c5bd5953e40503b93a70bdd56889ae'),
('edwin-arnold-et:gita.2.69','edwin-arnold-et','gita.2.69',2,69,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L600–L605','fa099a6dff615361b7de969abed6629d629f917cbcfca802f94e69b49daed14d','b1c73499ae2adc984e836279723e795c9f4bc53d29ab33a305bf53d86f97bb39'),
('edwin-arnold-et:gita.2.70','edwin-arnold-et','gita.2.70',2,70,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L606–L615','7d9690d6f08b93cfefe0a136dcb5f284b790030e786b9eaf9492bdb6554cf485','a28ad5e8ddc8109ebdf78444e63e67eed803accbbc4d73d5f7e2f0d05bccce78'),
('edwin-arnold-et:gita.2.71','edwin-arnold-et','gita.2.71',2,71,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L616–L619','432c012d060f2dd4f24b5bc71aa752ace2323a3f7beb7b7295c27ad9e3c7a55f','f5bf111b18472f7df0ccc7a23c61eca5cb80f7b650a1785e38e48cd47669a231'),
('edwin-arnold-et:gita.2.72','edwin-arnold-et','gita.2.72',2,72,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L619–L624','5ea9500904a020be0a4486ae14d8aa602abc0892fdd53989cbd02aee6c0bb49f','0cce49603299185b5c17261fa47f9fb99bf0747054d85a5ee95437de21900e2c'),
('edwin-arnold-et:gita.3.1','edwin-arnold-et','gita.3.1',3,1,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L635–L639','0245e4505f7cc521b16ae90567d581edcd157ce2aaa95b4969257bc577ab9ecf','1b3a0ec5275151a10bb36e6cd57407eba5126f0b14c601c386d28491d799ac56'),
('edwin-arnold-et:gita.3.2','edwin-arnold-et','gita.3.2',3,2,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L640–L643','dbb45f2a91ad08baaf8c08efc8e76f8d063fddc57f9ab98d33353d4177e103a4','2dc3338dd7d6926def724c0645aabb0599c50abe77796410714e178cf8277c15'),
('edwin-arnold-et:gita.3.3','edwin-arnold-et','gita.3.3',3,3,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L644–L652','30a2c241576a9aa91245f76a4a51fe7c424125401e55b7772cf7bf6f1ffa70fc','5818b0249592817ccda04ed922aa4df39c181f214e033b6e36f6fdf83a214da3'),
('edwin-arnold-et:gita.3.4','edwin-arnold-et','gita.3.4',3,4,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L652–L654','404ac00ac1eb3d3674aa1a567c6b05d39569ad909db1e37a1bb8f2bfe602057e','4ca2bf74747dd6b249ff9f9bdaa035ecc86b195b9e04646cb527e0ef170a9742'),
('edwin-arnold-et:gita.3.5','edwin-arnold-et','gita.3.5',3,5,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L655–L658','0cb54e0a46940ffdd9d124111861bf42016a303c7fc3ccaa6aadfd2a93863f8b','5737140c68874e1dff526fffd52a8009e1a1cc0f79ea95fb7c5d87d50a1de3a3'),
('edwin-arnold-et:gita.3.6','edwin-arnold-et','gita.3.6',3,6,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L658–L661','245055679cdf1f38c720292832b1e3447af337d17c826a314c1d1b26d4fa3bd4','c5f168ddc85fcaa11c24874f5c51cf4ba193cc0e165b43d644717168a8277dfb'),
('edwin-arnold-et:gita.3.7','edwin-arnold-et','gita.3.7',3,7,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L662–L665','7c6db511baffeb8be9da3d51b4275049751fc111423e620d351dffe9669059db','718c6f142eb2e2325689dad2d72a3b3401d22f3b16847b94dd7e06dcb0d23fab'),
('edwin-arnold-et:gita.3.8','edwin-arnold-et','gita.3.8',3,8,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L665–L667','8b9073c174f8c4ccf2934b04a856b973c3198d62cdd5937cb9cb51fb02d51f55','d4d672460eba8cbb2bdcef9860f171891d6863261119cc2ccb11181403658019'),
('edwin-arnold-et:gita.3.9','edwin-arnold-et','gita.3.9',3,9,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L668–L672','f74b406818e5b22d5912b465c7ff8213cb2f1d2122dc654a03e80eb2ab7bab33','2aabb91f156b78feb5e2efad153ce4e1497f2242a8f0ec37b8f3d672fe4f92d0'),
('edwin-arnold-et:gita.3.10','edwin-arnold-et','gita.3.10',3,10,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L672–L678','ef0b1fd1b072ad7235eab4d57fde047c641e89885dfd2d34545c58a3f6ebf6df','b2bf8c1d95f1cfe46b676000f68ac483b115663429ae0b792f383a7194c48d87'),
('edwin-arnold-et:gita.3.11','edwin-arnold-et','gita.3.11',3,11,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L678–L679','b85c624712444b6a1b3dba3215bebd70e47db2726bef96ebd47497de5fd0be2e','c13269fd1f41d50cb355fc00963ae1810dffa145f257d610a1be768bfd6929f3'),
('edwin-arnold-et:gita.3.12','edwin-arnold-et','gita.3.12',3,12,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L679–L684','b74e303fc3eb9b70e2af68a6107f1b16b0cf576352853444f14d8e064a5d509f','4d2bb08d28e61924c28dae8530efd1999c86e7cfc375d3da9bff61f6dae45031'),
('edwin-arnold-et:gita.3.13','edwin-arnold-et','gita.3.13',3,13,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L685–L687','d6c55c8d37fcc4d1081cf9886bdcb6d1c31f025b5bc5dad94fa597f16af2f491','fe17c557649e6934ff7cba9c62b755ce0a5302b858fe3306297ea17e2769e267'),
('edwin-arnold-et:gita.3.14','edwin-arnold-et','gita.3.14',3,14,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L688–L690','0e481cdc98a37379e94fafa387deb12e09ee0cd8775a1a1e635ddb40ebe6b6c6','bcdd0f5039b320066ef02d270f883f38c1974547867c325abffe080726797969'),
('edwin-arnold-et:gita.3.15','edwin-arnold-et','gita.3.15',3,15,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L691–L693','de6ea4c80c327aeff943834b1736ecb5baba8df3bd20ffd4be24a5dbfbd6542d','5249d558deefcc05e597f9799d65dee1d395492cb40ba9a91d4f6739de820d4b'),
('edwin-arnold-et:gita.3.16','edwin-arnold-et','gita.3.16',3,16,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L693–L696','7ddb04da69bd232b5bfca12db401189abf578e6a46a3dbe968a8bffd277a0171','672e597719f5bedde4e402df14d4185aa7f13945c14ae5f52bbbb09f35788655'),
('edwin-arnold-et:gita.3.17','edwin-arnold-et','gita.3.17',3,17,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L696–L698','34c115b1b7604f32a9006ac318e04e0de6979651e15e8d92fe4ea794efac34d2','34a4c2b44a74f7d4f64b98323e4e4d7832caaf043ce0fa6ef90928ea0d283d2d'),
('edwin-arnold-et:gita.3.18','edwin-arnold-et','gita.3.18',3,18,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L698–L701','d53051dd669f8dc7b9e7b8490234393329cb9e4f4f8f448155a1f7d927896f99','30b09f7bde20b0cd88a63205140f09728c6fd4f2b8871c461fffcffe533b4044'),
('edwin-arnold-et:gita.3.19','edwin-arnold-et','gita.3.19',3,19,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L701–L704','6e4dd116dcce864588a41433a0b29e11faeccc48a7a690f5b35402ee7e0901c9','df030c1d15b40c1dac9b170b48614da67bf792688b8e9b708eb9531c714034e7'),
('edwin-arnold-et:gita.3.20','edwin-arnold-et','gita.3.20',3,20,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L704–L707','16bb7c41bba2de334f3446dc287f39ffb20757824d2b211efc505852102d6168','1f41640c214e38a462cdf7ad9eb3ca6a08b0524d66370d1a6db4af2c586be8a0'),
('edwin-arnold-et:gita.3.21','edwin-arnold-et','gita.3.21',3,21,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L707–L709','fee326bdb6bd7237e7dc728c72fdf93a932f306dc72c7430243382a2b3b7e5c1','3d15d5492e8c817fca17213283fc9b5d1feedbf961f2ef6e09ab52de4adb3ac4'),
('edwin-arnold-et:gita.3.22','edwin-arnold-et','gita.3.22',3,22,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L709–L713','60d1b2639daf7adf0b01b4ac5b7101ebf77f8ccc1c00fae79ba3e3950687b8b3','d1ef72e28f8c6659ee0fb42b5b2977da90f45b885bbada4a118c22bbebf3c3e2'),
('edwin-arnold-et:gita.3.23','edwin-arnold-et','gita.3.23',3,23,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L713–L716','093aca0fc4fb30023d1ca57af694d19af9a39c7e152a6d67eae56d651d446748','a28a0f9f45e5a36ad58aaedd7e7d7bff2d35be2d558ee5ac2c92f3875b0bcbf2'),
('edwin-arnold-et:gita.3.24','edwin-arnold-et','gita.3.24',3,24,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L717–L718','f41397c0b18148a1079c753cc627818e3772c46ef10685a9d520425473e0c804','0c9492ea6189869f425617ea5e28c1e379337b81804188d5b95d865574965dc2'),
('edwin-arnold-et:gita.3.25','edwin-arnold-et','gita.3.25',3,25,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L719–L721','fa01495493c646b8dfaf3511d2708eac982f74fa43dbad87f5ba3815c6ba399e','6a1441eb0dc8ec420a4cf8bae80df46177a06ca1a9a14e0ddac007b98b528449'),
('edwin-arnold-et:gita.3.26','edwin-arnold-et','gita.3.26',3,26,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L722–L724','1d0909c7417bd9d79ac808c8a3b011dc8825ce1607075b033c94af4254fa39df','7b31ad8d7306a4fe790d6641c3d53a82ad64206e75a79bd648e6d479259fb49b'),
('edwin-arnold-et:gita.3.27','edwin-arnold-et','gita.3.27',3,27,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L725–L728','23c42aff838a2aaaee00ccefb5172f00c87cef6a338537b8960e750c4143c86b','c1dba3c54eaaa74c9eb3a5d5dc807d3774d44d1f7a3c80b140b4e92fdd6294c3'),
('edwin-arnold-et:gita.3.28','edwin-arnold-et','gita.3.28',3,28,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L728–L732','5049ad4f20c22388605165db1a86e7bc3559c96ec93c62d76396889f3deddd37','1d5ad67b6cbd2f3fec8f19aa51b18d5f950c63ab646e2d551cf60866c063faa8'),
('edwin-arnold-et:gita.3.29','edwin-arnold-et','gita.3.29',3,29,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L732–L735','28014516db0e35fbf925684fa899a5f0822ef5b64e4c8998d0ddb2cc18d13997','4c5dae1579a029042e9b455183b7d55773840ee6edbe699f535f01c69efb0e3d'),
('edwin-arnold-et:gita.3.30','edwin-arnold-et','gita.3.30',3,30,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L736–L739','f1a397c04caef7172e25c93f8a0ef22f9bc0215559f1db41a6bb97e225319254','ddc91b441909122d6f6e4c5d9ccaef29510fd4899fec3927dfff6ec9d6773285'),
('edwin-arnold-et:gita.3.31','edwin-arnold-et','gita.3.31',3,31,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L739–L741','48e8b3f83b129916d3407c0a59ee398abc74ee6f02f788504376cc772b31aa9a','cf441e2d41040d5b23bada633cfc5964edcea4d068d3357dc7931d053f435dfa'),
('edwin-arnold-et:gita.3.32','edwin-arnold-et','gita.3.32',3,32,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L742–L744','c4a5b1e00d87954a8a63ce6e61f62cc9a2a3572523d87bd9d0c752298b10e5f5','3bc1c5245725d06f92e0382e73f8651a822114018499e8701ab9511e3f73e9e6'),
('edwin-arnold-et:gita.3.33','edwin-arnold-et','gita.3.33',3,33,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L744–L747','1efca50554187c42048d63c14f6f4e9c420c989be9acf8f6ce0cf20ac9567a23','ca682f0637bb3037b1292ea013de0015a9647443ab52183f15cc2d0ccc0d3140'),
('edwin-arnold-et:gita.3.34','edwin-arnold-et','gita.3.34',3,34,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L747–L750','fb0bd4ab2e3d6f16265e9f12ac46971aa12b592e990263f0340403e65c9a52b5','6633b3b02b0c85afe07022cbed76bc09bb7e9e78458a059273f3b0eefd5ecd99'),
('edwin-arnold-et:gita.3.35','edwin-arnold-et','gita.3.35',3,35,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L751–L756','a72f527ecd2c663318674b862e1821c6ca2487969a987a295972f1ae1a36ae23','2fc4096baf41e09e41609af7d6c1461b5e66a12e6e109d3727c3c124a6325c3e'),
('edwin-arnold-et:gita.3.36','edwin-arnold-et','gita.3.36',3,36,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L757–L761','416867f4a5d5fae2d919b4b21568ebd1ead1c7959bc4bc4877ebf6695d7e1ec7','47780c567fa1f56f4cdac8da871ffcc9119d81d66c3c14df1862424566a48cec'),
('edwin-arnold-et:gita.3.37','edwin-arnold-et','gita.3.37',3,37,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L762–L766','cab8a18c31a44a3f3fcf54819f842c240bc397827b361d016372cfad1992feb0','bed1b1e1bdd1c29ed20f48c305878618d4363e5ece1d90f996c905e6229637aa'),
('edwin-arnold-et:gita.3.38','edwin-arnold-et','gita.3.38',3,38,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L767–L770','7df4c911ed3521d4a79a43378235d182a49be3df5375cdea81d718225171d0ce','cf85e2e77de259883be896002899e431072515f08e02d98dc9f9e0dad672a834'),
('edwin-arnold-et:gita.3.39','edwin-arnold-et','gita.3.39',3,39,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L771–L773','ea1ca0d7a40ec72cb83dbd9c1ed9bf0427dd22795b1b23583072d404b71e4630','983af02ff718dc8b0f27c41bb28da00d426c152cb1a9b822cbbcb807b3043c6c'),
('edwin-arnold-et:gita.3.40','edwin-arnold-et','gita.3.40',3,40,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L774–L776','f4b4008091fe9d0e336cc18645c33e5e793965a73021c1d4e353f29a5d10beff','8a65c79bf7926ca0b727502da78a0ba4de30df2cb0979a74734e4697fa9a2eb3'),
('edwin-arnold-et:gita.3.41','edwin-arnold-et','gita.3.41',3,41,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L777–L780','0b6ba3f86218a2cc189ce8bcd8e3a96bd407d0c5afcbb9fa148ee98df1779723','3b383e18bda005a59ea5116828ebce1af8c07e54d63ab859adea4162f8130bac'),
('edwin-arnold-et:gita.3.42','edwin-arnold-et','gita.3.42',3,42,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L780–L782','46b22f0d1bdb078dbf4c9ff2f96693a154572ff591b8a877fb2a62ba138834f6','18090b2344e5663dd2805723f26194ba1cd5da43ba2c5aed95f88b6b8efed8b9'),
('edwin-arnold-et:gita.3.43','edwin-arnold-et','gita.3.43',3,43,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L783–L787','12dff2bfb59f0de7e4e48048255eadbccb619d14cce7760d980ec721ede6bf0a','96c73595c2d9ca85351f4cb0631fb80d5addfc57863662420e13963d908326d7'),
('edwin-arnold-et:gita.4.1','edwin-arnold-et','gita.4.1',4,1,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L798–L802','89df61f828d7519786d620ef78b13a0a06f7d92ec4d208d7cdef7502ebf64063','811a1695192e6c72b7753f13870dc175c94695e3644e9b1dc5d27c961a4bc395'),
('edwin-arnold-et:gita.4.2','edwin-arnold-et','gita.4.2',4,2,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L802–L804','069d4528f9667c0ad823cac4d079d9d97f8e9efd9d185a81323f9f1f6a51bb6e','666be533beabe72525ddf1aa61bb5a073fbfa62da52cbda4daade2f7273a2038'),
('edwin-arnold-et:gita.4.3','edwin-arnold-et','gita.4.3',4,3,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L805–L808','e0697efb782842d2d625cdf91d10544513ad0c8b36360340801af47239154d4a','a9bc1d996755595b003d9afdd3aa8d5af4f57db98d602a0b37fefb89ad7207f3'),
('edwin-arnold-et:gita.4.4','edwin-arnold-et','gita.4.4',4,4,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L809–L814','1c6271f3b6c3d9700e21cb3b17da43b5949a2d50863c2d21ce1d788f122dfb4b','f2557340e66f1a5df280684b79e45d2997bdf1493c877148084f5a6dc0f87404'),
('edwin-arnold-et:gita.4.5','edwin-arnold-et','gita.4.5',4,5,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L815–L819','dc2743134f1be9307a8dc2a19d29910b2fba53ec4bd0b624ccd0abf175001cf9','687747b84a3fb38d08f79cc335463dfc6b7a5317d5d78bbca9629e6c0352d775'),
('edwin-arnold-et:gita.4.6','edwin-arnold-et','gita.4.6',4,6,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L819–L824','73a4b3840c593f739da44bf06174757d83f0268aa9edb5fa8ce392ea8c77db85','e86e711a53b75a786b666c8e51def2381c13cca1dd6770aadb0e796cb8170495'),
('edwin-arnold-et:gita.4.7','edwin-arnold-et','gita.4.7',4,7,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L824–L826','2e0875099a177f5944ca1d21e942d998eae12ac25cba98b4dc0d9a232bc30f6d','e27ffd5e26d6f714862248bc1181fa152bed1d39acbc6bc6834f8e73595d96be'),
('edwin-arnold-et:gita.4.8','edwin-arnold-et','gita.4.8',4,8,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L826–L829','cdeb78dfd21f5b6ef0107dd4085ca84b3daab1457828d71941df2aa6f12546cf','b90ad323f3c53925edb1a587bf0d5702420379a1d690b712b31e0b404bf294e0'),
('edwin-arnold-et:gita.4.9','edwin-arnold-et','gita.4.9',4,9,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L830–L833','482ad10144fcdf37930d759650f0b1a4eed992b02a3871e04c1a001d2e699f44','aec34a0e1e225d9f3f777533a01977fb1cb16e580a684225d2c9882149b9b7de'),
('edwin-arnold-et:gita.4.10','edwin-arnold-et','gita.4.10',4,10,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L834–L838','5d5343a1371585b69e8deca73f98d27c5a8730718e30efc0daba431ada878255','8e0b7e4858b4b9c55670a9e9d887d2ec9fbc23fcbb57389f2254e37ee8f7a43c'),
('edwin-arnold-et:gita.4.11','edwin-arnold-et','gita.4.11',4,11,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L838–L840','df4c3d520a1bf8d5dd486f157d4ae84b5551bc18f2d4671160fb697a13d3fdc1','b1f0fe7ced2aa0e7187d86da9192b3afd2737d798c81f9b7fdb19257b22cc111'),
('edwin-arnold-et:gita.4.12','edwin-arnold-et','gita.4.12',4,12,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L840–L843','8cb225e82646514840c3258ae19822864eb1eaec83c78c36ac37048b3a1af0c3','f5e3950f42f707f84adc6d6a675d5776f1c421ca63a9511d94dc3e8046cfc977'),
('edwin-arnold-et:gita.4.13','edwin-arnold-et','gita.4.13',4,13,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L843–L847','72087c06ff13fcfde72e970ca3736b0ec662b221d657f5771447561a87256b5e','baf7893a93e4cfbf725957e1f5c1e1f4c88fff3095d1c897f8d54ba23417a499'),
('edwin-arnold-et:gita.4.14','edwin-arnold-et','gita.4.14',4,14,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L848–L850','771a05516ca1e969347792682f1a63420e5f8eaa9ffb84dbf1e44168b374a085','24d09b3c424e66da5682fa26a949b03ae71ff1f34b5cf9a633ce57b7c9ab2b36'),
('edwin-arnold-et:gita.4.15','edwin-arnold-et','gita.4.15',4,15,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L851–L854','307c646c939866593e452baff324fb46688090e1d9d0e0b8a95864eabc119a7c','7f0d3ca2d361c7631576a28636a616f1151d0af482ba7a7cb29893a3655547e8'),
('edwin-arnold-et:gita.4.16','edwin-arnold-et','gita.4.16',4,16,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L855–L858','d66e9753b64656862597fcbe10d1dec4607f4ad8c89ea03fc9406d72fd53f4d8','a572b2745f71d72853ead5049532deefa34f531b49ed7e6e58d0dd978baabf3f'),
('edwin-arnold-et:gita.4.17','edwin-arnold-et','gita.4.17',4,17,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L859–L861','22e5698eddc45036a80ffb853b99af3b74de75d8621736823749c42acca04621','b2aae0be10815b4045fb4d53c2f9fc000f14b9b5e71f928b4dbfd2cc205dccf2'),
('edwin-arnold-et:gita.4.18','edwin-arnold-et','gita.4.18',4,18,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L861–L864','82d1d87eb88cef73e0198718e04dd4374f76e8231c85cd07d56c64687ea63dbb','eee38078a72ac6d99dc39e85b7ec8896b7fee3f49643fd9bbc1161477c09d949'),
('edwin-arnold-et:gita.4.19','edwin-arnold-et','gita.4.19',4,19,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L864–L867','25d30657829bf2677234497f5f8c07d1a67b8b0c79dbec9ebb44540e81603da5','34c04c8c7f21612e57bcc26b0ded011e4237433adacb44248fe6df8b4fea3492'),
('edwin-arnold-et:gita.4.20','edwin-arnold-et','gita.4.20',4,20,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L867–L871','904b1086a64b880cc817d6972a6414b919d936ed1ac2e670fff5e07e1cbc9b6b','d794e7674e1579b3416c4d3e3fe9537110f088eb0b3460081b7f646b309be240'),
('edwin-arnold-et:gita.4.21','edwin-arnold-et','gita.4.21',4,21,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L871–L874','a7337c61cb48827b48853de1c6d7cca502b637e7e0101ca23c4eb2dfffe93fec','04e447fc25f591d186cceb66f3f03e9b297134bbc2523ffd49501ef302401b6c'),
('edwin-arnold-et:gita.4.22','edwin-arnold-et','gita.4.22',4,22,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L874–L878','05eab9f03a4aa27dd49be23e84cdeacc24072252e0834f9a78441cbabe5e71e2','32d2b3f5c7a31b4a68aec1a616f08663ef9e58552343b6069ad29b336813833e'),
('edwin-arnold-et:gita.4.23','edwin-arnold-et','gita.4.23',4,23,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L878–L883','788c438e8a08a636eb0d3e6d05229c4ed6109d36f0f128be8369d871760264e4','c576baef30cec3a38f482a8f6be0fb7d1a2b4e9d15767833b507db30b38d35e1'),
('edwin-arnold-et:gita.4.24','edwin-arnold-et','gita.4.24',4,24,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L883–L887','51a74ccc98e31b28cd77927568d5e3dc94672a8d7c92d6b5c10f2e39fd83fc2d','4d13cf4ef7612a58f95bbdb8ad3fd0b70bed92dd59210a0952d6e179c93b9063'),
('edwin-arnold-et:gita.4.25','edwin-arnold-et','gita.4.25',4,25,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L888–L891','dabb659e77b2485da8c82621ef406e21a37fcd75e2f6746ab74c493204a0eb03','ec8961d57d9463287904abc00f44cd648ba9643f8474988d705c4bfb98024009'),
('edwin-arnold-et:gita.4.26','edwin-arnold-et','gita.4.26',4,26,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L891–L894','4f9b2c4d3ef3659319de2e5b2af498fed5d3de150622b6c26416c894c212d382','b55ffa6416b4a2c7481c7f4585665bcb0bb537cb61fa37c922afda1d155d5264'),
('edwin-arnold-et:gita.4.27','edwin-arnold-et','gita.4.27',4,27,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L895–L897','591b3aecb86e4e24ff539f8734d488953baf0c84b28863fbf59c8176e29dd96c','431f60208a3bab3b84ffe70cb14a81741a6e7eeb51d03879811c22df4c99334c'),
('edwin-arnold-et:gita.4.28','edwin-arnold-et','gita.4.28',4,28,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L898–L901','a1a60ae700a90dc8cb0c2279ab5f76c7bb48a38ea28959cdbf01feea727f1860','2a7a82a96c916ff8726e5b48d8c2e31c273f36e71097b18cac429160063c5856'),
('edwin-arnold-et:gita.4.29','edwin-arnold-et','gita.4.29',4,29,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L902–L906','be932f967043a0757725bd936d92b9e83814ecf87783c101a1cb07e2aa2e7e18','8f4725067404179f4bfdd56e91359c48166e68cea27985ebd0f5dd14fe8a77f1'),
('edwin-arnold-et:gita.4.30','edwin-arnold-et','gita.4.30',4,30,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L907–L911','24f8d9947dfe26eb328a3c238cae49a0ec4dff825e64a38720cba6af6f52f8cc','0f7993cc2c71f878ee7b331e4254007fe3897de293d1084030a98f7e0fe1d444'),
('edwin-arnold-et:gita.4.31','edwin-arnold-et','gita.4.31',4,31,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L912–L918','8b3fa287f7c70a23d1ee965b0b34f0082c161262156803e0e3163345214bad25','30978522eb9a4b8e16aa1224fa2207e6dba01ba71d4a87a031ff239b42b8b118'),
('edwin-arnold-et:gita.4.32','edwin-arnold-et','gita.4.32',4,32,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L919–L922','020e6966b686364da6fe7230f71f485bb467719fa2d49c66b8c68d9ced2242ce','e335ebb2ac6d5addabd00600aa9e6a670b9fca93c83538a225e4f701dffd8edd'),
('edwin-arnold-et:gita.4.33','edwin-arnold-et','gita.4.33',4,33,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L922–L925','6bf3bf4cc86cec1f81cb45a676af116992463f9dfe231e1b646961dec526e6f9','2059ce69cd76d7864c4a2a8745249a01ebdea37fcb888a01f69b42cfd34e5ac0'),
('edwin-arnold-et:gita.4.34','edwin-arnold-et','gita.4.34',4,34,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L926–L928','743dbd45adb67f251a4d7b5b7c6c79421139cafabb5ccee9ac130f399613316b','c5c8a917dca034234145d6402db38c0660d5f0684986fbb24615712a2235ef00'),
('edwin-arnold-et:gita.4.35','edwin-arnold-et','gita.4.35',4,35,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L928–L930','7ade7673ce224eb5d4380bb26eab88a369139b7b79eaceba54823756fe6dee5f','17cc81e41db6a3a8c76883bccb2a3f239bfcbcf55563ef3f9d99334aa6b56e19'),
('edwin-arnold-et:gita.4.36','edwin-arnold-et','gita.4.36',4,36,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L931–L934','0779785055c30b3b05ad388e787aa1ebed9fa7aa72a58e3727f6fbbca5ec2abf','8e6d744e214420a0a8c01e04ade8470c6cc6e8d84ac8d62def5557948ecd355d'),
('edwin-arnold-et:gita.4.37','edwin-arnold-et','gita.4.37',4,37,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L934–L937','0ebc0516ae5bfd189f3c61ee39241fbf53d890e1f2571d2e0d069b1f16e1751a','0f1fa826da324cac805859ccfc66049ccfc075c5e41c8f464dbe79dceed60233');
--> statement-breakpoint
INSERT INTO commentary_units (id,edition_id,passage_id,source_chapter,source_verse,unit_type,alignment_relation,alignment_status,source_locator,raw_checksum,display_checksum) VALUES
('edwin-arnold-et:gita.4.38','edwin-arnold-et','gita.4.38',4,38,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L938–L940','1bffdd3bc67de8f33c977c0c9b3ccd466aca9d48bb7610bb8bf3c9d79980e094','311b161a1c3caf885a699429e688ddcdde255e5362e5e49fb8130068c05a54f0'),
('edwin-arnold-et:gita.4.39','edwin-arnold-et','gita.4.39',4,39,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L941–L944','af7f0c77b936359fe269fe2d54745058b515ec8d593d5c322a290a8a65039346','6835548c6fd6ac3b37034b4e64a800e76204f0d14a048767235eca16ad0c91c8'),
('edwin-arnold-et:gita.4.40','edwin-arnold-et','gita.4.40',4,40,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L944–L947','e86c1dc6020a0045ad19e9ded7a0afa2516773430708c78b3aa2598ca4fe39e1','2e5a93e865c12ea2f0d1c88c4e0bea70dc3d798c89d4b73840478060f3b20108'),
('edwin-arnold-et:gita.4.41','edwin-arnold-et','gita.4.41',4,41,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L948–L951','1adbff8b21f930e49e25f85da9f143ba1db3c947b9264753940a0c9d6b98cd14','d84d4b3912af091e78327e669d93eb53d9f8088a468d0f906a5f1f56f5644619'),
('edwin-arnold-et:gita.4.42','edwin-arnold-et','gita.4.42',4,42,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L951–L956','22d885cd9c206a201f324271b03b8dfe6aed37e1e344f36363785ffb3e891e62','07a86a2170c577905bfbfabaf7227091ae72616c2f3d40794500e952304611e2'),
('edwin-arnold-et:gita.5.1','edwin-arnold-et','gita.5.1',5,1,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L967–L972','aeb991139cd119747fe436196d4c38863385d00f46aaff7c7090b1a05e0de927','8c0c43b004efee3024a95febb446fa5737cfc51c02303868ec79ee3d83fb3544'),
('edwin-arnold-et:gita.5.2','edwin-arnold-et','gita.5.2',5,2,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L973–L979','4d14ad352a1393d3649a4b8f40328ae80e0776c4af1f637a6f9061bcf06f58b9','d6a768909b816a7bbcd26a5e1239fa539fc5a16eda1c91f22c66cb15fae97adf'),
('edwin-arnold-et:gita.5.3','edwin-arnold-et','gita.5.3',5,3,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L980–L983','412d4490704925a58e12d89468cf8dd964acf48c82e8922b6aa46d24f43971f1','a56445d46cd66ecb2c50ca7db4a192755fcf97dbdec8496af8f26864312b40cf'),
('edwin-arnold-et:gita.5.4','edwin-arnold-et','gita.5.4',5,4,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L984–L986','d5091745689a09753551fe86871b49b761584808dcbd1cc57369490dc4582d11','268f09a6212ee227024551def79d1290d38e549d983aa333ac331e32853889ff'),
('edwin-arnold-et:gita.5.5','edwin-arnold-et','gita.5.5',5,5,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L987–L989','9874aa8b6af26956b9598bba66a9e0e372b0a8719f210d224b9995a069be6c61','208b54382e88a050b522610ee71bec599585429395e0857998755f9ed72bd2bc'),
('edwin-arnold-et:gita.5.6','edwin-arnold-et','gita.5.6',5,6,'passage-commentary','shared-source-span','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L989–L996','348f218d6f8431fd4d6111dfa47da16901ae222bbb7d36eb582258cf6b76dad3','663e0b1ce303dd08455e5908a3467eb3ff18e7d2384fc962dbc66f9a75403e84'),
('edwin-arnold-et:gita.5.7','edwin-arnold-et','gita.5.7',5,7,'passage-commentary','shared-source-span','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L989–L996','348f218d6f8431fd4d6111dfa47da16901ae222bbb7d36eb582258cf6b76dad3','663e0b1ce303dd08455e5908a3467eb3ff18e7d2384fc962dbc66f9a75403e84'),
('edwin-arnold-et:gita.5.8','edwin-arnold-et','gita.5.8',5,8,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L996–L999','8c3fa4b60ca31325aa48ff26404af5f6e2c7ec7894e092856a65929c6568674e','9c7ae1aabb4afc9a73aa19c1087f1d115d26de0af00134fdb4d7214743800760'),
('edwin-arnold-et:gita.5.9','edwin-arnold-et','gita.5.9',5,9,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L999–L1002','66d7c9627060a67ef751ed2189b2a32d257b81346792586cd80d119145d023fc','66d7c9627060a67ef751ed2189b2a32d257b81346792586cd80d119145d023fc'),
('edwin-arnold-et:gita.5.10','edwin-arnold-et','gita.5.10',5,10,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1002–L1005','f26c87e75d389495f6a9ca76b16dc91ded5eb25e51295a19cb44b0d8ca42cb31','fb2d84e1543d8a05cb42bf49386303157c5394af19ffb23ce25477d589296bfa'),
('edwin-arnold-et:gita.5.11','edwin-arnold-et','gita.5.11',5,11,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1006–L1008','a36068d0cd9bfdf290e26687c68f51a1ba7deeb33e37bfd6b77d31aad55b683f','3e918fae216724242c221591b658e18d7302e0d2dcfdb394433e7d71e329e72f'),
('edwin-arnold-et:gita.5.12','edwin-arnold-et','gita.5.12',5,12,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1009–L1011','4c46b31700a719654b733d6b7a3cc0b7a31035d0b3a3eb544636164e3b2b62e9','74e7755c2b2cf0e068f5a7b8a18bfcb226abb1aa1f6aa63481f616aa9fa84aee'),
('edwin-arnold-et:gita.5.13','edwin-arnold-et','gita.5.13',5,13,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1012–L1015','4347e346d7ba868e36a0c668ea79d3b12eda5640de27877cf9be39e9bebaa83b','37b231cb28be5b95f280fd341b510c2a676cde3cbdc1c68f1f46bb801f72338b'),
('edwin-arnold-et:gita.5.14','edwin-arnold-et','gita.5.14',5,14,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1015–L1018','9a1c2e1fd1494056e4324f494f43479e1645d20acc378ae27b9b68a455ed2625','8921d808e110be5df5bc7d9251f106a3bffe38306450eee0609d4f28ea4cdac4'),
('edwin-arnold-et:gita.5.15','edwin-arnold-et','gita.5.15',5,15,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1018–L1021','6487b6523c6f4a8d586d6aedbfa04f5fb0bf923fcb3a3cfa3d1b29c7bbf09db8','6143ebf978b6cec50446b45f21d0bac8b9fb95e55c33a0f13aee61cc1a39c03d'),
('edwin-arnold-et:gita.5.16','edwin-arnold-et','gita.5.16',5,16,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1021–L1025','521c1f653c4062044759e0b87b1ec6ce9eb4ebc11e8855bcd98b55d1637e4fbc','1518122d884c519ca3411e79c5c640fed09d263879ebb63947a8388c6464445a'),
('edwin-arnold-et:gita.5.17','edwin-arnold-et','gita.5.17',5,17,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1025–L1030','af8259882d75a0f7cbb30d2ee2fdb21f0c271351ee29449b5f38bdae3b9a58de','4d871e2bea793d73f5e1bbfbcaec099ca405ab1ace2ceb166a47f74f06309be9'),
('edwin-arnold-et:gita.5.18','edwin-arnold-et','gita.5.18',5,18,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1030–L1034','3fcb53a0fd464dd8735d680d01ad6cfcaae1cc02ebedc0fa4f25e8d08e1d22ff','0d89cf3a3a1fac7f7bc56fe269ebe9be1b7e38145cc958cb13eb4b64c882e135'),
('edwin-arnold-et:gita.5.19','edwin-arnold-et','gita.5.19',5,19,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1035–L1038','0127e1bdb07677931877c1ce0616d3b6723d7010def0ab074d07eff1d2d5b774','361b8df3ca6de2ac829300ef001b04458cb052f8072d705d16c179d681491a0d'),
('edwin-arnold-et:gita.5.20','edwin-arnold-et','gita.5.20',5,20,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1038–L1041','3d5a43cda845eac96d88b9acbb417709b15016f2e2e63927366b3d233372c2aa','97bc748dab370f2fc6b563c4522c0154b92b5b4c37ce372a8ff04fb167596d03'),
('edwin-arnold-et:gita.5.21','edwin-arnold-et','gita.5.21',5,21,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1041–L1044','5d13c6bf8a0cc3ff411e17935f37695cc5a03fe54a450c9eef25a498821b1c82','14e042b66b1bf27c29d7aad63e3d0b8d1c9e84b7f9db8ee5025d6177a226fa87'),
('edwin-arnold-et:gita.5.22','edwin-arnold-et','gita.5.22',5,22,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1044–L1048','eedeb56f4926340f5ab8e64904f38639de186c7c713b84a972bf50b5e93014b1','21c0fe4323087c817570a3ecb40391da825dd5a0fba2148a539b158462fc4f4a'),
('edwin-arnold-et:gita.5.23','edwin-arnold-et','gita.5.23',5,23,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1048–L1050','b94ad1313888fec6b782b27a8ea0e092dff64f3f7d6c90b271f02fa5660ab500','33a439d4db5cb079aa80fdde1fafd7bd143caf840ae4522de0b2a993359d449f'),
('edwin-arnold-et:gita.5.24','edwin-arnold-et','gita.5.24',5,24,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1051–L1053','14b58b8c70a9c69b69d6f89ff0ef47ec7ec630dc8c200ee0099b08420569844e','93a93cc4d7e464db9aa481d298fe4155ca3b62f49779f58fb9b72402a7b25694'),
('edwin-arnold-et:gita.5.25','edwin-arnold-et','gita.5.25',5,25,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1054–L1057','4f9ba44162e60bae685e742f9b365750b82389ea01f8d8c598e6a42429a4d1ab','dc9f4419b7dbd926610b32077905b1358c2f37d013e6df0097e5eae2bfef0e62'),
('edwin-arnold-et:gita.5.26','edwin-arnold-et','gita.5.26',5,26,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1057–L1060','8ca2799d142955f257fbc8da21adb660ff6b21b3c8c330011869e3fe759ed5b8','503d2037884221f12039420458cd29fb3a9b67fd6901ec6d53e1d2ca8bd4f1ce'),
('edwin-arnold-et:gita.5.27','edwin-arnold-et','gita.5.27',5,27,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1061–L1065','f3ab2c4f7ea0e872f5e82ae91dab57e1654a164b12ad82f2cb1bb49e113c94a5','3facc895c212bf2cc8b30159cca05c0cc8a6c69c7324763b5f4a3f47a4b95e6a'),
('edwin-arnold-et:gita.5.28','edwin-arnold-et','gita.5.28',5,28,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1066–L1069','b7ecbf5337a1bf4894aeb5cb48a64c76870c7abec8eb31e02a434f7c439f7908','4251685f6d64c9da698acdf859079bc76cc2eedea02d48805bff36be200ab3f8'),
('edwin-arnold-et:gita.5.29','edwin-arnold-et','gita.5.29',5,29,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1070–L1075','8b370ac0db7bb66ab3f176f434859e24f93bf755d2b55e8a060cedceff349f3b','213da307a0ef3f9d96c5f995349e738acd59d0f98f86f07737e14dbed1fb06cd'),
('edwin-arnold-et:gita.6.1','edwin-arnold-et','gita.6.1',6,1,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1086–L1092','abcd66d5e0b9edaeebd5bf84ec773697a6d450a3277b5c92cabb326bdae7263a','b7b0bc8ddc6923767685419003f63e9d8945db022a19e48687a5e2ab0b85563f'),
('edwin-arnold-et:gita.6.2','edwin-arnold-et','gita.6.2',6,2,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1093–L1095','e4758319eee8636a3c115bb2c6c97fb3d079363841c3c6b373fd6124bdd7798e','2a1cedcd66baf98201aca9d602204fc6b4fd2f509696f14021df1fb207568932'),
('edwin-arnold-et:gita.6.3','edwin-arnold-et','gita.6.3',6,3,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1095–L1098','952d6494a263bd8cb281da4b9dd416f3e0d8d51fe73d81c94016b1deaf480ec5','1245643c716ce9006f87b2cbb713deda66f6446e3c639b16febc73bfc9e4d56f'),
('edwin-arnold-et:gita.6.4','edwin-arnold-et','gita.6.4',6,4,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1098–L1101','d65eb6998f474bbd436807f2946578f0e345a24c66d5030c3111dfad5aabdfb2','e008764c280581f0d067c1e277f5da7f02bf4110d1e20cd06de87a328d96efc4'),
('edwin-arnold-et:gita.6.5','edwin-arnold-et','gita.6.5',6,5,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1102–L1104','3a287c460314d5bf8b612eb7300ba8d78e997531592a853eb8991e9fdf064d09','09e7e30d32fecb286a98653c993bd2dba7cf13e22b60b059332a82f1e1e535a4'),
('edwin-arnold-et:gita.6.6','edwin-arnold-et','gita.6.6',6,6,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1105–L1108','0f1ede09e25d4663df0340c64fbb5ded0688f31f13aa0864532062c4d17bee17','6ff88e004aad3d3bb7e8b93fe872d1451dba91178f1bd6d2ebaadef4b250a7f3'),
('edwin-arnold-et:gita.6.7','edwin-arnold-et','gita.6.7',6,7,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1109–L1112','cfd2a4e0eff886cf67073a3e864547320c24adab389dbdbe3a618efed5618fee','d143c1d713a69ec84ad694077a7c356fd89d08a6ea85902c7a7e0c8ce6a8319a'),
('edwin-arnold-et:gita.6.8','edwin-arnold-et','gita.6.8',6,8,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1113–L1117','b5293abe3720fe8d3e6a0800bd778a59c92e4cfd07294f66ff896f4040ee6d85','62e24041b867745b2cfce5656e36fb97ca0c2809acb07acb618889ee32c07ab9'),
('edwin-arnold-et:gita.6.9','edwin-arnold-et','gita.6.9',6,9,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1117–L1122','3d42d78326e50b5e671a6e4e159219eff2c1431c6fcbb753f45d31ed15011f31','26efa0f28474ce6aae65b0de458ed53e202fc7e3cdb0468def4e986ce42447a9'),
('edwin-arnold-et:gita.6.10','edwin-arnold-et','gita.6.10',6,10,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1123–L1126','c698b2b2b645a520a947b69f202d88e286afd861f7afdb965b7d6b150f9a0249','8803f99e8d08ed3a06fa96f0112b13f1b2267bae2d503838bfed0d56fc873e21'),
('edwin-arnold-et:gita.6.11','edwin-arnold-et','gita.6.11',6,11,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1126–L1129','36f7d4271233689f9a66c000e2c372e46e576ce3d9c548472991afbaaab2394f','247c3bb83f4f5be1b0bc6bab0f5b8ccd69678e5e537a03f3d1d37e31fdb1d79e'),
('edwin-arnold-et:gita.6.12','edwin-arnold-et','gita.6.12',6,12,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1130–L1133','77cd6cd86ca06d6c749d5572230af43613d38b7e448f826c6005a1b4c350be00','c21a595bc5bc97e76c23d3f96b51d0962d594b74febd852fd83c8657acb0bef4'),
('edwin-arnold-et:gita.6.13','edwin-arnold-et','gita.6.13',6,13,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1133–L1135','09fe9b50eff8acdc4f5cc6db32bf065c02e8d8b32b9569185a1cfbcc174428aa','cbb991310c166511b760c1fc7102fab1311df794e6935858578c48d20f999fe1'),
('edwin-arnold-et:gita.6.14','edwin-arnold-et','gita.6.14',6,14,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1136–L1138','cabeda0213afeaf6a675c821df0262427e1b20da0c3f4ad39a549328760a1108','2f5c9b3324a024a71dd215f6b5dec6dd7ca97b30359702d2f7d202c35fa89d68'),
('edwin-arnold-et:gita.6.15','edwin-arnold-et','gita.6.15',6,15,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1139–L1142','e72a04879a4069f0b818d94a11117b6917367c5f0b0d58ea36676c2f8864c547','57e9fe607ef26d9d881bb18321986a793c5741f337bb1eb5fd20a62d674f27d4'),
('edwin-arnold-et:gita.6.16','edwin-arnold-et','gita.6.16',6,16,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1143–L1147','1d60849e90f75400456ed0930aa832670dfa04a75b6693dce391acabf6c9f12d','edae809b155e122c12dfc22ca3cfe1297352c8cdcddb6680001830d13eda11c0'),
('edwin-arnold-et:gita.6.17','edwin-arnold-et','gita.6.17',6,17,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1147–L1153','acc9c2dd2595180e10e6abf4f8ac64c9af755fc4e4341d9c33929a542d73725a','5a158ec156550f4640f63ef80b791b0b3b4d7f0146764b4c02c3284a6b9f06c4'),
('edwin-arnold-et:gita.6.18','edwin-arnold-et','gita.6.18',6,18,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1154–L1157','6731536605c66ace1e25fdb3b4543cc04df216943056895180e784410b104074','3e0fe43b264241863a783f5efff2102151ea1a406dcae8f763d11aabdfa7797c'),
('edwin-arnold-et:gita.6.19','edwin-arnold-et','gita.6.19',6,19,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1157–L1160','91cac047312ae3230e192790eb482678a3747bcce58a9b97aca3a65c96321804','5be5f9bb70edb886870eab91ca3940c48e907ea62fa3c1fadeeaa97411a9f315'),
('edwin-arnold-et:gita.6.20','edwin-arnold-et','gita.6.20',6,20,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1161–L1163','7f56731e11de0f15de419b29a939f3aa2e0c3f29e125d010e6e5d40d00a3a0e3','091b2ec97953e9395cdc3832211afd26724ae052ed80c843391e1cc41f7bf1fd'),
('edwin-arnold-et:gita.6.21','edwin-arnold-et','gita.6.21',6,21,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1163–L1166','66baaa39b46cd43dd143d6e1162e24a2bf7026c6a2b5dc07090f1785b3cdee3b','b03b7b394326f3bbafa788767c5d133bc4ddf1fd5403353a56826f396cb3e8ca'),
('edwin-arnold-et:gita.6.22','edwin-arnold-et','gita.6.22',6,22,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1166–L1169','170292fa18878e2fbb77e4af26a502e0abfafd9ceaefcb1a1930f78752e6ffa0','081c1adb2c2b464dc441a3fc00298c1cfcad2dce995ce84bf5ded548628781ad'),
('edwin-arnold-et:gita.6.23','edwin-arnold-et','gita.6.23',6,23,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1169–L1175','16ec62f232d1048d0c18f9e568a5f496e634e080472e54878929b0741ab9071a','bee535c5b744a87b177311b1662dd5caf6f111b1438d73dee8e6fede94e56559'),
('edwin-arnold-et:gita.6.24','edwin-arnold-et','gita.6.24',6,24,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1175–L1178','ac9a956a4997825a968e085523d35cc65796498f4410f26f137a6bdd507d7d25','8367dc02ca6662919ff1cc02c9ecdc8907709517bd3ee2e1a23ef945e3e85b8c'),
('edwin-arnold-et:gita.6.25','edwin-arnold-et','gita.6.25',6,25,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1178–L1181','ea8e09be19d2d8585eaa373a3a3f1a483671d8134afc94b2bf4fc5fc7b259db2','4645966e84524a62a1c455c15c1ed7d69fa2ac5c489c65677cd643918eb37ab0'),
('edwin-arnold-et:gita.6.26','edwin-arnold-et','gita.6.26',6,26,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1181–L1184','1f76e58c902cd2e2e16117a61ef7704c2537562c890adbea8c5024e0645b6453','9bb2f308d1ea4baab931aa21996176681d841f7183bc098f714a895ad3696dfe'),
('edwin-arnold-et:gita.6.27','edwin-arnold-et','gita.6.27',6,27,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1184–L1187','41a03b366b2c26d74c4e66b33292704f4197ca4e1166d2a0dafd83fe09c064e4','98a1de1186f2792be50ddebd60b5bd9dfdce5a90e40919919665fb68b2ee2a2f'),
('edwin-arnold-et:gita.6.28','edwin-arnold-et','gita.6.28',6,28,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1187–L1190','2cf68d4f2787d39ac94bb5c3a500b1e749b2c20aba4bb3f118ca3c7a9f07833a','3a3aa09fedebf1a1be5c04b33226e31d6e3221841a7ac4ab425dcab3b3140168'),
('edwin-arnold-et:gita.6.29','edwin-arnold-et','gita.6.29',6,29,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1190–L1193','7b11ce75ae8c4e60a0dc0db05d90a113beae334a736223f79e31e8dc8f5eddfe','e395752adafed792e08c834a632bbc993e6506a9255f19f937651654aedcfec7'),
('edwin-arnold-et:gita.6.30','edwin-arnold-et','gita.6.30',6,30,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1193–L1196','b0b9a1886f7d59e952780a784bcb91d15cbc5293de09eec39ff2a33809e629aa','1af07e5334396cb2a7f62f755139cc4ca3230a454c39a7e9162b02d4561a97ea'),
('edwin-arnold-et:gita.6.31','edwin-arnold-et','gita.6.31',6,31,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1196–L1199','641affe996fa7e38a1c9e48db97471369a6c31c076ecb56a59e4b3ba1e706176','f7dda935b6b8b0e58a2db937b1e6a2f233bf4c635e8f1f060f15e867509ea122'),
('edwin-arnold-et:gita.6.32','edwin-arnold-et','gita.6.32',6,32,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1200–L1204','84c706241201e27d1ec89ce4e27562d489d6daf4478755f5d9cf7d4199f86f67','0b0ed590712fe0ceb2a53c1a070504443493f4c5354c1fbce02cb605ea9192ea'),
('edwin-arnold-et:gita.6.33','edwin-arnold-et','gita.6.33',6,33,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1205–L1209','005e87531c363113d022709a5366bb926bba75d0cf974713d34c9843c6e5449a','c262b06c55b5c449d5f97df2e5135f09f7ef926a686c126ad85b040923e78747'),
('edwin-arnold-et:gita.6.34','edwin-arnold-et','gita.6.34',6,34,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1209–L1213','88e4cb02a60e84f695bb08baa0fd2c290ef9e8c2ac7a4bb501d69a07dea73c36','0e939663619b7da32a698070cf15a36cb83b6f33d970ffb1cf847b0ded59e310'),
('edwin-arnold-et:gita.6.35','edwin-arnold-et','gita.6.35',6,35,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1214–L1218','a7d70c932c290f7b3d1b3270b9eb3bdc4afcdba7baf968f9f75aecd934ae51c3','1af8c98d241ea2e67e4dcc6b47624600397a5b7fa11567b271324d6d98e138a5'),
('edwin-arnold-et:gita.6.36','edwin-arnold-et','gita.6.36',6,36,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1218–L1222','8730b6eafa5c2d0703557a43dc5ba3f6dc4cf614688555676154ef806115d280','e8e13daa1a870bf2f8ea0455d7e659e020fb8f6d2f801cd8d78df39c61c2efa9'),
('edwin-arnold-et:gita.6.37','edwin-arnold-et','gita.6.37',6,37,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1223–L1226','0b93a5d355b92ad189a92a97217395aa05194c3210b30e3d1d5fa332aa6e5cc5','6def28e87e927117194f97830f7bc6bf64a5c19d23c01920dfadf49a8c181ede'),
('edwin-arnold-et:gita.6.38','edwin-arnold-et','gita.6.38',6,38,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1227–L1229','5190525c778d3175bead6036d532b3aa702d4bdfe733a137fae308983a5fca90','395b008d8fddbe389e0d59c6e0272b160e9e9c5bab3802210dfe6086bfebeeb0'),
('edwin-arnold-et:gita.6.39','edwin-arnold-et','gita.6.39',6,39,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1230–L1232','5ee6b3c6720c9a7b78a08179a7e6e34287d4197201006679a560eb3041dd363c','d1c42421997b6060eb9650cb028a2990e9b74ce76b44ae7f9c4fe8bd76461f89'),
('edwin-arnold-et:gita.6.40','edwin-arnold-et','gita.6.40',6,40,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1233–L1237','0b3ee20c359cda59bd00ab349841b9bf2f3e35b089ffb8d26d55d4bf89b4ebfe','47f08458a4319e7d20cd92d4406c2747dc5f510aad872fe24293a200106c5634'),
('edwin-arnold-et:gita.6.41','edwin-arnold-et','gita.6.41',6,41,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1237–L1242','9ffb5bbb137362724763677ce01fbc80965be67a52042292686b6244bb336616','dba141ba44a5780b62d50802b60ca2f04d27bfdb709080a78c1e71b4d92b8106'),
('edwin-arnold-et:gita.6.42','edwin-arnold-et','gita.6.42',6,42,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1242–L1245','cd218ed153001f15ee41f4459a2ca238330e36c299dba290af2dabaea31a68f4','8cc533a5d3473f87b5e61c227d2f25867f575f7002df5be40100d5102f27e849'),
('edwin-arnold-et:gita.6.43','edwin-arnold-et','gita.6.43',6,43,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1246–L1248','58ac0722f82fe6c58d2abc70bd6584201ce05a3c6e09ae0f8bf959a0fbbd5b10','ee1df4729375e410953b4106109c50c4ad0b27525db8a4bf0ab94323aab49b7e'),
('edwin-arnold-et:gita.6.44','edwin-arnold-et','gita.6.44',6,44,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1249–L1252','a425ef8086dc5894d6790466f7bf70f4b8ae6105868c8e2b97e0058d8e3d25e7','e248d73e8553e7aa425db5e54f896f580cae57fc7d96c1b11c087308b5b664f4'),
('edwin-arnold-et:gita.6.45','edwin-arnold-et','gita.6.45',6,45,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1253–L1256','fb1c4e318ccd97b6b261b4ac40e8b68537af98e41cd5a0349b7a456c5afc0b8c','abd445b9d45c7602b6b1087e49e74372943b1deeead942d07c9c1466568b4d19'),
('edwin-arnold-et:gita.6.46','edwin-arnold-et','gita.6.46',6,46,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1256–L1259','cf5bb902d9b3d925e8e1d28e3d440e0ce16dd6df1a182b7910aec3ef1264bf65','2c96fb0f09d13354c7fb3caeb722b16f32daf7688b6e5924e60591c8e35e5d5e'),
('edwin-arnold-et:gita.6.47','edwin-arnold-et','gita.6.47',6,47,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1259–L1262','cceaf63cf7feed14665492da5bf58e3e4c67a12d996351141043390c5b96e602','1cf3683bfc230b8e780cbfb970725fd061c4f99dcdeb73e1937b9820265832ec'),
('edwin-arnold-et:gita.7.1','edwin-arnold-et','gita.7.1',7,1,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1273–L1277','5c2290037770723b65848b76e806c2a3e4d925c9ddcfcfc9deb0a4cd517d2362','2c3bfa57154b938ea2b18a5997f311409fcd4ed9213ab4e57c1f8b6aaa9ae3fe'),
('edwin-arnold-et:gita.7.2','edwin-arnold-et','gita.7.2',7,2,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1278–L1281','b768fdba3cf251f787c82be18b459ad5f381ea6f243fff6885c288b1cf498ab7','798ea2c266c82a4d70d1007f7328774bce0cf086de15af1d1dcc6d6bf49632a2'),
('edwin-arnold-et:gita.7.3','edwin-arnold-et','gita.7.3',7,3,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1282–L1286','f145227d3cff2ae9062b89bc88a90b7dc230f0f3d68d56a169d1d4f64b71d1b8','69cc4c414084506168edd1f05eb209d314422bd78c16142486651eb832edeb6e'),
('edwin-arnold-et:gita.7.4','edwin-arnold-et','gita.7.4',7,4,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1287–L1290','2dda1fe8dfd313da2c6894eb0ed4c7a55a214ed990a145f44addcea1ffdc12ed','6e2d82cf8c2b3f9e2c02c1d6d3e7081878caad55fb397564fc41ee2baed4ae32'),
('edwin-arnold-et:gita.7.5','edwin-arnold-et','gita.7.5',7,5,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1291–L1293','d744e9449e86b7bb8759bdc6c0627bfccbf9a1d400d262636463c5069bd22175','bb18808c86224c8f96abbc0bbc028f71ae57dfc699752289c5ac2f80f943faba'),
('edwin-arnold-et:gita.7.6','edwin-arnold-et','gita.7.6',7,6,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1294–L1296','7cce4d25f66fc6bce9d50fb41be9e5af9e982ee019c389817c5b3df49f699acb','ecc0f23b862b4f1913b108cf7e262be97703c995742010f2a39bbd7580ab2ab9'),
('edwin-arnold-et:gita.7.7','edwin-arnold-et','gita.7.7',7,7,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1297–L1299','8c38b08fc85cc0b23124d9f837a17b8632ea4174e20cf6a21a6a10020df4c61b','3936e9b85dbc7802d40e45047e1e5e40e7ae66ded126ab992816ef52fb9ed846'),
('edwin-arnold-et:gita.7.8','edwin-arnold-et','gita.7.8',7,8,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1300–L1304','519d269c5d43099c3329b45cdcf39236a04ffb7259002f2f4b6009512d933ae5','72c884fe56be9ce894c02cb098c1e55262139e746f698e759a369b2067c220b7'),
('edwin-arnold-et:gita.7.9','edwin-arnold-et','gita.7.9',7,9,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1304–L1307','7f6a2ffb153743d72a4d2b8f1f04bf2f0009a423532dbc3dc5bf78ef79784b58','591585f8d98ac9c53c4b1c32a0e3b2207fc9f82c4995c1d3fcc3ba6fd60447d6'),
('edwin-arnold-et:gita.7.10','edwin-arnold-et','gita.7.10',7,10,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1307–L1311','a93ef8c2393d89b3c050221b2328a57290064563f93ffa45050b072a50561b46','4af7f03e6906759ef084f9d1870b6c3b6d911d2936028dda43f369c99864484b'),
('edwin-arnold-et:gita.7.11','edwin-arnold-et','gita.7.11',7,11,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1311–L1314','d6c80e8d47ee58a309d99661c0189a99af6e5808bcbedd21b218a823704289ad','2fef463adc503818e3d0097a6a13f38aa71f76f5f45316039937c7958cf766a6'),
('edwin-arnold-et:gita.7.12','edwin-arnold-et','gita.7.12',7,12,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1314–L1317','f19aba036c52cf2ff6ad5f128a7bbbb1bb9f9a97007fcb7255e8d4badf73240b','d9e13293116e9c95e8127a9da028465d3261d722c27855eddfa6b451b31a4265'),
('edwin-arnold-et:gita.7.13','edwin-arnold-et','gita.7.13',7,13,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1317–L1320','1d0148c350c7a177816c44226d2ddc2adf940461a01dce7592a1140689e1395b','d9b9c2884a36d9e7899ec1d7fef126b400c349141403625ffd00f22e7d49e675'),
('edwin-arnold-et:gita.7.14','edwin-arnold-et','gita.7.14',7,14,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1320–L1324','f1ce6611ed1b3d54c5e064641af3d41db4c1dea450537e75fbbcba7d1d9cc9a0','046dc973dd40da05f145f9dba7942e82154742bfe2bab2232678f5e2a097efeb'),
('edwin-arnold-et:gita.7.15','edwin-arnold-et','gita.7.15',7,15,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1325–L1330','730734349fe93d4670630c76b61b5f493e90bd29a8fb85f7f584b8f9fccd1754','45a4247d979dee0269ac71453f3f8a8f0ce2c42833ea89ae40ae6b4c981d760f'),
('edwin-arnold-et:gita.7.16','edwin-arnold-et','gita.7.16',7,16,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1331–L1335','b345b781d2d9fba292dce6baaa2aa68b9f9512128e2009eb819873f535a62880','392f85f0dc6fbe1443170013ff15772b9a2cfda9616a4b0d8774b32f4b864b24'),
('edwin-arnold-et:gita.7.17','edwin-arnold-et','gita.7.17',7,17,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1336–L1340','c90388a62e6fde8c49eeed3cc293f5b74c97dd4185fdc26602ec41685cfe7446','4b22e6f6e34581c5d29f481e7b91a9e11f4b6b0542255684e8a65768ffae9880'),
('edwin-arnold-et:gita.7.18','edwin-arnold-et','gita.7.18',7,18,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1341–L1344','f59959fad3c3fbe95cfbb7f77cfdfda51f344cf0b0d7753e003690b07c81c896','9dc1fe2f72ea5a854584218c110328d7940bb96cba6aa304f18b7b96a6a84fc3'),
('edwin-arnold-et:gita.7.19','edwin-arnold-et','gita.7.19',7,19,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1345–L1348','1049e7a0d5173ad90f761f84a5768a27db282ca681c9596aa3f6a9f6138d74c4','aa5e44b213215509264859cb64a5bf7ed4dda05f5139d5ffc6b147370ec9f68c'),
('edwin-arnold-et:gita.7.20','edwin-arnold-et','gita.7.20',7,20,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1349–L1352','86511c85dcc89db9ec3274b5a89c21196fcf5f0a4a1b63c95df05331efb3c588','8b63708b858db06c1f12aa812ef15efa3c290fdfec09b7f7d70a096f39929f63'),
('edwin-arnold-et:gita.7.21','edwin-arnold-et','gita.7.21',7,21,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1352–L1354','e468711ba5a05430825b7c2e5f4ab2aeac03474cee756963e2739f4f3ac6169c','7fab1c5a7b352cf9ae1aba4fdaef24334a94cfbe0ff36f92ca6f8ebccc910188'),
('edwin-arnold-et:gita.7.22','edwin-arnold-et','gita.7.22',7,22,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1355–L1357','38720c1c2217259d2ce43ef8868e65aac3d296a579caf8e9a708bca693dee7f5','16f7cedfeb16385f7a24d0983883b972ba62ed8fb568a9c854b90d86089f19cc'),
('edwin-arnold-et:gita.7.23','edwin-arnold-et','gita.7.23',7,23,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1358–L1361','a828e059f84da33cee06e58b54330912c1d91c946bc1dd37da2133976fa4f115','f2f1194cca6ec23ee9956efee88ca56f31113371fc75ca5ad317fb379d9ce312'),
('edwin-arnold-et:gita.7.24','edwin-arnold-et','gita.7.24',7,24,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1361–L1363','fccefa5f8e618728d1b13b7cc444c3b93e4cc2e3c44cbff33ff8675f4cf84787','7e4ffe06e19a4a345e992ca29922ea6f7c997f9de4e8a56292b5c4f59c650df0'),
('edwin-arnold-et:gita.7.25','edwin-arnold-et','gita.7.25',7,25,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1364–L1367','c4f0e0f57f9368cfe12b70cc6f31ce763a38d5b1aac15862d3b3f6ed645acb46','4f384c8bccf66f0fad46c694cb78a90e5915309f221c272509362968d09b5c18'),
('edwin-arnold-et:gita.7.26','edwin-arnold-et','gita.7.26',7,26,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1368–L1371','1c781c48c76a2651d8d1215019d1cfb739e7763a7e1767e71bb4164dc01d5c4f','ceb10b02e28f57866c94427cd7426cece39757e9dbf359e81e0c487076e12752'),
('edwin-arnold-et:gita.7.27','edwin-arnold-et','gita.7.27',7,27,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1372–L1374','4f8b2253ad0eafa0a3ccb31d7fd46be0fe8dd52abbf5148060ce236e14196478','98917265d2bfcf7acb6a6e4d504be123ba7fbc2e727c541a940b0bab40ed829a'),
('edwin-arnold-et:gita.7.28','edwin-arnold-et','gita.7.28',7,28,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1374–L1378','43d64656e01a007088a90ae7489a72fe6cc10f7f798522a2ffe3358e1325c4ec','3ca6404889912b4e76d7f94cacf1447ee2503b8197e3ea4682ca08ba5132efe1'),
('edwin-arnold-et:gita.7.29','edwin-arnold-et','gita.7.29',7,29,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1379–L1382','9b7a35f581f2365d3856a82dd40cbf187cbaddf0af6a334590a0610db1cdc3b6','f4540dd36a1dd547593677d50b86b12f2c3cc48fdf1ea0b0730d6e8956797798'),
('edwin-arnold-et:gita.7.30','edwin-arnold-et','gita.7.30',7,30,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1383–L1388','2bc535df959f724ff5335acb9562fbd442c23a8ab56c5d92d495a746f5182a02','b0fd44eb6a90cd777f89c8f236db51b06f5bfab920938ee604ea262e4d66af4c'),
('edwin-arnold-et:gita.8.1','edwin-arnold-et','gita.8.1',8,1,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1399–L1404','1714f3e3b087d035aaa61493811a74e0fb561390f846356ce2f7bdc7cf22f6bf','ee4f3a1e1317eeb296072511550728f294a30f5f49ab1d7ddf58b59ce39a75ea'),
('edwin-arnold-et:gita.8.2','edwin-arnold-et','gita.8.2',8,2,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1404–L1408','da6361dc417fd4f813bd1143e19489f78b5caaecc73215fd0a8c98b383f39ca1','eb03c25d0cd8d25e3d5b56f12d9788914c51eb7c16b5c6a44518605640718a49'),
('edwin-arnold-et:gita.8.3','edwin-arnold-et','gita.8.3',8,3,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1409–L1413','2e3c4ce2ec626228812817b1dcc3117e950296ba9b3e06ac9efbd1b1649653f4','36def6c3717927efe86855a794ef393d9c41bf747e2b2bfe82381bd8d634287d'),
('edwin-arnold-et:gita.8.4','edwin-arnold-et','gita.8.4',8,4,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1414–L1421','1c1290c51b8038a02ac058224d172cda2ae96d8e8788ddad4282ca536c5bbb78','75ae75c945daaef70ac332f63090029a4d870077914606da0e34120bc8eebaa1'),
('edwin-arnold-et:gita.8.5','edwin-arnold-et','gita.8.5',8,5,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1421–L1424','47906a72414b597ab8865015beb0f05c4d3ebf839cb4dc7186d741f4cadd0d30','f6ca85e4b1e9e6543ef21f88bcab6edd18b063b22f25e1ccad546b99e4b48dc3'),
('edwin-arnold-et:gita.8.6','edwin-arnold-et','gita.8.6',8,6,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1425–L1429','5268b62ebc996b2db025571ff67c7010f5779667c6ef7c84b4b63b621b515cb1','845735694fe3389ed2e9bef32574099e9b4173f8cb3c25c051cf6efb09bd8885'),
('edwin-arnold-et:gita.8.7','edwin-arnold-et','gita.8.7',8,7,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1430–L1432','3e73129cbdc92733bc169fd89ee8fbfdabb3376d0802aae14fc9fb25452dd2fe','396d5a1aeee2066fee5b99bbb6ef076c1a0720719f447d711a591ae9af0cb424'),
('edwin-arnold-et:gita.8.8','edwin-arnold-et','gita.8.8',8,8,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1432–L1436','bfaae71749bba62449dce4a9d9baf4e0646ca8d04da946cff963d7984de92710','3b996c9f260af463249159afb505aa39b8dcc417368133282a0f9a2d1ae047ce'),
('edwin-arnold-et:gita.8.9','edwin-arnold-et','gita.8.9',8,9,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1437–L1446','b46694ba65bf6e861695177ffe60f8dd55ca2bda28f4ab7cb9243db286c43e8a','b1997ec8746c48e6ddd0ffdcc0614100c8b056da7da8fbbb27feebdc25e498cd'),
('edwin-arnold-et:gita.8.10','edwin-arnold-et','gita.8.10',8,10,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1447–L1453','008075f642190963157527284140d31d558c113d6c12e46c477b834d6715da0e','81ded7e2fd0b189509c0a53e2e978e1f471210da209ad6f1c73edc01b1888b63'),
('edwin-arnold-et:gita.8.11','edwin-arnold-et','gita.8.11',8,11,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1453–L1456','c8a5d4ae95cd8106b9cbbd3fbe32a59f459595ba8817093121ddfe079af9f5e2','84e6ac33d7bd244f45c4647087621e1dc66d8e4df4d6bc894cd1657d4d47f3cb'),
('edwin-arnold-et:gita.8.12','edwin-arnold-et','gita.8.12',8,12,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1457–L1460','5e37711f54dd5d9c0439ea59006f825662be5c03b754110338d17c69728c9c8c','183adf4821fffd26853923ecd7b32f20c9d96f875a53618743d762141e31a357'),
('edwin-arnold-et:gita.8.13','edwin-arnold-et','gita.8.13',8,13,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1461–L1463','7198c23809f0b87954fbf881c229359912e9595f022299d26b00bb7c8aba4275','8d3e7382decab87567d6b9122ee153d16e53b3c0a8627c07bd14c505a7f3330d'),
('edwin-arnold-et:gita.8.14','edwin-arnold-et','gita.8.14',8,14,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1464–L1466','70a21b5286028de325c3e007304a3c1d8269bb2af30a9edd2785d9d54ed04d9c','f58a6330c0d85373781cc2791831204c548c8ef9094eb4498f4cf9c8af38ad92'),
('edwin-arnold-et:gita.8.15','edwin-arnold-et','gita.8.15',8,15,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1466–L1470','37ce2fa413438c11f39b3597933f1dcbf6b2f6472ef8a910eae0bc3f814f42de','2734fb7eeb5da849c7887687cf143422a030967890dc7596e611fd8a404d5762'),
('edwin-arnold-et:gita.8.16','edwin-arnold-et','gita.8.16',8,16,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1471–L1474','d928a6429563ecb40cfa14c8e59e48b7ba962994a5462393682e80f1daa20992','aa2388be0cb92a95d394a4ce7b7639f453227cee63c1dd9062c6a325452f9030'),
('edwin-arnold-et:gita.8.17','edwin-arnold-et','gita.8.17',8,17,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1474–L1477','7c079b855ae4deeeed6b19f302a9da5ee3a8c1cb3fccbcc9b54ab99ca7b24dd9','4f642f2af6598147d26f2949a35be633f97dc02cadbe1cb397017985ca74aa35'),
('edwin-arnold-et:gita.8.18','edwin-arnold-et','gita.8.18',8,18,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1478–L1481','3a32d43a9a17ad758f412f4ecc9f6efdf5d74c4845c6771d0d7a62f90d4685cd','50ef8040f6847530fefd013bf682360f3f5cfa36595f4c19f157e8d745a83f1e'),
('edwin-arnold-et:gita.8.19','edwin-arnold-et','gita.8.19',8,19,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1482–L1485','45ed4a01b353ce6ad6dd2949de1e18a9f6b8dd82dae29ef2a44c6808851a4d01','c1f3bae8cf2a9a5278b03d98fe921b6b968a354e2a27ffdef406b893f6abe973'),
('edwin-arnold-et:gita.8.20','edwin-arnold-et','gita.8.20',8,20,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1486–L1489','a6db66c19475fa2ef305f61eee82019163ef59cf4a59d0cca5f64f3a331fb7d3','f82211bc285828369eaefd57889e38e2bae87a6f03201bb834a7bc9d498bd707'),
('edwin-arnold-et:gita.8.21','edwin-arnold-et','gita.8.21',8,21,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1490–L1493','c37b8a656ecef3b1828b04387641006caaa7474363122a578fba0704139c351a','5958ec8477b5d4bcf86fd99dfe00149f3aa36fb25d48ee642ead4c1d4f271849'),
('edwin-arnold-et:gita.8.22','edwin-arnold-et','gita.8.22',8,22,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1493–L1498','d4e272c40d2b5b654fc3e1d6be7054e5fd509d857f389f3bcd95a4779f4c4d32','feee221503d52013dbb4a83827269b61a27b3d35143799642c6bb80f481e39cc'),
('edwin-arnold-et:gita.8.23','edwin-arnold-et','gita.8.23',8,23,'passage-commentary','source-omission','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:CHAPTER VIII:source-omission','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'),
('edwin-arnold-et:gita.8.24','edwin-arnold-et','gita.8.24',8,24,'passage-commentary','source-omission','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:CHAPTER VIII:source-omission','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'),
('edwin-arnold-et:gita.8.25','edwin-arnold-et','gita.8.25',8,25,'passage-commentary','source-omission','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:CHAPTER VIII:source-omission','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'),
('edwin-arnold-et:gita.8.26','edwin-arnold-et','gita.8.26',8,26,'passage-commentary','source-omission','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:CHAPTER VIII:source-omission','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'),
('edwin-arnold-et:gita.8.27','edwin-arnold-et','gita.8.27',8,27,'passage-commentary','source-omission','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:CHAPTER VIII:source-omission','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'),
('edwin-arnold-et:gita.8.28','edwin-arnold-et','gita.8.28',8,28,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1501–L1505','e04915188424c77b2f106331a995a7229eeccf9faaadeaeeca0e9da85d05f35f','9d0da311a2ca723ebac9021412a5db4d9f08603f51d3b64a1e77e4ec8ff8b25c'),
('edwin-arnold-et:gita.9.1','edwin-arnold-et','gita.9.1',9,1,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1516–L1520','ccfac8f51dd9cc00bf0c2eef9a53b98931667e7a765aa509c0a10e2426e4e256','e93f681a6a5c996ec5e6ae491440537bd9437cd2775724f5fce558511dd54ec0'),
('edwin-arnold-et:gita.9.2','edwin-arnold-et','gita.9.2',9,2,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1521–L1526','d88dc33280ee40c1b93125fa4f387803f9c58e07479750a2cdf57ee08d0c4236','825d196e2a701e0dd1e67793f9be8d8b2b51ae841c080bbf7527e3306693e61b'),
('edwin-arnold-et:gita.9.3','edwin-arnold-et','gita.9.3',9,3,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1527–L1531','4e0798c76580bb8aff5a5d7a2f459eb39bef696eff5926f2cdebfa63edee4c82','574a3df5654a26058567b9a1403290b3669bcf0bcb3e3376aa24cc227211d35d'),
('edwin-arnold-et:gita.9.4','edwin-arnold-et','gita.9.4',9,4,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1532–L1536','8a2798bd3e8d5dfaec57c36f5872b105697365619a3a3dd10a7cea817e72eb61','7476f981bbf3ba4cf07bc961aa91cd618d43533514daa3ad90772bdb4ebca1e3'),
('edwin-arnold-et:gita.9.5','edwin-arnold-et','gita.9.5',9,5,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1537–L1542','aafa8619c1d5a32ecc240dcee517854a2cad0d1cf97dba4f5ac124535548d1b5','68aabdfaa282a91244f5ae332dfe7acc28f4a1fe1f053ec6db32018f2576b651'),
('edwin-arnold-et:gita.9.6','edwin-arnold-et','gita.9.6',9,6,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1543–L1547','dd4ff7970c0991eaa0028af36936038094da0ae542da2c69c85fa695cb4d0e5f','d314e07092571c90c08527fdab2923ad9778a02631cacdff581b1415db76da36'),
('edwin-arnold-et:gita.9.7','edwin-arnold-et','gita.9.7',9,7,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1548–L1552','efd56e5a48149db89b7381c0e880161c6ca8fe49014c4dd3784235033f1f5fc2','3fe73a14a117f32236cf91e8909326a842fe855bbdd829f74656fe4388822b96'),
('edwin-arnold-et:gita.9.8','edwin-arnold-et','gita.9.8',9,8,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1553–L1558','29753d0574af621f28b3e7a55cab979a95c588aadbf97f52c4e67f1d47e3832e','aa100507927d2258056b1de9cd76dc45ba3447096ba887644c7601a993626eec'),
('edwin-arnold-et:gita.9.9','edwin-arnold-et','gita.9.9',9,9,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1559–L1562','064c15e651bbef3e624e24343d190eb390f6f1cad7bd073bdea383ff4a74dbdf','92acd3d03c8822567631103c168e395248caaa97dad6152120c23b25d809623d'),
('edwin-arnold-et:gita.9.10','edwin-arnold-et','gita.9.10',9,10,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1563–L1566','7449bbae2cd879401deed4a730be71d19c62d1a01f96ef45d5c0a18a4f6ac274','bfd47f9b28dc393a075a07c08e8c21b8b95e72c4ece753112a1bcba66866a754'),
('edwin-arnold-et:gita.9.11','edwin-arnold-et','gita.9.11',9,11,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1567–L1569','ebf46fab217ebf2da31220bffb821b116eee8fe4cef5430c87bae3f8d54f302e','ce599c6c565dfe87a218bf424e396a394847bbdf4f9271207990f4f4263879c2'),
('edwin-arnold-et:gita.9.12','edwin-arnold-et','gita.9.12',9,12,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1570–L1572','896f42c41ca4c59fdfe35eb57dea4f8c6f3467a89d245dbde3d3deb559bf8cc3','c4b50f8fb42f814eb89bc1653022a637f7efe3ccdac2566ebbf703ed200f0e08'),
('edwin-arnold-et:gita.9.13','edwin-arnold-et','gita.9.13',9,13,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1573–L1576','c75c3b342ec2ca69f50c4d5617c8a8c738ef26d1f2b6a23a660390ee8809a81b','08e3cc8a45965aee42531533f555c539e6f1c245d27961ffb6f16871f5278cad'),
('edwin-arnold-et:gita.9.14','edwin-arnold-et','gita.9.14',9,14,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1576–L1579','4d2d28dfabe3b41390d0b5284ff8f3af9d730b2bacea4d0bed62a8e99b505bb8','64b549a6d69f7799afab1c27fe484fb88c7c51fd915842d5349e0c350bee45ad'),
('edwin-arnold-et:gita.9.15','edwin-arnold-et','gita.9.15',9,15,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1579–L1582','0dc8116f9f47260d391206b9fa9e0204cc4dfee7cd945bf17b9482aefb03fe5e','f080e58043cce25498844aca8df20cf81fd5a8b260d658dc0f2d456b60384e53'),
('edwin-arnold-et:gita.9.16','edwin-arnold-et','gita.9.16',9,16,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1583–L1586','03c94f925d7d974a8543d105cdf09914cfadac7d17f33b2705782f283432bfd3','0ddc9ccdf010e19f52c0a60224735bfc1e1d05d6d5842efdb7832932e2c202f1'),
('edwin-arnold-et:gita.9.17','edwin-arnold-et','gita.9.17',9,17,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1587–L1591','ca3c1982413839e088142a4e8f0d4ac0f1fd5a855132606bb401334d32b00249','c7783d748b3c7787620e49d083da3d121abe28086521889bbbe539706cb0e7a6'),
('edwin-arnold-et:gita.9.18','edwin-arnold-et','gita.9.18',9,18,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1592–L1597','8344185c1140add773c667ce6b4a37feb6532ab5248e7372a6cb3f52defc6f2f','fa0bd16fdf93bb8251dc9540f7a0101cbd79db715fd6c18f7e6cada365831fb4'),
('edwin-arnold-et:gita.9.19','edwin-arnold-et','gita.9.19',9,19,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1597–L1602','9cb350e12ffd529ab999dfb89620b7992c09468c0be5cecac0ab81185a946041','d1fbfb4ab9a94ad6bb1b55b4a542236e8f16f9e8875a3957e7e812c1a0e03676'),
('edwin-arnold-et:gita.9.20','edwin-arnold-et','gita.9.20',9,20,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1603–L1609','2f94d0d7b0fe20a76a0ed8f868904b1d89b4c4e10cf576452be4dc8f91035b36','993780b97ef3bf29d475bb2623cca015aa37f8a999e8982b656388ca87b3dc6e'),
('edwin-arnold-et:gita.9.21','edwin-arnold-et','gita.9.21',9,21,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1609–L1617','56a7dc05146e9245e8d60c4891d58686b678f6ee835451cf7a25eed8a48ca603','35caeac55adc7759373acd7cc39b7165328f08eeab5c4affee399e0df8edb72e'),
('edwin-arnold-et:gita.9.22','edwin-arnold-et','gita.9.22',9,22,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1618–L1621','95b2d77822aec80815b7b50435b71d890c9e10e3906064df094dea318a02d29e','3f96fb31c5c3d97915f6e534c7db492857d4388e8a6ce6565988a17349bd5980'),
('edwin-arnold-et:gita.9.23','edwin-arnold-et','gita.9.23',9,23,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1622–L1624','27cdb5c5c6f58b36a9de33d9c5be858ceee14fcd9af6cf1156fd3d55ce77c3be','8457b9db47b9513607d1a7bc2b32afbaf6c4c7ea03ea1fc4bd63189c22267c72'),
('edwin-arnold-et:gita.9.24','edwin-arnold-et','gita.9.24',9,24,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1625–L1627','f65ad735730e8a5a61af3f61bbcd82f3340cbd1bad8a976e1c9030173b4ce31c','e822ba20991784ac207cc03424ec1318000084bb284930eb72fcb464a569caa8'),
('edwin-arnold-et:gita.9.25','edwin-arnold-et','gita.9.25',9,25,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1628–L1631','f9fd819afb0d332547d40664470db54ebc56672651447118815a5f629e03699f','5ee18ba56799ddcc3d87dbd57a88cd0a479747a9a9ff81530659744559d8ca41'),
('edwin-arnold-et:gita.9.26','edwin-arnold-et','gita.9.26',9,26,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1632–L1635','77e445bd2b95128f1b04b1d3e4d4d089176415c42e07cbfcc043a9a9b9568b7b','4ff1bcd998e29a6668b886894a9526d80bda9ec9c8608125a2ea28edc2b342dd'),
('edwin-arnold-et:gita.9.27','edwin-arnold-et','gita.9.27',9,27,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1635–L1638','cc833fe5b4bcd20d63271051afe00ed1fa0af78ac0795d55146fa3e685a63f2a','59bf709f5b36f3df4417413bd38af417667c805836c71605d170244f6cfd84e4'),
('edwin-arnold-et:gita.9.28','edwin-arnold-et','gita.9.28',9,28,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1638–L1643','87b35a929e5cd44aa3b80d606fa960e40bf8ea031ea0945595c9dbeffbcf92bc','f2d18ec06341b5b316d8575d216245f06a2463fdde81682d69401a3c9f767e0b'),
('edwin-arnold-et:gita.9.29','edwin-arnold-et','gita.9.29',9,29,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1644–L1648','7513dfa9dc463e2bdc2051b5e59ec8eaa9d225d3835d8d3241e6a3510abdc042','b682b43f539c57a8b888426aaea2b5e04719b944f8f9e3c6a27e0185f206eaf1'),
('edwin-arnold-et:gita.9.30','edwin-arnold-et','gita.9.30',9,30,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1649–L1652','e9b2e88afa812b0cd6d9e79a06112d1c8605ae55d67a15c25830c84febe8adf0','d6ad3ac3b41691945e3207879ce7a63a3b4931f742ddc976e2f169dae50b50a6'),
('edwin-arnold-et:gita.9.31','edwin-arnold-et','gita.9.31',9,31,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1652–L1655','286cc8f062f4f7d98bd911d142ea16141a9c833ab8015b45c6c23d2569d95711','0ba96aee4b7a0c65ff41accc9b6ec71ac8d2bd727ea9b974eeb1b8a750c6bc51'),
('edwin-arnold-et:gita.9.32','edwin-arnold-et','gita.9.32',9,32,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1656–L1660','7500fd0ab9a4bd80724f38f1ed013558c949d94f73a4da505269ded77426ef6d','b78a30f83d3853193dd1c4b359c677a6974ddab3811d7291696812c3ae574901'),
('edwin-arnold-et:gita.9.33','edwin-arnold-et','gita.9.33',9,33,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1660–L1663','0b15e16232c36d54beec2305b931d45ecef02d425921a9bce819b21a73c06860','60208e7fd728ced714a74c4c30e9f234b6527f05f229acdbf2e2685012b56324'),
('edwin-arnold-et:gita.9.34','edwin-arnold-et','gita.9.34',9,34,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1664–L1668','718f06fc593e80110aa01444d895c5a98d9a084a6df66b659fbfe289760fa354','33faa18e7ff17afcbfe9396566f7a4d093a8b3b06b638e362485e1d57a35293a'),
('edwin-arnold-et:gita.10.1','edwin-arnold-et','gita.10.1',10,1,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1680–L1682','0360f46af054d07af176c8acbbbb58c2fc78d9e1d05bcadf982d61ba6612ff60','e2eb17026934648fc769754c95045118faa467637ebf80e03a073c1cf1b838b7'),
('edwin-arnold-et:gita.10.2','edwin-arnold-et','gita.10.2',10,2,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1683–L1684','eb7d047a3802da73b8c7f0e44871986872f40ea5ba362c36f30e952b07432a10','ff4c48c0a37fb17e3aa0507e829deadae25b7213e81ae3e91e335ee98c944cd4'),
('edwin-arnold-et:gita.10.3','edwin-arnold-et','gita.10.3',10,3,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1685–L1687','1efbcfd94b856c10ca8a8dd533ead3aaa2abbf1bd8cd7f6a968eb893700bb6bd','60e66d675c6a69200e731c38190822d81792818facc02a39e3d4d3a1ea939bce'),
('edwin-arnold-et:gita.10.4','edwin-arnold-et','gita.10.4',10,4,'passage-commentary','shared-source-span','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1687–L1695','575dcc6d3623f4ce363108038a02c3e36b5f2d516126c8539758e8849f25beb5','7487b94dea2b6dcf872bb681ac7902b5657c82f27f98e733878f72ceaf37fbb2'),
('edwin-arnold-et:gita.10.5','edwin-arnold-et','gita.10.5',10,5,'passage-commentary','shared-source-span','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1687–L1695','575dcc6d3623f4ce363108038a02c3e36b5f2d516126c8539758e8849f25beb5','7487b94dea2b6dcf872bb681ac7902b5657c82f27f98e733878f72ceaf37fbb2'),
('edwin-arnold-et:gita.10.6','edwin-arnold-et','gita.10.6',10,6,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1696–L1699','12e5b822706c35a4f233ddc0dfc1097af8abc24ea624b1d6975b37bce506a0b0','9f0c61994bfe361ad8c48c4140cbfa83e7690f03d521d4c3ae49b1a641248116'),
('edwin-arnold-et:gita.10.7','edwin-arnold-et','gita.10.7',10,7,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1700–L1701','7e9f6a065d362196715c677869db1c038230092905ee192d5fb5247562fd9c4f','86da1a0ca0a7c591714ce9f12166491657b175d63dd729d36adb096b151092a8'),
('edwin-arnold-et:gita.10.8','edwin-arnold-et','gita.10.8',10,8,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1702–L1703','455956fb212033dc4254f9484cda0de2429e47a034eb8a37632764da45a31268','c2fe62825d77032c0a7804d1e530be946aeedf3975abc4f526d3359a0491141c'),
('edwin-arnold-et:gita.10.9','edwin-arnold-et','gita.10.9',10,9,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1704–L1705','cda59b85f1f193a972bdc9bea977066047df634e918c938b90ff537bc46da809','c1385ed3fd758c5ff5686a2d27eb42be4798f329904ffa7f52b1f75b89608f94'),
('edwin-arnold-et:gita.10.10','edwin-arnold-et','gita.10.10',10,10,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1706–L1707','b42d2e18979ba457437b6cc11d324381845c7fa240727d1aa5f7da9aefbcb0cf','ec6db70b4aa589a478bea6e5658d373b8579b7ed6b731e61335bede28d3d6048'),
('edwin-arnold-et:gita.10.11','edwin-arnold-et','gita.10.11',10,11,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1708–L1710','69013533481a88b354a78c8f809c746034063e0ac2d106dbadfd51dcc84e5ccf','0d385d79afb0f469adbb5d10de8233630e5da445e478b9eaabd83a2354dbd5a1'),
('edwin-arnold-et:gita.10.12','edwin-arnold-et','gita.10.12',10,12,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1711–L1715','24bcf4c627a5ab156b9b35b024ee38ce5acdfe1ce54997affea8eb20b3d2fa64','7d3667466ef5b8ada1ef95f5ef0fbaa39837059ea1619c0ba790ec00014c1334'),
('edwin-arnold-et:gita.10.13','edwin-arnold-et','gita.10.13',10,13,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1716–L1718','bc3900963f784d201c710d40026a15e5ea4eceaa532a6b405d1e0dd10ffaabb3','ebaf422be61063006240de0ab6a0ba5c1bec83fa7fa80272566ad360ecd014a8'),
('edwin-arnold-et:gita.10.14','edwin-arnold-et','gita.10.14',10,14,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1719–L1722','be992c74b4c110dc468f6cd942a9d962117d06d46e9224430eac72d3bc8b742e','c1ca2c52eaf4c0a8b8713f38c4511960a5b6876052bda117a21b065f997aaaa5'),
('edwin-arnold-et:gita.10.15','edwin-arnold-et','gita.10.15',10,15,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1722–L1725','39d492dc9ecca13c80e4ca91a938467c63d622005f6ee24259bdbb4838d36860','08b079de078833d854b0719af574cee7624bd6938b85e7cb69cea32077324363'),
('edwin-arnold-et:gita.10.16','edwin-arnold-et','gita.10.16',10,16,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1725–L1728','6abc469e968bf573565c4c30cf3082107984740b7f89e6a2a4460ba1f63f2459','d4582e6463d8e9398f666f1020bd67916552bb9fcbb7c16b9c673c48e5f01b09'),
('edwin-arnold-et:gita.10.17','edwin-arnold-et','gita.10.17',10,17,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1729–L1732','717561bcd1963e5cd54b24a0f5fb9b5da53d09fc4accbb7d7c43230fcc73a856','39b20cf2c5ab07f0596965bda1f05290dec94a0a631f32f15a429f4b05ab21b8'),
('edwin-arnold-et:gita.10.18','edwin-arnold-et','gita.10.18',10,18,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1732–L1737','211da08b3ba025485574e81773ab0bf008dab3613f3ea63eb1846ac884890f8d','c86dbc08250f51dcd887b956a1c52aa0a3c257a7945cb0083231b6b3e2280364'),
('edwin-arnold-et:gita.10.19','edwin-arnold-et','gita.10.19',10,19,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1738–L1740','c7715341b562fe59a2e82bdb2af90c16f721f7c058e07b8b9d8848cdbda85e2a','4581090717046774ff6777c33b32672e532e25990636d2477a827d6fa9991fd7'),
('edwin-arnold-et:gita.10.20','edwin-arnold-et','gita.10.20',10,20,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1741–L1742','ee143eb4171605f40599bb9d1b1ab554773a4d16687910f73ac78aa5fe7bbc30','4ae1d29e1daf7fa4994f7320ccd80d80676ac4db4774e9e7b60981f96ea51996'),
('edwin-arnold-et:gita.10.21','edwin-arnold-et','gita.10.21',10,21,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1743–L1746','6dfe11d5657856389ad62b0e0383a83ecff4c356da9ba23bbc2811caaf7ee4df','a2402db4b65f03ee28e008abb8a42d692e12410518140010cdbb223c9a405518'),
('edwin-arnold-et:gita.10.22','edwin-arnold-et','gita.10.22',10,22,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1747–L1749','1f083832d2eb57e949d050fb5f67142f54d9f83dced5a3a7bfff62a2d4e4accc','e193224661d9b37797b3a3d09f9c1f561ee05e9b6c1a46ea43d2d15448e19afb'),
('edwin-arnold-et:gita.10.23','edwin-arnold-et','gita.10.23',10,23,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1749–L1751','ab5b85594845d7f7d08c358ba8dee02d38ebfe90e73fa9844e9c47115d2b27eb','943930fc71f41beb9f697382fe9690f00f91c17a75c34526356afcf3966dec78'),
('edwin-arnold-et:gita.10.24','edwin-arnold-et','gita.10.24',10,24,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1751–L1754','f9cf42cd47dfeb2ba83100938165c692292c7220a129916e9abb9468f52ed9f6','231d36740099dcb8366d5bff8dfea07f476394b4c91c2dee6aa131f88aac7257'),
('edwin-arnold-et:gita.10.25','edwin-arnold-et','gita.10.25',10,25,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1754–L1755','d455f106292b34c933db0c6e758e0ca7dbeb789af7cd4c1d3e4e0bf07fa35892','531133347670cadee9b3885e8d1e1c38917f4b34c28b6176d928efd72e6eead3');
--> statement-breakpoint
INSERT INTO commentary_units (id,edition_id,passage_id,source_chapter,source_verse,unit_type,alignment_relation,alignment_status,source_locator,raw_checksum,display_checksum) VALUES
('edwin-arnold-et:gita.10.26','edwin-arnold-et','gita.10.26',10,26,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1756–L1758','a69b0046c5e0c02388ea0e7d734502602d871df1ab1a1aaa5d18f7a4b7b08ee6','b3748283213847772eb2c32c17fb38fffe515c40995942ad8cbcb3d43fcf2a5b'),
('edwin-arnold-et:gita.10.27','edwin-arnold-et','gita.10.27',10,27,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1758–L1760','c95598578b56e6a34e7f05a932fe177d3d992f481eed2f4d54f4cfdae0c3b707','af6190ed7d0813f0033aac24adbe6b99c131001a21425a711bf6a6174b83035d'),
('edwin-arnold-et:gita.10.28','edwin-arnold-et','gita.10.28',10,28,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1761–L1763','669a9867844056600d8af6feeefa46a2b5819606890fb7889fd25ceb3ceb96d6','1047468ab9bbd41454b8d656df1d9b9e56b14978c0dd2feb88455c84a2a12ce4'),
('edwin-arnold-et:gita.10.29','edwin-arnold-et','gita.10.29',10,29,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1764–L1766','c76fb62233c585cc84ff829a9b57b873799f05d88325354041b5c6f7e4ebc31e','73caa208b7ce5f69cdd692643260500116eeb607649b79bbb7742a82a96c1dd3'),
('edwin-arnold-et:gita.10.30','edwin-arnold-et','gita.10.30',10,30,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1767–L1769','8bf3cb41b8927dc91af5196eb019980c48551c2a616ede36e03c8abf831a1097','d8a546a52f425c5e584e5904deef7c5a484eac487a89782f03ea19b23cfc716c'),
('edwin-arnold-et:gita.10.31','edwin-arnold-et','gita.10.31',10,31,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1770–L1771','9bdc0a1f15c85e68fd81caf799bc972d4cfdadaf49942c424c4f43096c6d5110','f78ef3a2f2029046d095ba169c0cd251e0ed53007691381dfe8ea298c1704b53'),
('edwin-arnold-et:gita.10.32','edwin-arnold-et','gita.10.32',10,32,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1772–L1774','e541e76dc327ba5acd566bf7d109356bb078467752c3a438c57ecdabb2ee593e','b6a4b03f347540a9e2c9e83e3e39110d7d05d38f5f3b4d8c5e53a25b64f1039a'),
('edwin-arnold-et:gita.10.33','edwin-arnold-et','gita.10.33',10,33,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1775–L1776','fa2d6c143e7833a811c0f01fcba482f535026665eac652ac5ee4e6e583395a9f','65097e5705206038a13c8ed7b2b5fbf20b1e479794f5047c331e8a053360baeb'),
('edwin-arnold-et:gita.10.34','edwin-arnold-et','gita.10.34',10,34,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1777–L1780','14140e410caa0703dea794cf5f6f69d42fd60447b556459ca99c7e74f322f4f3','2a96a4e02f50dc0c967fe055086d8bb0a446b2f641b0a619f8f673e4c4464463'),
('edwin-arnold-et:gita.10.35','edwin-arnold-et','gita.10.35',10,35,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1781–L1783','b1486ad95bd445ba2c05d9dd434f4b13d66a4a1cb86727a52b2b6569ba6a5499','30a2915e90e1a0ae6c4f8368af126b29adc658b22f6a604331371de5274cb2ec'),
('edwin-arnold-et:gita.10.36','edwin-arnold-et','gita.10.36',10,36,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1783–L1786','0f541f97dac1d11c83150b5d4e0b568c0fc94dbce373ae0da8b33124f6b59126','8f34143571755f44bb8110f53b537a08533ae94c64ae560ffd268f102a7c36db'),
('edwin-arnold-et:gita.10.37','edwin-arnold-et','gita.10.37',10,37,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1787–L1789','6a8463ab54f562283334dd921fd7c5afea186335cfe12ae6906146fcf9ab0670','858bf6115c96c571ed94961cec02b10b8633ec22054374c2802455c274d71f59'),
('edwin-arnold-et:gita.10.38','edwin-arnold-et','gita.10.38',10,38,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1790–L1792','4f3702a08531ad9af7b9202d60e382f862696cd4af03709be3e45ee03f1ef2d6','097ff0ce8fe1911afb8046c7f95cfbe9a7513b73b9af665156ac702a398f67b6'),
('edwin-arnold-et:gita.10.39','edwin-arnold-et','gita.10.39',10,39,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1792–L1794','0c7c656371edd7bbe52fa785fe2715ff1a25d328e1014d8173fece206e9b99e0','02efee967e42419d0e0e82c90dc2612bb08d847e2ddd500d712e0aa6aea514d4'),
('edwin-arnold-et:gita.10.40','edwin-arnold-et','gita.10.40',10,40,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1795–L1796','62db2e5aa4da4f87b04c9e7c2f6fe3bf77ec1421fa4cb0a131480b3943d29ca5','f1c7c4668af4fa94dfe6017aa64c2676fbf37e2377e109aa79355c85f8d2a49c'),
('edwin-arnold-et:gita.10.41','edwin-arnold-et','gita.10.41',10,41,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1797–L1798','f48645be67b476eb61704004751358643d4c6a885145cd0e39c91df76f63042f','acab45be21d5b7a101eef27d1df6f99ef91590656d2efac13db56fb61529c403'),
('edwin-arnold-et:gita.10.42','edwin-arnold-et','gita.10.42',10,42,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1799–L1801','5f12f35b8093849c10be67796194065defe46084ffc6c777aa16844f30485df2','e4bdfa6c2197bf376fef98dddf8378e050fe37c47dad5fa4d0b758b205750ecf'),
('edwin-arnold-et:gita.11.1','edwin-arnold-et','gita.11.1',11,1,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1812–L1816','c4e089a8fad591b1f037704684214029de65684aeb70ba4798f94aa2c84bc361','aca33ed6ea8d989f00f89bc00e4ea9e4633b37af5e40ac66eba42cec13f6d58e'),
('edwin-arnold-et:gita.11.2','edwin-arnold-et','gita.11.2',11,2,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1816–L1819','861bf98f71a945dc5a31373a4ceb597e2bc002e3a757d7a0fc0d5d46da117616','559e6c5b636ee3ea3065cb8fdc99cb8dd0d723ab9110169d8f2b553d7ca0d6e6'),
('edwin-arnold-et:gita.11.3','edwin-arnold-et','gita.11.3',11,3,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1819–L1822','5370ecd126db328227e027a6eff900ca6b8e151d4c8139708b2c44b68ac4d402','90d70c4e58873188f7b4d32913052d4684dea5e65706271154361705dbc6c018'),
('edwin-arnold-et:gita.11.4','edwin-arnold-et','gita.11.4',11,4,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1822–L1826','20107bc4adb98a5b367e608c93703347e5af427c34efdae4cc0d33a68cb3dca9','8ffbde66d10983b88ba1f012d816a54d57ccfbb5fd30114cdc899973903a8400'),
('edwin-arnold-et:gita.11.5','edwin-arnold-et','gita.11.5',11,5,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1827–L1831','dc2bea390bfd6143e5d1187c48a45870df26e22d9bd6e09913b0d0afe819a7ee','7b687d2fa81caca84522424d5454be97e8fb9d2dcc9f092f44387fcf59d15547'),
('edwin-arnold-et:gita.11.6','edwin-arnold-et','gita.11.6',11,6,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1831–L1833','f19badccc8e0950b04cf989e11ffaa401a41eba81492eb0394694c6ac76c29a4','71971553f0fba86cc3377375ff8f29b216a878cf83897798d7e37a6370bb6963'),
('edwin-arnold-et:gita.11.7','edwin-arnold-et','gita.11.7',11,7,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1834–L1837','30a587d75213b1a6c8bebd2f75d54638b55b9b9a6bd0faca7b4753965226e3bc','e54c7d4af6d1e93bbebc4e8b48f3c49e0574819fa3fab6b431f2a978f1741d1e'),
('edwin-arnold-et:gita.11.8','edwin-arnold-et','gita.11.8',11,8,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1838–L1841','f04c488bb4e76d7d79cab12e267679a0647f6e54ab4dab2bcd5603f6efbcd3c1','1fc6366ca52cb3134126898075818642af5a6d29e265da3623e31386dd3e8aa6'),
('edwin-arnold-et:gita.11.9','edwin-arnold-et','gita.11.9',11,9,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1842–L1846','9352bb1e9528691c8ff124e72791ccc5363a96ecac884e384c5fc1a763e2b57d','0eea3b0551f8d0ab1af08b777fe0f825f461ad5d71df0db75733f3c4fb3d1553'),
('edwin-arnold-et:gita.11.10','edwin-arnold-et','gita.11.10',11,10,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1847–L1852','e3a78eb6ed40053003387e00e2a23416077c3d3c90995bde1572251f666f62ab','66788660272433aa4a76ec8fba2145944113175f9f8dae738f84a5a2ddef78ba'),
('edwin-arnold-et:gita.11.11','edwin-arnold-et','gita.11.11',11,11,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1853–L1861','46b64290895e805f79f37d1802d1986c242f052e2aa9576cce206be11e71fc18','471680d2c3da573554e15bafdd518804eed989aedde0273291042ede4dd61c6b'),
('edwin-arnold-et:gita.11.12','edwin-arnold-et','gita.11.12',11,12,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1861–L1867','14da94b59ab50a66eca0b8d7f8a2308790aa9a411c4ee000dcaf826b8edd3c6b','b971569b9cb360bbdce2b42278a9c55f4495b709754e25bbad0beaba217f6012'),
('edwin-arnold-et:gita.11.13','edwin-arnold-et','gita.11.13',11,13,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1868–L1877','c81813cfe1faddebec7887f03b41cb4c50fb2ba4b98cfbdb6e15765efa3a1181','f78b406ad45627598b1280c70b02c9ec1b92cf9baa3d987a26d0f0dd519bf8df'),
('edwin-arnold-et:gita.11.14','edwin-arnold-et','gita.11.14',11,14,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1878–L1882','0c6977310dcd6b0c97cb4589d9e12844f948b72eaea037554fda8e9538ef2e2a','13ad6389e9c792b3f7e3cb03a1bfec81c1b965169dd61004afdb4ff3f00cbaef'),
('edwin-arnold-et:gita.11.15','edwin-arnold-et','gita.11.15',11,15,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1883–L1895','c6cb42135182a50a3505c902e99b80a5260e8598c746e67074a11b37259ce859','a1372b0857e86d2b92aee6122288698bb57222a6c7fbb3bf6991e37588cad5ce'),
('edwin-arnold-et:gita.11.16','edwin-arnold-et','gita.11.16',11,16,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1895–L1903','518ed7c9290780eb39f06eb980a08136a73a7e2200ce1ba7876636f8286b914a','39fbfa8c33e8e7578e227a572c5e264f27a84a8527c52bc475cc555157a21d80'),
('edwin-arnold-et:gita.11.17','edwin-arnold-et','gita.11.17',11,17,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1904–L1913','8043f8242b34488d207d663a95e2ab3983539501a573cbefa69c3771da3656cd','fc5f60ecc2acca35ecb07beeb48a0a2d1f592e0f98e4cb833fd0adcce13ffdb3'),
('edwin-arnold-et:gita.11.18','edwin-arnold-et','gita.11.18',11,18,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1913–L1920','9fa9ea61edc783b70554eda8ccc4d950eaf7daf47723818e9c8d9b5634affd29','9d41a2c072d67bbc356b05637aee3b04fc2476b1f9563dacb082136df28be893'),
('edwin-arnold-et:gita.11.19','edwin-arnold-et','gita.11.19',11,19,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1921–L1930','97c65fceb71c300d402352cd64d7655366dcbb05bd5ce514392cdb79561af7b6','4a9d85111548193b93b5766c4527d5fdcb128305f6e81a2313fb171e1a2a670d'),
('edwin-arnold-et:gita.11.20','edwin-arnold-et','gita.11.20',11,20,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1930–L1941','81d97d86c0ef4d617cef981bde06d3e06ffa4a605c599de334684eecc984607c','32e559ad4cd2e5c5a8f5d7a84bf84660526b1e3bce929d291f397e53df282cd4'),
('edwin-arnold-et:gita.11.21','edwin-arnold-et','gita.11.21',11,21,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1941–L1952','2602b78f892d6022be38abee4714c68c2c06e1da87aa392231163f3745a2841b','319f10c8dc96c0ad659e181fadea8c3abb267b4c34c57680e4c5c286e28908bb'),
('edwin-arnold-et:gita.11.22','edwin-arnold-et','gita.11.22',11,22,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1953–L1962','0585f14904535553eb838dcd63f6f3fddf38c036e50c3ef93a2dc992d942b61f','6f96c2fab92fc3d884b8157441f50031581006d3f3397c3a6ad81033e04042e8'),
('edwin-arnold-et:gita.11.23','edwin-arnold-et','gita.11.23',11,23,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1962–L1973','ebad8c6b6e20534f177de0c6cae924184fa3fc435f7c25112ad044f75cca308a','afad8a37e8f7ba2f11fa085bcac4d0b5ecc53bc445a10bbad2898fffa6b4ff5f'),
('edwin-arnold-et:gita.11.24','edwin-arnold-et','gita.11.24',11,24,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1974–L1983','b8cf3eec73d3edfc982410f930e73a934fd6fe987c1b0163f965be255c253b1a','1d24843e4e9b0c51b79fe2560d2bba1aecca0aff1cc1aac5142145d4c4131160'),
('edwin-arnold-et:gita.11.25','edwin-arnold-et','gita.11.25',11,25,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1984–L1995','d1c4f979fb53cbfa080ba37d6397a226f92bdde5fe921917dafc0ea4bcf5fc7d','9aaea75e80b695a979dc51b0d22178d8fa17e2c0c30c25b3cddf99e0716ac52a'),
('edwin-arnold-et:gita.11.26','edwin-arnold-et','gita.11.26',11,26,'passage-commentary','shared-source-span','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1996–L2007','e620d8c1b15000890ab39c694bb10bd34fa379e8cbed8e7b24ac5f56666fc5c6','1b067c0742a1aa5182e0d98a248aafc83242f8982d48ae30871f7bab1c33a40b'),
('edwin-arnold-et:gita.11.27','edwin-arnold-et','gita.11.27',11,27,'passage-commentary','shared-source-span','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L1996–L2007','e620d8c1b15000890ab39c694bb10bd34fa379e8cbed8e7b24ac5f56666fc5c6','1b067c0742a1aa5182e0d98a248aafc83242f8982d48ae30871f7bab1c33a40b'),
('edwin-arnold-et:gita.11.28','edwin-arnold-et','gita.11.28',11,28,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2007–L2015','725bdb932ce92850bb54a20d36b4967d8bbc493538cb6fb594c97f4bf53e50a0','ded63ddf4932aac8fb5dfe583c12177aa55019f34445f1340dae4e0ac30ac3df'),
('edwin-arnold-et:gita.11.29','edwin-arnold-et','gita.11.29',11,29,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2016–L2022','08c56de7293e32bcf0de51c9e91a0f4b9fdd8652253818059bd8d897293f8a8c','7fa1a3494c091686911947c210d568f7d31c74cdfe2f7c3402ed1e6181441ef3'),
('edwin-arnold-et:gita.11.30','edwin-arnold-et','gita.11.30',11,30,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2023–L2033','c012a8717531f61ef91b4da817497a8544b20d5b94ac9143cb2f250e0380580c','e8c329d61c313fd721fd2e36d366bc10678638f00ba474246b1ad94e8bdbe8cd'),
('edwin-arnold-et:gita.11.31','edwin-arnold-et','gita.11.31',11,31,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2033–L2043','5536a09a2849e422276b451dbc338d033c75a780458f7098ce2079679b2f3405','89b740ee1a6c1fd03943ffc23b69501ebe050df12ecde6e777e51d77f0ec897e'),
('edwin-arnold-et:gita.11.32','edwin-arnold-et','gita.11.32',11,32,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2044–L2049','a5f1c387ea3784e9c57e544d5971a40dc5bf313be8ab71aa25d4f9c31db63a1a','c545638b19939bd45eaf23e641c01a122a48d0d2f94e6c22f3f86fde1a313d89'),
('edwin-arnold-et:gita.11.33','edwin-arnold-et','gita.11.33',11,33,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2049–L2053','52605e2b116d231da9bc3598f46d5a34c0333e8691be5fe57252afdd4b1ba196','f373286f2595be5ee56c49842a7eb03379b2abdfff8771a6ca9159d04f6c3c2c'),
('edwin-arnold-et:gita.11.34','edwin-arnold-et','gita.11.34',11,34,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2054–L2058','2f01d1dee71ba7a1a71b38d7d62df0433e6bd1a925683606b16ea69b51c61779','f58e61457bc578e35e891d0fb28c118ee65f2eb155f0ab62f6ef1d93f7b32f2f'),
('edwin-arnold-et:gita.11.35','edwin-arnold-et','gita.11.35',11,35,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2059–L2066','ef3537cc81a3559837d79b4a411d90ac79ce6582ca115899f4ec846ec58a1560','18f5f4f54337d96e51842c08384d6a7af3a5a4223891d6ddcbb173f7987823af'),
('edwin-arnold-et:gita.11.36','edwin-arnold-et','gita.11.36',11,36,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2067–L2075','7ee4949a1a2171f79c4a38f02c856d580a6bc497b3aac03e5c86584d6178fc46','9f91cffd5fc1ac16d29e308f98ad77064bd10a1584d3641bab84a9da1ffcada8'),
('edwin-arnold-et:gita.11.37','edwin-arnold-et','gita.11.37',11,37,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2076–L2084','832e5e94bd6df60931e430b2770a1b69d29856cf71c0c96344df91c48c40b74e','445aa17e670e69809c2bcc75c81ebc0e3d5b1ee0a70370fdad52f2bcdc13db48'),
('edwin-arnold-et:gita.11.38','edwin-arnold-et','gita.11.38',11,38,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2085–L2094','129a6688783dd8d1c7d085df49ef40c5698a10453519209c0a37c0d29acb42c3','83bf296593b9b08f48827af3785ae59004f3fe0a2d347581c6c0e70e9df5ac49'),
('edwin-arnold-et:gita.11.39','edwin-arnold-et','gita.11.39',11,39,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2094–L2105','9de2d5ae0be45a13a0ecb417e661d767767de5ac83a6a330423efe356abeefd1','6a21bcdfca1222df896f0ca2ed7a989eddb336147dcfae53c38fc81ae234bccf'),
('edwin-arnold-et:gita.11.40','edwin-arnold-et','gita.11.40',11,40,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2106–L2118','ecd474827168d6e0b48d5de22b4e34b7fe5fd0d6423c4b11889674446d380391','21a0959aced56445bf282b13167e846cefb23887df5762099e089b27fc3e101c'),
('edwin-arnold-et:gita.11.41','edwin-arnold-et','gita.11.41',11,41,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2118–L2126','8377ae7dba2dac7f991a59dc9293fa465a17a26ff079637fecf7d1fdea1a1311','576b06fa33efdcc194133ca12f96283d72dbf7890344d364e30b0efac5b417da'),
('edwin-arnold-et:gita.11.42','edwin-arnold-et','gita.11.42',11,42,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2127–L2133','a4ef33acba075e99ebbee6b8ab4ab649084d7b762378cbbe10790071c7076e0a','356f39e3f7aef48aedc0a57c1d7b36bf451787c091460b83afc16363d894273a'),
('edwin-arnold-et:gita.11.43','edwin-arnold-et','gita.11.43',11,43,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2134–L2144','f199179faa80b7cd48ea6979d458c1bcdd6e90a3bdc3727e8485252781423a50','630f33739d3816a5296a20323acd023f0f5b26e15c5ceceba7c465b743dface7'),
('edwin-arnold-et:gita.11.44','edwin-arnold-et','gita.11.44',11,44,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2145–L2153','0c74f9c5fa8a987a1765076fa0c2a354f050f2d672d9d0a723810047a0022751','bd39332d469238d2b97c5eaab01b83352cf2eb5ec58350b4ffb7d5f09e250c76'),
('edwin-arnold-et:gita.11.45','edwin-arnold-et','gita.11.45',11,45,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2153–L2158','19c5a8031dbc16f396a80e5d38f02913ae58f50fb5102cd3f4b0264635adffa0','015e600468a3ab6463825793ecb6dff7d3a21d7db0cce10f7d12a369c7f36459'),
('edwin-arnold-et:gita.11.46','edwin-arnold-et','gita.11.46',11,46,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2159–L2172','f6d47d3063cb29f26b9d4b7278182cc7b5be3571e5aa287a6585f88a4a2fa2ba','453a42fd073fbe7393e64a3d81f9d9085474187963ea7f81e1660e275bacda1d'),
('edwin-arnold-et:gita.11.47','edwin-arnold-et','gita.11.47',11,47,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2173–L2177','25422745ad542c35ba82761d4358fdbdda41edb4b005b9788c734e55b10e594e','5eb64cc284d928248e9b008636f813450521a268c336c221a93fc85d11fdf7c8'),
('edwin-arnold-et:gita.11.48','edwin-arnold-et','gita.11.48',11,48,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2178–L2182','9c4476c0c3c9e0b18144623e2c3ebae3be7d27eadc4b6ceab610ff786412ef84','c3e303806f8e97e533a4efc4f56a2c05f673db4e1fe03d29cd395c8f4b8be80d'),
('edwin-arnold-et:gita.11.49','edwin-arnold-et','gita.11.49',11,49,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2183–L2187','5f363076a0ada0add1aec7b53ea5cdbbc919bc0e44ee67b20b74410cf14b2148','2387adb3e14cf3f6ec6e39fbab2b1c1b7345c3a2dd70fb5e17268a07ff4fbf17'),
('edwin-arnold-et:gita.11.50','edwin-arnold-et','gita.11.50',11,50,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2188–L2197','773014a03620883b4088638ad5f44fc17a4366b5c7beb16c413ba92d83ae5948','0320f1bffab53a4850f46c6854ce55edfb0dc3822857c10ecd05335b57ba5b98'),
('edwin-arnold-et:gita.11.51','edwin-arnold-et','gita.11.51',11,51,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2198–L2202','b6e9b33457551ff718f8d832ed316db27005c1de5877d42cbf24b2f085cf34a3','ab53168dac135f227306eda410a24e67df9dcbf5bec489cbc55d396085f8c26c'),
('edwin-arnold-et:gita.11.52','edwin-arnold-et','gita.11.52',11,52,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2203–L2206','1d043ff0c83beb14943762db373d5eada0644c865f687cc1895942f9745dc12a','f39630af7966ee117f78c66f2cc2812f251aadc41ddbcd7415a1180acfb979ab'),
('edwin-arnold-et:gita.11.53','edwin-arnold-et','gita.11.53',11,53,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2207–L2209','9d0176f40eef83d7dfaa27fce98fd14f7db722384f2b11f46f1954639a570423','a181fe037ea115501d0c6e6d67c25affdea10c7c36cdc68c73de0c4a4fd4c555'),
('edwin-arnold-et:gita.11.54','edwin-arnold-et','gita.11.54',11,54,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2210–L2212','087480e4fa599836ac668097e1947b1402add126214f37fbdb358a4d10a5c64a','c817108d51232c1832a62230131c5048a28591e394a2d0107f3a0b61d461796e'),
('edwin-arnold-et:gita.11.55','edwin-arnold-et','gita.11.55',11,55,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2213–L2217','7c49228a0aa29bb8b92bfe0afe938576b516719b85a0a008bad2d4489d34f53d','75dc3917edda2fd1a37ddeb4d9c2b379b57d8c8a118db8c8d02c6fae5787e326'),
('edwin-arnold-et:gita.12.1','edwin-arnold-et','gita.12.1',12,1,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2228–L2233','6e9158b2459aaca3bce3f74f4b956aef2c69f4048b848045fada07d6ee944c01','c46736c05f03dd8d014d79eac5c4582055e4650551a15459746e27a8ba43fb46'),
('edwin-arnold-et:gita.12.2','edwin-arnold-et','gita.12.2',12,2,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2234–L2237','e2b88290c7cd9e91ba9c116eabfbdbaa8b3172c0ff48263340250ad496a97b24','271c19e6eaeb6e97d14ca86ac3dc16eb17628e28e116deb20ea9a91e1e0c464f'),
('edwin-arnold-et:gita.12.3','edwin-arnold-et','gita.12.3',12,3,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2237–L2240','bceddee40f152f6e101d4c7e83c7f9df382f900d73eddf5e2d8c25c6f3f8de47','81dde5316c9665c4bf814bad61ea8254ebd9d215ffdbda98cff260ead4572acf'),
('edwin-arnold-et:gita.12.4','edwin-arnold-et','gita.12.4',12,4,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2241–L2244','128f3f7df32fe42d17d198a4662c1fe40f2043250a3c036807159176552d0b43','64daa07514289cb95889007315efdd6a030e9ee8661c33e6e0de7697a49eadcc'),
('edwin-arnold-et:gita.12.5','edwin-arnold-et','gita.12.5',12,5,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2245–L2248','07176e168b19c6ee5af11a04bd1712f626e1daef0c95410cc81653afa5270214','482a66b6672739082f0942b83eba924c85d68c3f4d04ec5a26e5decb108f01b4'),
('edwin-arnold-et:gita.12.6','edwin-arnold-et','gita.12.6',12,6,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2249–L2252','e19782dc896089fd995a8a9dc7443900a1564e210f6707eafcb9ae2eb525f8ce','0ee82520425a7b56870975c90c9b934ac75478648779f99a152674b71a55c720'),
('edwin-arnold-et:gita.12.7','edwin-arnold-et','gita.12.7',12,7,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2252–L2254','9a62fea8888dbfae5cf6e86186a960a94995e14e40840a37cb63e2e5861f73fa','f67ca59c2a36a831f07c5bb81802e31618f453253212d567c1e2de4d65750a43'),
('edwin-arnold-et:gita.12.8','edwin-arnold-et','gita.12.8',12,8,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2254–L2256','a57bd83eaf5c8f4bea3a81578a1d303e97161d8a09939269947e709108ebebcc','478567405a830c8c441ce5537b3fa9ff02d0a0b1b019cec24ee635b44de4612d'),
('edwin-arnold-et:gita.12.9','edwin-arnold-et','gita.12.9',12,9,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2256–L2260','c1df2fee3ceec938be489a2cb57b31ec63e80b78f043c383100271a9b1690ae3','e1e4d9f00f9576cce6a5a1c928364cb51c6f9cac954fd622198217e974286b4e'),
('edwin-arnold-et:gita.12.10','edwin-arnold-et','gita.12.10',12,10,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2261–L2264','02c2adbeadf989708e53b8f31d71d0797a906935d341f5e5489f621998d1b9d6','b605f5dd0fb666972b0c5a5c17bd7c14c29012ec232a811021d026985915d395'),
('edwin-arnold-et:gita.12.11','edwin-arnold-et','gita.12.11',12,11,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2264–L2268','9237a529f26754d45557b65033e9328220c91a84a26ee65035488b48bed1cbe7','d2f96cd3acd44da3c7dae22c39362bfc5506b276b66b484cb6d57a02134a84e1'),
('edwin-arnold-et:gita.12.12','edwin-arnold-et','gita.12.12',12,12,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2268–L2273','e5004a93918c8d49fce873425cfe12bc5d3701218cc50cd2f4ebfd8c934f0b33','f0921a5a1f58ce69fba989e585a1b4d1c873eee1045ff69a2bce525b37e67ad3'),
('edwin-arnold-et:gita.12.13','edwin-arnold-et','gita.12.13',12,13,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2274–L2278','645c152a56b32c1fb747caa9f15a8328982a766dc539664a66d0cf0240f69912','786b96ee3c26bc4446a69ed5a599240cbb4e29e3ca28c99f45c470a77e112938'),
('edwin-arnold-et:gita.12.14','edwin-arnold-et','gita.12.14',12,14,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2278–L2281','8367238ee0f06611bf791f66eff4a76f6ccb7392209bfcb5b69d6161033acbc6','4a163fe6c64a7e3f359c8d6090330fe0fceca04c0cd3504cc9b34ae242453501'),
('edwin-arnold-et:gita.12.15','edwin-arnold-et','gita.12.15',12,15,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2281–L2284','595cbc7498ac7e4d423fbcd1caa77279e3a14b06317aaa84d623dfc0e03c3896','c4c6290e3d9745b5452fb8cc71f866f92fe0c8e22facb7bc367df76465918a3d'),
('edwin-arnold-et:gita.12.16','edwin-arnold-et','gita.12.16',12,16,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2284–L2287','76db4ea23ee42287151a304e8b70505c7b4975837ccd763370af73561ca9fdb6','058b270014308558127c8f811726c7d3f3ce27b84b70e4c27532fc97716e7ef7'),
('edwin-arnold-et:gita.12.17','edwin-arnold-et','gita.12.17',12,17,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2287–L2291','55b1420a72b9da8f0ebd38ee063f999f63386361d7ef75a0f7028bde5b4fc982','6cf9c9f18f8b072d56972a8ac813508ff0dcf0cb88667e0e692327d2043725ab'),
('edwin-arnold-et:gita.12.18','edwin-arnold-et','gita.12.18',12,18,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2291–L2295','c86e1263e3fe3e2bfdf522a2f1d50711b88eb3d2687a87b0db13df9c1853b85f','9e55369dfbb2936fd1b4f77b3a4cf2c3535901112f510277bcc9781262a70a70'),
('edwin-arnold-et:gita.12.19','edwin-arnold-et','gita.12.19',12,19,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2295–L2298','09147f8796bd6e5f4e067372ac7e4030c0774ea1270b957a381fd298bd2a491a','cabe5946471ac4ede395df04298f5f2540240f71c590b7b5418e8f5b4530ae6e'),
('edwin-arnold-et:gita.12.20','edwin-arnold-et','gita.12.20',12,20,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2298–L2302','1548df963a80418a851ac6b2aa22f050cb25b0db185b699e881ebcdd737042a1','ee4662bad40e58363c1a3aaa151c5202a20e99542287498c1bf595e53a961845'),
('edwin-arnold-et:gita.13.1','edwin-arnold-et','gita.13.1',13,1,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2318–L2322','e6296b8e091dad268978b80f231117456efacac5a1862cabb4eafae0a33249ec','d3da8fc73f59bfdf496db33eda9134eb9053bf64d8e6a70329cf443805095e00'),
('edwin-arnold-et:gita.13.2','edwin-arnold-et','gita.13.2',13,2,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2322–L2325','ac8f9e22e2f5794871d0bcb5c4dd6e2f250f67a5acc6c2a9347a8dc89c45fa79','a649cba44c6504115430e3379cee42248c813158aa52eca79270b690f72f9690'),
('edwin-arnold-et:gita.13.3','edwin-arnold-et','gita.13.3',13,3,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2325–L2330','9768cd09491e06bbcbdbdf969e9007acedb3fd1bb1f62f8b0646781daff881a8','a65a0acef4cbb879d961820a8d15aa43173ea455fb5e2819477329ce30f712b4'),
('edwin-arnold-et:gita.13.4','edwin-arnold-et','gita.13.4',13,4,'passage-commentary','source-omission','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:CHAPTER XIII:source-omission','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'),
('edwin-arnold-et:gita.13.5','edwin-arnold-et','gita.13.5',13,5,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2334–L2336','2c1397d4ac1e43c0bdc34b2837c69b32308edd03f773573c9930bba9dcf3e2a6','1a1caca1989f855d3bc922cd4186fb6cc74045152660a45c1ec257c4be82cd6a'),
('edwin-arnold-et:gita.13.6','edwin-arnold-et','gita.13.6',13,6,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2337–L2340','5612790fbdd9e7a9375dc0f3fb9b199dc09744f49686f1e6ee3c27bd7c37ae0c','7f3cb3528c194a7de497f8268b85eeb734bf106c4c274212454595c458576dbb'),
('edwin-arnold-et:gita.13.7','edwin-arnold-et','gita.13.7',13,7,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2341–L2343','695f177a379f7ee3fcf7f73d6f1872998ee3beb5ce9217de99b25f2c9fde2dd2','7fac79cefec0bd5b2b689a6ee2e59f640fe46da83c3f4b2b1c0047f54f57ee74'),
('edwin-arnold-et:gita.13.8','edwin-arnold-et','gita.13.8',13,8,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2344–L2346','49e1d60b3791cdd2c676ed7f519f1796e0bbe47f0406d92284835e473aa4aa00','bdd9e38bf18f1c50b432257a371c84c344ba5a66ef75309dc518f6eb36ae7831'),
('edwin-arnold-et:gita.13.9','edwin-arnold-et','gita.13.9',13,9,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2347–L2350','f832b233c7af5b089b3d78d7e6ca2f8b57cd4815b875e484421aa94e47a62fd8','15203bda0c59229c2c015814f51e691bb6138328c29583418aa466d400dc4216'),
('edwin-arnold-et:gita.13.10','edwin-arnold-et','gita.13.10',13,10,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2350–L2353','c934ac348304a84db7558abbf39fa31e709026a7ad1337cf9ee75d0bb662075d','efb4b1c2136e7fbbd82540d600599700e28dec09c210dbbafa342ea456cd0243'),
('edwin-arnold-et:gita.13.11','edwin-arnold-et','gita.13.11',13,11,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2353–L2358','72683454c382aa0f8a7e10393f7e83007bd10aa349c725c085367cb8c45e72bc','d4cb4743f2a6a09793f8e4d88858011916983d7864723e7249ebae13ecd9be38'),
('edwin-arnold-et:gita.13.12','edwin-arnold-et','gita.13.12',13,12,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2359–L2363','27a95448959133ffc1418aaa0e64f15c564922b9fe1a42fd0e9cd5e8184cbf25','a19dd8c0876479c913c0042824a1695880382fcff5944467631855d89150b415'),
('edwin-arnold-et:gita.13.13','edwin-arnold-et','gita.13.13',13,13,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2364–L2368','fa6c48f4de2517b226fc97b904f06fcf5f13f9490247101429edcfbc8db77c08','11e05155a7ad6503f1ed885cd96148f9704b8286c363f5e5866c65c40404869f'),
('edwin-arnold-et:gita.13.14','edwin-arnold-et','gita.13.14',13,14,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2369–L2372','de3da830b19ec7e03aab57fdae1862a077f49cdda2cfd6e9965abce4b28ee381','98673b821ad9e3224eff81740ded9b8b2fdcb067a16694ce08b254e16c4858fc'),
('edwin-arnold-et:gita.13.15','edwin-arnold-et','gita.13.15',13,15,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2373–L2376','484e37182da7baa65b77d7e3ec08bc15bf15182b87b4d3f121326e324547666f','fe5324a0eb346ac36e4549076797cdbae68820780c27143d60c41ca5d611c488'),
('edwin-arnold-et:gita.13.16','edwin-arnold-et','gita.13.16',13,16,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2377–L2380','f21f4f1277462814b3af6e45b2db81afc63bc69219a779da328f57fc43a87e8a','224a30b52400222eb9482107000f4db124d0d90094de48d7f1f693d92ff8e4da'),
('edwin-arnold-et:gita.13.17','edwin-arnold-et','gita.13.17',13,17,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2381–L2385','0b32bc1408748fabde708a02c2d83559197f58ead86c8ad82ea1d32eda8a86c0','aedea9ffa37a1b494df29ed0d5eec634e316f02f7cd89823598cd99b0af3dd80'),
('edwin-arnold-et:gita.13.18','edwin-arnold-et','gita.13.18',13,18,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2386–L2390','766affa11a060a6e4fa52ec4d930743878a879b2f7b656d714727b1de9ed347c','fb0426f3ff7cb708197f38295f88085d5869249de2d647587bb213fb34c7c318'),
('edwin-arnold-et:gita.13.19','edwin-arnold-et','gita.13.19',13,19,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2391–L2393','8d70106d9406827d34894bf9e1bd11515a13ab5278545f8ca73269f5ee3ce95e','2a7dea9d1b11b3fa5759e6a0460bbf281ed3445c16ce5676d4ea74ff1ce9f4b8'),
('edwin-arnold-et:gita.13.20','edwin-arnold-et','gita.13.20',13,20,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2394–L2396','1981ebd8aa8fae88a52edad6b0d66d4fb555a71573d2f325c2d26d44503603bf','1db22c6dda30c3d1d9cc5edd56e26bf58c2b618d6623b5bcc4de291bf446dafe'),
('edwin-arnold-et:gita.13.21','edwin-arnold-et','gita.13.21',13,21,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2396–L2401','02eb3eaee30ab9759683e734d23340701d644290218de05f275d1beb9590a541','8a636b8850f3dcdf398b3078ad7ea4e9dd3944f39cc0ddbaa98a7c207ae2b076'),
('edwin-arnold-et:gita.13.22','edwin-arnold-et','gita.13.22',13,22,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2402–L2407','71c7f82bbe9a262f3ade68a8637abd1f2859313a9733c3d0c881d3e5d2e3c8e4','059495d0e66805a597923df74d979632ad04f121a8600840040de772b4a260b7'),
('edwin-arnold-et:gita.13.23','edwin-arnold-et','gita.13.23',13,23,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2408–L2412','31b86b857cd59a61d5bf335aa346cc1d31915794823f64616e70875ec56efaf4','44dcf71516f95907e2497b9d0e23bfaadbfab5f8944bf57042ec1e0f300ce4c1'),
('edwin-arnold-et:gita.13.24','edwin-arnold-et','gita.13.24',13,24,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2412–L2415','209737fbdc7c580e1d31db6357636c1079c05afc1784141afb53aebf8037583c','4ec11a7c226229bd088243e8f06de10bb3bda0d17cebcb6409c5552d85652f17'),
('edwin-arnold-et:gita.13.25','edwin-arnold-et','gita.13.25',13,25,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2416–L2420','9efe212816f36cb71e18da725618b43415930380f5487400051c9d9966ae04b7','93215a965236b15bfa139ef9d5b5ab074aa889dbeeb0150c27b492c44e42235e'),
('edwin-arnold-et:gita.13.26','edwin-arnold-et','gita.13.26',13,26,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2421–L2424','c37921374ea791ad2cbd24f4acbb9d84cca1e887e5c89a78f8ed63527681cf37','796ee7c84f5090dd8957dc82b5a95470a938fd3fe33aabba9e379a7cd962e7cb'),
('edwin-arnold-et:gita.13.27','edwin-arnold-et','gita.13.27',13,27,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2424–L2427','8f35d04706aa5e048bfbc6736ab6e10ed741a2d39637b8ec6fb41962e56b4d80','d81f51a32ac8a873277d5ac3e92ff7c916e579952b171ab42111f30b53aa63df'),
('edwin-arnold-et:gita.13.28','edwin-arnold-et','gita.13.28',13,28,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2428–L2431','4ef7c4f0322d5559524ca84cb66133856ae38bfa5542658e7773682e20cb16fd','f1dbe69729ba855e5fcf9474f0337f86c40c820ea6e2cac20687493f9ecece1a'),
('edwin-arnold-et:gita.13.29','edwin-arnold-et','gita.13.29',13,29,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2432–L2434','4cd4a1a46d7bf1f47ed1c63790be398a5bf59231c5041c89733a93e8ac6d237f','8a3ca99324898484ee8e103490661db58cf2ffafac0cfe646ecec78f72a0b5cd'),
('edwin-arnold-et:gita.13.30','edwin-arnold-et','gita.13.30',13,30,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2434–L2438','e7b21c22477a9e59171c4c7f76e92469b432005473a47de364427929bab38251','c5f104c1cbece8c83d5e009639504a0107fb736b2665e1bfa9431093bb7e4c94'),
('edwin-arnold-et:gita.13.31','edwin-arnold-et','gita.13.31',13,31,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2439–L2442','71be951e296f0a3dce8d6d2984cca13fe85974d53b715db52444048f278bd5e5','cb8748312a8b2e7a234eed03384c92dede4b81d03f24cde72cbb779394ba8848'),
('edwin-arnold-et:gita.13.32','edwin-arnold-et','gita.13.32',13,32,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2443–L2445','ce028519c38e84da5ed45219f6b2b2e037f9356f5b3ce184ea78b3c3d484450e','332f962a53b4ef14a1fa7d2f0fb0b95adcfaeabba7268b6fc984262a37bf23cf'),
('edwin-arnold-et:gita.13.33','edwin-arnold-et','gita.13.33',13,33,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2446–L2448','d63cad9a046eb51f76f450a5f10709e3cbc7aa766f9ca2cac4e4fb439fcdb013','7518df8bfa63c186cfa53c379ccb06016eb59334f076fca80ddd25bf76386803'),
('edwin-arnold-et:gita.13.34','edwin-arnold-et','gita.13.34',13,34,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2449–L2453','311a6385d9e029b174b62c109aaf53541e6eead62a343a5cd3650b30b2834d84','363b67b1358514e18db3c7f780c6a2bc453e6950f0021033abfd337bb3b066b8'),
('edwin-arnold-et:gita.14.1','edwin-arnold-et','gita.14.1',14,1,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2464–L2468','e95bcc0923c1fdce8985833d5e7170e4180bcffc84b078dd51f97aa75f490c29','9c123318ca144f1fa7bd76f5d4ba02453a2a4addfee3f4861cc56ff2058fe1c9'),
('edwin-arnold-et:gita.14.2','edwin-arnold-et','gita.14.2',14,2,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2468–L2472','d24c18670d90f0d4ecb04bd29b9104810016a4ce94fdb9631ec1473d904ce4f1','e41369168d08862b84886910d6d213db88d092c71fbb30f8410f6d90341c1856'),
('edwin-arnold-et:gita.14.3','edwin-arnold-et','gita.14.3',14,3,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2473–L2475','a053a3ec3a4efea2563c0f759f048ad046a62688fd1d9490febf6a747ccfe93f','ba168f2cec4486517139d12ffe02642dcc976d5a9409540209331185f643a0c5'),
('edwin-arnold-et:gita.14.4','edwin-arnold-et','gita.14.4',14,4,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2475–L2478','23c1c986a83787cd8acac9daabaa40c27e352cd742f3ce2e856a7e19c312c487','80965ee9b2a750d71ed1597962b6a5b4002f35235e8a7b3f9e6f7b4639388d1b'),
('edwin-arnold-et:gita.14.5','edwin-arnold-et','gita.14.5',14,5,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2479–L2482','2d713967d78927d11447e35ae1c79fd22c8a69ca01729bd0d699c402d7763ac3','9e2d1c17370611618bab6262040dd2f6b82cf0f80a4f375e564ef43e2140f2c1'),
('edwin-arnold-et:gita.14.6','edwin-arnold-et','gita.14.6',14,6,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2483–L2485','87672c8f66cc563856de0b11027347feb4cd58883b8d4d5125b3e1b594927eeb','2c68647a799ebda1b9f026a1b3f543cd818a0c59ca4949484719d1cb21bfc563'),
('edwin-arnold-et:gita.14.7','edwin-arnold-et','gita.14.7',14,7,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2486–L2489','70aee30d3ccc7e26c7d883e7163e0f041d971f0c3ba9e05de8c62294a8afa781','b887a2b2f06d29ce096841b0715628446b2ab0ca9029a31eec9dd8b8bd908ffc'),
('edwin-arnold-et:gita.14.8','edwin-arnold-et','gita.14.8',14,8,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2489–L2491','79a61f13cfef6cfe879384605a7b250f8f13a05139b2aeee3440e9d4d1d7c102','f2a5dced91f8c052d42e3e1b95ed0b02e94bad8ee90ab5a5cfd19c2eec8d783d'),
('edwin-arnold-et:gita.14.9','edwin-arnold-et','gita.14.9',14,9,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2492–L2495','6f70b8113ba7ce31774889b9461a30e79f70f7e65362b8cd79f667d107de5b66','0d0c1445420de319b5921201ff3c4a81f53bf9d06629ea56c18e1bfb9b5eb398'),
('edwin-arnold-et:gita.14.10','edwin-arnold-et','gita.14.10',14,10,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2496–L2499','e80ec489cafd22dbd66de9a5e9bd85c80eb38578002213fe18ac7cdcc64582d2','56500265514fec041614dcbe3093018bbd0617b2f760733786af17313de9f405'),
('edwin-arnold-et:gita.14.11','edwin-arnold-et','gita.14.11',14,11,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2500–L2502','1ab6699c7f58cf2753d2192a54df3da251ca28017e3a9c25e9abd366bac22074','1943293336bad8965214bdee40c65ad7c3b7d9f458234b8a07d8d1064c57f113'),
('edwin-arnold-et:gita.14.12','edwin-arnold-et','gita.14.12',14,12,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2503–L2505','b994cc69dd9406b9fce48eb7265481f6f4fe25438c3e3f6a92e0b1f07b3b018d','9c5eae0e252802fe299dc6ed9bb46fec53dbb1395887f6f40286e7aaa645019a'),
('edwin-arnold-et:gita.14.13','edwin-arnold-et','gita.14.13',14,13,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2505–L2508','8e6ce2ecac1c229970c7aa552a6abd91906f8fbc7e922715985873a95f6642cb','f4399f76494d10ebd7227b89b2e28f1ff5f05c2f41e10051e9346f1dfa34264c'),
('edwin-arnold-et:gita.14.14','edwin-arnold-et','gita.14.14',14,14,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2509–L2511','14041ad298c8f1f22f12153f969d2aa8298e7a141d67059de7f7cd0bd185ee49','7880859b24566a30ef686083d7ff7f966dd6f365838396d019591c4ab331994f'),
('edwin-arnold-et:gita.14.15','edwin-arnold-et','gita.14.15',14,15,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2512–L2517','c393812edb93042cbeee7a28d42e00ff9055c9039d2a329d6179a9ebf2d2c993','4d75bbf7235d12ffd62c59826444d673acffa0eee7bdd9668d4bed345e428d18'),
('edwin-arnold-et:gita.14.16','edwin-arnold-et','gita.14.16',14,16,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2518–L2520','5879c34a9ef80b92e8bd80dd9d038ba3175dfdf8e7324f7f1544577c3833c153','437263b60585ac26ec68b643f43c748b354c6a7ba7271bb673759a5626abf8dc'),
('edwin-arnold-et:gita.14.17','edwin-arnold-et','gita.14.17',14,17,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2521–L2523','e546511d2e24944f29e943d692e6294f2ce4afd717a59c3a7997d7eb618cfd98','aafa6b4eef3a89f1221a926136f152bc37e719ce813d13c83d19b92e698f96d4'),
('edwin-arnold-et:gita.14.18','edwin-arnold-et','gita.14.18',14,18,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2523–L2527','b70c545eb34f1a8e0ea91e726c2127e3abcb87791f66e94495c7b4b9991a7c46','be65be23de46373bc2ec0aa9879bdc59b39631e71138217261b10e4ba98f074f'),
('edwin-arnold-et:gita.14.19','edwin-arnold-et','gita.14.19',14,19,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2528–L2532','6e99f49af911036d47abd567dceb22a766132c7d6c4914e340004afe46cfbf63','a3bcc12e5d06da5652d8453a8f553efc3033f6a74d541080766c63506366ffab'),
('edwin-arnold-et:gita.14.20','edwin-arnold-et','gita.14.20',14,20,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2533–L2538','1e669d1514657222877836f812cbe05fa2ac9b506b065cd9063f731c515ef1e5','6cedef34450fde86941061acf8b963b20a2bfb2c29ebd2a98deaa527672429ea'),
('edwin-arnold-et:gita.14.21','edwin-arnold-et','gita.14.21',14,21,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2539–L2544','7eb862d911125f26a0b379814c70929210d76df595e55aa0fadc580c8d8e023c','6fe282508fa4d73fb1dfb63bf8b2d7f3ea967a04e2f6156f762821562c04b499'),
('edwin-arnold-et:gita.14.22','edwin-arnold-et','gita.14.22',14,22,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2545–L2549','b7a6cd7af043090ee89900e1fdba0cdfd9c3bf9d365ba8a9b0e930157491315e','97fa170f5c2d396fba4df05365762a580a2551d076bb8b907e23ac008345e455'),
('edwin-arnold-et:gita.14.23','edwin-arnold-et','gita.14.23',14,23,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2549–L2552','e262623907eed84f81ad19e110e24d12433385bbbafe83a398fa67c543c05c56','2cd794d93c0682487f12ad3ecee69c3e67c3f27ff91ff326322c90d6a3deb45e'),
('edwin-arnold-et:gita.14.24','edwin-arnold-et','gita.14.24',14,24,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2553–L2558','0ba990f10a4cf8e14c551661e69bedc8bf1a12865d21ffa149e1a58cc21cd6c6','da3ea8df1dd4349bc7b470835ec359af7c9c3fcd518f6d01c44ea4799ab8bc20'),
('edwin-arnold-et:gita.14.25','edwin-arnold-et','gita.14.25',14,25,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2558–L2563','12e7737289d460ceff4956d7ac7a9e6280b46d13f93a95d8186e0209ee9689b5','588749bbcd1625392482bac6d6a5f17368c05b1f1a85118086875e21df498e6b'),
('edwin-arnold-et:gita.14.26','edwin-arnold-et','gita.14.26',14,26,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2564–L2568','508cd65285e4c9f634c8ce272e05a75a19cd265a5e9d21f02e812675cf9f8d9a','329493b9472a9014c8508ec8cc219795eec163a064989f6b9f92084937806498'),
('edwin-arnold-et:gita.14.27','edwin-arnold-et','gita.14.27',14,27,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2569–L2573','771201989ee6c062366e07ab173416525ecddeaf67f7a6fcf2b1d9617eac6f12','eb3e0c05d7dc745953fb98e178cdb96584e5327ff8c3f153b74c1640cce3521e'),
('edwin-arnold-et:gita.15.1','edwin-arnold-et','gita.15.1',15,1,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2584–L2590','4ed14b0a54443c5dd7aebb20d8c93d892a17294420a4451706ba6743eb7a58e8','fe950e309452b6242028422474769d94594dec8f63a8166dba6f39cb72064518'),
('edwin-arnold-et:gita.15.2','edwin-arnold-et','gita.15.2',15,2,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2591–L2602','02d192eb9d380a7e0fb5d5c3f181204136fde5a4ca014d3cbf057b33388cd14c','a9440e5444c2c4b004cc1c6c0418511c8778b5121752064ac71766770f7138b5'),
('edwin-arnold-et:gita.15.3','edwin-arnold-et','gita.15.3',15,3,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2602–L2609','beeaa4c96602f6b23b118c134a864b32a3d9f602870feab49fa3febd23e93f78','f1510d2dce5a74df04085b7131191cc014a1a95e9f8ff46b5b6e38ad44f2aa29'),
('edwin-arnold-et:gita.15.4','edwin-arnold-et','gita.15.4',15,4,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2610–L2615','b3253d69f6240ad3ba1e45b530361ff482bd90dd312b904e377b22ec82391c43','f015d34c338e81dad7538f8e882f2900fbc2f07718ed1f551b64ecb8dff408c8'),
('edwin-arnold-et:gita.15.5','edwin-arnold-et','gita.15.5',15,5,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2615–L2624','9b3dfc3d9b5eba6819d14a83be07b4394a6504248c232b5b235c4ee945e5ab4b','ae2282596e3c86c1dbca21847442348d7fb26bd9e6ed0fbc4f45f26342d1c0a7'),
('edwin-arnold-et:gita.15.6','edwin-arnold-et','gita.15.6',15,6,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2625–L2629','63ead2b1d1da89fe1622f104cdcccae46bda13afe5a03e4933d4c785c42cad44','7f63d86c2ae3a7ad716af47e9d86daf68b8f767231511adf2712303b25103a20'),
('edwin-arnold-et:gita.15.7','edwin-arnold-et','gita.15.7',15,7,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2630–L2634','103f371da7eee08a333c8758ba336d7110a9218f3c8d1d19cfb1053a3fbd19bc','a7e075b8f1d74774055b37e02691b2bbe2ab113e720a6be87784cf24c4bae865'),
('edwin-arnold-et:gita.15.8','edwin-arnold-et','gita.15.8',15,8,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2634–L2637','e293710ca22a97c1c568b01be630e464540c36d5ac43eaa89d4858a2d7f1e9b0','54767ba95dcd3c36583c078b22823916f0cacdc1b93a401e7fc55b65310e8f19'),
('edwin-arnold-et:gita.15.9','edwin-arnold-et','gita.15.9',15,9,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2637–L2641','42378207c51845a8d4a4d0bfb3ae69fbb38140848dc0cdc8a4ff8b3f4277a651','0b0c60e8fd3c0dff1f8e86913df79e4aabf1c8982348ae78c7070e3b71b11b10'),
('edwin-arnold-et:gita.15.10','edwin-arnold-et','gita.15.10',15,10,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2642–L2646','80210b15621d5b5b4ac69a194f4cf242305890ebf2ae9c7f72b1aa19c69be8c7','7eed149d51fd1e4573f5f4c24ca2992278b612c469ec73a50e4be4aa1ae5d85e'),
('edwin-arnold-et:gita.15.11','edwin-arnold-et','gita.15.11',15,11,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2646–L2651','f4a724b82b2474b3f881b3c031ed56564b5b69de8c86ade9ecdb4c092589bd1e','d9ef4ba9fe0400666584af3a236fc939df68c5d873314fbbf500ff962e62c03a'),
('edwin-arnold-et:gita.15.12','edwin-arnold-et','gita.15.12',15,12,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2652–L2655','f810c7704728661713c5418790df88ce3f5d1dfec4ffd91bd3dba81de25d5558','924c29de123adda7fa920cfa0a0b104bbbd5a048346be7e2a48bf88a5faac3b1'),
('edwin-arnold-et:gita.15.13','edwin-arnold-et','gita.15.13',15,13,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2656–L2659','0c6a517b641738cf818cf9dbf3085dc1e6bcd0061aab35ba4166d66ea30d767e','2e54d85aeacf71c64ca3dd1f647f5ac32a38453415a8d8ff742c3099ec574504'),
('edwin-arnold-et:gita.15.14','edwin-arnold-et','gita.15.14',15,14,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2659–L2663','ec5f94ba24e0f8376be8e27662a34cd41e336a3e4c9079c6d4268580244c844f','9a6d3691d7598436799fa4622e65ece559668834c3a0778832350e19dbddd97a'),
('edwin-arnold-et:gita.15.15','edwin-arnold-et','gita.15.15',15,15,'passage-commentary','source-omission','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:CHAPTER XV:source-omission','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'),
('edwin-arnold-et:gita.15.16','edwin-arnold-et','gita.15.16',15,16,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2664–L2669','92ae225211d6a1854224ccd9b9d272fcf1a9f73f8cc53da6d098330013d4e86c','e381c068592048af7847fbf8535c5ff81c6181a89b026ca0cec329a39de44b69'),
('edwin-arnold-et:gita.15.17','edwin-arnold-et','gita.15.17',15,17,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2670–L2673','0e9f798062d6bd83c7f19d650091ea1b6561ec5dd469818a63d81d5c84cc3fcf','c60293ac041b0eaa4c0ac884f4104e91bd6038d625bfa3c1b8d72fef36596bb8'),
('edwin-arnold-et:gita.15.18','edwin-arnold-et','gita.15.18',15,18,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2673–L2677','194aed0acfee726ac3c8b05ead2557c55432c1c11427b2a35575db8b9108ddcc','278051d6f89f90451a592c1f63654665bcfe60a4890805f4e6fb2c6cf2bb90bc'),
('edwin-arnold-et:gita.15.19','edwin-arnold-et','gita.15.19',15,19,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2678–L2682','ee6e56f3b88f83200c6e01966f8e64daf30e34687a5335582a5dd1fad08d9f84','de87cc7fd5ae8b22908ea13ce97b496fe9db225a46312d765ad7eee592380182'),
('edwin-arnold-et:gita.15.20','edwin-arnold-et','gita.15.20',15,20,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2683–L2686','4772c2c958f34fcba49093bad44b5ddfc19eca37d852000df00a9fcd0b751fa7','e20bb6ceb5b6aff06bc6ab4e99eef185f0ed245a8a1947b9b64a923dc6e76498'),
('edwin-arnold-et:gita.16.1','edwin-arnold-et','gita.16.1',16,1,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2697–L2702','3adb82a64691cd06530dcc4a54dc5d91c98acbd4e17ee8f5fbda5e5202dedf19','cb42300dfbb9bfb0db42f212f2d47b14fa4e041f7d5d099fba4e6ec977695583'),
('edwin-arnold-et:gita.16.2','edwin-arnold-et','gita.16.2',16,2,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2702–L2709','a1c8f627fb93d35310ff307c9275f3d5bc410abfa57257978a8edb81a5ab759a','26a8da46611faa6b012a833787f9727d889b7cccb62829870ae1243e72c3b4b6'),
('edwin-arnold-et:gita.16.3','edwin-arnold-et','gita.16.3',16,3,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2709–L2715','4d82dad3b563dc4cca2d5ec640145f656f468a1cdbc918888070352ad46d0fc1','8709297f03d3ae04527e4cbd0667621ec7a72b3404f590bc5d78a73e0e4e2beb'),
('edwin-arnold-et:gita.16.4','edwin-arnold-et','gita.16.4',16,4,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2716–L2721','c608973cf3fbcc6786a7bc0aef9dd77155b7c88d8e695aacd56cffb7848ef875','932d55c0fac620c6977e40ec486f1c2e914fb0e8c6fff8dc7bc3c1296eb8a9d0'),
('edwin-arnold-et:gita.16.5','edwin-arnold-et','gita.16.5',16,5,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2722–L2726','346ef19440a19c6fe95121c5fb1f4d7cf601994b12e64f921da1afe000cef59f','1757ffa8e36e10d4b68243fdc424fdfeb5af620f49e55f97cdca3fdf69d25013'),
('edwin-arnold-et:gita.16.6','edwin-arnold-et','gita.16.6',16,6,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2727–L2731','88e906270b5bfbbc81bd160359237d88fd1572dbafd8bc7cb9473f0540164408','cf57b57916a1d17a8af6bd16b53e76c25d2fb63102eee35ddf679ae779d01084'),
('edwin-arnold-et:gita.16.7','edwin-arnold-et','gita.16.7',16,7,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2732–L2735','406be1d461f1507ba4dba50d5ebf80341af2a91200e15950b407ae103a686f10','a4152d6fa80ae85fd352ddefabe74381b1c056333f02f1f7b1614d7363405113'),
('edwin-arnold-et:gita.16.8','edwin-arnold-et','gita.16.8',16,8,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2735–L2739','a9ec44d5cd9278bcb0ce4b3953b5410dc5cd29590e364c3302fd1888a042b0c1','998750b8abcdf0859e9bf4b4fef99bf9d37fda28174aa0958b8425879a3b977c'),
('edwin-arnold-et:gita.16.9','edwin-arnold-et','gita.16.9',16,9,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2740–L2742','ec9cdac092bd54e99f378ac0302e04487246324370557b25c806eeb255433728','98bd0922d93fe5e683dc102042da570cf792bdc6141ba32f9eb295a530c11c7b'),
('edwin-arnold-et:gita.16.10','edwin-arnold-et','gita.16.10',16,10,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2743–L2746','cae36b09a747ba4341de39ceb275f190aa54c868c56297124b618b9d167a9f37','a431a2001317ab92d18cea096dcd421b72cb46c5da818483703eb3185628b43e'),
('edwin-arnold-et:gita.16.11','edwin-arnold-et','gita.16.11',16,11,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2746–L2750','7bad4408fd556d06c4410f8e9816a71d8260eb2f6296c98089f8ab5690ca87a0','083d91b627278dac3bd49941613549018a5b62d39026bc4c1675f6626b655fd5'),
('edwin-arnold-et:gita.16.12','edwin-arnold-et','gita.16.12',16,12,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2751–L2754','65155a1b1960a95142d14fbfcebcb36d23cbbd5600c65967e381ebd59ef8decb','54c7f137bb304ed9350ba3d5bd5f00413d241cec3a53a4373cb1aedfea4eba2b'),
('edwin-arnold-et:gita.16.13','edwin-arnold-et','gita.16.13',16,13,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2755–L2757','f54b072000f49cd0340b23674c8fa0a8f632c86d83d6fa49f1468ffd3867fe91','2277c9ed560fad6dcfa29d8f098613352af4121c48c11366220f6a7949363271'),
('edwin-arnold-et:gita.16.14','edwin-arnold-et','gita.16.14',16,14,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2758–L2761','9de3a4bf2adf00f961bddd9f0e18bac7f5f58fc3c3c9fb5e82049f096fc298ef','063e2afd78ab2371357110b620a46b2bf4f1fa7fff3d7f3831f0470b314edf3e'),
('edwin-arnold-et:gita.16.15','edwin-arnold-et','gita.16.15',16,15,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2762–L2765','d776ee55d93fa993ffb186671c3ee495c05af4f4b0958da845f9631de8311ecd','37052ea51335d0edd9ecd7856651181fe3e69c24c413fa65a7898e1fb0ef296b'),
('edwin-arnold-et:gita.16.16','edwin-arnold-et','gita.16.16',16,16,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2765–L2768','b224b90b45375ed0b0e1880f07c4e1c3e806806562081c7e5f70569f1070c2ed','643946efd3fd6e44f8063f1c6c0589561098699b20fba9a7178e48eb5e8d0007'),
('edwin-arnold-et:gita.16.17','edwin-arnold-et','gita.16.17',16,17,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2768–L2772','bdbc6092afc772ed641d34469fbe524ff9b09c4ebbebb514694a71a4d516f438','a7bb5659d12fd1cfdb98d999b58cc30e1e85c18ef7dcc335006edba1155adb16'),
('edwin-arnold-et:gita.16.18','edwin-arnold-et','gita.16.18',16,18,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2772–L2775','c096666bdaf624f4e642caa8a93ad697ebe015170d4d28f326f240991f1aaaf6','3f99f81197878f4971bff70b27a2ecacf1ef667f6244f4f499d781601b2f89bf'),
('edwin-arnold-et:gita.16.19','edwin-arnold-et','gita.16.19',16,19,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2776–L2779','c048edbc6d928d292640524a3be9ec1e9a37bcda333c50cf472b7b32389aa43f','af62daaef1198cd6400e4b195337848ef8fd70ed6135713c6d424de2e99b6228'),
('edwin-arnold-et:gita.16.20','edwin-arnold-et','gita.16.20',16,20,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2779–L2783','bc2c01239123b5d8f7dca8c8d25c9d8359f5b8e1097dd8cdf620d31234286768','28ab4c3ade6d8ea519b9719321496eef922c26890be50248c9a2b96eb44cfaee'),
('edwin-arnold-et:gita.16.21','edwin-arnold-et','gita.16.21',16,21,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2784–L2787','972391b7f969405b23f556eff4c1275dae3cabec8f9b749a0c9b0ade839648d4','cc90dce9005c4d248c26129c38dcf72342514321d2b9c41718c250e451c7562c'),
('edwin-arnold-et:gita.16.22','edwin-arnold-et','gita.16.22',16,22,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2788–L2791','a77c2dd34aa2a48767e90be2d731e785b963288660b7bf8f5976ddb25ad2328d','48dce38717cfe0285f570312d7f98c5b639fad3989721d3688506408cda3f6da'),
('edwin-arnold-et:gita.16.23','edwin-arnold-et','gita.16.23',16,23,'passage-commentary','source-omission','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:CHAPTER XVI:source-omission','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855');
--> statement-breakpoint
INSERT INTO commentary_units (id,edition_id,passage_id,source_chapter,source_verse,unit_type,alignment_relation,alignment_status,source_locator,raw_checksum,display_checksum) VALUES
('edwin-arnold-et:gita.16.24','edwin-arnold-et','gita.16.24',16,24,'passage-commentary','source-omission','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:CHAPTER XVI:source-omission','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'),
('edwin-arnold-et:gita.17.1','edwin-arnold-et','gita.17.1',17,1,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2804–L2809','f2c287a714c0b431e30c2aaa1f597636019f1582e7354860d754ca13b48bf0bc','5f956c0dd7ac04df9e22ce272908237f36d452635e6cc356257d3f4ff5030ac0'),
('edwin-arnold-et:gita.17.2','edwin-arnold-et','gita.17.2',17,2,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2810–L2814','c25f413a2c5b5f1bfc340a67b83c1b9cee08415c9223b0ffd7901f3908683647','c7de7f76e45400349e5e00ac3a9d459073e841528dae4ec03155c067e1eab2c5'),
('edwin-arnold-et:gita.17.3','edwin-arnold-et','gita.17.3',17,3,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2815–L2819','49a686d58ebeaac65365653ba537d73637270eb34cde481bd83a3a8bf54f499e','35a95b09942a05f9448439b9eba0c7465868d885b1149d241f12372b8d901cfe'),
('edwin-arnold-et:gita.17.4','edwin-arnold-et','gita.17.4',17,4,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2820–L2823','b96643193c3cd87e803866e8e7973957a9a58fc8ef5f9ed8f36af4174ba8f87e','5965ae7059cf876e1a053d48e4f46b0078899273f867305f4c58e296d1cbbbcf'),
('edwin-arnold-et:gita.17.5','edwin-arnold-et','gita.17.5',17,5,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2823–L2827','419d4e5b61817849460ffb185558f5ed0952a34c61d880d961dbf3fb48b40a43','cfa8ad686bcfa2af8620771ba833eb75ea31668fc9ad8944fd2d30ed00b477aa'),
('edwin-arnold-et:gita.17.6','edwin-arnold-et','gita.17.6',17,6,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2828–L2831','2df82a1d21c5a3932a2d0db888b0e411c8fc45b49788f5f3d64c0625ee3595f3','5ab87b67d1c5c1856cc2a90453903121985b69285271191718f77735d64da3b4'),
('edwin-arnold-et:gita.17.7','edwin-arnold-et','gita.17.7',17,7,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2832–L2835','18ac90244e47744bd4488ee146d4b6674a7bbcc31d6b0a5fe5b2c0a384d8973f','b9826bd97a053d61b2201c478809ccbd943bf92fa01931c4fbfaf1139909b852'),
('edwin-arnold-et:gita.17.8','edwin-arnold-et','gita.17.8',17,8,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2835–L2838','460e81f98d3e33b4ed1710b23d199cf8bcb958daf941405cf995f21f8de82336','92f173d6b3a658dcd0f0ba4e65d1626d3474e5bbe59b7af31f7b11985b82d5a2'),
('edwin-arnold-et:gita.17.9','edwin-arnold-et','gita.17.9',17,9,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2838–L2841','330ab656548a7647be766724ef0235fcc519054a62829e593b6df65dcb6fc45d','2cb752e025ca8f67a35ae5f11bcb9d49a001c6a1b4d869761a7676baea2cc623'),
('edwin-arnold-et:gita.17.10','edwin-arnold-et','gita.17.10',17,10,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2842–L2846','ae0b9a07e8b7c12aa6cd0295a78bf78d5a6c64be9a43c993169a5c104b169b84','ce926c449ad708f2eba1007c72fb2f132de6e39ae772dce6a9d8e75483fbfdcb'),
('edwin-arnold-et:gita.17.11','edwin-arnold-et','gita.17.11',17,11,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2847–L2851','1c30132f80f39008168e13d38e79a63e58073b794320e24934754598e6ad8a3f','5440aa844ea4d44c9c32c145938e00e4bc4437c693dfb499c399951d44d0831e'),
('edwin-arnold-et:gita.17.12','edwin-arnold-et','gita.17.12',17,12,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2851–L2854','9d7c73a6178c6b5d03fba08194617b5a3a6b62a9e2df7ec1b762d0001cded7f8','178400e453207b28d9b2c9fbc86ec92e80ed6d2b6c41c6e0d817cac7ad332eaa'),
('edwin-arnold-et:gita.17.13','edwin-arnold-et','gita.17.13',17,13,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2854–L2860','c22d9725eceff877eef3dd881c88279f1641df48813214955c350f3f76860619','917e863218b74feb372d129f574893a6352624bd610ab34130f354a1689c8222'),
('edwin-arnold-et:gita.17.14','edwin-arnold-et','gita.17.14',17,14,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2861–L2867','f71e85320bdb35384288215fb424eb442982dab1b315be98085fe26bb692719a','c442e460402cfab20e671490def82ff022456b0231360ec41cdaaecb5782e95c'),
('edwin-arnold-et:gita.17.15','edwin-arnold-et','gita.17.15',17,15,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2868–L2872','d42f609a7385795339210b83fcea9279b1a3f3d1d33c40f58f45bb2b38397e99','949c027c4f9937444e3ac45b8177f54e2526d52e103d36db746b8f7f756f0c45'),
('edwin-arnold-et:gita.17.16','edwin-arnold-et','gita.17.16',17,16,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2873–L2877','20669dc02fe59c38e7f15743975d923160cb99ecedd7a54237411638deee36b0','f59066d5829e7f6365c4b8329a42b90279100afe1cff212b9e81a415e248b6c4'),
('edwin-arnold-et:gita.17.17','edwin-arnold-et','gita.17.17',17,17,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2878–L2881','1bb6abb951bcbd3a1be2f17ae6e1cd359bf50f967781104e66f52248f69f53f4','94321fce85e769d562ba849de313da9fcc15adebcb3f3bb95b54d15ea1fab57c'),
('edwin-arnold-et:gita.17.18','edwin-arnold-et','gita.17.18',17,18,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2882–L2885','786e7fe936e6cc2500495b56298fdf009cadbafc0622e3c0fd89bd09b968f682','a93266560b306b3a9a695d7b7ec9c2521cfbfc13cf0983882420c814c87a674b'),
('edwin-arnold-et:gita.17.19','edwin-arnold-et','gita.17.19',17,19,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2886–L2889','a0b9cf17c58282b04c2f1c32be8c9a64983f3ee84c5bf746e8e4bd6b7a1feb59','c24bfb3b5ad8ea7dd9c406074a1619f0f3fa1987bc1ff435355524496ab60150'),
('edwin-arnold-et:gita.17.20','edwin-arnold-et','gita.17.20',17,20,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2890–L2895','2f5dfb736e0db1e32133044c8c033528a3cf1b6e9ddbdd6e732c1995ebb00acc','a6cfab5f5e66960513d8079457f5496d612192e6af110a7589884a449059f35e'),
('edwin-arnold-et:gita.17.21','edwin-arnold-et','gita.17.21',17,21,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2896–L2900','dbad0ccbeeb85a960963b139dd2344d793b7c4961ab6ef9fe4e8bd2a4c7d874a','a9d14f95ad1e449ce46688d130cf72cefe6f1fea5a5bbbfd38bc91c0ced48345'),
('edwin-arnold-et:gita.17.22','edwin-arnold-et','gita.17.22',17,22,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2901–L2905','e9dfda86cb857bcb40a0b226e7bcee0f4532c4b6a77250288a76fb9ad8c1b6ac','e7a25ed747d0219c1778bba83b7fc477eabfa97f679ffa0ae6a8f8a927969e04'),
('edwin-arnold-et:gita.17.23','edwin-arnold-et','gita.17.23',17,23,'passage-commentary','source-omission','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:CHAPTER XVII:source-omission','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'),
('edwin-arnold-et:gita.17.24','edwin-arnold-et','gita.17.24',17,24,'passage-commentary','source-omission','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:CHAPTER XVII:source-omission','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'),
('edwin-arnold-et:gita.17.25','edwin-arnold-et','gita.17.25',17,25,'passage-commentary','source-omission','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:CHAPTER XVII:source-omission','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'),
('edwin-arnold-et:gita.17.26','edwin-arnold-et','gita.17.26',17,26,'passage-commentary','source-omission','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:CHAPTER XVII:source-omission','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'),
('edwin-arnold-et:gita.17.27','edwin-arnold-et','gita.17.27',17,27,'passage-commentary','source-omission','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:CHAPTER XVII:source-omission','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'),
('edwin-arnold-et:gita.17.28','edwin-arnold-et','gita.17.28',17,28,'passage-commentary','source-omission','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:CHAPTER XVII:source-omission','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'),
('edwin-arnold-et:gita.18.1','edwin-arnold-et','gita.18.1',18,1,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2916–L2921','f1032251708ce0c58d5eac2d2ef144517d8b9abae8c938223951278d2887a8b5','442c8457d169936f6aa99acc5fb746608a97f28ee083ca702fe6ae3330766a47'),
('edwin-arnold-et:gita.18.2','edwin-arnold-et','gita.18.2',18,2,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2922–L2927','f28204e620708409f220a3c0455e5a110550e17b7edd31e3789b839995553ab5','1af7684a359051467c0fecd32bd19dbb300af137021ea0511a0c2e3ab13ce1a2'),
('edwin-arnold-et:gita.18.3','edwin-arnold-et','gita.18.3',18,3,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2928–L2931','a695bfdbb074a06782e734ed6dfa8c3def51b0ea573c139236af2c0f5a70175b','9b8526a689253558678d461e76abbfa7afd311e996701e72401b68d1e2a7d5ee'),
('edwin-arnold-et:gita.18.4','edwin-arnold-et','gita.18.4',18,4,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2932–L2935','589c8e8182471c2916cbed2a05c1c04a96698a5a22e21133b0207e7339d0e245','8201241c79456c446a5349a67245677c8998be8528e35e8a2258aa66856bdb22'),
('edwin-arnold-et:gita.18.5','edwin-arnold-et','gita.18.5',18,5,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2936–L2939','a9f6a6a038e2980a4d640df69d17146103696e099291c9c138066f95f6a1ca3f','17755205aec8b5bb81952bf7f1e824fee92fc274049ca285c100e68b90ea1992'),
('edwin-arnold-et:gita.18.6','edwin-arnold-et','gita.18.6',18,6,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2940–L2944','3d19d7e0ce79b408fbd04f42a41a3251f57b6e110945e269d84cd97f4b9b966e','5f5ab201b7be8c911051f6f64b347537b57e2052afc717e83280366f59e0cd57'),
('edwin-arnold-et:gita.18.7','edwin-arnold-et','gita.18.7',18,7,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2945–L2947','67d9f29b6284dc191a1a46f704aa26c16cc82cc4ac6c692ff978124cb23e0ff4','a783c7431cd4331cb38dbbc41d2d3a6e7e9759b4507010b3435735de332d5d24'),
('edwin-arnold-et:gita.18.8','edwin-arnold-et','gita.18.8',18,8,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2948–L2951','7a9981f8b2835e2ee2269485eb650726d201c09baed517063a20c135486a1789','6df70e91a73a147933161a322739313e5d257585b52b109cf268387128bc9093'),
('edwin-arnold-et:gita.18.9','edwin-arnold-et','gita.18.9',18,9,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2951–L2956','37416bd1a8f5f1e69a513414def4b0afe5f451b87fec961ad412c3b3a6e8309b','d7555bf9111bba2fd8d7fe753086c70ea81fecc833e86d9fa3a70ee8eab03543'),
('edwin-arnold-et:gita.18.10','edwin-arnold-et','gita.18.10',18,10,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2956–L2959','a5b76f7619ea5a32bc42bb67e9ce2d71285623517695d7026ed2f6a34a35e564','7ac13a72b61570beecd8526f71bb710891bb6a9c2367705996a5902c67edece5'),
('edwin-arnold-et:gita.18.11','edwin-arnold-et','gita.18.11',18,11,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2960–L2963','d81fc5faf80f9550b82e8e3b477b7d9dac938bc70219a7b18e1990b9555b51d1','b09b001e2346f227ee8b0435c17d000545536cd60334fd85625968a1a454ea39'),
('edwin-arnold-et:gita.18.12','edwin-arnold-et','gita.18.12',18,12,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2964–L2968','2d58d1ffc47f34fa93d01fe7f10a269dffd18a779fc32ae6806f3f12c0aaf382','3dc31aaf789043e32fddf4f166e729a277a2a8ad7fb389e2da45479362828066'),
('edwin-arnold-et:gita.18.13','edwin-arnold-et','gita.18.13',18,13,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2969–L2971','bc0d6f7f05721ae956dc0ca3077773448d3515416a69f76d37c93f21d66f4ff2','bfe88c2dcbcf8e968b96b8721036dbd8062bd7579b7b6d232067283cbb580760'),
('edwin-arnold-et:gita.18.14','edwin-arnold-et','gita.18.14',18,14,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2971–L2973','09cdcbed794328fbc76f62f7787ac7fad180c0bb80bee5e4bbbb4749b0cf4f23','7b2ba3f9ac7755226373a2b56ba44c04743c54bd03cba96480bf8fe5985e7c98'),
('edwin-arnold-et:gita.18.15','edwin-arnold-et','gita.18.15',18,15,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2974–L2976','f0460e203fde7e2e82d24ae8e19a2c84f4070b0acb45be1b805737013e71a127','5286c1a8b360fe58f185b730345530f9fcb0473794cf63f7a368d04d5c23461a'),
('edwin-arnold-et:gita.18.16','edwin-arnold-et','gita.18.16',18,16,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2976–L2979','f61b21b6ac3b4d8bf7dd1c619ab9a209dcad5e900f218a354a1b244a1762484f','c6541691ca339081e568091a74a54322e5770538c0c6719046f6ec31d837494e'),
('edwin-arnold-et:gita.18.17','edwin-arnold-et','gita.18.17',18,17,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2979–L2983','6881d0f0ed5317ad0d6c968ab99b11fae8f58a9f801103927a7e1d2a1122f859','5f9ba6112ef96679f0eac4e4bcf1e06911d9a004a8b2d698a0c1e4f72b297171'),
('edwin-arnold-et:gita.18.18','edwin-arnold-et','gita.18.18',18,18,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2984–L2987','b015e57341b44306e07bb3d45380bab35228c8c84ac499fbd83a0d9da0c36780','5797f8152315905cffd602b6f470c6c7188cdc0b2316cfecfcacee00a6e43996'),
('edwin-arnold-et:gita.18.19','edwin-arnold-et','gita.18.19',18,19,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2988–L2991','1a8f7bbdd3973366b5513bbdc11141bcdcf92b06b543359ccb6a5f649f3bfc08','ca95092312047a3dd86445f9684f103a6c38c8a0cdbc9ad149a0f1995352a693'),
('edwin-arnold-et:gita.18.20','edwin-arnold-et','gita.18.20',18,20,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2992–L2994','b2f3e2bc3fa6d6056bb3eebb91f8e363c49a69f2aa02fd57c42db2a06f997864','ee7bfc2032d5f6c4b893d692babb20ce25efc1fb9c618e28c265dcfdd5b4d5ab'),
('edwin-arnold-et:gita.18.21','edwin-arnold-et','gita.18.21',18,21,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2995–L2997','fdc9c9131ab111fa42ea18b1dde03e2ac77d7e7ba7289855c07079f7ad2a1471','f3f7108f4e7c673feeeaf7f1080bec2b63015db7d88f09504d817565969f745b'),
('edwin-arnold-et:gita.18.22','edwin-arnold-et','gita.18.22',18,22,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L2998–L3001','e20c3e8685911e6796b8921707515d86a1bd2bb1dce7e7f6e8595922908e5286','cfd7f82032efe5acf3087cd0ad7c1118bd5f945c95e2024b258986bb6b8f78b5'),
('edwin-arnold-et:gita.18.23','edwin-arnold-et','gita.18.23',18,23,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3002–L3004','e7487aa0e999db212b7658294bbcbedf73352a237f872174b7479a5d067912e1','20784464eb319c372ec9331ecba8e45866a0635bdaf7ce185da2f4863d6d761b'),
('edwin-arnold-et:gita.18.24','edwin-arnold-et','gita.18.24',18,24,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3005–L3008','0601e777348a231cf771c3199c0020b57562dd47b777ee828e43f83db286148f','e70756836560a328e42b272da4a626cab1c2453ecad5dc964524fe1199fc9bc4'),
('edwin-arnold-et:gita.18.25','edwin-arnold-et','gita.18.25',18,25,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3009–L3013','4b75fdd3433615d53fac3199b6108c3d3348e7237f3fb9a1f29d8dac7c5abec4','c3e6194c00155d6ac05003d2d9cdcbd1f0eb896aba45a207f61a5af96a882934'),
('edwin-arnold-et:gita.18.26','edwin-arnold-et','gita.18.26',18,26,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3014–L3017','d42824015ebc40699547423bdc5fab566ca82410c5b698d0ea9ab2d50966d234','ce51a411da3bd477a59abab931661d019424737cc25f78283b1d27c31ced2ee2'),
('edwin-arnold-et:gita.18.27','edwin-arnold-et','gita.18.27',18,27,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3018–L3021','11a281d4d32d27d30c4ea08b32df09db42e62d2bf769b5713ef6ad2291b8a737','3593734b64b1b73807264e09dce6a711701584970fa09629f40a1e80d93fedbb'),
('edwin-arnold-et:gita.18.28','edwin-arnold-et','gita.18.28',18,28,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3022–L3025','afde604dd48df145fa8e98e7684eb9476ab028526cb636bf7b710ff4a959f4d3','cac13c9f3f4201f21690ae78c326afa013702fcbd01a19697baf9d0d83e8fb9a'),
('edwin-arnold-et:gita.18.29','edwin-arnold-et','gita.18.29',18,29,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3026–L3029','7952faaa50840dd1eebab42dd7cf4ecfdf07b59c569ae47850bbc886b81047ef','b8fcb0618aa8b37f6d2e100d347974749ac18abb2d5c54e3a4010ab02af8138f'),
('edwin-arnold-et:gita.18.30','edwin-arnold-et','gita.18.30',18,30,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3030–L3035','8ad53b6ec0154add10fb396fa990b6581617d6a24aaf2ae4b3e47eea4e69c009','bb6e15bdd8d684d1005a36312daa1085aca38cce6dabe4885972129e9e2cd4fc'),
('edwin-arnold-et:gita.18.31','edwin-arnold-et','gita.18.31',18,31,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3036–L3040','6840c6cf3a05c21030bfaf8aec4f6e776bff640c054e58f4c0a62f66e31b5477','4f8afa4be6b64255b98e6435d30fe984e712ef20aab2dafbffcf4616621aaeaf'),
('edwin-arnold-et:gita.18.32','edwin-arnold-et','gita.18.32',18,32,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3041–L3045','bfb2b5e814d924b1d59dcb238b21109448bf0bedb6b05c092ace55cf6d08ef4f','7975f3c5b87ca27f9552679beb7ad56515fdd3797083e78a09f2311e22820cb0'),
('edwin-arnold-et:gita.18.33','edwin-arnold-et','gita.18.33',18,33,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3046–L3050','3cf0441da78f219f39a6031ccbab50d7a98ce9e5a487d89d9f435d14a87041b2','50a99bc42565c5640dbaa715b8224e7e534e771fce8c99b321a5319d45583004'),
('edwin-arnold-et:gita.18.34','edwin-arnold-et','gita.18.34',18,34,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3051–L3054','deb7147bc79528138f2233baf7fe09b46ea91943ae2111aef680cccfe783fe01','eaccff299a0fe88a5ffaee2a1aa40882678dc05d9722f22da4fce594be7e5982'),
('edwin-arnold-et:gita.18.35','edwin-arnold-et','gita.18.35',18,35,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3055–L3060','c9a587941c137d6152fb1e169d7d54dfc7c86a6c25142a1fa80375a4d1ab8650','49d56f5fcd1d7682c440539b024d1109894acfdf6c10f7cab3c5b8f74ff1822f'),
('edwin-arnold-et:gita.18.36','edwin-arnold-et','gita.18.36',18,36,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3061–L3065','f38c9dab14bf5d3ebe03169334849d6dee255eaf1d6bd4402570947a0d2a9644','ce320b879545a633074e8f37ae9ad22430037934fc6f1fabcd6971a97b300f57'),
('edwin-arnold-et:gita.18.37','edwin-arnold-et','gita.18.37',18,37,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3065–L3068','bfd184f76ab9c25beede637c59056a5ab40c2214526b7df481b7c412d576f11a','14e35c1a6f0a93a4fb0fa4fc079abce3073a757c5893269888e874ac0d35b48f'),
('edwin-arnold-et:gita.18.38','edwin-arnold-et','gita.18.38',18,38,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3069–L3072','8f6b2ac188df9e3722fe1757d354eb855e76fb6195f219d999f9d465868da18c','4af343ceb0bcad9746a15a06eaf0a7f8d65415c9ea7043a59385e85a400d85b3'),
('edwin-arnold-et:gita.18.39','edwin-arnold-et','gita.18.39',18,39,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3073–L3077','8f6133a24a489cd3c9d357b834d457a0b316b1eefbf1dfa14c6f259823dd679c','a884a327dc14a9bdb45485160b1b55c9e27cdd7331e12b1ed3c30ec619b4a0cf'),
('edwin-arnold-et:gita.18.40','edwin-arnold-et','gita.18.40',18,40,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3078–L3081','861a744a182a96202180be7f6527c733bfd2526754072786eb73a4a715ab2807','156cd43eb1d3f9decab8dbf30ce77b7b9832d1333c9fac753b7a9dff2fed9d38'),
('edwin-arnold-et:gita.18.41','edwin-arnold-et','gita.18.41',18,41,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3082–L3086','86511ef7aaa4f83cc2d3c7a625e9e9d9afb9c7ea03d4b63cb80a22308c64583f','066076387cd78a00b3274c4e9b60dfb8c1193d9806cf1d99749a63b860582db4'),
('edwin-arnold-et:gita.18.42','edwin-arnold-et','gita.18.42',18,42,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3087–L3091','3ad1140028ddb9c5cc271ef76aee717c2fc18d1c6b04de785a773aede47b2a49','6aedbf6d15e6f6583aa30e4dd056073fd836891311a85be97dfb6059f61ed892'),
('edwin-arnold-et:gita.18.43','edwin-arnold-et','gita.18.43',18,43,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3091–L3095','8a1c471e14c38e7f50769708d2e6240be97ad9daf9b4071e84217564e871da82','9cafd6341bff22df4d60b8f2633a1235222e7a612fb607ab15307130343e56aa'),
('edwin-arnold-et:gita.18.44','edwin-arnold-et','gita.18.44',18,44,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3095–L3099','54cdb800ecd85a038ccb0257e8297439605d7fbc2e42d08319489fda51a74ae4','8957705ad73da658f019dbe268b7f073aba64c18ee17bc18485d01c573d900cf'),
('edwin-arnold-et:gita.18.45','edwin-arnold-et','gita.18.45',18,45,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3100–L3103','6776ca912f0f464f62188db9358222b1504f44427815de3d39c324f742634bfe','730c12cce3f1fcfa2c3561014499f4b3a0877d7a1654eff59820e4dff117ab9e'),
('edwin-arnold-et:gita.18.46','edwin-arnold-et','gita.18.46',18,46,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3104–L3107','1abc1540265465e8a7f366b7fd60b866c5db3239a411188c082f5c1046052720','77a8c266d651a7fdee0cf9414d8cc6b872a0eb2bb8b73c5e98b86b3981d98a3c'),
('edwin-arnold-et:gita.18.47','edwin-arnold-et','gita.18.47',18,47,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3108–L3111','28e79d0aeae5968669b9f8472f3b4b989d8f7b3953d64fe905ffa5edd6228a37','ca9f33dbfbe5b7c62b2457046316a56f75dd5ab66c805cdd89845247c25c2d7f'),
('edwin-arnold-et:gita.18.48','edwin-arnold-et','gita.18.48',18,48,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3111–L3114','5f8930183590932f4646b2c42f4202d797a78c4adbee4bd0ff9c6c502c0f017f','d43d4dca2eb68be8ef0ec6633f3594477ce8d72fb1ba09fead199f0432292f0d'),
('edwin-arnold-et:gita.18.49','edwin-arnold-et','gita.18.49',18,49,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3114–L3118','afbf855964974789d30f25ff7649fa597193bb30d8664cf323e29fb00774f8a4','f551ad5a0520f4bc5d02373dce0d18cbb1b7cf1923d90663e1d74fa0d82e11a9'),
('edwin-arnold-et:gita.18.50','edwin-arnold-et','gita.18.50',18,50,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3119–L3122','b9cb979742d990dd94f1173fd4989b5dbc75d74e420b359fed9d44efe36127a2','448a6cda52d1b07121b968cbde75cc21a434a1a67a4899c08b705f391c4f3847'),
('edwin-arnold-et:gita.18.51','edwin-arnold-et','gita.18.51',18,51,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3123–L3125','6b8c8a971ac86faadbb77047cc5cadb632d08ad51b5a4a44e1d6dadef82d802f','491e05cf02ea14b5a9413bacec472a5e724215944b08d7ae7a784f5d2b911249'),
('edwin-arnold-et:gita.18.52','edwin-arnold-et','gita.18.52',18,52,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3126–L3129','637eb8fcb97cc8f801cece7baee803f825add1804a20d08ca67f5b61e1b0751a','74e31ce273c37de3917982c6c70e100873b1b0c77d4e2ea07a453da737578040'),
('edwin-arnold-et:gita.18.53','edwin-arnold-et','gita.18.53',18,53,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3129–L3132','79da422ef95a3356c62e02cae71d6767aa7f6b4fbb9cb0b0a7032ca781f20880','43f7a40643c1d71548c6997d0539c315c99e7a6481bd282dca4f2e2ff1991e4b'),
('edwin-arnold-et:gita.18.54','edwin-arnold-et','gita.18.54',18,54,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3133–L3136','7c0a0088bc6e6ecabebe1d2836759bc229f5bc5f056150b62868989000e9aaab','821d25214442b63cb71b976f15828f5216d4829833a502be634fbdf73a9515b1'),
('edwin-arnold-et:gita.18.55','edwin-arnold-et','gita.18.55',18,55,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3137–L3139','2431c974217b7bef7dc527d45ec665226fdbf221414140dff53ec76ef0bc5a81','7c20381b95f3e18a9fb85a3fc4bf74cfa45860d9e15588b02457541692c86ac8'),
('edwin-arnold-et:gita.18.56','edwin-arnold-et','gita.18.56',18,56,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3140–L3143','4b158e24f1ba8afce3561ac557dc72c8f61286e42a2bc6c9bdde3e91b3851c5e','a699ca7b71d6a5bbf5ed5a6628e046b2fdcdbd16096b1351a72c9b97ef7a1d9b'),
('edwin-arnold-et:gita.18.57','edwin-arnold-et','gita.18.57',18,57,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3143–L3146','7965c5de0a073011d576c5d8468519ac21e597dde7b51ba25c0b4adffdde45f1','35bf0574a8b8e3a5dff6a9f5160fa3381dee5fbebc8ea6733373308722677813'),
('edwin-arnold-et:gita.18.58','edwin-arnold-et','gita.18.58',18,58,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3146–L3149','ae2c4262226e61c66d83568b00c4e0fa0b2a8d22d0eab07552b874c3e28700f9','37cafbb23ab98565dbf2f7cb480495b3f08cebba49352f99a6a906d25642d9e5'),
('edwin-arnold-et:gita.18.59','edwin-arnold-et','gita.18.59',18,59,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3149–L3152','f66bced5bcacdebca5547a2d91a5d0955edaff1d903a54aab9cc481b8788c1a6','ae7d5a0a01a21d26d3879eb7a414fd47b4040081e2b2f197f1895aeafa7c755a'),
('edwin-arnold-et:gita.18.60','edwin-arnold-et','gita.18.60',18,60,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3152–L3155','b9b1e5961a23d9f4c4fbb3556eacf0a52147c795764f5fd971e0508d2d548aec','ed4b7f909308676065ca35b7f298780af1c2aded427ab3f4013680e84f54a22f'),
('edwin-arnold-et:gita.18.61','edwin-arnold-et','gita.18.61',18,61,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3156–L3158','68801fa57f63d08b009aa63b02919a1110dfb4d3ea6898a8666301b9dd7b3d0d','9b2d9e4b0645fd3c361595b7b5eca99a9d5a0d3641ee23ba2044c8fa45938e7d'),
('edwin-arnold-et:gita.18.62','edwin-arnold-et','gita.18.62',18,62,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3158–L3163','ea28957e6fca543b3a36940291354404d692835dcf586b4b587c78dd5d13ec2a','ac529a873bd3efd8dd86f4b829d8236e73f47d79a6ddceff18eb9af64a8e05ed'),
('edwin-arnold-et:gita.18.63','edwin-arnold-et','gita.18.63',18,63,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3164–L3168','4719948d2db656fcbaa4a8c2221d589dd615706f0c417f74f61ca959acda9a2c','7bdf1cb0e0b302154a67ead96cff0f8255e90a4ab90998edd04a595bd0a21392'),
('edwin-arnold-et:gita.18.64','edwin-arnold-et','gita.18.64',18,64,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3169–L3172','571cc7c237803fc5b86917d51e644e6b81f1439fcab06923229d1fc202a0109d','dd6824f50f31cf743a6d37307376e8d76c02bf93b3c25002d8e43f268c5f9cf1'),
('edwin-arnold-et:gita.18.65','edwin-arnold-et','gita.18.65',18,65,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3173–L3177','ebcf3b4de512da27d0fea94d5425c691c8f8eb309c21e8d2a29072818cb30a38','e0888ab68491a4c09edd00f6d06abf815f6646032a89d9da3bd9051c7ffbabde'),
('edwin-arnold-et:gita.18.66','edwin-arnold-et','gita.18.66',18,66,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3178–L3182','70321458344a1b9606e48108d5783c22da15f2d0f2ad958a824405d3081199b3','980e60717d3e41034351a9dd86f13246ab91c158361d321f774f02fbd5832a4d'),
('edwin-arnold-et:gita.18.67','edwin-arnold-et','gita.18.67',18,67,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3183–L3187','cc78dc9f0f0f27712bddefc299fad56e72747daa7bd8e758c7c28d8c47a719a4','bbf3078512a319be8642403451cf5b34c6ca2a0ab45fd0df5429108cded61a01'),
('edwin-arnold-et:gita.18.68','edwin-arnold-et','gita.18.68',18,68,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3188–L3194','364d0d70fd8f1baf701b1c1c569fd420e1af17e8837202b3ae764dce6b9b0a7a','ab38277a9d649aacbf21cdc61279ed5c2fb74402a80012c5c4bef7c88369b744'),
('edwin-arnold-et:gita.18.69','edwin-arnold-et','gita.18.69',18,69,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3195–L3199','ca13e662339bbd6318cc7847aa89ceb34fdb1b68c6382365b1e717b86d5ea52c','e0a39ef4b4c0f66c20f840ecb3a71c7b455a0e8caedb5278bf59b9e0df58894b'),
('edwin-arnold-et:gita.18.70','edwin-arnold-et','gita.18.70',18,70,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3199–L3204','5d3068560c47bc0be2a99754143534664e3a8c43e706d39adb8052d1879dd6a7','3051cf4d71641ecd882fe75a7444d391219323856bea18b2d2d3c0734aac2d4a'),
('edwin-arnold-et:gita.18.71','edwin-arnold-et','gita.18.71',18,71,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3205–L3211','26919a4d58858f17291c0ced9e6dd2ebdb57174f649810e3ded718995166198c','f71d3d9682ff44a6aab6447b16c90de25f936dea024f179c560f29453696b6f1'),
('edwin-arnold-et:gita.18.72','edwin-arnold-et','gita.18.72',18,72,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3212–L3215','4a5b33db3eae9efbae80d504a79c27d50885dc90f49f61875b6ef976de7afdc8','b5fe1b9b4d7de4b31ee0819c866476c31dddccc6a04d18ac31ae905884b95475'),
('edwin-arnold-et:gita.18.73','edwin-arnold-et','gita.18.73',18,73,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3216–L3221','66c6ea9152ac390df4624e895938ac630b14f8906bc03ff50bff62908698b22f','93d190dd7ef5b9d687eec46ac06738c09c795f3a02269d0536804a7696f44823'),
('edwin-arnold-et:gita.18.74','edwin-arnold-et','gita.18.74',18,74,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3222–L3224','ffe2a570abbde44136e73bb2aa30a301a2476aa4320059b6a0032ed2eeb62996','8cfdb4cc4b6b254dc9cec48b2cc759fbffdf46165b839f1858876ab22939e821'),
('edwin-arnold-et:gita.18.75','edwin-arnold-et','gita.18.75',18,75,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3225–L3226','f857bcc5867bbde816d68e4ce401114ec2b8268774da86c0ce5b550b5233d22f','593d7ec9b50eb00cfa68f7550c12a1dd7543cfb2dc775d298958d955aaf539f5'),
('edwin-arnold-et:gita.18.76','edwin-arnold-et','gita.18.76',18,76,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3227–L3229','d71d799e16555f0a1cacede01729e2e1fa0640a2f9f54f34fa5a8922a65d4d04','e06594b4fb733377e83b589a0759249ae4258906d418b60c31e43ba603d6c557'),
('edwin-arnold-et:gita.18.77','edwin-arnold-et','gita.18.77',18,77,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3229–L3231','aacda881a09fabbe3641051aedf3894d51e12db2afd0ead4bee55205ff76c0be','c12e3d51500c1c1caeb805958d1aad711ac32107ff6601494c87a2a01a902634'),
('edwin-arnold-et:gita.18.78','edwin-arnold-et','gita.18.78',18,78,'passage-commentary','semantic-verse-alignment','first model review verified (google/gemini-3.8-flash); second review pending','pg2388.txt:L3231–L3235','871e429da5450ecc44c27a5179150421f20181d682c8334fd95f1f15cb74b5b0','d5ad1ff50f5c87425bd36c24cc455239c35769dda75f99eca7fa61bd789b7db4'),
('edwin-arnold-et:paratext:1:chapter-colophon','edwin-arnold-et',NULL,1,0,'chapter-colophon',NULL,'paratext-preserved','pg2388.txt:L322–L324','49e082d75fecfb3505f159f7d19baf5672ddac041f5cfc0253f9d5b8d6786951','7b323da0f89154165a406b354627722fa6472656bfeefd120e2a59f1b87764e1'),
('edwin-arnold-et:paratext:2:chapter-colophon','edwin-arnold-et',NULL,2,0,'chapter-colophon',NULL,'paratext-preserved','pg2388.txt:L625–L627','b97c1c7e54d6c4342f46c593759d2995eacba5e7a7255bcd3de83064af4a3043','2b244d326b797c893dcd1b6314c5abbd60669c51c2e5ecef9487cb816d03e822'),
('edwin-arnold-et:paratext:3:chapter-colophon','edwin-arnold-et',NULL,3,0,'chapter-colophon',NULL,'paratext-preserved','pg2388.txt:L788–L790','3f72b0c29979156e611d0f213bebe623fc8b8a718a53910b18cd6cbdf797c115','8ac54ed6616e7f047a00e88a16c25648b2f5b13844cbe39e781a5828f9969d63'),
('edwin-arnold-et:paratext:4:chapter-colophon','edwin-arnold-et',NULL,4,0,'chapter-colophon',NULL,'paratext-preserved','pg2388.txt:L957–L959','1730c4f75036359cc2c370eb77c7ef153b99a0b4da1cf2b10110655840b6e66b','2a8d588f567e8dc19be451fe5150c3bfffb8fb2ff6b6de19d07201f09ce3ef30'),
('edwin-arnold-et:paratext:5:chapter-colophon','edwin-arnold-et',NULL,5,0,'chapter-colophon',NULL,'paratext-preserved','pg2388.txt:L1076–L1078','8687b5acdd8d70e386ec07e8402e616d55108fd96aa2c7e2657ede7e220dbee1','a191cda6db2927c6770000944f10273da4d48b32f9752709de1e4ffecbf585cc'),
('edwin-arnold-et:paratext:6:chapter-colophon','edwin-arnold-et',NULL,6,0,'chapter-colophon',NULL,'paratext-preserved','pg2388.txt:L1263–L1265','847cbb267b937cef3aea6e648f4fcdb096536d304957a12c0dfc16178b28d27f','46ebc081d566bd1acc3a3fb132a9959d9902b448d3d22701837e82952f72ea56'),
('edwin-arnold-et:paratext:7:chapter-colophon','edwin-arnold-et',NULL,7,0,'chapter-colophon',NULL,'paratext-preserved','pg2388.txt:L1389–L1391','b42e613ac9c739c466153068bfedf2b4a40ea6b520f8361b5a5b38eef5c4c451','f87d8f27ca1fed5f13b2fc096e06be8fb1f9c9335dfb2a4c930f7b23d5015edb'),
('edwin-arnold-et:paratext:8:omission-marker','edwin-arnold-et',NULL,8,0,'omission-marker',NULL,'paratext-preserved','pg2388.txt:L1499–L1500','4428e2ce37578dac7b668a77c2648c30f9a7f0a5e4cd7a945509bde818380cdd','7abad1f2fcbc8afc4d008377de745abe273e18d23b55a1b059d3412c30659392'),
('edwin-arnold-et:paratext:8:chapter-colophon','edwin-arnold-et',NULL,8,0,'chapter-colophon',NULL,'paratext-preserved','pg2388.txt:L1506–L1508','0394924547c8267b20f4f49ece2fe238c5e015bcb97926656eb08007d680d16b','22f6450bf3e1833cafc452f063fcc2286f4a60d694bbbcaa8e83aa75512d02d5'),
('edwin-arnold-et:paratext:9:chapter-colophon','edwin-arnold-et',NULL,9,0,'chapter-colophon',NULL,'paratext-preserved','pg2388.txt:L1669–L1672','f4d23773134750d5afada18339831fa7799f5bb65030f3470a9fba4abda9dd7d','3f77acec897897568a09a2b44e1a87ea4f7fc38c30087702c9c6ca700754b4f4'),
('edwin-arnold-et:paratext:10:chapter-colophon','edwin-arnold-et',NULL,10,0,'chapter-colophon',NULL,'paratext-preserved','pg2388.txt:L1802–L1804','f238831263e0f5ccf90efd32327885b0c21e2a6ec6028b35aadce3377c959279','c0aebacbaf1aa73927f7a5ec35070c41face524ef35d485f004aa0e067c0a8c8'),
('edwin-arnold-et:paratext:11:chapter-colophon','edwin-arnold-et',NULL,11,0,'chapter-colophon',NULL,'paratext-preserved','pg2388.txt:L2218–L2220','fccd218d1112da68ecb46bc89797c474c1d7d2afdfefad8dea4ff4dd7f453690','7475c015719227519258c796af10a3db5d20369f575b9d0b4ec6666960770c51'),
('edwin-arnold-et:paratext:12:chapter-colophon','edwin-arnold-et',NULL,12,0,'chapter-colophon',NULL,'paratext-preserved','pg2388.txt:L2303–L2305','38a6ca7517f07850635463266e60dc6eba573b3f7113121886baf2ead72e23f4','7980bc74df54725d0f8906d730960af0e617c36c41d03e7e8c61ba9830bd1839'),
('edwin-arnold-et:paratext:13:recensional-prelude','edwin-arnold-et',NULL,13,0,'recensional-prelude',NULL,'paratext-preserved','pg2388.txt:L2313–L2317','f693fd24f99f6f3fa6c771b0c0864c280f8b3a5e50ec897d22cad463bf4f6358','76b6be4dd6904c06f45bbfe7a863c33c533bbf343b0502df60ceeb63093c73aa'),
('edwin-arnold-et:paratext:13:omission-marker','edwin-arnold-et',NULL,13,0,'omission-marker',NULL,'paratext-preserved','pg2388.txt:L2331–L2333','547a41279b2668f25d30c3a2869d31691cc85332771937fbff425e0f21019b30','0a5f343ba14d8bd39ebb7ce27a7434addf4882e61389620795a8c0ee0a87eed5'),
('edwin-arnold-et:paratext:13:chapter-colophon','edwin-arnold-et',NULL,13,0,'chapter-colophon',NULL,'paratext-preserved','pg2388.txt:L2454–L2456','546d0421abac28cf6be39024b7150822e69cfbad654d6d750b7dc31deecd87c2','feb3f4de16f711c002d47c9d3a2fb428d263fc504902d04388a4c8b0679258c3'),
('edwin-arnold-et:paratext:14:chapter-colophon','edwin-arnold-et',NULL,14,0,'chapter-colophon',NULL,'paratext-preserved','pg2388.txt:L2574–L2576','32fec2b909e45faaab1f548fc1e6fe296b1e300293aeb59657da436201ebc2e5','c3384ee4dd078d50dd0bb5ab6120f53cea9035ae8571ce1cd808122b8ab2f830'),
('edwin-arnold-et:paratext:15:chapter-colophon','edwin-arnold-et',NULL,15,0,'chapter-colophon',NULL,'paratext-preserved','pg2388.txt:L2687–L2689','57d6c2c1253d7a3dc2b58278f9e095ce3d1d231d02fb3de3f9a8d2f9011dd463','bcc192c0e1ac256ccf0be0b41a4d48c2a618ea781f5bb1d7fd35d925c61216ea'),
('edwin-arnold-et:paratext:16:omission-marker','edwin-arnold-et',NULL,16,0,'omission-marker',NULL,'paratext-preserved','pg2388.txt:L2792–L2793','768a66bd2b42d45d80dad3b4169b1df48261db7340ae12bf05bf8108e3f4d609','22b089ef25e66c2c238892cf92c282eb3275126da84e2772f413a9a227947326'),
('edwin-arnold-et:paratext:16:chapter-colophon','edwin-arnold-et',NULL,16,0,'chapter-colophon',NULL,'paratext-preserved','pg2388.txt:L2794–L2796','26d836484320d584b80732763621bb7b26f5fcd1a2ba7950a148ec931750c19e','27f80842e7b7ee0bbe6188b40ab22e09952d280ac2dd575d1176fad45b2bb0ea'),
('edwin-arnold-et:paratext:17:chapter-colophon','edwin-arnold-et',NULL,17,0,'chapter-colophon',NULL,'paratext-preserved','pg2388.txt:L2906–L2908','15db85e1840468c8820e75d60f4295b8bc6e38183ce698575d10a22d63bb8b30','4383f86f7cf22f3ba92ea04f3ef0da3c62299a8666dc57b41e41ca9ce47da552'),
('edwin-arnold-et:paratext:18:chapter-colophon','edwin-arnold-et',NULL,18,0,'chapter-colophon',NULL,'paratext-preserved','pg2388.txt:L3236–L3239','1569a77aa75d5a4a9653479cb343fe71119b365ac502b3ad1725aa8db8ebdc78','87d4bd9c2a57f5eefd4d4368e1c8133d27fc97d8d87d4cd1ebf4396ca5c1606f');
--> statement-breakpoint
INSERT INTO commentary_unit_chunks (unit_id,chunk_index,content) VALUES
('edwin-arnold-et:gita.1.1',0,'Dhritirashtra:
  Ranged thus for battle on the sacred plain--
  On Kurukshetra--say, Sanjaya! say
  What wrought my people, and the Pandavas?'),
('edwin-arnold-et:gita.1.2',0,'Sanjaya:
  When he beheld the host of Pandavas,
  Raja Duryodhana to Drona drew,
  And spake these words:'),
('edwin-arnold-et:gita.1.3',0,'"Ah, Guru! see this line,
  How vast it is of Pandu fighting-men,
  Embattled by the son of Drupada,
  Thy scholar in the war!'),
('edwin-arnold-et:gita.1.4',0,'Therein stand ranked
  Chiefs like Arjuna, like to Bhima chiefs,
  Benders of bows; Virata, Yuyudhan,
  Drupada, eminent upon his car,'),
('edwin-arnold-et:gita.1.5',0,'Dhrishtaket, Chekitan, Kasi''s stout lord,
  Purujit, Kuntibhoj, and Saivya,'),
('edwin-arnold-et:gita.1.6',0,'With Yudhamanyu, and Uttamauj
  Subhadra''s child; and Drupadi''s;-all famed!
  All mounted on their shining chariots!'),
('edwin-arnold-et:gita.1.7',0,'On our side, too,--thou best of Brahmans! see
  Excellent chiefs, commanders of my line,
  Whose names I joy to count:'),
('edwin-arnold-et:gita.1.8',0,'thyself the first,
  Then Bhishma, Karna, Kripa fierce in fight,
  Vikarna, Aswatthaman; next to these
  Strong Saumadatti,'),
('edwin-arnold-et:gita.1.9',0,'with full many more
  Valiant and tried, ready this day to die
  For me their king, each with his weapon grasped,
  Each skilful in the field.'),
('edwin-arnold-et:gita.1.10',0,'Weakest-meseems-
  Our battle shows where Bhishma holds command,
  And Bhima, fronting him, something too strong!'),
('edwin-arnold-et:gita.1.11',0,'Have care our captains nigh to Bhishma''s ranks
  Prepare what help they may! Now, blow my shell!"'),
('edwin-arnold-et:gita.1.12',0,'Then, at the signal of the aged king,
  With blare to wake the blood, rolling around
  Like to a lion''s roar, the trumpeter
  Blew the great Conch;'),
('edwin-arnold-et:gita.1.13',0,'and, at the noise of it,
  Trumpets and drums, cymbals and gongs and horns
  Burst into sudden clamour; as the blasts
  Of loosened tempest, such the tumult seemed!'),
('edwin-arnold-et:gita.1.14',0,'Then might be seen, upon their car of gold
  Yoked with white steeds, blowing their battle-shells,
  Krishna the God, Arjuna at his side:'),
('edwin-arnold-et:gita.1.15',0,'Krishna, with knotted locks, blew his great conch
  Carved of the "Giant''s bone;" Arjuna blew
  Indra''s loud gift; Bhima the terrible--
  Wolf-bellied Bhima-blew a long reed-conch;'),
('edwin-arnold-et:gita.1.16',0,'And Yudhisthira, Kunti''s blameless son,
  Winded a mighty shell, "Victory''s Voice;"
  And Nakula blew shrill upon his conch
  Named the "Sweet-sounding," Sahadev on his
  Called"Gem-bedecked,"'),
('edwin-arnold-et:gita.1.17',0,'and Kasi''s Prince on his.
  Sikhandi on his car, Dhrishtadyumn,
  Virata, Satyaki the Unsubdued,'),
('edwin-arnold-et:gita.1.18',0,'Drupada, with his sons, (O Lord of Earth!)
  Long-armed Subhadra''s children, all blew loud,'),
('edwin-arnold-et:gita.1.19',0,'So that the clangour shook their foemen''s hearts,
  With quaking earth and thundering heav''n.'),
('edwin-arnold-et:gita.1.20',0,'Then ''twas-
  Beholding Dhritirashtra''s battle set,
  Weapons unsheathing, bows drawn forth, the war
  Instant to break-Arjun, whose ensign-badge
  Was Hanuman the monkey, spake this thing
  To Krishna the Divine, his charioteer:'),
('edwin-arnold-et:gita.1.21',0,'"Drive, Dauntless One! to yonder open ground
  Betwixt the armies;'),
('edwin-arnold-et:gita.1.22',0,'I would see more nigh
  These who will fight with us, those we must slay
  To-day, in war''s arbitrament;'),
('edwin-arnold-et:gita.1.23',0,'for, sure,
  On bloodshed all are bent who throng this plain,
  Obeying Dhritirashtra''s sinful son."'),
('edwin-arnold-et:gita.1.24',0,'Thus, by Arjuna prayed, (O Bharata!)
  Between the hosts that heavenly Charioteer
  Drove the bright car, reining its milk-white steeds'),
('edwin-arnold-et:gita.1.25',0,'Where Bhishma led,and Drona,and their Lords.
  "See!" spake he to Arjuna, "where they stand,
  Thy kindred of the Kurus:"'),
('edwin-arnold-et:gita.1.26',0,'and the Prince
  Marked on each hand the kinsmen of his house,
  Grandsires and sires, uncles and brothers and sons,
  Cousins and sons-in-law and nephews, mixed
  With friends and honoured elders; some this side,
  Some that side ranged: and, seeing those opposed,
  Such kith grown enemies-Arjuna''s heart
  Melted with pity, while he uttered this:'),
('edwin-arnold-et:gita.1.27',0,'and the Prince
  Marked on each hand the kinsmen of his house,
  Grandsires and sires, uncles and brothers and sons,
  Cousins and sons-in-law and nephews, mixed
  With friends and honoured elders; some this side,
  Some that side ranged: and, seeing those opposed,
  Such kith grown enemies-Arjuna''s heart
  Melted with pity, while he uttered this:'),
('edwin-arnold-et:gita.1.28',0,'Arjuna.
  Krishna! as I behold, come here to shed
  Their common blood, yon concourse of our kin,'),
('edwin-arnold-et:gita.1.29',0,'My members fail, my tongue dries in my mouth,
  A shudder thrills my body, and my hair
  Bristles with horror;'),
('edwin-arnold-et:gita.1.30',0,'from my weak hand slips
  Gandiv, the goodly bow; a fever burns
  My skin to parching; hardly may I stand;
  The life within me seems to swim and faint;'),
('edwin-arnold-et:gita.1.31',0,'Nothing do I foresee save woe and wail!
  It is not good, O Keshav! nought of good
  Can spring from mutual slaughter!'),
('edwin-arnold-et:gita.1.32',0,'Lo, I hate
  Triumph and domination, wealth and ease,
  Thus sadly won! Aho! what victory
  Can bring delight, Govinda! what rich spoils
  Could profit; what rule recompense; what span
  Of life itself seem sweet, bought with such blood?'),
('edwin-arnold-et:gita.1.33',0,'Seeing that these stand here, ready to die,
  For whose sake life was fair, and pleasure pleased,
  And power grew precious:-'),
('edwin-arnold-et:gita.1.34',0,'grandsires, sires, and sons,
  Brothers, and fathers-in-law, and sons-in-law,
  Elders and friends!'),
('edwin-arnold-et:gita.1.35',0,'Shall I deal death on these
  Even though they seek to slay us? Not one blow,
  O Madhusudan! will I strike to gain

  The rule of all Three Worlds; then, how much less
  To seize an earthly kingdom!'),
('edwin-arnold-et:gita.1.36',0,'Killing these
  Must breed but anguish, Krishna! If they be
  Guilty, we shall grow guilty by their deaths;'),
('edwin-arnold-et:gita.1.37',0,'Their sins will light on us, if we shall slay
  Those sons of Dhritirashtra, and our kin;
  What peace could come of that, O Madhava?'),
('edwin-arnold-et:gita.1.38',0,'For if indeed, blinded by lust and wrath,
  These cannot see, or will not see, the sin
  Of kingly lines o''erthrown and kinsmen slain,'),
('edwin-arnold-et:gita.1.39',0,'How should not we, who see, shun such a crime--
  We who perceive the guilt and feel the shame--
  O thou Delight of Men, Janardana?'),
('edwin-arnold-et:gita.1.40',0,'By overthrow of houses perisheth
  Their sweet continuous household piety,
  And-rites neglected, piety extinct--
  Enters impiety upon that home;'),
('edwin-arnold-et:gita.1.41',0,'Its women grow unwomaned, whence there spring
  Mad passions, and the mingling-up of castes,'),
('edwin-arnold-et:gita.1.42',0,'Sending a Hell-ward road that family,
  And whoso wrought its doom by wicked wrath.
  Nay, and the souls of honoured ancestors
  Fall from their place of peace, being bereft
  Of funeral-cakes and the wan death-water.[FN#1]'),
('edwin-arnold-et:gita.1.43',0,''),
('edwin-arnold-et:gita.1.44',0,'So teach our holy hymns.'),
('edwin-arnold-et:gita.1.45',0,'Thus, if we slay
  Kinsfolk and friends for love of earthly power,
  Ahovat! what an evil fault it were!'),
('edwin-arnold-et:gita.1.46',0,'Better I deem it, if my kinsmen strike,
  To face them weaponless, and bare my breast
  To shaft and spear, than answer blow with blow.'),
('edwin-arnold-et:gita.1.47',0,'So speaking, in the face of those two hosts,
  Arjuna sank upon his chariot-seat,
  And let fall bow and arrows, sick at heart.'),
('edwin-arnold-et:gita.2.1',0,'Sanjaya.
  Him, filled with such compassion and such grief,
  With eyes tear-dimmed, despondent, in stern words
  The Driver, Madhusudan, thus addressed:'),
('edwin-arnold-et:gita.2.2',0,'Krishna.
  How hath this weakness taken thee? Whence springs
  The inglorious trouble, shameful to the brave,
  Barring the path of virtue?'),
('edwin-arnold-et:gita.2.3',0,'Nay, Arjun!
  Forbid thyself to feebleness! it mars
  Thy warrior-name! cast off the coward-fit!
  Wake! Be thyself! Arise, Scourge of thy Foes!'),
('edwin-arnold-et:gita.2.4',0,'Arjuna.
  How can I, in the battle, shoot with shafts
  On Bhishma, or on Drona-O thou Chief!--
  Both worshipful, both honourable men?'),
('edwin-arnold-et:gita.2.5',0,'Better to live on beggar''s bread
    With those we love alive,
  Than taste their blood in rich feasts spread,
    And guiltily survive!'),
('edwin-arnold-et:gita.2.6',0,'Ah! were it worse-who knows?--to be
    Victor or vanquished here,
  When those confront us angrily
    Whose death leaves living drear?'),
('edwin-arnold-et:gita.2.7',0,'In pity lost, by doubtings tossed,
    My thoughts-distracted-turn
  To Thee, the Guide I reverence most,
    That I may counsel learn:'),
('edwin-arnold-et:gita.2.8',0,'I know not what would heal the grief
    Burned into soul and sense,
  If I were earth''s unchallenged chief--
    A god--and these gone thence!'),
('edwin-arnold-et:gita.2.9',0,'Sanjaya.
  So spake Arjuna to the Lord of  Hearts,
  And sighing,"I will not fight!" held silence then.'),
('edwin-arnold-et:gita.2.10',0,'To whom, with tender smile, (O Bharata! )
  While the Prince wept despairing ''twixt those hosts,
  Krishna made answer in divinest verse:'),
('edwin-arnold-et:gita.2.11',0,'Krishna.
  Thou grievest where no grief should be! thou speak''st
  Words lacking wisdom! for the wise in heart
  Mourn not for those that live, nor those that die.'),
('edwin-arnold-et:gita.2.12',0,'Nor I, nor thou, nor any one of these,
  Ever was not, nor ever will not be,
  For ever and for ever afterwards.
  All, that doth live, lives always!'),
('edwin-arnold-et:gita.2.13',0,'To man''s frame
  As there come infancy and youth and age,
  So come there raisings-up and layings-down
  Of other and of other life-abodes,
  Which the wise know, and fear not.'),
('edwin-arnold-et:gita.2.14',0,'This that irks--
  Thy sense-life, thrilling to the elements--
  Bringing thee heat and cold, sorrows and joys,
  ''Tis brief and mutable! Bear with it, Prince!
  As the wise bear.'),
('edwin-arnold-et:gita.2.15',0,'The soul which is not moved,
  The soul that with a strong and constant calm
  Takes sorrow and takes joy indifferently,
  Lives in the life undying!'),
('edwin-arnold-et:gita.2.16',0,'That which is
  Can never cease to be; that which is not
  Will not exist. To see this truth of both
  Is theirs who part essence from accident,
  Substance from shadow.'),
('edwin-arnold-et:gita.2.17',0,'Indestructible,
  Learn thou! the Life is, spreading life through all;
  It cannot anywhere, by any means,
  Be anywise diminished, stayed, or changed.'),
('edwin-arnold-et:gita.2.18',0,'But for these fleeting frames which it informs
  With spirit deathless, endless, infinite,
  They perish. Let them perish, Prince! and fight!'),
('edwin-arnold-et:gita.2.19',0,'He who shall say, "Lo! I have slain a man!"
  He who shall think, "Lo! I am slain!" those both
  Know naught! Life cannot slay. Life is not slain!'),
('edwin-arnold-et:gita.2.20',0,'Never the spirit was born; the spirit shall cease to be never;
  Never was time it was not; End and Beginning are dreams!
  Birthless and deathless and changeless remaineth the spirit for ever;
  Death hath not touched it at all, dead though the house of it seems!'),
('edwin-arnold-et:gita.2.21',0,'Who knoweth it exhaustless, self-sustained,
  Immortal, indestructible,--shall such
  Say, "I have killed a man, or caused to kill?"'),
('edwin-arnold-et:gita.2.22',0,'Nay, but as when one layeth
    His worn-out robes away,
  And taking new ones, sayeth,
    "These will I wear to-day!"
  So putteth by the spirit
    Lightly its garb of flesh,
  And passeth to inherit
    A residence afresh.'),
('edwin-arnold-et:gita.2.23',0,'I say to thee weapons reach not the Life;
  Flame burns it not, waters cannot o''erwhelm,
  Nor dry winds wither it.'),
('edwin-arnold-et:gita.2.24',0,'Impenetrable,
  Unentered, unassailed, unharmed, untouched,
  Immortal, all-arriving, stable, sure,'),
('edwin-arnold-et:gita.2.25',0,'Invisible, ineffable, by word
  And thought uncompassed, ever all itself,
  Thus is the Soul declared! How wilt thou, then,--
  Knowing it so,--grieve when thou shouldst not grieve?'),
('edwin-arnold-et:gita.2.26',0,'How, if thou hearest that the man new-dead
  Is, like the man new-born, still living man--
  One same, existent Spirit--wilt thou weep?'),
('edwin-arnold-et:gita.2.27',0,'The end of birth is death; the end of death
  Is birth: this is ordained! and mournest thou,
  Chief of the stalwart arm! for what befalls
  Which could not otherwise befall?'),
('edwin-arnold-et:gita.2.28',0,'The birth
  Of living things comes unperceived; the death
  Comes unperceived; between them, beings perceive:
  What is there sorrowful herein, dear Prince?'),
('edwin-arnold-et:gita.2.29',0,'Wonderful, wistful, to contemplate!
    Difficult, doubtful, to speak upon!
  Strange and great for tongue to relate,
    Mystical hearing for every one!
  Nor wotteth man this, what a marvel it is,
    When seeing, and saying, and hearing are done!'),
('edwin-arnold-et:gita.2.30',0,'This Life within all living things, my Prince!
  Hides beyond harm; scorn thou to suffer, then,
  For that which cannot suffer.'),
('edwin-arnold-et:gita.2.31',0,'Do thy part!
  Be mindful of thy name, and tremble not!
  Nought better can betide a martial soul
  Than lawful war;'),
('edwin-arnold-et:gita.2.32',0,'happy the warrior
  To whom comes joy of battle--comes, as now,
  Glorious and fair, unsought; opening for him
  A gateway unto Heav''n.'),
('edwin-arnold-et:gita.2.33',0,'But, if thou shunn''st
  This honourable field--a Kshattriya--
  If, knowing thy duty and thy task, thou bidd''st
  Duty and task go by--that shall be sin!'),
('edwin-arnold-et:gita.2.34',0,'And those to come shall speak thee infamy
  From age to age; but infamy is worse
  For men of noble blood to bear than death!'),
('edwin-arnold-et:gita.2.35',0,'The chiefs upon their battle-chariots
  Will deem ''twas fear that drove thee from the fray.
  Of those who held thee mighty-souled the scorn
  Thou must abide,'),
('edwin-arnold-et:gita.2.36',0,'while all thine enemies
  Will scatter bitter speech of thee, to mock
  The valour which thou hadst; what fate could fall
  More grievously than this?'),
('edwin-arnold-et:gita.2.37',0,'Either--being killed--
  Thou wilt win Swarga''s safety, or--alive
  And victor--thou wilt reign an earthly king.
  Therefore, arise, thou Son of Kunti! brace
  Thine arm for conflict,'),
('edwin-arnold-et:gita.2.38',0,'nerve thy heart to meet--
  As things alike to thee--pleasure or pain,
  Profit or ruin, victory or defeat:
  So minded, gird thee to the fight, for so
  Thou shalt not sin!'),
('edwin-arnold-et:gita.2.39',0,'Thus far I speak to thee
  As from the "Sankhya"--unspiritually--
  Hear now the deeper teaching of the Yog,
  Which holding, understanding, thou shalt burst
  Thy Karmabandh, the bondage of wrought deeds.'),
('edwin-arnold-et:gita.2.40',0,'Here shall no end be hindered, no hope marred,
  No loss be feared: faith--yea, a little faith--
  Shall save thee from the anguish of thy dread.'),
('edwin-arnold-et:gita.2.41',0,'Here, Glory of the Kurus! shines one rule--
  One steadfast rule--while shifting souls have laws
  Many and hard.'),
('edwin-arnold-et:gita.2.42',0,'Specious, but wrongful deem
  The speech of those ill-taught ones who extol
  The letter of their Vedas, saying, "This
  Is all we have, or need;"'),
('edwin-arnold-et:gita.2.43',0,'being weak at heart
  With wants, seekers of Heaven: which comes--they say--
  As "fruit of good deeds done;" promising men
  Much profit in new births for works of faith;
  In various rites abounding; following whereon
  Large merit shall accrue towards wealth and power;'),
('edwin-arnold-et:gita.2.44',0,'Albeit, who wealth and power do most desire
  Least fixity of soul have such, least hold
  On heavenly meditation.'),
('edwin-arnold-et:gita.2.45',0,'Much these teach,
  From Veds, concerning the "three qualities;"
  But thou, be free of the "three qualities,"
  Free of the "pairs of opposites,"[FN#2] and free
  From that sad righteousness which calculates;
  Self-ruled, Arjuna! simple, satisfied![FN#3]'),
('edwin-arnold-et:gita.2.46',0,'Look! like as when a tank pours water forth
  To suit all needs, so do these Brahmans draw
  Text for all wants from tank of Holy Writ.'),
('edwin-arnold-et:gita.2.47',0,'But thou, want not! ask not! Find full reward
  Of doing right in right! Let right deeds be
  Thy motive, not the fruit which comes from them.
  And live in action! Labour!'),
('edwin-arnold-et:gita.2.48',0,'Make thine acts
  Thy piety, casting all self aside,
  Contemning gain and merit; equable
  In good or evil: equability
  Is Yog, is piety!'),
('edwin-arnold-et:gita.2.49',0,'Yet, the right act
  Is less, far less, than the right-thinking mind.
  Seek refuge in thy soul; have there thy heaven!
  Scorn them that follow virtue for her gifts!'),
('edwin-arnold-et:gita.2.50',0,'The mind of pure devotion--even here--
  Casts equally aside good deeds and bad,
  Passing above them. Unto pure devotion
  Devote thyself: with perfect meditation
  Comes perfect act,'),
('edwin-arnold-et:gita.2.51',0,'and the right-hearted rise--
  More certainly because they seek no gain--
  Forth from the bands of body, step by step,
  To highest seats of bliss.'),
('edwin-arnold-et:gita.2.52',0,'When thy firm soul
  Hath shaken off those tangled oracles
  Which ignorantly guide, then shall it soar
  To high neglect of what''s denied or said,
  This way or that way, in doctrinal writ.'),
('edwin-arnold-et:gita.2.53',0,'Troubled no longer by the priestly lore,
  Safe shall it live, and sure; steadfastly bent
  On meditation. This is Yog--and Peace!'),
('edwin-arnold-et:gita.2.54',0,'Arjuna.
  What is his mark who hath that steadfast heart,
  Confirmed in holy meditation? How
  Know we his speech, Kesava? Sits he, moves he
  Like other men?'),
('edwin-arnold-et:gita.2.55',0,'Krishna.
  When one, O Pritha''s Son!
  Abandoning desires which shake the mind--
  Finds in his soul full comfort for his soul,
  He hath attained the Yog--that man is such!'),
('edwin-arnold-et:gita.2.56',0,'In sorrows not dejected, and in joys
  Not overjoyed; dwelling outside the stress
  Of passion, fear, and anger; fixed in calms
  Of lofty contemplation;--such an one
  Is Muni, is the Sage, the true Recluse!'),
('edwin-arnold-et:gita.2.57',0,'He who to none and nowhere overbound
  By ties of flesh, takes evil things and good
  Neither desponding nor exulting, such
  Bears wisdom''s plainest mark!'),
('edwin-arnold-et:gita.2.58',0,'He who shall draw
  As the wise tortoise draws its four feet safe
  Under its shield, his five frail senses back
  Under the spirit''s buckler from the world
  Which else assails them, such an one, my Prince!
  Hath wisdom''s mark!'),
('edwin-arnold-et:gita.2.59',0,'Things that solicit sense
  Hold off from the self-governed; nay, it comes,
  The appetites of him who lives beyond
  Depart,--aroused no more.'),
('edwin-arnold-et:gita.2.60',0,'Yet may it chance,
  O Son of Kunti! that a governed mind
  Shall some time feel the sense-storms sweep, and wrest
  Strong self-control by the roots.'),
('edwin-arnold-et:gita.2.61',0,'Let him regain
  His kingdom! let him conquer this, and sit
  On Me intent. That man alone is wise
  Who keeps the mastery of himself!'),
('edwin-arnold-et:gita.2.62',0,'If one
  Ponders on objects of the sense, there springs
  Attraction; from attraction grows desire,
  Desire flames to fierce passion,'),
('edwin-arnold-et:gita.2.63',0,'passion breeds
  Recklessness; then the memory--all betrayed--
  Lets noble purpose go, and saps the mind,
  Till purpose, mind, and man are all undone.'),
('edwin-arnold-et:gita.2.64',0,'But, if one deals with objects of the sense
  Not loving and not hating, making them
  Serve his free soul, which rests serenely lord,
  Lo! such a man comes to tranquillity;'),
('edwin-arnold-et:gita.2.65',0,'And out of that tranquillity shall rise
  The end and healing of his earthly pains,
  Since the will governed sets the soul at peace.'),
('edwin-arnold-et:gita.2.66',0,'The soul of the ungoverned is not his,
  Nor hath he knowledge of himself; which lacked,
  How grows serenity? and, wanting that,
  Whence shall he hope for happiness?'),
('edwin-arnold-et:gita.2.67',0,'The mind
  That gives itself to follow shows of sense
  Seeth its helm of wisdom rent away,
  And, like a ship in waves of whirlwind, drives
  To wreck and death.'),
('edwin-arnold-et:gita.2.68',0,'Only with him, great Prince!
  Whose senses are not swayed by things of sense--
  Only with him who holds his mastery,
  Shows wisdom perfect.'),
('edwin-arnold-et:gita.2.69',0,'What is midnight-gloom
  To unenlightened souls shines wakeful day
  To his clear gaze; what seems as wakeful day
  Is known for night, thick night of ignorance,
  To his true-seeing eyes. Such is the Saint!'),
('edwin-arnold-et:gita.2.70',0,'And like the ocean, day by day receiving
      Floods from all lands, which never overflows
  Its boundary-line not leaping, and not leaving,
      Fed by the rivers, but unswelled by those;--

  So is the perfect one! to his soul''s ocean
      The world of sense pours streams of witchery;
  They leave him as they find, without commotion,
      Taking their tribute, but remaining sea.'),
('edwin-arnold-et:gita.2.71',0,'Yea! whoso, shaking off the yoke of flesh
  Lives lord, not servant, of his lusts; set free
  From pride, from passion, from the sin of "Self,"
  Toucheth tranquillity!'),
('edwin-arnold-et:gita.2.72',0,'O Pritha''s Son!
  That is the state of Brahm! There rests no dread
  When that last step is reached! Live where he will,
  Die when he may, such passeth from all ''plaining,
  To blest Nirvana, with the Gods, attaining.'),
('edwin-arnold-et:gita.3.1',0,'Arjuna.
  Thou whom all mortals praise, Janardana!
  If meditation be a nobler thing
  Than action, wherefore, then, great Kesava!
  Dost thou impel me to this dreadful fight?'),
('edwin-arnold-et:gita.3.2',0,'Now am I by thy doubtful speech disturbed!
  Tell me one thing, and tell me certainly;
  By what road shall I find the better end?'),
('edwin-arnold-et:gita.3.3',0,'Krishna.
  I told thee, blameless Lord! there be two paths
  Shown to this world; two schools of wisdom.

  First
  The Sankhya''s, which doth save in way of works
  Prescribed[FN#4] by reason; next, the Yog, which bids
  Attain by meditation, spiritually:
  Yet these are one!'),
('edwin-arnold-et:gita.3.4',0,'No man shall ''scape from act
  By shunning action; nay, and none shall come
  By mere renouncements unto perfectness.'),
('edwin-arnold-et:gita.3.5',0,'Nay, and no jot of time, at any time,
  Rests any actionless; his nature''s law
  Compels him, even unwilling, into act;
  [For thought is act in fancy].'),
('edwin-arnold-et:gita.3.6',0,'He who sits
  Suppressing all the instruments of flesh,
  Yet in his idle heart thinking on them,
  Plays the inept and guilty hypocrite:'),
('edwin-arnold-et:gita.3.7',0,'But he who, with strong body serving mind,
  Gives up his mortal powers to worthy work,
  Not seeking gain, Arjuna! such an one
  Is honourable.'),
('edwin-arnold-et:gita.3.8',0,'Do thine allotted task!
  Work is more excellent than idleness;
  The body''s life proceeds not, lacking work.'),
('edwin-arnold-et:gita.3.9',0,'There is a task of holiness to do,
  Unlike world-binding toil, which bindeth not
  The faithful soul; such earthly duty do
  Free from desire, and thou shalt well perform
  Thy heavenly purpose.'),
('edwin-arnold-et:gita.3.10',0,'Spake Prajapati--
  In the beginning, when all men were made,
  And, with mankind, the sacrifice-- "Do this!
  Work! sacrifice! Increase and multiply
  With sacrifice! This shall be Kamaduk,
  Your ''Cow of Plenty,'' giving back her milk
  Of all abundance.'),
('edwin-arnold-et:gita.3.11',0,'Worship the gods thereby;
  The gods shall yield thee grace.'),
('edwin-arnold-et:gita.3.12',0,'Those meats ye crave
  The gods will grant to Labour, when it pays
  Tithes in the altar-flame. But if one eats
  Fruits of the earth, rendering to kindly Heaven
  No gift of toil, that thief steals from his world."'),
('edwin-arnold-et:gita.3.13',0,'Who eat of food after their sacrifice
  Are quit of fault, but they that spread a feast
  All for themselves, eat sin and drink of sin.'),
('edwin-arnold-et:gita.3.14',0,'By food the living live; food comes of rain,
  And rain comes by the pious sacrifice,
  And sacrifice is paid with tithes of toil;'),
('edwin-arnold-et:gita.3.15',0,'Thus action is of Brahma, who is One,
  The Only, All-pervading; at all times
  Present in sacrifice.'),
('edwin-arnold-et:gita.3.16',0,'He that abstains
  To help the rolling wheels of this great world,
  Glutting his idle sense, lives a lost life,
  Shameful and vain.'),
('edwin-arnold-et:gita.3.17',0,'Existing for himself,
  Self-concentrated, serving self alone,
  No part hath he in aught;'),
('edwin-arnold-et:gita.3.18',0,'nothing achieved,
  Nought wrought or unwrought toucheth him; no hope
  Of help for all the living things of earth
  Depends from him.[FN#5]'),
('edwin-arnold-et:gita.3.19',0,'Therefore, thy task prescribed
  With spirit unattached gladly perform,
  Since in performance of plain duty man
  Mounts to his highest bliss.'),
('edwin-arnold-et:gita.3.20',0,'By works alone
  Janak and ancient saints reached blessedness!
  Moreover, for the upholding of thy kind,
  Action thou should''st embrace.'),
('edwin-arnold-et:gita.3.21',0,'What the wise choose
  The unwise people take; what best men do
  The multitude will follow.'),
('edwin-arnold-et:gita.3.22',0,'Look on me,
  Thou Son of Pritha! in the three wide worlds
  I am not bound to any toil, no height
  Awaits to scale, no gift remains to gain,
  Yet I act here!'),
('edwin-arnold-et:gita.3.23',0,'and, if I acted not--
  Earnest and watchful--those that look to me
  For guidance, sinking back to sloth again
  Because I slumbered, would decline from good,'),
('edwin-arnold-et:gita.3.24',0,'And I should break earth''s order and commit
  Her offspring unto ruin, Bharata!'),
('edwin-arnold-et:gita.3.25',0,'Even as the unknowing toil, wedded to sense,
  So let the enlightened toil, sense-freed, but set
  To bring the world deliverance, and its bliss;'),
('edwin-arnold-et:gita.3.26',0,'Not sowing in those simple, busy hearts
  Seed of despair. Yea! let each play his part
  In all he finds to do, with unyoked soul.'),
('edwin-arnold-et:gita.3.27',0,'All things are everywhere by Nature wrought
  In interaction of the qualities.
  The fool, cheated by self, thinks, "This I did"
  And "That I wrought; "'),
('edwin-arnold-et:gita.3.28',0,'but--ah, thou strong-armed Prince!--
  A better-lessoned mind, knowing the play
  Of visible things within the world of sense,
  And how the qualities must qualify,
  Standeth aloof even from his acts.'),
('edwin-arnold-et:gita.3.29',0,'Th'' untaught
  Live mixed with them, knowing not Nature''s way,
  Of highest aims unwitting, slow and dull.
  Those make thou not to stumble, having the light;'),
('edwin-arnold-et:gita.3.30',0,'But all thy dues discharging, for My sake,
  With meditation centred inwardly,
  Seeking no profit, satisfied, serene,
  Heedless of issue--fight!'),
('edwin-arnold-et:gita.3.31',0,'They who shall keep
  My ordinance thus, the wise and willing hearts,
  Have quittance from all issue of their acts;'),
('edwin-arnold-et:gita.3.32',0,'But those who disregard My ordinance,
  Thinking they know, know nought, and fall to loss,
  Confused and foolish.'),
('edwin-arnold-et:gita.3.33',0,'''Sooth, the instructed one
  Doth of his kind, following what fits him most:
  And lower creatures of their kind; in vain
  Contending ''gainst the law.'),
('edwin-arnold-et:gita.3.34',0,'Needs must it be
  The objects of the sense will stir the sense
  To like and dislike, yet th'' enlightened man
  Yields not to these, knowing them enemies.'),
('edwin-arnold-et:gita.3.35',0,'Finally, this is better, that one do
  His own task as he may, even though he fail,
  Than take tasks not his own, though they seem good.
  To die performing duty is no ill;
  But who seeks other roads shall wander still.'),
('edwin-arnold-et:gita.3.36',0,'Arjuna.
  Yet tell me, Teacher! by what force doth man
  Go to his ill, unwilling; as if one
  Pushed him that evil path?'),
('edwin-arnold-et:gita.3.37',0,'Krishna.
  Kama it is!
  Passion it is! born of the Darknesses,
  Which pusheth him. Mighty of appetite,
  Sinful, and strong is this!--man''s enemy!'),
('edwin-arnold-et:gita.3.38',0,'As smoke blots the white fire, as clinging rust
  Mars the bright mirror, as the womb surrounds
  The babe unborn, so is the world of things
  Foiled, soiled, enclosed in this desire of flesh.'),
('edwin-arnold-et:gita.3.39',0,'The wise fall, caught in it; the unresting foe
  It is of wisdom, wearing countless forms,
  Fair but deceitful, subtle as a flame.'),
('edwin-arnold-et:gita.3.40',0,'Sense, mind, and reason--these, O Kunti''s Son!
  Are booty for it; in its play with these
  It maddens man, beguiling, blinding him.'),
('edwin-arnold-et:gita.3.41',0,'Therefore, thou noblest child of Bharata!
  Govern thy heart! Constrain th'' entangled sense!
  Resist the false, soft sinfulness which saps
  Knowledge and judgment!'),
('edwin-arnold-et:gita.3.42',0,'Yea, the world is strong,
  But what discerns it stronger, and the mind
  Strongest; and high o''er all the ruling Soul.'),
('edwin-arnold-et:gita.3.43',0,'Wherefore, perceiving Him who reigns supreme,
  Put forth full force of Soul in thy own soul!
  Fight! vanquish foes and doubts, dear Hero! slay
  What haunts thee in fond shapes, and would betray!'),
('edwin-arnold-et:gita.4.1',0,'Krishna.
  This deathless Yoga, this deep union,
  I taught Vivaswata,[FN#6] the Lord of Light;
  Vivaswata to Manu gave it; he
  To Ikshwaku;'),
('edwin-arnold-et:gita.4.2',0,'so passed it down the line
  Of all my royal Rishis. Then, with years,
  The truth grew dim and perished, noble Prince!'),
('edwin-arnold-et:gita.4.3',0,'Now once again to thee it is declared--
  This ancient lore, this mystery supreme--
  Seeing I find thee votary and friend.'),
('edwin-arnold-et:gita.4.4',0,'Arjuna.
  Thy birth, dear Lord, was in these later days,
  And bright Vivaswata''s preceded time!
  How shall I comprehend this thing thou sayest,
  "From the beginning it was I who taught?"'),
('edwin-arnold-et:gita.4.5',0,'Krishna.
  Manifold the renewals of my birth
  Have been, Arjuna! and of thy births, too!
  But mine I know, and thine thou knowest not,
  O Slayer of thy Foes!'),
('edwin-arnold-et:gita.4.6',0,'Albeit I be
  Unborn, undying, indestructible,
  The Lord of all things living; not the less--
  By Maya, by my magic which I stamp
  On floating Nature-forms, the primal vast--
  I come, and go, and come.'),
('edwin-arnold-et:gita.4.7',0,'When Righteousness
  Declines, O Bharata! when Wickedness
  Is strong, I rise,'),
('edwin-arnold-et:gita.4.8',0,'from age to age, and take
  Visible shape, and move a man with men,
  Succouring the good, thrusting the evil back,
  And setting Virtue on her seat again.'),
('edwin-arnold-et:gita.4.9',0,'Who knows the truth touching my births on earth
  And my divine work, when he quits the flesh
  Puts on its load no more, falls no more down
  To earthly birth: to Me he comes, dear Prince!'),
('edwin-arnold-et:gita.4.10',0,'Many there be who come! from fear set free,
  From anger, from desire; keeping their hearts
  Fixed upon me--my Faithful--purified
  By sacred flame of Knowledge. Such as these
  Mix with my being.'),
('edwin-arnold-et:gita.4.11',0,'Whoso worship me,
  Them I exalt; but all men everywhere
  Shall fall into my path;'),
('edwin-arnold-et:gita.4.12',0,'albeit, those souls
  Which seek reward for works, make sacrifice
  Now, to the lower gods. I say to thee
  Here have they their reward.'),
('edwin-arnold-et:gita.4.13',0,'But I am He
  Made the Four Castes, and portioned them a place
  After their qualities and gifts. Yea, I
  Created, the Reposeful; I that live
  Immortally, made all those mortal births:'),
('edwin-arnold-et:gita.4.14',0,'For works soil not my essence, being works
  Wrought uninvolved.[FN#7] Who knows me acting thus
  Unchained by action, action binds not him;'),
('edwin-arnold-et:gita.4.15',0,'And, so perceiving, all those saints of old
  Worked, seeking for deliverance. Work thou
  As, in the days gone by, thy fathers did.'),
('edwin-arnold-et:gita.4.16',0,'Thou sayst, perplexed, It hath been asked before
  By singers and by sages, "What is act,
  And what inaction? "I will teach thee this,
  And, knowing, thou shalt learn which work doth save'),
('edwin-arnold-et:gita.4.17',0,'Needs must one rightly meditate those three--
  Doing,--not doing,--and undoing. Here
  Thorny and dark the path is!'),
('edwin-arnold-et:gita.4.18',0,'He who sees
  How action may be rest, rest action--he
  Is wisest ''mid his kind; he hath the truth!
  He doeth well, acting or resting.'),
('edwin-arnold-et:gita.4.19',0,'Freed
  In all his works from prickings of desire,
  Burned clean in act by the white fire of truth,
  The wise call that man wise;'),
('edwin-arnold-et:gita.4.20',0,'and such an one,
  Renouncing fruit of deeds, always content.
  Always self-satisfying, if he works,
  Doth nothing that shall stain his separate soul,'),
('edwin-arnold-et:gita.4.21',0,'Which--quit of fear and hope--subduing self--
  Rejecting outward impulse--yielding up
  To body''s need nothing save body, dwells
  Sinless amid all sin,'),
('edwin-arnold-et:gita.4.22',0,'with equal calm
  Taking what may befall, by grief unmoved,
  Unmoved by joy, unenvyingly; the same
  In good and evil fortunes; nowise bound
  By bond of deeds.'),
('edwin-arnold-et:gita.4.23',0,'Nay, but of such an one,
  Whose crave is gone, whose soul is liberate,
  Whose heart is set on truth--of such an one
  What work he does is work of sacrifice,
  Which passeth purely into ash and smoke
  Consumed upon the altar!'),
('edwin-arnold-et:gita.4.24',0,'All''s then God!
  The sacrifice is Brahm, the ghee and grain
  Are Brahm, the fire is Brahm, the flesh it eats
  Is Brahm, and unto Brahm attaineth he
  Who, in such office, meditates on Brahm.'),
('edwin-arnold-et:gita.4.25',0,'Some votaries there be who serve the gods
  With flesh and altar-smoke; but other some
  Who, lighting subtler fires, make purer rite
  With will of worship.'),
('edwin-arnold-et:gita.4.26',0,'Of the which be they
  Who, in white flame of continence, consume
  Joys of the sense, delights of eye and ear,
  Forgoing tender speech and sound of song:'),
('edwin-arnold-et:gita.4.27',0,'And they who, kindling fires with torch of Truth,
  Burn on a hidden altar-stone the bliss
  Of youth and love, renouncing happiness:'),
('edwin-arnold-et:gita.4.28',0,'And they who lay for offering there their wealth,
  Their penance, meditation, piety,
  Their steadfast reading of the scrolls, their lore
  Painfully gained with long austerities:'),
('edwin-arnold-et:gita.4.29',0,'And they who, making silent sacrifice,
  Draw in their breath to feed the flame of thought,
  And breathe it forth to waft the heart on high,
  Governing the ventage of each entering air
  Lest one sigh pass which helpeth not the soul:'),
('edwin-arnold-et:gita.4.30',0,'And they who, day by day denying needs,
  Lay life itself upon the altar-flame,
  Burning the body wan. Lo! all these keep
  The rite of offering, as if they slew
  Victims; and all thereby efface much sin.'),
('edwin-arnold-et:gita.4.31',0,'Yea! and who feed on the immortal food
  Left of such sacrifice, to Brahma pass,
  To The Unending. But for him that makes
  No sacrifice, he hath nor part nor lot
  Even in the present world. How should he share
  Another, O thou Glory of thy Line?'),
('edwin-arnold-et:gita.4.32',0,'In sight of Brahma all these offerings
  Are spread and are accepted! Comprehend
  That all proceed by act; for knowing this,
  Thou shalt be quit of doubt.'),
('edwin-arnold-et:gita.4.33',0,'The sacrifice
  Which Knowledge pays is better than great gifts
  Offered by wealth, since gifts'' worth--O my Prince!
  Lies in the mind which gives, the will that serves:'),
('edwin-arnold-et:gita.4.34',0,'And these are gained by reverence, by strong search,
  By humble heed of those who see the Truth
  And teach it.'),
('edwin-arnold-et:gita.4.35',0,'Knowing Truth, thy heart no more
  Will ache with error, for the Truth shall show
  All things subdued to thee, as thou to Me.'),
('edwin-arnold-et:gita.4.36',0,'Moreover, Son of Pandu! wert thou worst
  Of all wrong-doers, this fair ship of Truth
  Should bear thee safe and dry across the sea
  Of thy transgressions.'),
('edwin-arnold-et:gita.4.37',0,'As the kindled flame
  Feeds on the fuel till it sinks to ash,
  So unto ash, Arjuna! unto nought
  The flame of Knowledge wastes works'' dross away!'),
('edwin-arnold-et:gita.4.38',0,'There is no purifier like thereto
  In all this world, and he who seeketh it
  Shall find it--being grown perfect--in himself.'),
('edwin-arnold-et:gita.4.39',0,'Believing, he receives it when the soul
  Masters itself, and cleaves to Truth, and comes--
  Possessing knowledge--to the higher peace,
  The uttermost repose.'),
('edwin-arnold-et:gita.4.40',0,'But those untaught,
  And those without full faith, and those who fear
  Are shent; no peace is here or other where,
  No hope, nor happiness for whoso doubts.'),
('edwin-arnold-et:gita.4.41',0,'He that, being self-contained, hath vanquished doubt,
  Disparting self from service, soul from works,
  Enlightened and emancipate, my Prince!
  Works fetter him no more!'),
('edwin-arnold-et:gita.4.42',0,'Cut then atwain
  With sword of wisdom, Son of Bharata!
  This doubt that binds thy heart-beats! cleave the bond
  Born of thy ignorance! Be bold and wise!
  Give thyself to the field with me! Arise!'),
('edwin-arnold-et:gita.5.1',0,'Arjuna.
  Yet, Krishna! at the one time thou dost laud
  Surcease of works, and, at another time,
  Service through work. Of these twain plainly tell
  Which is the better way?'),
('edwin-arnold-et:gita.5.2',0,'Krishna.
  To cease from works
  Is well, and to do works in holiness
  Is well; and both conduct to bliss supreme;
  But of these twain the better way is his
  Who working piously refraineth not.'),
('edwin-arnold-et:gita.5.3',0,'That is the true Renouncer, firm and fixed,
  Who--seeking nought, rejecting nought--dwells proof
  Against the "opposites."[FN#8] O valiant Prince!
  In doing, such breaks lightly from all deed:'),
('edwin-arnold-et:gita.5.4',0,'''Tis the new scholar talks as they were two,
  This Sankhya and this Yoga: wise men know
  Who husbands one plucks golden fruit of both!'),
('edwin-arnold-et:gita.5.5',0,'The region of high rest which Sankhyans reach
  Yogins attain. Who sees these twain as one
  Sees with clear eyes!'),
('edwin-arnold-et:gita.5.6',0,'Yet such abstraction, Chief!
  Is hard to win without much holiness.
  Whoso is fixed in holiness, self-ruled,
  Pure-hearted, lord of senses and of self,
  Lost in the common life of all which lives--
  A "Yogayukt"--he is a Saint who wends
  Straightway to Brahm. Such an one is not touched
  By taint of deeds.'),
('edwin-arnold-et:gita.5.7',0,'Yet such abstraction, Chief!
  Is hard to win without much holiness.
  Whoso is fixed in holiness, self-ruled,
  Pure-hearted, lord of senses and of self,
  Lost in the common life of all which lives--
  A "Yogayukt"--he is a Saint who wends
  Straightway to Brahm. Such an one is not touched
  By taint of deeds.'),
('edwin-arnold-et:gita.5.8',0,'"Nought of myself I do!"
  Thus will he think-who holds the truth of truths--
  In seeing, hearing, touching, smelling; when
  He eats, or goes, or breathes; slumbers'),
('edwin-arnold-et:gita.5.9',0,'or talks,
  Holds fast or loosens, opes his eyes or shuts;
  Always assured "This is the sense-world plays
  With senses."'),
('edwin-arnold-et:gita.5.10',0,'He that acts in thought of Brahm,
  Detaching end from act, with act content,
  The world of sense can no more stain his soul
  Than waters mar th'' enamelled lotus-leaf.'),
('edwin-arnold-et:gita.5.11',0,'With life, with heart, with mind,-nay, with the help
  Of all five senses--letting selfhood go--
  Yogins toil ever towards their souls'' release.'),
('edwin-arnold-et:gita.5.12',0,'Such votaries, renouncing fruit of deeds,
  Gain endless peace: the unvowed, the passion-bound,
  Seeking a fruit from works, are fastened down.'),
('edwin-arnold-et:gita.5.13',0,'The embodied sage, withdrawn within his soul,
  At every act sits godlike in "the town
  Which hath nine gateways,"[FN#9] neither doing aught
  Nor causing any deed.'),
('edwin-arnold-et:gita.5.14',0,'This world''s Lord makes
  Neither the work, nor passion for the work,
  Nor lust for fruit of work; the man''s own self
  Pushes to these!'),
('edwin-arnold-et:gita.5.15',0,'The Master of this World
  Takes on himself the good or evil deeds
  Of no man--dwelling beyond! Mankind errs here
  By folly, darkening knowledge.'),
('edwin-arnold-et:gita.5.16',0,'But, for whom
  That darkness of the soul is chased by light,
  Splendid and clear shines manifest the Truth
  As if a Sun of Wisdom sprang to shed
  Its beams of dawn.'),
('edwin-arnold-et:gita.5.17',0,'Him meditating still,
  Him seeking, with Him blended, stayed on Him,
  The souls illuminated take that road
  Which hath no turning back--their sins flung off
  By strength of faith. [Who will may have this Light;
  Who hath it sees.]'),
('edwin-arnold-et:gita.5.18',0,'To him who wisely sees,
  The Brahman with his scrolls and sanctities,
  The cow, the elephant, the unclean dog,
  The Outcast gorging dog''s meat, are all one.'),
('edwin-arnold-et:gita.5.19',0,'The world is overcome--aye! even here!
  By such as fix their faith on Unity.
  The sinless Brahma dwells in Unity,
  And they in Brahma.'),
('edwin-arnold-et:gita.5.20',0,'Be not over-glad
  Attaining joy, and be not over-sad
  Encountering grief, but, stayed on Brahma, still
  Constant let each abide!'),
('edwin-arnold-et:gita.5.21',0,'The sage whose soul
  Holds off from outer contacts, in himself
  Finds bliss; to Brahma joined by piety,
  His spirit tastes eternal peace.'),
('edwin-arnold-et:gita.5.22',0,'The joys
  Springing from sense-life are but quickening wombs
  Which breed sure griefs: those joys begin and end!
  The wise mind takes no pleasure, Kunti''s Son!
  In such as those!'),
('edwin-arnold-et:gita.5.23',0,'But if a man shall learn,
  Even while he lives and bears his body''s chain,
  To master lust and anger, he is blest!'),
('edwin-arnold-et:gita.5.24',0,'He is the Yukta; he hath happiness,
  Contentment, light, within: his life is merged
  In Brahma''s life; he doth Nirvana touch!'),
('edwin-arnold-et:gita.5.25',0,'Thus go the Rishis unto rest, who dwell
  With sins effaced, with doubts at end, with hearts
  Governed and calm. Glad in all good they live,
  Nigh to the peace of God;'),
('edwin-arnold-et:gita.5.26',0,'and all those live
  Who pass their days exempt from greed and wrath,
  Subduing self and senses, knowing the Soul!'),
('edwin-arnold-et:gita.5.27',0,'The Saint who shuts outside his placid soul
  All touch of sense, letting no contact through;
  Whose quiet eyes gaze straight from fixed brows,
  Whose outward breath and inward breath are drawn
  Equal and slow through nostrils still and close;'),
('edwin-arnold-et:gita.5.28',0,'That one-with organs, heart, and mind constrained,
  Bent on deliverance, having put away
  Passion, and fear, and rage;--hath, even now,
  Obtained deliverance, ever and ever freed.'),
('edwin-arnold-et:gita.5.29',0,'Yea! for he knows Me Who am He that heeds
  The sacrifice and worship, God revealed;
  And He who heeds not, being Lord of Worlds,
  Lover of all that lives, God unrevealed,
  Wherein who will shall find surety and shield!'),
('edwin-arnold-et:gita.6.1',0,'Krishna.
  Therefore, who doeth work rightful to do,
  Not seeking gain from work, that man, O Prince!
  Is Sanyasi and Yogi--both in one
  And he is neither who lights not the flame
  Of sacrifice, nor setteth hand to task.'),
('edwin-arnold-et:gita.6.2',0,'Regard as true Renouncer him that makes
  Worship by work, for who renounceth not
  Works not as Yogin.'),
('edwin-arnold-et:gita.6.3',0,'So is that well said:
  "By works the votary doth rise to faith,
  And saintship is the ceasing from all works;'),
('edwin-arnold-et:gita.6.4',0,'Because the perfect Yogin acts--but acts
  Unmoved by passions and unbound by deeds,
  Setting result aside.'),
('edwin-arnold-et:gita.6.5',0,'Let each man raise
  The Self by Soul, not trample down his Self,
  Since Soul that is Self''s friend may grow Self''s foe.'),
('edwin-arnold-et:gita.6.6',0,'Soul is Self''s friend when Self doth rule o''er Self,
  But Self turns enemy if Soul''s own self
  Hates Self as not itself.[FN#10]'),
('edwin-arnold-et:gita.6.7',0,'The sovereign soul
  Of him who lives self-governed and at peace
  Is centred in itself, taking alike
  Pleasure and pain; heat, cold; glory and shame.'),
('edwin-arnold-et:gita.6.8',0,'He is the Yogi, he is Yukta, glad
  With joy of light and truth; dwelling apart
  Upon a peak, with senses subjugate
  Whereto the clod, the rock, the glistering gold
  Show all as one.'),
('edwin-arnold-et:gita.6.9',0,'By this sign is he known
  Being of equal grace to comrades, friends,
  Chance-comers, strangers, lovers, enemies,
  Aliens and kinsmen; loving all alike,
  Evil or good.'),
('edwin-arnold-et:gita.6.10',0,'Sequestered should he sit,
  Steadfastly meditating, solitary,
  His thoughts controlled, his passions laid away,
  Quit of belongings.'),
('edwin-arnold-et:gita.6.11',0,'In a fair, still spot
  Having his fixed abode,--not too much raised,
  Nor yet too low,--let him abide, his goods
  A cloth, a deerskin, and the Kusa-grass.'),
('edwin-arnold-et:gita.6.12',0,'There, setting hard his mind upon The One,
  Restraining heart and senses, silent, calm,
  Let him accomplish Yoga, and achieve
  Pureness of soul,'),
('edwin-arnold-et:gita.6.13',0,'holding immovable
  Body and neck and head, his gaze absorbed
  Upon his nose-end,[FN#11] rapt from all around,'),
('edwin-arnold-et:gita.6.14',0,'Tranquil in spirit, free of fear, intent
  Upon his Brahmacharya vow, devout,
  Musing on Me, lost in the thought of Me.'),
('edwin-arnold-et:gita.6.15',0,'That Yojin, so devoted, so controlled,
  Comes to the peace beyond,--My peace, the peace
  Of high Nirvana!'),
('edwin-arnold-et:gita.6.16',0,'But for earthly needs
  Religion is not his who too much fasts
  Or too much feasts, nor his who sleeps away
  An idle mind; nor his who wears to waste
  His strength in vigils.'),
('edwin-arnold-et:gita.6.17',0,'Nay, Arjuna! call
  That the true piety which most removes
  Earth-aches and ills, where one is moderate
  In eating and in resting, and in sport;
  Measured in wish and act; sleeping betimes,
  Waking betimes for duty.'),
('edwin-arnold-et:gita.6.18',0,'When the man,
  So living, centres on his soul the thought
  Straitly restrained--untouched internally
  By stress of sense--then is he Yukta.'),
('edwin-arnold-et:gita.6.19',0,'See!
  Steadfast a lamp burns sheltered from the wind;
  Such is the likeness of the Yogi''s mind
  Shut from sense-storms and burning bright to Heaven.'),
('edwin-arnold-et:gita.6.20',0,'When mind broods placid, soothed with holy wont;
  When Self contemplates self, and in itself
  Hath comfort;'),
('edwin-arnold-et:gita.6.21',0,'when it knows the nameless joy
  Beyond all scope of sense, revealed to soul--
  Only to soul! and, knowing, wavers not,
  True to the farther Truth;'),
('edwin-arnold-et:gita.6.22',0,'when, holding this,
  It deems no other treasure comparable,
  But, harboured there, cannot be stirred or shook
  By any gravest grief,'),
('edwin-arnold-et:gita.6.23',0,'call that state "peace,"
  That happy severance Yoga; call that man
  The perfect Yogin!

  Steadfastly the will
  Must toil thereto, till efforts end in ease,
  And thought has passed from thinking.'),
('edwin-arnold-et:gita.6.24',0,'Shaking off
  All longings bred by dreams of fame and gain,
  Shutting the doorways of the senses close
  With watchful ward;'),
('edwin-arnold-et:gita.6.25',0,'so, step by step, it comes
  To gift of peace assured and heart assuaged,
  When the mind dwells self-wrapped, and the soul broods
  Cumberless.'),
('edwin-arnold-et:gita.6.26',0,'But, as often as the heart
  Breaks--wild and wavering--from control, so oft
  Let him re-curb it, let him rein it back
  To the soul''s governance;'),
('edwin-arnold-et:gita.6.27',0,'for perfect bliss
  Grows only in the bosom tranquillised,
  The spirit passionless, purged from offence,
  Vowed to the Infinite.'),
('edwin-arnold-et:gita.6.28',0,'He who thus vows
  His soul to the Supreme Soul, quitting sin,
  Passes unhindered to the endless bliss
  Of unity with Brahma.'),
('edwin-arnold-et:gita.6.29',0,'He so vowed,
  So blended, sees the Life-Soul resident
  In all things living, and all living things
  In that Life-Soul contained.'),
('edwin-arnold-et:gita.6.30',0,'And whoso thus
  Discerneth Me in all, and all in Me,
  I never let him go; nor looseneth he
  Hold upon Me;'),
('edwin-arnold-et:gita.6.31',0,'but, dwell he where he may,
  Whate''er his life, in Me he dwells and lives,
  Because he knows and worships Me, Who dwell
  In all which lives, and cleaves to Me in all.'),
('edwin-arnold-et:gita.6.32',0,'Arjuna! if a man sees everywhere--
  Taught by his own similitude--one Life,
  One Essence in the Evil and the Good,
  Hold him a Yogi, yea! well-perfected!'),
('edwin-arnold-et:gita.6.33',0,'Arjuna.
  Slayer of Madhu! yet again, this Yog,
  This Peace, derived from equanimity,
  Made known by thee--I see no fixity
  Therein, no rest,'),
('edwin-arnold-et:gita.6.34',0,'because the heart of men
  Is unfixed, Krishna! rash, tumultuous,
  Wilful and strong. It were all one, I think,
  To hold the wayward wind, as tame man''s heart.'),
('edwin-arnold-et:gita.6.35',0,'Krishna.
  Hero long-armed! beyond denial, hard
  Man''s heart is to restrain, and wavering;
  Yet may it grow restrained by habit, Prince!
  By wont of self-command.'),
('edwin-arnold-et:gita.6.36',0,'This Yog, I say,
  Cometh not lightly to th'' ungoverned ones;
  But he who will be master of himself
  Shall win it, if he stoutly strive thereto.'),
('edwin-arnold-et:gita.6.37',0,'Arjuna.
  And what road goeth he who, having faith,
  Fails, Krishna! in the striving; falling back
  From holiness, missing the perfect rule?'),
('edwin-arnold-et:gita.6.38',0,'Is he not lost, straying from Brahma''s light,
  Like the vain cloud, which floats ''twixt earth and heaven
  When lightning splits it, and it vanisheth?'),
('edwin-arnold-et:gita.6.39',0,'Fain would I hear thee answer me herein,
  Since, Krishna! none save thou can clear the doubt.'),
('edwin-arnold-et:gita.6.40',0,'Krishna.
  He is not lost, thou Son of Pritha! No!
  Nor earth, nor heaven is forfeit, even for him,
  Because no heart that holds one right desire
  Treadeth the road of loss!'),
('edwin-arnold-et:gita.6.41',0,'He who should fail,
  Desiring righteousness, cometh at death
  Unto the Region of the Just; dwells there
  Measureless years, and being born anew,
  Beginneth life again in some fair home
  Amid the mild and happy.'),
('edwin-arnold-et:gita.6.42',0,'It may chance
  He doth descend into a Yogin house
  On Virtue''s breast; but that is rare! Such birth
  Is hard to be obtained on this earth, Chief!'),
('edwin-arnold-et:gita.6.43',0,'So hath he back again what heights of heart
  He did achieve, and so he strives anew
  To perfectness, with better hope, dear Prince!'),
('edwin-arnold-et:gita.6.44',0,'For by the old desire he is drawn on
  Unwittingly; and only to desire
  The purity of Yog is to pass
  Beyond the Sabdabrahm, the spoken Ved.'),
('edwin-arnold-et:gita.6.45',0,'But, being Yogi, striving strong and long,
  Purged from transgressions, perfected by births
  Following on births, he plants his feet at last
  Upon the farther path.'),
('edwin-arnold-et:gita.6.46',0,'Such as one ranks
  Above ascetics, higher than the wise,
  Beyond achievers of vast deeds! Be thou
  Yogi Arjuna!'),
('edwin-arnold-et:gita.6.47',0,'And of such believe,
  Truest and best is he who worships Me
  With inmost soul, stayed on My Mystery!'),
('edwin-arnold-et:gita.7.1',0,'Krishna.
  Learn now, dear Prince! how, if thy soul be set
  Ever on Me--still exercising Yog,
  Still making Me thy Refuge--thou shalt come
  Most surely unto perfect hold of Me.'),
('edwin-arnold-et:gita.7.2',0,'I will declare to thee that utmost lore,
  Whole and particular, which, when thou knowest,
  Leaveth no more to know here in this world.'),
('edwin-arnold-et:gita.7.3',0,'Of many thousand mortals, one, perchance,
  Striveth for Truth; and of those few that strive--
  Nay, and rise high--one only--here and there--
  Knoweth Me, as I am, the very Truth.'),
('edwin-arnold-et:gita.7.4',0,'Earth, water, flame, air, ether, life, and mind,
  And individuality--those eight
  Make up the showing of Me, Manifest.'),
('edwin-arnold-et:gita.7.5',0,'These be my lower Nature; learn the higher,
  Whereby, thou Valiant One! this Universe
  Is, by its principle of life, produced;'),
('edwin-arnold-et:gita.7.6',0,'Whereby the worlds of visible things are born
  As from a Yoni. Know! I am that womb:
  I make and I unmake this Universe:'),
('edwin-arnold-et:gita.7.7',0,'Than me there is no other Master, Prince!
  No other Maker! All these hang on me
  As hangs a row of pearls upon its string.'),
('edwin-arnold-et:gita.7.8',0,'I am the fresh taste of the water; I
  The silver of the moon, the gold o'' the sun,
  The word of worship in the Veds, the thrill
  That passeth in the ether, and the strength
  Of man''s shed seed.'),
('edwin-arnold-et:gita.7.9',0,'I am the good sweet smell
  Of the moistened earth, I am the fire''s red light,
  The vital air moving in all which moves,
  The holiness of hallowed souls,'),
('edwin-arnold-et:gita.7.10',0,'the root
  Undying, whence hath sprung whatever is;
  The wisdom of the wise, the intellect
  Of the informed, the greatness of the great.
  The splendour of the splendid.'),
('edwin-arnold-et:gita.7.11',0,'Kunti''s Son!
  These am I, free from passion and desire;
  Yet am I right desire in all who yearn,
  Chief of the Bharatas!'),
('edwin-arnold-et:gita.7.12',0,'for all those moods,
  Soothfast, or passionate, or ignorant,
  Which Nature frames, deduce from me; but all
  Are merged in me--not I in them!'),
('edwin-arnold-et:gita.7.13',0,'The world--
  Deceived by those three qualities of being--
  Wotteth not Me Who am outside them all,
  Above them all, Eternal!'),
('edwin-arnold-et:gita.7.14',0,'Hard it is
  To pierce that veil divine of various shows
  Which hideth Me; yet they who worship Me
  Pierce it and pass beyond.'),
('edwin-arnold-et:gita.7.15',0,'I am not known
  To evil-doers, nor to foolish ones,
  Nor to the base and churlish; nor to those
  Whose mind is cheated by the show of things,
  Nor those that take the way of Asuras.[FN#12]'),
('edwin-arnold-et:gita.7.16',0,'Four sorts of mortals know me: he who weeps,
  Arjuna! and the man who yearns to know;
  And he who toils to help; and he who sits
  Certain of me, enlightened.'),
('edwin-arnold-et:gita.7.17',0,'Of these four,
  O Prince of India! highest, nearest, best
  That last is, the devout soul, wise, intent
  Upon "The One." Dear, above all, am I
  To him; and he is dearest unto me!'),
('edwin-arnold-et:gita.7.18',0,'All four are good, and seek me; but mine own,
  The true of heart, the faithful--stayed on me,
  Taking me as their utmost blessedness,
  They are not "mine,"but I--even I myself!'),
('edwin-arnold-et:gita.7.19',0,'At end of many births to Me they come!
  Yet hard the wise Mahatma is to find,
  That man who sayeth, "All is Vasudev!"[FN#13]'),
('edwin-arnold-et:gita.7.20',0,'There be those, too, whose knowledge, turned aside
  By this desire or that, gives them to serve
  Some lower gods, with various rites, constrained
  By that which mouldeth them.'),
('edwin-arnold-et:gita.7.21',0,'Unto all such--
  Worship what shrine they will, what shapes, in faith--
  ''Tis I who give them faith! I am content!'),
('edwin-arnold-et:gita.7.22',0,'The heart thus asking favour from its God,
  Darkened but ardent, hath the end it craves,
  The lesser blessing--but ''tis I who give!'),
('edwin-arnold-et:gita.7.23',0,'Yet soon is withered what small fruit they reap:
  Those men of little minds, who worship so,
  Go where they worship, passing with their gods.
  But Mine come unto me!'),
('edwin-arnold-et:gita.7.24',0,'Blind are the eyes
  Which deem th'' Unmanifested manifest,
  Not comprehending Me in my true Self!'),
('edwin-arnold-et:gita.7.25',0,'Imperishable, viewless, undeclared,
  Hidden behind my magic veil of shows,
  I am not seen by all; I am not known--
  Unborn and changeless--to the idle world.'),
('edwin-arnold-et:gita.7.26',0,'But I, Arjuna! know all things which were,
  And all which are, and all which are to be,
  Albeit not one among them knoweth Me!'),
('edwin-arnold-et:gita.7.27',0,'By passion for the "pairs of opposites,"
  By those twain snares of Like and Dislike, Prince!
  All creatures live bewildered,'),
('edwin-arnold-et:gita.7.28',0,'save some few
  Who, quit of sins, holy in act, informed,
  Freed from the "opposites,"and fixed in faith,
  Cleave unto Me.'),
('edwin-arnold-et:gita.7.29',0,'Who cleave, who seek in Me
  Refuge from birth[FN#14] and death, those have the Truth!
  Those know Me BRAHMA; know Me Soul of Souls,
  The ADHYATMAN; know KARMA, my work;'),
('edwin-arnold-et:gita.7.30',0,'Know I am ADHIBHUTA, Lord of Life,
  And ADHIDAIVA, Lord of all the Gods,
  And ADHIYAJNA, Lord of Sacrifice;
  Worship Me well, with hearts of love and faith,
  And find and hold me in the hour of death.'),
('edwin-arnold-et:gita.8.1',0,'Arjuna.
  Who is that BRAHMA? What that Soul of Souls,
  The ADHYATMAN? What, Thou Best of All!
  Thy work, the KARMA? Tell me what it is
  Thou namest ADHIBHUTA? What again
  Means ADHIDAIVA?'),
('edwin-arnold-et:gita.8.2',0,'Yea, and how it comes
  Thou canst be ADHIYAJNA in thy flesh?
  Slayer of Madhu! Further, make me know
  How good men find thee in the hour of death?'),
('edwin-arnold-et:gita.8.3',0,'Krishna.
  I BRAHMA am! the One Eternal GOD,
  And ADHYATMAN is My Being''s name,
  The Soul of Souls! What goeth forth from Me,
  Causing all life to live, is KARMA called:'),
('edwin-arnold-et:gita.8.4',0,'And, Manifested in divided forms,
  I am the ADHIBHUTA, Lord of Lives;
  And ADHIDAIVA, Lord of all the Gods,
  Because I am PURUSHA, who begets.
  And ADHIYAJNA, Lord of Sacrifice,
  I--speaking with thee in this body here--
  Am, thou embodied one! (for all the shrines
  Flame unto Me!)'),
('edwin-arnold-et:gita.8.5',0,'And, at the hour of death,
  He that hath meditated Me alone,
  In putting off his flesh, comes forth to Me,
  Enters into My Being--doubt thou not!'),
('edwin-arnold-et:gita.8.6',0,'But, if he meditated otherwise
  At hour of death, in putting off the flesh,
  He goes to what he looked for, Kunti''s Son!
  Because the Soul is fashioned to its like.'),
('edwin-arnold-et:gita.8.7',0,'Have Me, then, in thy heart always! and fight!
  Thou too, when heart and mind are fixed on Me,
  Shalt surely come to Me!'),
('edwin-arnold-et:gita.8.8',0,'All come who cleave
  With never-wavering will of firmest faith,
  Owning none other Gods: all come to Me,
  The Uttermost, Purusha, Holiest!'),
('edwin-arnold-et:gita.8.9',0,'Whoso hath known Me, Lord of sage and singer,
     Ancient of days; of all the Three Worlds Stay,
  Boundless,--but unto every atom Bringer
     Of that which quickens it: whoso, I say,

  Hath known My form, which passeth mortal knowing;
    Seen my effulgence--which no eye hath seen--
  Than the sun''s burning gold more brightly glowing,
    Dispersing darkness,--unto him hath been'),
('edwin-arnold-et:gita.8.10',0,'Right life! And, in the hour when life is ending,
    With mind set fast and trustful piety,
  Drawing still breath beneath calm brows unbending,
    In happy peace that faithful one doth die,--

  In glad peace passeth to Purusha''s heaven.'),
('edwin-arnold-et:gita.8.11',0,'The place which they who read the Vedas name
  AKSHARAM, "Ultimate;" whereto have striven
     Saints and ascetics--their road is the same.'),
('edwin-arnold-et:gita.8.12',0,'That way--the highest way--goes he who shuts
  The gates of all his senses, locks desire
  Safe in his heart, centres the vital airs
  Upon his parting thought, steadfastly set;'),
('edwin-arnold-et:gita.8.13',0,'And, murmuring OM, the sacred syllable--
  Emblem of BRAHM--dies, meditating Me.'),
('edwin-arnold-et:gita.8.14',0,'For who, none other Gods regarding, looks
  Ever to Me, easily am I gained
  By such a Yogi;'),
('edwin-arnold-et:gita.8.15',0,'and, attaining Me,
  They fall not--those Mahatmas--back to birth,
  To life, which is the place of pain, which ends,
  But take the way of utmost blessedness.'),
('edwin-arnold-et:gita.8.16',0,'The worlds, Arjuna!--even Brahma''s world--
  Roll back again from Death to Life''s unrest;
  But they, O Kunti''s Son! that reach to Me,
  Taste birth no more.'),
('edwin-arnold-et:gita.8.17',0,'If ye know Brahma''s Day
  Which is a thousand Yugas; if ye know
  The thousand Yugas making Brahma''s Night,
  Then know ye Day and Night as He doth know!'),
('edwin-arnold-et:gita.8.18',0,'When that vast Dawn doth break, th'' Invisible
  Is brought anew into the Visible;
  When that deep Night doth darken, all which is
  Fades back again to Him Who sent it forth;'),
('edwin-arnold-et:gita.8.19',0,'Yea! this vast company of living things--
  Again and yet again produced--expires
  At Brahma''s Nightfall; and, at Brahma''s Dawn,
  Riseth, without its will, to life new-born.'),
('edwin-arnold-et:gita.8.20',0,'But--higher, deeper, innermost--abides
  Another Life, not like the life of sense,
  Escaping sight, unchanging. This endures
  When all created things have passed away:'),
('edwin-arnold-et:gita.8.21',0,'This is that Life named the Unmanifest,
  The Infinite! the All! the Uttermost.
  Thither arriving none return. That Life
  Is Mine, and I am there!'),
('edwin-arnold-et:gita.8.22',0,'And, Prince! by faith
  Which wanders not, there is a way to come
  Thither. I, the PURUSHA, I Who spread
  The Universe around me--in Whom dwell
  All living Things--may so be reached and seen!'),
('edwin-arnold-et:gita.8.23',0,''),
('edwin-arnold-et:gita.8.24',0,''),
('edwin-arnold-et:gita.8.25',0,''),
('edwin-arnold-et:gita.8.26',0,''),
('edwin-arnold-et:gita.8.27',0,''),
('edwin-arnold-et:gita.8.28',0,'Richer than holy fruit on Vedas growing,
     Greater than gifts, better than prayer or fast,
  Such wisdom is! The Yogi, this way knowing,
     Comes to the Utmost Perfect Peace at last.'),
('edwin-arnold-et:gita.9.1',0,'Krishna.
  Now will I open unto thee--whose heart
  Rejects not--that last lore, deepest-concealed,
  That farthest secret of My Heavens and Earths,
  Which but to know shall set thee free from ills,--'),
('edwin-arnold-et:gita.9.2',0,'A royal lore! a Kingly mystery!
  Yea! for the soul such light as purgeth it
  From every sin; a light of holiness
  With inmost splendour shining; plain to see;
  Easy to walk by, inexhaustible!'),
('edwin-arnold-et:gita.9.3',0,'They that receive not this, failing in faith
  To grasp the greater wisdom, reach not Me,
  Destroyer of thy foes! They sink anew
  Into the realm of Flesh, where all things change!'),
('edwin-arnold-et:gita.9.4',0,'By Me the whole vast Universe of things
  Is spread abroad;--by Me, the Unmanifest!
  In Me are all existences contained;
  Not I in them!'),
('edwin-arnold-et:gita.9.5',0,'Yet they are not contained,
  Those visible things! Receive and strive to embrace
  The mystery majestical! My Being--
  Creating all, sustaining all--still dwells
  Outside of all!'),
('edwin-arnold-et:gita.9.6',0,'See! as the shoreless airs
  Move in the measureless space, but are not space,
  [And space were space without the moving airs];
  So all things are in Me, but are not I.'),
('edwin-arnold-et:gita.9.7',0,'At closing of each Kalpa, Indian Prince!
  All things which be back to My Being come:
  At the beginning of each Kalpa, all
  Issue new-born from Me.'),
('edwin-arnold-et:gita.9.8',0,'By Energy
  And help of Prakriti my outer Self,
  Again, and yet again, I make go forth
  The realms of visible things--without their will--
  All of them--by the power of Prakriti.'),
('edwin-arnold-et:gita.9.9',0,'Yet these great makings, Prince! involve Me not
  Enchain Me not! I sit apart from them,
  Other, and Higher, and Free; nowise attached!'),
('edwin-arnold-et:gita.9.10',0,'Thus doth the stuff of worlds, moulded by Me,
  Bring forth all that which is, moving or still,
  Living or lifeless! Thus the worlds go on!'),
('edwin-arnold-et:gita.9.11',0,'The minds untaught mistake Me, veiled in form;--
  Naught see they of My secret Presence, nought
  Of My hid Nature, ruling all which lives.'),
('edwin-arnold-et:gita.9.12',0,'Vain hopes pursuing, vain deeds doing; fed
  On vainest knowledge, senselessly they seek
  An evil way, the way of brutes and fiends.'),
('edwin-arnold-et:gita.9.13',0,'But My Mahatmas, those of noble soul
  Who tread the path celestial, worship Me
  With hearts unwandering,--knowing Me the Source,
  Th'' Eternal Source, of Life.'),
('edwin-arnold-et:gita.9.14',0,'Unendingly
  They glorify Me; seek Me; keep their vows
  Of reverence and love, with changeless faith
  Adoring Me.'),
('edwin-arnold-et:gita.9.15',0,'Yea, and those too adore,
  Who, offering sacrifice of wakened hearts,
  Have sense of one pervading Spirit''s stress,
  One Force in every place, though manifold!'),
('edwin-arnold-et:gita.9.16',0,'I am the Sacrifice! I am the Prayer!
  I am the Funeral-Cake set for the dead!
  I am the healing herb! I am the ghee,
  The Mantra, and the flame, and that which burns!'),
('edwin-arnold-et:gita.9.17',0,'I am-of all this boundless Universe-
  The Father, Mother, Ancestor, and Guard!
  The end of Learning! That which purifies
  In lustral water! I am OM! I am
  Rig-Veda, Sama-Veda, Yajur-Ved;'),
('edwin-arnold-et:gita.9.18',0,'The Way, the Fosterer, the Lord, the Judge,
  The Witness; the Abode, the Refuge-House,
  The Friend, the Fountain and the Sea of Life
  Which sends, and swallows up; Treasure of Worlds
  And Treasure-Chamber! Seed and Seed-Sower,
  Whence endless harvests spring!'),
('edwin-arnold-et:gita.9.19',0,'Sun''s heat is mine;
  Heaven''s rain is mine to grant or to withhold;
  Death am I, and Immortal Life I am,
  Arjuna! SAT and ASAT, Visible Life,
  And Life Invisible!'),
('edwin-arnold-et:gita.9.20',0,'Yea! those who learn
    The threefold Veds, who drink the Soma-wine,
  Purge sins, pay sacrifice--from Me they earn
    Passage to Swarga; where the meats divine

  Of great gods feed them in high Indra''s heaven.'),
('edwin-arnold-et:gita.9.21',0,'Yet they, when that prodigious joy is o''er,
  Paradise spent, and wage for merits given,
    Come to the world of death and change once more.

  They had their recompense! they stored their treasure,
    Following the threefold Scripture and its writ;
  Who seeketh such gaineth the fleeting pleasure
    Of joy which comes and goes! I grant them it!'),
('edwin-arnold-et:gita.9.22',0,'But to those blessed ones who worship Me,
  Turning not otherwhere, with minds set fast,
  I bring assurance of full bliss beyond.'),
('edwin-arnold-et:gita.9.23',0,'Nay, and of hearts which follow other gods
  In simple faith, their prayers arise to me,
  O Kunti''s Son! though they pray wrongfully;'),
('edwin-arnold-et:gita.9.24',0,'For I am the Receiver and the Lord
  Of every sacrifice, which these know not
  Rightfully; so they fall to earth again!'),
('edwin-arnold-et:gita.9.25',0,'Who follow gods go to their gods; who vow
  Their souls to Pitris go to Pitris; minds
  To evil Bhuts given o''er sink to the Bhuts;
  And whoso loveth Me cometh to Me.'),
('edwin-arnold-et:gita.9.26',0,'Whoso shall offer Me in faith and love
  A leaf, a flower, a fruit, water poured forth,
  That offering I accept, lovingly made
  With pious will.'),
('edwin-arnold-et:gita.9.27',0,'Whate''er thou doest, Prince!
  Eating or sacrificing, giving gifts,
  Praying or fasting, let it all be done
  For Me, as Mine.'),
('edwin-arnold-et:gita.9.28',0,'So shalt thou free thyself
  From Karmabandh, the chain which holdeth men
  To good and evil issue, so shalt come
  Safe unto Me-when thou art quit of flesh--
  By faith and abdication joined to Me!'),
('edwin-arnold-et:gita.9.29',0,'I am alike for all! I know not hate,
  I know not favour! What is made is Mine!
  But them that worship Me with love, I love;
  They are in Me, and I in them!'),
('edwin-arnold-et:gita.9.30',0,'Nay, Prince!
  If one of evil life turn in his thought
  Straightly to Me, count him amidst the good;
  He hath the high way chosen;'),
('edwin-arnold-et:gita.9.31',0,'he shall grow
  Righteous ere long; he shall attain that peace
  Which changes not. Thou Prince of India!
  Be certain none can perish, trusting Me!');
--> statement-breakpoint
INSERT INTO commentary_unit_chunks (unit_id,chunk_index,content) VALUES
('edwin-arnold-et:gita.9.32',0,'O Pritha''s Son! whoso will turn to Me,
  Though they be born from the very womb of Sin,
  Woman or man; sprung of the Vaisya caste
  Or lowly disregarded Sudra,--all
  Plant foot upon the highest path;'),
('edwin-arnold-et:gita.9.33',0,'how then
  The holy Brahmans and My Royal Saints?
  Ah! ye who into this ill world are come--
  Fleeting and false--set your faith fast on Me!'),
('edwin-arnold-et:gita.9.34',0,'Fix heart and thought on Me! Adore Me! Bring
  Offerings to Me! Make Me prostrations! Make
  Me your supremest joy! and, undivided,
  Unto My rest your spirits shall be guided.'),
('edwin-arnold-et:gita.10.1',0,'Krishna.[FN#l6]
  Hear farther yet, thou Long-Armed Lord! these latest words I say--
  Uttered to bring thee bliss and peace, who lovest Me alway--'),
('edwin-arnold-et:gita.10.2',0,'Not the great company of gods nor kingly Rishis know
  My Nature, Who have made the gods and Rishis long ago;'),
('edwin-arnold-et:gita.10.3',0,'He only knoweth-only he is free of sin, and wise,
  Who seeth Me, Lord of the Worlds, with faith-enlightened eyes,
  Unborn, undying, unbegun.'),
('edwin-arnold-et:gita.10.4',0,'Whatever Natures be
  To mortal men distributed, those natures spring from Me!
  Intellect, skill, enlightenment, endurance, self-control,
  Truthfulness, equability, and grief or joy of soul,
  And birth and death, and fearfulness, and fearlessness, and shame,
  And honour, and sweet harmlessness,[FN#17] and peace which is the
  same
  Whate''er befalls, and mirth, and tears, and piety, and thrift,
  And wish to give, and will to help,--all cometh of My gift!'),
('edwin-arnold-et:gita.10.5',0,'Whatever Natures be
  To mortal men distributed, those natures spring from Me!
  Intellect, skill, enlightenment, endurance, self-control,
  Truthfulness, equability, and grief or joy of soul,
  And birth and death, and fearfulness, and fearlessness, and shame,
  And honour, and sweet harmlessness,[FN#17] and peace which is the
  same
  Whate''er befalls, and mirth, and tears, and piety, and thrift,
  And wish to give, and will to help,--all cometh of My gift!'),
('edwin-arnold-et:gita.10.6',0,'The Seven Chief Saints, the Elders Four, the Lordly Manus set--
  Sharing My work--to rule the worlds, these too did I beget;
  And Rishis, Pitris, Manus, all, by one thought of My mind;
  Thence did arise, to fill this world, the races of mankind;'),
('edwin-arnold-et:gita.10.7',0,'Wherefrom who comprehends My Reign of mystic Majesty--
  That truth of truths--is thenceforth linked in faultless faith to Me:'),
('edwin-arnold-et:gita.10.8',0,'Yea! knowing Me the source of all, by Me all creatures wrought,
  The wise in spirit cleave to Me, into My Being brought;'),
('edwin-arnold-et:gita.10.9',0,'Hearts fixed on Me; breaths breathed to Me; praising Me, each to each,
  So have they happiness and peace, with pious thought and speech;'),
('edwin-arnold-et:gita.10.10',0,'And unto these--thus serving well, thus loving ceaselessly--
  I give a mind of perfect mood, whereby they draw to Me;'),
('edwin-arnold-et:gita.10.11',0,'And, all for love of them, within their darkened souls I dwell,
  And, with bright rays of wisdom''s lamp, their ignorance dispel.'),
('edwin-arnold-et:gita.10.12',0,'Arjuna.
  Yes! Thou art Parabrahm! The High Abode!
  The Great Purification! Thou art God
  Eternal, All-creating, Holy, First,
  Without beginning! Lord of Lords and Gods!'),
('edwin-arnold-et:gita.10.13',0,'Declared by all the Saints--by Narada,
  Vyasa Asita, and Devalas;
  And here Thyself declaring unto me!'),
('edwin-arnold-et:gita.10.14',0,'What Thou hast said now know I to be truth,
  O Kesava! that neither gods nor men
  Nor demons comprehend Thy mystery
  Made manifest, Divinest!'),
('edwin-arnold-et:gita.10.15',0,'Thou Thyself
  Thyself alone dost know, Maker Supreme!
  Master of all the living! Lord of Gods!
  King of the Universe!'),
('edwin-arnold-et:gita.10.16',0,'To Thee alone
  Belongs to tell the heavenly excellence
  Of those perfections wherewith Thou dost fill
  These worlds of Thine; Pervading, Immanent!'),
('edwin-arnold-et:gita.10.17',0,'How shall I learn, Supremest Mystery!
  To know Thee, though I muse continually?
  Under what form of Thine unnumbered forms
  Mayst Thou be grasped?'),
('edwin-arnold-et:gita.10.18',0,'Ah! yet again recount,
  Clear and complete, Thy great appearances,
  The secrets of Thy Majesty and Might,
  Thou High Delight of Men! Never enough
  Can mine ears drink the Amrit[FN#18] of such words!'),
('edwin-arnold-et:gita.10.19',0,'Krishna.
  Hanta! So be it! Kuru Prince! I will to thee unfold
  Some portions of My Majesty, whose powers are manifold!'),
('edwin-arnold-et:gita.10.20',0,'I am the Spirit seated deep in every creature''s heart;
  From Me they come; by Me they live; at My word they depart!'),
('edwin-arnold-et:gita.10.21',0,'Vishnu of the Adityas I am, those Lords of Light;
  Maritchi of the Maruts, the Kings of Storm and Blight;
  By day I gleam, the golden Sun of burning cloudless Noon;
  By Night, amid the asterisms I glide, the dappled Moon!'),
('edwin-arnold-et:gita.10.22',0,'Of Vedas I am Sama-Ved, of gods in Indra''s Heaven
  Vasava; of the faculties to living beings given
  The mind which apprehends and thinks;'),
('edwin-arnold-et:gita.10.23',0,'of Rudras Sankara;
  Of Yakshas and of Rakshasas, Vittesh; and Pavaka
  Of Vasus, and of mountain-peaks Meru;'),
('edwin-arnold-et:gita.10.24',0,'Vrihaspati
  Know Me ''mid planetary Powers; ''mid Warriors heavenly
  Skanda; of all the water-floods the Sea which drinketh each,'),
('edwin-arnold-et:gita.10.25',0,'And Bhrigu of the holy Saints, and OM of sacred speech;
  Of prayers the prayer ye whisper;[FN#19] of hills Himala''s snow,'),
('edwin-arnold-et:gita.10.26',0,'And Aswattha, the fig-tree, of all the trees that grow;
  Of the Devarshis, Narada; and Chitrarath of them
  That sing in Heaven, and Kapila of Munis,'),
('edwin-arnold-et:gita.10.27',0,'and the gem
  Of flying steeds, Uchchaisravas, from Amrit-wave which burst;
  Of elephants Airavata; of males the Best and First;'),
('edwin-arnold-et:gita.10.28',0,'Of weapons Heav''n''s hot thunderbolt; of cows white Kamadhuk,
  From whose great milky udder-teats all hearts'' desires are strook;
  Vasuki of the serpent-tribes, round Mandara entwined;'),
('edwin-arnold-et:gita.10.29',0,'And thousand-fanged Ananta, on whose broad coils reclined
  Leans Vishnu; and of water-things Varuna; Aryam
  Of Pitris, and, of those that judge, Yama the Judge I am;'),
('edwin-arnold-et:gita.10.30',0,'Of Daityas dread Prahlada; of what metes days and years,
  Time''s self I am; of woodland-beasts-buffaloes, deers, and bears-
  The lordly-painted tiger; of birds the vast Garud,'),
('edwin-arnold-et:gita.10.31',0,'The whirlwind ''mid the winds; ''mid chiefs Rama with blood imbrued,
  Makar ''mid fishes of the sea, and Ganges ''mid the streams;'),
('edwin-arnold-et:gita.10.32',0,'Yea! First, and Last, and Centre of all which is or seems
  I am, Arjuna! Wisdom Supreme of what is wise,
  Words on the uttering lips I am, and eyesight of the eyes,'),
('edwin-arnold-et:gita.10.33',0,'And "A" of written characters, Dwandwa[FN#20] of knitted speech,
  And Endless Life, and boundless Love, whose power sustaineth each;'),
('edwin-arnold-et:gita.10.34',0,'And bitter Death which seizes all, and joyous sudden Birth,
  Which brings to light all beings that are to be on earth;
  And of the viewless virtues, Fame, Fortune, Song am I,
  And Memory, and Patience; and Craft, and Constancy:'),
('edwin-arnold-et:gita.10.35',0,'Of Vedic hymns the Vrihatsam, of metres Gayatri,
  Of months the Margasirsha, of all the seasons three
  The flower-wreathed Spring;'),
('edwin-arnold-et:gita.10.36',0,'in dicer''s-play the conquering
  Double-Eight;
  The splendour of the splendid, and the greatness of the great,
  Victory I am, and Action! and the goodness of the good,'),
('edwin-arnold-et:gita.10.37',0,'And Vasudev of Vrishni''s race, and of this Pandu brood
  Thyself!--Yea, my Arjuna! thyself; for thou art Mine!
  Of poets Usana, of saints Vyasa, sage divine;'),
('edwin-arnold-et:gita.10.38',0,'The policy of conquerors, the potency of kings,
  The great unbroken silence in learning''s secret things;
  The lore of all the learned,'),
('edwin-arnold-et:gita.10.39',0,'the seed of all which springs.
  Living or lifeless, still or stirred, whatever beings be,
  None of them is in all the worlds, but it exists by Me!'),
('edwin-arnold-et:gita.10.40',0,'Nor tongue can tell, Arjuna! nor end of telling come
  Of these My boundless glories, whereof I teach thee some;'),
('edwin-arnold-et:gita.10.41',0,'For wheresoe''er is wondrous work, and majesty, and might,
  From Me hath all proceeded. Receive thou this aright!'),
('edwin-arnold-et:gita.10.42',0,'Yet how shouldst thou receive, O Prince! the vastness of this word?
  I, who am all, and made it all, abide its separate Lord!'),
('edwin-arnold-et:gita.11.1',0,'Arjuna.
  This, for my soul''s peace, have I heard from Thee,
  The unfolding of the Mystery Supreme
  Named Adhyatman; comprehending which,
  My darkness is dispelled;'),
('edwin-arnold-et:gita.11.2',0,'for now I know--
  O Lotus-eyed![FN#21]--whence is the birth of men,
  And whence their death, and what the majesties
  Of Thine immortal rule.'),
('edwin-arnold-et:gita.11.3',0,'Fain would I see,
  As thou Thyself declar''st it, Sovereign Lord!
  The likeness of that glory of Thy Form
  Wholly revealed.'),
('edwin-arnold-et:gita.11.4',0,'O Thou Divinest One!
  If this can be, if I may bear the sight,
  Make Thyself visible, Lord of all prayers!
  Show me Thy very self, the Eternal God!'),
('edwin-arnold-et:gita.11.5',0,'Krishna.
  Gaze, then, thou Son of Pritha! I manifest for thee
  Those hundred thousand thousand shapes that clothe my Mystery:
  I show thee all my semblances, infinite, rich, divine,
  My changeful hues, my countless forms.'),
('edwin-arnold-et:gita.11.6',0,'See! in this face of mine,
  Adityas, Vasus, Rudras, Aswins, and Maruts; see
  Wonders unnumbered, Indian Prince! revealed to none save thee.'),
('edwin-arnold-et:gita.11.7',0,'Behold! this is the Universe!--Look! what is live and dead
  I gather all in one--in Me! Gaze, as thy lips have said,
  On GOD ETERNAL, VERY GOD! See Me! see what thou prayest!'),
('edwin-arnold-et:gita.11.8',0,'Thou canst not!--nor, with human eyes, Arjuna! ever mayest!
  Therefore I give thee sense divine. Have other eyes, new light!
  And, look! This is My glory, unveiled to mortal sight!'),
('edwin-arnold-et:gita.11.9',0,'Sanjaya.
  Then, O King! the God, so saying,
  Stood, to Pritha''s Son displaying
  All the splendour, wonder, dread
  Of His vast Almighty-head.'),
('edwin-arnold-et:gita.11.10',0,'Out of countless eyes beholding,
  Out of countless mouths commanding,
  Countless mystic forms enfolding
  In one Form: supremely standing
  Countless radiant glories wearing,
  Countless heavenly weapons bearing,'),
('edwin-arnold-et:gita.11.11',0,'Crowned with garlands of star-clusters,
  Robed in garb of woven lustres,
  Breathing from His perfect Presence
  Breaths of every subtle essence
  Of all heavenly odours; shedding
  Blinding brilliance; overspreading--
  Boundless, beautiful--all spaces
  With His all-regarding faces;
  So He showed!'),
('edwin-arnold-et:gita.11.12',0,'If there should rise
  Suddenly within the skies
  Sunburst of a thousand suns
  Flooding earth with beams undeemed-of,
  Then might be that Holy One''s
  Majesty and radiance dreamed of!'),
('edwin-arnold-et:gita.11.13',0,'So did Pandu''s Son behold
  All this universe enfold
  All its huge diversity
  Into one vast shape, and be
  Visible, and viewed, and blended
  In one Body--subtle, splendid,
  Nameless--th'' All-comprehending
  God of Gods, the Never-Ending
  Deity!'),
('edwin-arnold-et:gita.11.14',0,'But, sore amazed,
  Thrilled, o''erfilled, dazzled, and dazed,
  Arjuna knelt; and bowed his head,
  And clasped his palms; and cried, and said:'),
('edwin-arnold-et:gita.11.15',0,'Arjuna.
  Yea! I have seen! I see!
  Lord! all is wrapped in Thee!
  The gods are in Thy glorious frame! the creatures
  Of earth, and heaven, and hell
  In Thy Divine form dwell,
  And in Thy countenance shine all the features

  Of Brahma, sitting lone
  Upon His lotus-throne;
  Of saints and sages, and the serpent races
  Ananta, Vasuki;'),
('edwin-arnold-et:gita.11.16',0,'Yea! mightiest Lord! I see
  Thy thousand thousand arms, and breasts, and faces,
  And eyes,--on every side
  Perfect, diversified;
  And nowhere end of Thee, nowhere beginning,
  Nowhere a centre! Shifts--
  Wherever soul''s gaze lifts--
  Thy central Self, all-wielding, and all-winning!'),
('edwin-arnold-et:gita.11.17',0,'Infinite King! I see
  The anadem on Thee,
  The club, the shell, the discus; see Thee burning
  In beams insufferable,
  Lighting earth, heaven, and hell
  With brilliance blazing, glowing, flashing; turning

  Darkness to dazzling day,
  Look I whichever way;'),
('edwin-arnold-et:gita.11.18',0,'Ah, Lord! I worship Thee, the Undivided,
  The Uttermost of thought,
  The Treasure-Palace wrought
  To hold the wealth of the worlds; the Shield provided

  To shelter Virtue''s laws;
  The Fount whence Life''s stream draws
  All waters of all rivers of all being:'),
('edwin-arnold-et:gita.11.19',0,'The One Unborn, Unending:
  Unchanging and Unblending!
  With might and majesty, past thought, past seeing!

  Silver of moon and gold
  Of sun are glories rolled
  From Thy great eyes; Thy visage, beaming tender
  Throughout the stars and skies,
  Doth to warm life surprise
  Thy Universe.'),
('edwin-arnold-et:gita.11.20',0,'The worlds are filled with wonder

  Of Thy perfections! Space
  Star-sprinkled, and void place
  From pole to pole of the Blue, from bound to bound,
  Hath Thee in every spot,
  Thee, Thee!--Where Thou art not,
  O Holy, Marvellous Form! is nowhere found!

  O Mystic, Awful One!
  At sight of Thee, made known,
  The Three Worlds quake;'),
('edwin-arnold-et:gita.11.21',0,'the lower gods draw nigh Thee;
  They fold their palms, and bow
  Body, and breast, and brow,
  And, whispering worship, laud and magnify Thee!

  Rishis and Siddhas cry
  "Hail! Highest Majesty!"
  From sage and singer breaks the hymn of glory
  In dulcet harmony,
  Sounding the praise of Thee;
  While countless companies take up the story,'),
('edwin-arnold-et:gita.11.22',0,'Rudras, who ride the storms,
  Th'' Adityas'' shining forms,
  Vasus and Sadhyas, Viswas, Ushmapas;
  Maruts, and those great Twins
  The heavenly, fair, Aswins,
  Gandharvas, Rakshasas, Siddhas, and Asuras,[FN#22]--

  These see Thee, and revere
  In sudden-stricken fear;'),
('edwin-arnold-et:gita.11.23',0,'Yea! the Worlds,--seeing Thee with form stupendous,
  With faces manifold,
  With eyes which all behold,
  Unnumbered eyes, vast arms, members tremendous,

  Flanks, lit with sun and star,
  Feet planted near and far,
  Tushes of terror, mouths wrathful and tender;--
  The Three wide Worlds before Thee
  Adore, as I adore Thee,
  Quake, as I quake, to witness so much splendour!'),
('edwin-arnold-et:gita.11.24',0,'I mark Thee strike the skies
  With front, in wondrous wise
  Huge, rainbow-painted, glittering; and thy mouth
  Opened, and orbs which see
  All things, whatever be
  In all Thy worlds, east, west, and north and south.

  O Eyes of God! O Head!
  My strength of soul is fled,
  Gone is heart''s force, rebuked is mind''s desire!'),
('edwin-arnold-et:gita.11.25',0,'When I behold Thee so,
  With awful brows a-glow,
  With burning glance, and lips lighted by fire

  Fierce as those flames which shall
  Consume, at close of all,
  Earth, Heaven! Ah me! I see no Earth and Heaven!
  Thee, Lord of Lords! I see,
  Thee only-only Thee!
  Now let Thy mercy unto me be given,

  Thou Refuge of the World!'),
('edwin-arnold-et:gita.11.26',0,'Lo! to the cavern hurled
  Of Thy wide-opened throat, and lips white-tushed,
  I see our noblest ones,
  Great Dhritarashtra''s sons,
  Bhishma, Drona, and Karna, caught and crushed!

  The Kings and Chiefs drawn in,
  That gaping gorge within;
  The best of both these armies torn and riven!
  Between Thy jaws they lie
  Mangled full bloodily,
  Ground into dust and death!'),
('edwin-arnold-et:gita.11.27',0,'Lo! to the cavern hurled
  Of Thy wide-opened throat, and lips white-tushed,
  I see our noblest ones,
  Great Dhritarashtra''s sons,
  Bhishma, Drona, and Karna, caught and crushed!

  The Kings and Chiefs drawn in,
  That gaping gorge within;
  The best of both these armies torn and riven!
  Between Thy jaws they lie
  Mangled full bloodily,
  Ground into dust and death!'),
('edwin-arnold-et:gita.11.28',0,'Like streams down-driven

  With helpless haste, which go
  In headlong furious flow
  Straight to the gulfing deeps of th'' unfilled ocean,
  So to that flaming cave
  Those heroes great and brave
  Pour, in unending streams, with helpless motion!'),
('edwin-arnold-et:gita.11.29',0,'Like moths which in the night
  Flutter towards a light,
  Drawn to their fiery doom, flying and dying,
  So to their death still throng,
  Blind, dazzled, borne along
  Ceaselessly, all those multitudes, wild flying!'),
('edwin-arnold-et:gita.11.30',0,'Thou, that hast fashioned men,
  Devourest them again,
  One with another, great and small, alike!
  The creatures whom Thou mak''st,
  With flaming jaws Thou tak''st,
  Lapping them up! Lord God! Thy terrors strike

  From end to end of earth,
  Filling life full, from birth
  To death, with deadly, burning, lurid dread!'),
('edwin-arnold-et:gita.11.31',0,'Ah, Vishnu! make me know
  Why is Thy visage so?
  Who art Thou, feasting thus upon Thy dead?

  Who? awful Deity!
  I bow myself to Thee,
  Namostu Te, Devavara! Prasid![FN#23]
  O Mightiest Lord! rehearse
  Why hast Thou face so fierce?
  Whence doth this aspect horrible proceed?'),
('edwin-arnold-et:gita.11.32',0,'Krishna.
  Thou seest Me as Time who kills,
  Time who brings all to doom,
  The Slayer Time, Ancient of Days, come hither to consume;
  Excepting thee, of all these hosts of hostile chiefs arrayed,
  There stands not one shall leave alive the battlefield!'),
('edwin-arnold-et:gita.11.33',0,'Dismayed
  No longer be! Arise! obtain renown! destroy thy foes!
  Fight for the kingdom waiting thee when thou hast vanquished those.
  By Me they fall--not thee! the stroke of death is dealt them now,
  Even as they show thus gallantly; My instrument art thou!'),
('edwin-arnold-et:gita.11.34',0,'Strike, strong-armed Prince, at Drona! at Bhishma strike! deal death
  On Karna, Jyadratha; stay all their warlike breath!
  ''Tis I who bid them perish! Thou wilt but slay the slain;
  Fight! they must fall, and thou must live, victor upon this plain!'),
('edwin-arnold-et:gita.11.35',0,'Sanjaya.
  Hearing mighty Keshav''s word,
  Tremblingly that helmed Lord
  Clasped his lifted palms, and--praying
  Grace of Krishna--stood there, saying,
  With bowed brow and accents broken,
  These words, timorously spoken:'),
('edwin-arnold-et:gita.11.36',0,'Arjuna.
  Worthily, Lord of Might!
  The whole world hath delight
  In Thy surpassing power, obeying Thee;
  The Rakshasas, in dread
  At sight of Thee, are sped
  To all four quarters; and the company

  Of Siddhas sound Thy name.'),
('edwin-arnold-et:gita.11.37',0,'How should they not proclaim
  Thy Majesties, Divinest, Mightiest?
  Thou Brahm, than Brahma greater!
  Thou Infinite Creator!
  Thou God of gods, Life''s Dwelling-place and Rest!

  Thou, of all souls the Soul!
  The Comprehending Whole!
  Of being formed, and formless being the Framer;'),
('edwin-arnold-et:gita.11.38',0,'O Utmost One! O Lord!
  Older than eld, Who stored
  The worlds with wealth of life! O Treasure-Claimer,

  Who wottest all, and art
  Wisdom Thyself! O Part
  In all, and All; for all from Thee have risen
  Numberless now I see
  The aspects are of Thee!'),
('edwin-arnold-et:gita.11.39',0,'Vayu[FN#24] Thou art, and He who keeps the prison

  Of Narak, Yama dark;
  And Agni''s shining spark;
  Varuna''s waves are Thy waves. Moon and starlight
  Are Thine! Prajapati
  Art Thou, and ''tis to Thee
  They knelt in worshipping the old world''s far light,

  The first of mortal men.
  Again, Thou God! again
  A thousand thousand times be magnified!'),
('edwin-arnold-et:gita.11.40',0,'Honour and worship be--
  Glory and praise,--to Thee
  Namo, Namaste, cried on every side;

  Cried here, above, below,
  Uttered when Thou dost go,
  Uttered where Thou dost come! Namo! we call;
  Namostu! God adored!
  Namostu! Nameless Lord!
  Hail to Thee! Praise to Thee! Thou One in all;

  For Thou art All! Yea, Thou!'),
('edwin-arnold-et:gita.11.41',0,'Ah! if in anger now
  Thou shouldst remember I did think Thee Friend,
  Speaking with easy speech,
  As men use each to each;
  Did call Thee "Krishna," "Prince," nor comprehend

  Thy hidden majesty,
  The might, the awe of Thee;
  Did, in my heedlessness, or in my love,'),
('edwin-arnold-et:gita.11.42',0,'On journey, or in jest,
  Or when we lay at rest,
  Sitting at council, straying in the grove,

  Alone, or in the throng,
  Do Thee, most Holy! wrong,
  Be Thy grace granted for that witless sin!'),
('edwin-arnold-et:gita.11.43',0,'For Thou art, now I know,
  Father of all below,
  Of all above, of all the worlds within

  Guru of Gurus; more
  To reverence and adore
  Than all which is adorable and high!
  How, in the wide worlds three
  Should any equal be?
  Should any other share Thy Majesty?'),
('edwin-arnold-et:gita.11.44',0,'Therefore, with body bent
  And reverent intent,
  I praise, and serve, and seek Thee, asking grace.
  As father to a son,
  As friend to friend, as one
  Who loveth to his lover, turn Thy face

  In gentleness on me!'),
('edwin-arnold-et:gita.11.45',0,'Good is it I did see
  This unknown marvel of Thy Form! But fear
  Mingles with joy! Retake,
  Dear Lord! for pity''s sake
  Thine earthly shape, which earthly eyes may bear!'),
('edwin-arnold-et:gita.11.46',0,'Be merciful, and show
  The visage that I know;
  Let me regard Thee, as of yore, arrayed
  With disc and forehead-gem,
  With mace and anadem,
  Thou that sustainest all things! Undismayed

  Let me once more behold
  The form I loved of old,
  Thou of the thousand arms and countless eyes!
  This frightened heart is fain
  To see restored again
  My Charioteer, in Krishna''s kind disguise.'),
('edwin-arnold-et:gita.11.47',0,'Krishna.
  Yea! thou hast seen, Arjuna! because I loved thee well,
  The secret countenance of Me, revealed by mystic spell,
  Shining, and wonderful, and vast, majestic, manifold,
  Which none save thou in all the years had favour to behold;'),
('edwin-arnold-et:gita.11.48',0,'For not by Vedas cometh this, nor sacrifice, nor alms,
  Nor works well-done, nor penance long, nor prayers, nor chaunted
  psalms,
  That mortal eyes should bear to view the Immortal Soul unclad,
  Prince of the Kurus! This was kept for thee alone! Be glad!'),
('edwin-arnold-et:gita.11.49',0,'Let no more trouble shake thy heart, because thine eyes have seen
  My terror with My glory. As I before have been
  So will I be again for thee; with lightened heart behold!
  Once more I am thy Krishna, the form thou knew''st of old!'),
('edwin-arnold-et:gita.11.50',0,'Sanjaya.
  These words to Arjuna spake
  Vasudev, and straight did take
  Back again the semblance dear
  Of the well-loved charioteer;
  Peace and joy it did restore
  When the Prince beheld once more
  Mighty BRAHMA''s form and face
  Clothed in Krishna''s gentle grace.'),
('edwin-arnold-et:gita.11.51',0,'Arjuna.
  Now that I see come back, Janardana!
  This friendly human frame, my mind can think
  Calm thoughts once more; my heart beats still again!'),
('edwin-arnold-et:gita.11.52',0,'Krishna.
  Yea! it was wonderful and terrible
  To view me as thou didst, dear Prince! The gods
  Dread and desire continually to view!'),
('edwin-arnold-et:gita.11.53',0,'Yet not by Vedas, nor from sacrifice,
  Nor penance, nor gift-giving, nor with prayer
  Shall any so behold, as thou hast seen!'),
('edwin-arnold-et:gita.11.54',0,'Only by fullest service, perfect faith,
  And uttermost surrender am I known
  And seen, and entered into, Indian Prince!'),
('edwin-arnold-et:gita.11.55',0,'Who doeth all for Me; who findeth Me
  In all; adoreth always; loveth all
  Which I have made, and Me, for Love''s sole end
  That man, Arjuna! unto Me doth wend.'),
('edwin-arnold-et:gita.12.1',0,'Arjuna.
  Lord! of the men who serve Thee--true in heart--
  As God revealed; and of the men who serve,
  Worshipping Thee Unrevealed, Unbodied, Far,
  Which take the better way of faith and life?'),
('edwin-arnold-et:gita.12.2',0,'Krishna.
  Whoever serve Me--as I show Myself--
  Constantly true, in full devotion fixed,
  Those hold I very holy.'),
('edwin-arnold-et:gita.12.3',0,'But who serve--
  Worshipping Me The One, The Invisible,
  The Unrevealed, Unnamed, Unthinkable,
  Uttermost, All-pervading, Highest, Sure--'),
('edwin-arnold-et:gita.12.4',0,'Who thus adore Me, mastering their sense,
  Of one set mind to all, glad in all good,
  These blessed souls come unto Me.'),
('edwin-arnold-et:gita.12.5',0,'Yet, hard
  The travail is for such as bend their minds
  To reach th'' Unmanifest That viewless path
  Shall scarce be trod by man bearing the flesh!'),
('edwin-arnold-et:gita.12.6',0,'But whereso any doeth all his deeds
  Renouncing self for Me, full of Me, fixed
  To serve only the Highest, night and day
  Musing on Me--'),
('edwin-arnold-et:gita.12.7',0,'him will I swiftly lift
  Forth from life''s ocean of distress and death,
  Whose soul clings fast to Me.'),
('edwin-arnold-et:gita.12.8',0,'Cling thou to Me!
  Clasp Me with heart and mind! so shalt thou dwell
  Surely with Me on high.'),
('edwin-arnold-et:gita.12.9',0,'But if thy thought
  Droops from such height; if thou be''st weak to set
  Body and soul upon Me constantly,
  Despair not! give Me lower service! seek
  To reach Me, worshipping with steadfast will;'),
('edwin-arnold-et:gita.12.10',0,'And, if thou canst not worship steadfastly,
  Work for Me, toil in works pleasing to Me!
  For he that laboureth right for love of Me
  Shall finally attain!'),
('edwin-arnold-et:gita.12.11',0,'But, if in this
  Thy faint heart fails, bring Me thy failure! find
  Refuge in Me! let fruits of labour go,
  Renouncing hope for Me, with lowliest heart,
  So shalt thou come;'),
('edwin-arnold-et:gita.12.12',0,'for, though to know is more
  Than diligence, yet worship better is
  Than knowing, and renouncing better still.
  Near to renunciation--very near--
  Dwelleth Eternal Peace!'),
('edwin-arnold-et:gita.12.13',0,'Who hateth nought
  Of all which lives, living himself benign,
  Compassionate, from arrogance exempt,
  Exempt from love of self, unchangeable
  By good or ill; patient,'),
('edwin-arnold-et:gita.12.14',0,'contented, firm
  In faith, mastering himself, true to his word,
  Seeking Me, heart and soul; vowed unto Me,--
  That man I love!'),
('edwin-arnold-et:gita.12.15',0,'Who troubleth not his kind,
  And is not troubled by them; clear of wrath,
  Living too high for gladness, grief, or fear,
  That man I love!'),
('edwin-arnold-et:gita.12.16',0,'Who, dwelling quiet-eyed,[FN#25]
  Stainless, serene, well-balanced, unperplexed,
  Working with Me, yet from all works detached,
  That man I love!'),
('edwin-arnold-et:gita.12.17',0,'Who, fixed in faith on Me,
  Dotes upon none, scorns none; rejoices not,
  And grieves not, letting good or evil hap
  Light when it will, and when it will depart,
  That man I love!'),
('edwin-arnold-et:gita.12.18',0,'Who, unto friend and foe
  Keeping an equal heart, with equal mind
  Bears shame and glory; with an equal peace
  Takes heat and cold, pleasure and pain; abides
  Quit of desires,'),
('edwin-arnold-et:gita.12.19',0,'hears praise or calumny
  In passionless restraint, unmoved by each;
  Linked by no ties to earth, steadfast in Me,
  That man I love!'),
('edwin-arnold-et:gita.12.20',0,'But most of all I love
  Those happy ones to whom ''tis life to live
  In single fervid faith and love unseeing,
  Drinking the blessed Amrit of my Being!'),
('edwin-arnold-et:gita.13.1',0,'Krishna.
  Yea! Son of Kunti! for this flesh ye see
  Is Kshetra, is the field where Life disports;
  And that which views and knows it is the Soul,
  Kshetrajna.'),
('edwin-arnold-et:gita.13.2',0,'In all "fields," thou Indian prince!
  I am Kshetrajna. I am what surveys!
  Only that knowledge knows which knows the known
  By the knower![FN#27]'),
('edwin-arnold-et:gita.13.3',0,'What it is, that "field" of life,
  What qualities it hath, and whence it is,
  And why it changeth, and the faculty
  That wotteth it, the mightiness of this,
  And how it wotteth-hear these things from Me!'),
('edwin-arnold-et:gita.13.4',0,''),
('edwin-arnold-et:gita.13.5',0,'The elements, the conscious life, the mind,
  The unseen vital force, the nine strange gates
  Of the body, and the five domains of sense;'),
('edwin-arnold-et:gita.13.6',0,'Desire, dislike, pleasure and pain, and thought
  Deep-woven, and persistency of being;
  These all are wrought on Matter by the Soul!'),
('edwin-arnold-et:gita.13.7',0,'Humbleness, truthfulness, and harmlessness,
  Patience and honour, reverence for the wise.
  Purity, constancy, control of self,'),
('edwin-arnold-et:gita.13.8',0,'Contempt of sense-delights, self-sacrifice,
  Perception of the certitude of ill
  In birth, death, age, disease, suffering, and sin;'),
('edwin-arnold-et:gita.13.9',0,'Detachment, lightly holding unto home,
  Children, and wife, and all that bindeth men;
  An ever-tranquil heart in fortunes good
  And fortunes evil,'),
('edwin-arnold-et:gita.13.10',0,'with a will set firm
  To worship Me--Me only! ceasing not;
  Loving all solitudes, and shunning noise
  Of foolish crowds;'),
('edwin-arnold-et:gita.13.11',0,'endeavours resolute
  To reach perception of the Utmost Soul,
  And grace to understand what gain it were
  So to attain,--this is true Wisdom, Prince!
  And what is otherwise is ignorance!'),
('edwin-arnold-et:gita.13.12',0,'Now will I speak of knowledge best to know-
  That Truth which giveth man Amrit to drink,
  The Truth of HIM, the Para-Brahm, the All,
  The Uncreated;; not Asat, not Sat,
  Not Form, nor the Unformed; yet both, and more;--'),
('edwin-arnold-et:gita.13.13',0,'Whose hands are everywhere, and everywhere
  Planted His feet, and everywhere His eyes
  Beholding, and His ears in every place
  Hearing, and all His faces everywhere
  Enlightening and encompassing His worlds.'),
('edwin-arnold-et:gita.13.14',0,'Glorified in the senses He hath given,
  Yet beyond sense He is; sustaining all,
  Yet dwells He unattached: of forms and modes
  Master, yet neither form nor mode hath He;'),
('edwin-arnold-et:gita.13.15',0,'He is within all beings--and without--
  Motionless, yet still moving; not discerned
  For subtlety of instant presence; close
  To all, to each; yet measurelessly far!'),
('edwin-arnold-et:gita.13.16',0,'Not manifold, and yet subsisting still
  In all which lives; for ever to be known
  As the Sustainer, yet, at the End of Times,
  He maketh all to end--and re-creates.'),
('edwin-arnold-et:gita.13.17',0,'The Light of Lights He is, in the heart of the Dark
  Shining eternally. Wisdom He is
  And Wisdom''s way, and Guide of all the wise,
  Planted in every heart.'),
('edwin-arnold-et:gita.13.18',0,'So have I told
  Of Life''s stuff, and the moulding, and the lore
  To comprehend. Whoso, adoring Me,
  Perceiveth this, shall surely come to Me!'),
('edwin-arnold-et:gita.13.19',0,'Know thou that Nature and the Spirit both
  Have no beginning! Know that qualities
  And changes of them are by Nature wrought;'),
('edwin-arnold-et:gita.13.20',0,'That Nature puts to work the acting frame,
  But Spirit doth inform it, and so cause
  Feeling of pain and pleasure.'),
('edwin-arnold-et:gita.13.21',0,'Spirit, linked
  To moulded matter, entereth into bond
  With qualities by Nature framed, and, thus
  Married to matter, breeds the birth again
  In good or evil yonis.[FN#29]'),
('edwin-arnold-et:gita.13.22',0,'Yet is this
  Yea! in its bodily prison!--Spirit pure,
  Spirit supreme; surveying, governing,
  Guarding, possessing; Lord and Master still
  PURUSHA, Ultimate, One Soul with Me.'),
('edwin-arnold-et:gita.13.23',0,'Whoso thus knows himself, and knows his soul
  PURUSHA, working through the qualities
  With Nature''s modes, the light hath come for him!
  Whatever flesh he bears, never again
  Shall he take on its load.'),
('edwin-arnold-et:gita.13.24',0,'Some few there be
  By meditation find the Soul in Self
  Self-schooled; and some by long philosophy
  And holy life reach thither; some by works:'),
('edwin-arnold-et:gita.13.25',0,'Some, never so attaining, hear of light
  From other lips, and seize, and cleave to it
  Worshipping; yea! and those--to teaching true--
  Overpass Death!'),
('edwin-arnold-et:gita.13.26',0,'Wherever, Indian Prince!
  Life is--of moving things, or things unmoved,
  Plant or still seed--know, what is there hath grown
  By bond of Matter and of Spirit:'),
('edwin-arnold-et:gita.13.27',0,'Know
  He sees indeed who sees in all alike
  The living, lordly Soul; the Soul Supreme,
  Imperishable amid the Perishing:'),
('edwin-arnold-et:gita.13.28',0,'For, whoso thus beholds, in every place,
  In every form, the same, one, Living Life,
  Doth no more wrongfulness unto himself,
  But goes the highest road which brings to bliss.'),
('edwin-arnold-et:gita.13.29',0,'Seeing, he sees, indeed, who sees that works
  Are Nature''s wont, for Soul to practise by
  Acting, yet not the agent;'),
('edwin-arnold-et:gita.13.30',0,'sees the mass
  Of separate living things--each of its kind--
  Issue from One, and blend again to One:
  Then hath he BRAHMA, he attains!'),
('edwin-arnold-et:gita.13.31',0,'O Prince!
  That Ultimate, High Spirit, Uncreate,
  Unqualified, even when it entereth flesh
  Taketh no stain of acts, worketh in nought!'),
('edwin-arnold-et:gita.13.32',0,'Like to the ethereal air, pervading all,
  Which, for sheer subtlety, avoideth taint,
  The subtle Soul sits everywhere, unstained:'),
('edwin-arnold-et:gita.13.33',0,'Like to the light of the all-piercing sun
  [Which is not changed by aught it shines upon,]
  The Soul''s light shineth pure in every place;'),
('edwin-arnold-et:gita.13.34',0,'And they who, by such eye of wisdom, see
  How Matter, and what deals with it, divide;
  And how the Spirit and the flesh have strife,
  Those wise ones go the way which leads to Life!'),
('edwin-arnold-et:gita.14.1',0,'Krishna.
  Yet farther will I open unto thee
  This wisdom of all wisdoms, uttermost,
  The which possessing, all My saints have passed
  To perfectness.'),
('edwin-arnold-et:gita.14.2',0,'On such high verities
  Reliant, rising into fellowship
  With Me, they are not born again at birth
  Of Kalpas, nor at Pralyas suffer change!'),
('edwin-arnold-et:gita.14.3',0,'This Universe the womb is where I plant
  Seed of all lives! Thence, Prince of India, comes
  Birth to all beings!'),
('edwin-arnold-et:gita.14.4',0,'Whoso, Kunti''s Son!
  Mothers each mortal form, Brahma conceives,
  And I am He that fathers, sending seed!'),
('edwin-arnold-et:gita.14.5',0,'Sattwan, Rajas, and Tamas, so are named
  The qualities of Nature, "Soothfastness,"
  "Passion," and "Ignorance." These three bind down
  The changeless Spirit in the changeful flesh.'),
('edwin-arnold-et:gita.14.6',0,'Whereof sweet "Soothfastness," by purity
  Living unsullied and enlightened, binds
  The sinless Soul to happiness and truth;'),
('edwin-arnold-et:gita.14.7',0,'And Passion, being kin to appetite,
  And breeding impulse and propensity,
  Binds the embodied Soul, O Kunti''s Son!
  By tie of works.'),
('edwin-arnold-et:gita.14.8',0,'But Ignorance, begot
  Of Darkness, blinding mortal men, binds down
  Their souls to stupor, sloth, and drowsiness.'),
('edwin-arnold-et:gita.14.9',0,'Yea, Prince of India! Soothfastness binds souls
  In pleasant wise to flesh; and Passion binds
  By toilsome strain; but Ignorance, which blots
  The beams of wisdom, binds the soul to sloth.'),
('edwin-arnold-et:gita.14.10',0,'Passion and Ignorance, once overcome,
  Leave Soothfastness, O Bharata! Where this
  With Ignorance are absent, Passion rules;
  And Ignorance in hearts not good nor quick.'),
('edwin-arnold-et:gita.14.11',0,'When at all gateways of the Body shines
  The Lamp of Knowledge, then may one see well
  Soothfastness settled in that city reigns;'),
('edwin-arnold-et:gita.14.12',0,'Where longing is, and ardour, and unrest,
  Impulse to strive and gain, and avarice,
  Those spring from Passion--Prince!--engrained;'),
('edwin-arnold-et:gita.14.13',0,'and where
  Darkness and dulness, sloth and stupor are,
  ''Tis Ignorance hath caused them, Kuru Chief!'),
('edwin-arnold-et:gita.14.14',0,'Moreover, when a soul departeth, fixed
  In Soothfastness, it goeth to the place--
  Perfect and pure--of those that know all Truth.'),
('edwin-arnold-et:gita.14.15',0,'If it departeth in set habitude
  Of Impulse, it shall pass into the world
  Of spirits tied to works; and, if it dies
  In hardened Ignorance, that blinded soul
  Is born anew in some unlighted womb.'),
('edwin-arnold-et:gita.14.16',0,'The fruit of Soothfastness is true and sweet;
  The fruit of lusts is pain and toil; the fruit
  Of Ignorance is deeper darkness. Yea!'),
('edwin-arnold-et:gita.14.17',0,'For Light brings light, and Passion ache to have;
  And gloom, bewilderments, and ignorance
  Grow forth from Ignorance.'),
('edwin-arnold-et:gita.14.18',0,'Those of the first
  Rise ever higher; those of the second mode
  Take a mid place; the darkened souls sink back
  To lower deeps, loaded with witlessness!'),
('edwin-arnold-et:gita.14.19',0,'When, watching life, the living man perceives
  The only actors are the Qualities,
  And knows what rules beyond the Qualities,
  Then is he come nigh unto Me!'),
('edwin-arnold-et:gita.14.20',0,'The Soul,
  Thus passing forth from the Three Qualities--
  Whereby arise all bodies--overcomes
  Birth, Death, Sorrow, and Age; and drinketh deep
  The undying wine of Amrit.'),
('edwin-arnold-et:gita.14.21',0,'Arjuna.
  Oh, my Lord!
  Which be the signs to know him that hath gone
  Past the Three Modes? How liveth he? What way
  Leadeth him safe beyond the threefold Modes?'),
('edwin-arnold-et:gita.14.22',0,'Krishna.
  He who with equanimity surveys
  Lustre of goodness, strife of passion, sloth
  Of ignorance, not angry if they are,
  Not wishful when they are not:'),
('edwin-arnold-et:gita.14.23',0,'he who sits
  A sojourner and stranger in their midst
  Unruffled, standing off, saying--serene--
  When troubles break, "These be the Qualities!"'),
('edwin-arnold-et:gita.14.24',0,'He unto whom--self-centred--grief and joy
  Sound as one word; to whose deep-seeing eyes
  The clod, the marble, and the gold are one;
  Whose equal heart holds the same gentleness
  For lovely and unlovely things, firm-set,
  Well-pleased in praise and dispraise;'),
('edwin-arnold-et:gita.14.25',0,'satisfied
  With honour or dishonour; unto friends
  And unto foes alike in tolerance;
  Detached from undertakings,--he is named
  Surmounter of the Qualities!'),
('edwin-arnold-et:gita.14.26',0,'And such--
  With single, fervent faith adoring Me,
  Passing beyond the Qualities, conforms
  To Brahma, and attains Me!'),
('edwin-arnold-et:gita.14.27',0,'For I am
  That whereof Brahma is the likeness! Mine
  The Amrit is; and Immortality
  Is mine; and mine perfect Felicity!'),
('edwin-arnold-et:gita.15.1',0,'Krishna.
  Men call the Aswattha,--the Banyan-tree,--
  Which hath its boughs beneath, its roots above,--
  The ever-holy tree. Yea! for its leaves
  Are green and waving hymns which whisper Truth!
  Who knows the Aswattha, knows Veds, and all.'),
('edwin-arnold-et:gita.15.2',0,'Its branches shoot to heaven and sink to earth,[FN#30]
  Even as the deeds of men, which take their birth
    From qualities: its silver sprays and blooms,
  And all the eager verdure of its girth,
  Leap to quick life at kiss of sun and air,
  As men''s lives quicken to the temptings fair
    Of wooing sense: its hanging rootlets seek
  The soil beneath, helping to hold it there,

  As actions wrought amid this world of men
  Bind them by ever-tightening bonds again.'),
('edwin-arnold-et:gita.15.3',0,'If ye knew well the teaching of the Tree,
  What its shape saith; and whence it springs; and, then

  How it must end, and all the ills of it,
  The axe of sharp Detachment ye would whet,
    And cleave the clinging snaky roots, and lay
  This Aswattha of sense-life low,--to set'),
('edwin-arnold-et:gita.15.4',0,'New growths upspringing to that happier sky,--
  Which they who reach shall have no day to die,
    Nor fade away, nor fall--to Him, I mean,
  FATHER and FIRST, Who made the mystery

  Of old Creation;'),
('edwin-arnold-et:gita.15.5',0,'for to Him come they
  From passion and from dreams who break away;
    Who part the bonds constraining them to flesh,
  And,--Him, the Highest, worshipping alway--

  No longer grow at mercy of what breeze
  Of summer pleasure stirs the sleeping trees,
    What blast of tempest tears them, bough and stem
  To the eternal world pass such as these!'),
('edwin-arnold-et:gita.15.6',0,'Another Sun gleams there! another Moon!
  Another Light,--not Dusk, nor Dawn, nor Noon--
    Which they who once behold return no more;
  They have attained My rest, life''s Utmost boon!'),
('edwin-arnold-et:gita.15.7',0,'When, in this world of manifested life,
  The undying Spirit, setting forth from Me,
  Taketh on form, it draweth to itself
  From Being''s storehouse,--which containeth all,--
  Senses and intellect.'),
('edwin-arnold-et:gita.15.8',0,'The Sovereign Soul
  Thus entering the flesh, or quitting it,
  Gathers these up, as the wind gathers scents,
  Blowing above the flower-beds.'),
('edwin-arnold-et:gita.15.9',0,'Ear and Eye,
  And Touch and Taste, and Smelling, these it takes,--
  Yea, and a sentient mind;--linking itself
  To sense-things so.'),
('edwin-arnold-et:gita.15.10',0,'The unenlightened ones
  Mark not that Spirit when he goes or comes,
  Nor when he takes his pleasure in the form,
  Conjoined with qualities; but those see plain
  Who have the eyes to see.'),
('edwin-arnold-et:gita.15.11',0,'Holy souls see
  Which strive thereto. Enlightened, they perceive
  That Spirit in themselves; but foolish ones,
  Even though they strive, discern not, having hearts
  Unkindled, ill-informed!'),
('edwin-arnold-et:gita.15.12',0,'Know, too, from Me
  Shineth the gathered glory of the suns
  Which lighten all the world: from Me the moons
  Draw silvery beams, and fire fierce loveliness.'),
('edwin-arnold-et:gita.15.13',0,'I penetrate the clay, and lend all shapes
  Their living force; I glide into the plant--
  Root, leaf, and bloom--to make the woodlands green
  With springing sap.'),
('edwin-arnold-et:gita.15.14',0,'Becoming vital warmth,
  I glow in glad, respiring frames, and pass,
  With outward and with inward breath, to feed
  The body by all meats.[FN#31]'),
('edwin-arnold-et:gita.15.15',0,''),
('edwin-arnold-et:gita.15.16',0,'For in this world
  Being is twofold: the Divided, one;
  The Undivided, one. All things that live
  Are "the Divided." That which sits apart,
  "The Undivided."'),
('edwin-arnold-et:gita.15.17',0,'Higher still is He,
  The Highest, holding all, whose Name is LORD,
  The Eternal, Sovereign, First! Who fills all worlds,
  Sustaining them.'),
('edwin-arnold-et:gita.15.18',0,'And--dwelling thus beyond
  Divided Being and Undivided--I
  Am called of men and Vedas, Life Supreme,
  The PURUSHOTTAMA.'),
('edwin-arnold-et:gita.15.19',0,'Who knows Me thus,
  With mind unclouded, knoweth all, dear Prince!
  And with his whole soul ever worshippeth Me.'),
('edwin-arnold-et:gita.15.20',0,'Now is the sacred, secret Mystery
  Declared to thee! Who comprehendeth this
  Hath wisdom! He is quit of works in bliss!'),
('edwin-arnold-et:gita.16.1',0,'Krishna.
  Fearlessness, singleness of soul, the will
  Always to strive for wisdom; opened hand
  And governed appetites; and piety,
  And love of lonely study; humbleness,
  Uprightness,'),
('edwin-arnold-et:gita.16.2',0,'heed to injure nought which lives,
  Truthfulness, slowness unto wrath, a mind
  That lightly letteth go what others prize;
  And equanimity, and charity
  Which spieth no man''s faults; and tenderness
  Towards all that suffer; a contented heart,
  Fluttered by no desires; a bearing mild,
  Modest, and grave,'),
('edwin-arnold-et:gita.16.3',0,'with manhood nobly mixed,
  With patience, fortitude, and purity;
  An unrevengeful spirit, never given
  To rate itself too high;--such be the signs,
  O Indian Prince! of him whose feet are set
  On that fair path which leads to heavenly birth!'),
('edwin-arnold-et:gita.16.4',0,'Deceitfulness, and arrogance, and pride,
  Quickness to anger, harsh and evil speech,
  And ignorance, to its own darkness blind,--
  These be the signs, My Prince! of him whose birth
  Is fated for the regions of the vile.[FN#32]'),
('edwin-arnold-et:gita.16.5',0,'The Heavenly Birth brings to deliverance,
  So should''st thou know! The birth with Asuras
  Brings into bondage. Be thou joyous, Prince!
  Whose lot is set apart for heavenly Birth.'),
('edwin-arnold-et:gita.16.6',0,'Two stamps there are marked on all living men,
  Divine and Undivine; I spake to thee
  By what marks thou shouldst know the Heavenly Man,
  Hear from me now of the Unheavenly!'),
('edwin-arnold-et:gita.16.7',0,'They comprehend not, the Unheavenly,
  How Souls go forth from Me; nor how they come
  Back unto Me: nor is there Truth in these,
  Nor purity, nor rule of Life.'),
('edwin-arnold-et:gita.16.8',0,'"This world
  Hath not a Law, nor Order, nor a Lord,"
  So say they: "nor hath risen up by Cause
  Following on Cause, in perfect purposing,
  But is none other than a House of Lust."'),
('edwin-arnold-et:gita.16.9',0,'And, this thing thinking, all those ruined ones--
  Of little wit, dark-minded--give themselves
  To evil deeds, the curses of their kind.'),
('edwin-arnold-et:gita.16.10',0,'Surrendered to desires insatiable,
  Full of deceitfulness, folly, and pride,
  In blindness cleaving to their errors, caught
  Into the sinful course,'),
('edwin-arnold-et:gita.16.11',0,'they trust this lie
  As it were true--this lie which leads to death--
  Finding in Pleasure all the good which is,
  And crying "Here it finisheth!"'),
('edwin-arnold-et:gita.16.12',0,'Ensnared
  In nooses of a hundred idle hopes,
  Slaves to their passion and their wrath, they buy
  Wealth with base deeds, to glut hot appetites;'),
('edwin-arnold-et:gita.16.13',0,'"Thus much, to-day," they say, "we gained! thereby
  Such and such wish of heart shall have its fill;
  And this is ours! and th'' other shall be ours!'),
('edwin-arnold-et:gita.16.14',0,'To-day we slew a foe, and we will slay
  Our other enemy to-morrow! Look!
  Are we not lords? Make we not goodly cheer?
  Is not our fortune famous, brave, and great?'),
('edwin-arnold-et:gita.16.15',0,'Rich are we, proudly born! What other men
  Live like to us? Kill, then, for sacrifice!
  Cast largesse, and be merry!" So they speak
  Darkened by ignorance;'),
('edwin-arnold-et:gita.16.16',0,'and so they fall--
  Tossed to and fro with projects, tricked, and bound
  In net of black delusion, lost in lusts--
  Down to foul Naraka.'),
('edwin-arnold-et:gita.16.17',0,'Conceited, fond,
  Stubborn and proud, dead-drunken with the wine
  Of wealth, and reckless, all their offerings
  Have but a show of reverence, being not made
  In piety of ancient faith.'),
('edwin-arnold-et:gita.16.18',0,'Thus vowed
  To self-hood, force, insolence, feasting, wrath,
  These My blasphemers, in the forms they wear
  And in the forms they breed, my foemen are,'),
('edwin-arnold-et:gita.16.19',0,'Hateful and hating; cruel, evil, vile,
  Lowest and least of men, whom I cast down
  Again, and yet again, at end of lives,
  Into some devilish womb,'),
('edwin-arnold-et:gita.16.20',0,'whence--birth by birth--
  The devilish wombs re-spawn them, all beguiled;
  And, till they find and worship Me, sweet Prince!
  Tread they that Nether Road.'),
('edwin-arnold-et:gita.16.21',0,'The Doors of Hell
  Are threefold, whereby men to ruin pass,--
  The door of Lust, the door of Wrath, the door
  Of Avarice. Let a man shun those three!'),
('edwin-arnold-et:gita.16.22',0,'He who shall turn aside from entering
  All those three gates of Narak, wendeth straight
  To find his peace, and comes to Swarga''s gate.'),
('edwin-arnold-et:gita.16.23',0,''),
('edwin-arnold-et:gita.16.24',0,''),
('edwin-arnold-et:gita.17.1',0,'Arjuna.
  If men forsake the holy ordinance,
  Heedless of Shastras, yet keep faith at heart
  And worship, what shall be the state of those,
  Great Krishna! Sattwan, Rajas, Tamas? Say!'),
('edwin-arnold-et:gita.17.2',0,'Krishna.
  Threefold the faith is of mankind and springs
  From those three qualities,--becoming "true,"
  Or "passion-stained," or "dark," as thou shalt hear!'),
('edwin-arnold-et:gita.17.3',0,'The faith of each believer, Indian Prince!
  Conforms itself to what he truly is.
  Where thou shalt see a worshipper, that one
  To what he worships lives  assimilate,
  [Such as the shrine, so is the votary,]'),
('edwin-arnold-et:gita.17.4',0,'The "soothfast" souls adore true gods; the souls
  Obeying Rajas worship Rakshasas[FN#34]
  Or Yakshas; and the men of Darkness pray
  To Pretas and to Bhutas.[FN#35]'),
('edwin-arnold-et:gita.17.5',0,'Yea, and those
  Who  practise bitter penance, not enjoined
  By rightful rule--penance which hath its root
  In self-sufficient, proud hypocrisies--
  Those men, passion-beset, violent, wild,'),
('edwin-arnold-et:gita.17.6',0,'Torturing--the witless ones--My elements
  Shut in fair company within their flesh,
  (Nay, Me myself, present within the flesh!)
  Know them to devils devoted, not to Heaven!'),
('edwin-arnold-et:gita.17.7',0,'For like as foods are threefold for mankind
  In nourishing, so is there threefold way
  Of worship, abstinence, and almsgiving!
  Hear this of Me!'),
('edwin-arnold-et:gita.17.8',0,'there is a food which brings
  Force, substance, strength, and health, and joy to live,
  Being well-seasoned, cordial, comforting,
  The "Soothfast" meat.'),
('edwin-arnold-et:gita.17.9',0,'And there be foods which bring
  Aches and unrests, and burning blood, and grief,
  Being too biting, heating, salt, and sharp,
  And therefore craved by too strong appetite.'),
('edwin-arnold-et:gita.17.10',0,'And there is foul food--kept from over-night,[FN#36]
  Savourless, filthy, which the foul will eat,
  A feast of rottenness, meet for the lips
  Of such as love the "Darkness."'),
('edwin-arnold-et:gita.17.11',0,'Thus with rites;--
  A sacrifice not for rewardment made,
  Offered in rightful wise, when he who vows
  Sayeth, with heart devout, "This I should do!"
  Is "Soothfast" rite.'),
('edwin-arnold-et:gita.17.12',0,'But sacrifice for gain,
  Offered for good repute, be sure that this,
  O Best of Bharatas! is Rajas-rite,
  With stamp of "passion."'),
('edwin-arnold-et:gita.17.13',0,'And a sacrifice
  Offered against the laws, with no due dole
  Of food-giving, with no accompaniment
  Of hallowed hymn, nor largesse to the priests,
  In faithless celebration, call it vile,
  The deed of "Darkness!"--lost!'),
('edwin-arnold-et:gita.17.14',0,'Worship of gods
  Meriting worship; lowly reverence
  Of Twice-borns, Teachers, Elders; Purity,
  Rectitude, and the Brahmacharya''s vow,
  And not to injure any helpless thing,--
  These make a true religiousness of Act.'),
('edwin-arnold-et:gita.17.15',0,'Words causing no man woe, words ever true,
  Gentle and pleasing words, and those ye say
  In murmured reading of a Sacred Writ,--
  These make the true religiousness of Speech.'),
('edwin-arnold-et:gita.17.16',0,'Serenity of soul, benignity,
  Sway of the silent Spirit, constant stress
  To sanctify the Nature,--these things make
  Good rite, and true religiousness of Mind.'),
('edwin-arnold-et:gita.17.17',0,'Such threefold faith, in highest piety
  Kept, with no hope of gain, by hearts devote,
  Is perfect work of Sattwan, true belief.'),
('edwin-arnold-et:gita.17.18',0,'Religion shown in act of proud display
  To win good entertainment, worship, fame,
  Such--say I--is of Rajas, rash and vain.'),
('edwin-arnold-et:gita.17.19',0,'Religion followed by a witless will
  To torture self, or come at power to hurt
  Another,--''tis of Tamas, dark and ill.'),
('edwin-arnold-et:gita.17.20',0,'The gift lovingly given, when one shall say
  "Now must I gladly give!" when he who takes
  Can render nothing back; made in due place,
  Due time, and to a meet recipient,
  Is gift of Sattwan, fair and profitable.'),
('edwin-arnold-et:gita.17.21',0,'The gift selfishly given, where to receive
  Is hoped again, or when some end is sought,
  Or where the gift is proffered with a grudge,
  This is of Rajas, stained with impulse, ill.'),
('edwin-arnold-et:gita.17.22',0,'The gift churlishly flung, at evil time,
  In wrongful place, to base recipient,
  Made in disdain or harsh unkindliness,
  Is gift of Tamas, dark; it doth not bless![FN#37]'),
('edwin-arnold-et:gita.17.23',0,''),
('edwin-arnold-et:gita.17.24',0,''),
('edwin-arnold-et:gita.17.25',0,''),
('edwin-arnold-et:gita.17.26',0,''),
('edwin-arnold-et:gita.17.27',0,''),
('edwin-arnold-et:gita.17.28',0,''),
('edwin-arnold-et:gita.18.1',0,'Arjuna.
  Fain would I better know, Thou Glorious One!
  The very truth--Heart''s Lord!--of Sannyas,
  Abstention; and  enunciation, Lord!
  Tyaga; and what separates these twain!'),
('edwin-arnold-et:gita.18.2',0,'Krishna.
  The poets rightly teach that Sannyas
  Is the foregoing of all acts which spring
  Out of desire; and their wisest say
  Tyaga is renouncing fruit of acts.'),
('edwin-arnold-et:gita.18.3',0,'There be among the saints some who have held
  All action sinful, and to be renounced;
  And some who answer, "Nay! the goodly acts--
  As worship, penance, alms--must be performed!"'),
('edwin-arnold-et:gita.18.4',0,'Hear now My sentence, Best of Bharatas!

  ''Tis well set forth, O Chaser of thy Foes!
  Renunciation is of threefold form,'),
('edwin-arnold-et:gita.18.5',0,'And Worship, Penance, Alms, not to be stayed;
  Nay, to be gladly done; for all those three
  Are purifying waters for true souls!'),
('edwin-arnold-et:gita.18.6',0,'Yet must be practised even those high works
  In yielding up attachment, and all fruit
  Produced by works. This is My judgment, Prince!
  This My insuperable and fixed decree!'),
('edwin-arnold-et:gita.18.7',0,'Abstaining from a work by right prescribed
  Never is meet! So to abstain doth spring
  From "Darkness," and Delusion teacheth it.'),
('edwin-arnold-et:gita.18.8',0,'Abstaining from a work grievous to flesh,
  When one saith "''Tis unpleasing!" this is null!
  Such an one acts from "passion;" nought of gain
  Wins his Renunciation!'),
('edwin-arnold-et:gita.18.9',0,'But, Arjun!
  Abstaining from attachment to the work,
  Abstaining from rewardment in the work,
  While yet one doeth it full faithfully,
  Saying, "Tis right to do!" that is "true " act
  And abstinence!'),
('edwin-arnold-et:gita.18.10',0,'Who doeth duties so,
  Unvexed if his work fail, if it succeed
  Unflattered, in his own heart justified,
  Quit of debates and doubts, his is "true" act:'),
('edwin-arnold-et:gita.18.11',0,'For, being in the body, none may stand
  Wholly aloof from act; yet, who abstains
  From profit of his acts is abstinent.'),
('edwin-arnold-et:gita.18.12',0,'The fruit of labours, in the lives to come,
  Is threefold for all men,--Desirable,
  And Undesirable, and mixed of both;
  But no fruit is at all where no work was.'),
('edwin-arnold-et:gita.18.13',0,'Hear from me, Long-armed Lord! the makings five
  Which go to every act, in Sankhya taught
  As necessary.'),
('edwin-arnold-et:gita.18.14',0,'First the force; and then
  The agent; next, the various instruments;
  Fourth, the especial effort; fifth, the God.'),
('edwin-arnold-et:gita.18.15',0,'What work soever any mortal doth
  Of body, mind, or speech, evil or good,
  By these five doth he that.'),
('edwin-arnold-et:gita.18.16',0,'Which being thus,
  Whoso, for lack of knowledge, seeth himself
  As the sole actor, knoweth nought at all
  And seeth nought.'),
('edwin-arnold-et:gita.18.17',0,'Therefore, I say, if one--
  Holding aloof from self--with unstained mind
  Should slay all yonder host, being bid to slay,
  He doth not slay; he is not bound thereby!'),
('edwin-arnold-et:gita.18.18',0,'Knowledge, the thing known, and the mind which knows,
  These make the threefold starting-ground of act.
  The act, the actor, and the instrument,
  These make the threefold total of the deed.'),
('edwin-arnold-et:gita.18.19',0,'But knowledge, agent, act, are differenced
  By three dividing qualities. Hear now
  Which be the qualities dividing them.'),
('edwin-arnold-et:gita.18.20',0,'There is "true" Knowledge. Learn thou it is this:
  To see one changeless Life in all the Lives,
  And in the Separate, One Inseparable.'),
('edwin-arnold-et:gita.18.21',0,'There is imperfect Knowledge: that which sees
  The separate existences apart,
  And, being separated, holds them real.'),
('edwin-arnold-et:gita.18.22',0,'There is false Knowledge: that which blindly clings
  To one as if ''twere all, seeking no Cause,
  Deprived of light, narrow, and dull, and "dark."'),
('edwin-arnold-et:gita.18.23',0,'There is "right" Action: that which being enjoined--
  Is wrought without attachment, passionlessly,
  For duty, not for love, nor hate, nor gain.'),
('edwin-arnold-et:gita.18.24',0,'There is "vain" Action: that which men pursue
  Aching to satisfy desires, impelled
  By sense of self, with all-absorbing stress:
  This is of Rajas--passionate and vain.'),
('edwin-arnold-et:gita.18.25',0,'There is "dark" Action: when one doth a thing
  Heedless of issues, heedless of the hurt
  Or wrong for others, heedless if he harm
  His own soul--''tis of Tamas, black and bad!'),
('edwin-arnold-et:gita.18.26',0,'There is the "rightful"doer. He who acts
  Free from self-seeking, humble, resolute,
  Steadfast, in good or evil hap the same,
  Content to do aright-he "truly" acts.'),
('edwin-arnold-et:gita.18.27',0,'There is th'' "impassioned" doer. He that works
  From impulse, seeking profit, rude and bold
  To overcome, unchastened; slave by turns
  Of sorrow and of joy: of Rajas he!'),
('edwin-arnold-et:gita.18.28',0,'And there be evil doers; loose of heart,
  Low-minded, stubborn, fraudulent, remiss,
  Dull, slow, despondent--children of the "dark."'),
('edwin-arnold-et:gita.18.29',0,'Hear, too, of Intellect and Steadfastness
  The threefold separation, Conqueror-Prince!
  How these are set apart by Qualities.'),
('edwin-arnold-et:gita.18.30',0,'Good is the Intellect which comprehends
  The coming forth and going back of life,
  What must be done, and what must not be done,
  What should be feared, and what should not be feared,
  What binds and what emancipates the soul:
  That is of Sattwan, Prince! of "soothfastness."'),
('edwin-arnold-et:gita.18.31',0,'Marred is the Intellect which, knowing right
  And knowing wrong, and what is well to do
  And what must not be done, yet understands
  Nought with firm mind, nor as the calm truth is:
  This is of Rajas, Prince! and "passionate!"'),
('edwin-arnold-et:gita.18.32',0,'Evil is Intellect which, wrapped in gloom,
  Looks upon wrong as right, and sees all things
  Contrariwise of Truth. O Pritha''s Son!
  That is of Tamas, "dark" and desperate!'),
('edwin-arnold-et:gita.18.33',0,'Good is the steadfastness whereby a man
  Masters his beats of heart, his very breath
  Of life, the action of his senses; fixed
  In never-shaken faith and piety:
  That is of Sattwan, Prince! "soothfast" and fair!'),
('edwin-arnold-et:gita.18.34',0,'Stained is the steadfastness whereby a man
  Holds to his duty, purpose, effort, end,
  For life''s sake, and the love of goods to gain,
  Arjuna! ''tis of Rajas, passion-stamped!'),
('edwin-arnold-et:gita.18.35',0,'Sad is the steadfastness wherewith the fool
  Cleaves to his sloth, his sorrow, and his fears,
  His folly and despair. This--Pritha''s Son!--
  Is born of Tamas, "dark" and miserable!'),
('edwin-arnold-et:gita.18.36',0,'Hear further, Chief of Bharatas! from Me
  The threefold kinds of Pleasure which there be.

  Good Pleasure is the pleasure that endures,
  Banishing pain for aye;'),
('edwin-arnold-et:gita.18.37',0,'bitter at first
  As poison to the soul, but afterward
  Sweet as the taste of Amrit. Drink of that!
  It springeth in the Spirit''s deep content.'),
('edwin-arnold-et:gita.18.38',0,'And painful Pleasure springeth from the bond
  Between the senses and the sense-world. Sweet
  As Amrit is its first taste, but its last
  Bitter as poison. ''Tis of Rajas, Prince!'),
('edwin-arnold-et:gita.18.39',0,'And foul and "dark" the Pleasure is which springs
  From sloth and sin and foolishness; at first
  And at the last, and all the way of life
  The soul bewildering. ''Tis of Tamas, Prince!'),
('edwin-arnold-et:gita.18.40',0,'For nothing lives on earth, nor ''midst the gods
  In utmost heaven, but hath its being bound
  With these three Qualities, by Nature framed.'),
('edwin-arnold-et:gita.18.41',0,'The work of Brahmans, Kshatriyas, Vaisyas,
  And Sudras, O thou Slayer of thy Foes!
  Is fixed by reason of the Qualities
  Planted in each:'),
('edwin-arnold-et:gita.18.42',0,'A Brahman''s virtues, Prince!
  Born of his nature, are serenity,
  Self-mastery, religion, purity,
  Patience, uprightness, learning, and to know
  The truth of things which be.'),
('edwin-arnold-et:gita.18.43',0,'A Kshatriya''s pride,
  Born of his nature, lives in valour, fire,
  Constancy, skilfulness, spirit in fight,
  And open-handedness and noble mien,
  As of a lord of men.'),
('edwin-arnold-et:gita.18.44',0,'A Vaisya''s task,
  Born with his nature, is to till the ground,
  Tend cattle, venture trade. A Sudra''s state,
  Suiting his nature, is to minister.'),
('edwin-arnold-et:gita.18.45',0,'Whoso performeth--diligent, content--
  The work allotted him, whate''er it be,
  Lays hold of perfectness! Hear how a man
  Findeth perfection, being so content:'),
('edwin-arnold-et:gita.18.46',0,'He findeth it through worship--wrought by work--
  Of Him that is the Source of all which lives,
  Of HIM by Whom the universe was stretched.'),
('edwin-arnold-et:gita.18.47',0,'Better thine own work is, though done with fault,
  Than doing others'' work, ev''n excellently.
  He shall not fall in sin who fronts the task
  Set him by Nature''s hand!'),
('edwin-arnold-et:gita.18.48',0,'Let no man leave
  His natural duty, Prince! though it bear blame!
  For every work hath blame, as every flame
  Is wrapped in smoke!'),
('edwin-arnold-et:gita.18.49',0,'Only that man attains
  Perfect surcease of work whose work was wrought
  With mind unfettered, soul wholly subdued,
  Desires for ever dead, results renounced.'),
('edwin-arnold-et:gita.18.50',0,'Learn from me, Son of Kunti! also this,
  How one, attaining perfect peace, attains
  BRAHM, the supreme, the highest height of all!'),
('edwin-arnold-et:gita.18.51',0,'Devoted--with a heart grown pure, restrained
  In lordly self-control, forgoing wiles
  Of song and senses, freed from love and hate,'),
('edwin-arnold-et:gita.18.52',0,'Dwelling ''mid solitudes, in diet spare,
  With body, speech, and will tamed to obey,
  Ever to holy meditation vowed,
  From passions liberate,'),
('edwin-arnold-et:gita.18.53',0,'quit of the Self,
  Of arrogance, impatience, anger, pride;
  Freed from surroundings, quiet, lacking nought--
  Such an one grows to oneness with the BRAHM;'),
('edwin-arnold-et:gita.18.54',0,'Such an one, growing one with BRAHM, serene,
  Sorrows no more, desires no more; his soul,
  Equally loving all that lives, loves well
  Me, Who have made them, and attains to Me.'),
('edwin-arnold-et:gita.18.55',0,'By this same love and worship doth he know
  Me as I am, how high and wonderful,
  And knowing, straightway enters into Me.'),
('edwin-arnold-et:gita.18.56',0,'And whatsoever deeds he doeth--fixed
  In Me, as in his refuge--he hath won
  For ever and for ever by My grace
  Th'' Eternal Rest!'),
('edwin-arnold-et:gita.18.57',0,'So win thou! In thy thoughts
  Do all thou dost for Me! Renounce for Me!
  Sacrifice heart and mind and will to Me!
  Live in the faith of Me!'),
('edwin-arnold-et:gita.18.58',0,'In faith of Me
  All dangers thou shalt vanquish, by My grace;
  But, trusting to thyself and heeding not,
  Thou can''st but perish!'),
('edwin-arnold-et:gita.18.59',0,'If this day thou say''st,
  Relying on thyself, "I will not fight!"
  Vain will the purpose prove! thy qualities
  Would spur thee to the war.'),
('edwin-arnold-et:gita.18.60',0,'What thou dost shun,
  Misled by fair illusions, thou wouldst seek
  Against thy will, when the task comes to thee
  Waking the promptings in thy nature set.'),
('edwin-arnold-et:gita.18.61',0,'There lives a Master in the hearts of men
  Maketh their deeds, by subtle  pulling--strings,
  Dance to what tune HE will.'),
('edwin-arnold-et:gita.18.62',0,'With all thy soul
  Trust Him, and take Him for thy succour, Prince!
  So--only so, Arjuna!--shalt thou gain--
  By grace of Him--the uttermost repose,
  The Eternal Place!'),
('edwin-arnold-et:gita.18.63',0,'Thus hath been opened thee
  This Truth of Truths, the Mystery more hid
  Than any secret mystery. Meditate!
  And--as thou wilt--then act!'),
('edwin-arnold-et:gita.18.64',0,'Nay! but once more
  Take My last word, My utmost meaning have!
  Precious thou art to Me; right well-beloved!
  Listen! I tell thee for thy comfort this.'),
('edwin-arnold-et:gita.18.65',0,'Give Me thy heart! adore Me! serve Me! cling
  In faith and love and reverence to Me!
  So shalt thou come to Me! I promise true,
  For thou art sweet to Me!'),
('edwin-arnold-et:gita.18.66',0,'And let go those--
  Rites and writ duties! Fly to Me alone!
  Make Me thy single refuge! I will free
  Thy soul from all its  sins! Be of good cheer!'),
('edwin-arnold-et:gita.18.67',0,'[Hide, the holy Krishna saith,
  This from him that hath no faith,
  Him that worships not, nor seeks
  Wisdom''s teaching when she speaks:
  Hide it from all men who mock;'),
('edwin-arnold-et:gita.18.68',0,'But, wherever, ''mid the flock
  Of My lovers, one shall teach
  This  divinest, wisest, speech--
  Teaching in the faith to bring
  Truth to them, and offering
  Of all honour unto Me--
  Unto Brahma cometh he!'),
('edwin-arnold-et:gita.18.69',0,'Nay, and nowhere shall ye find
  Any man of all mankind
  Doing dearer deed for Me;
  Nor shall any dearer be
  In My earth.'),
('edwin-arnold-et:gita.18.70',0,'Yea, furthermore,
  Whoso reads this converse o''er,
  Held by Us upon the plain,
  Pondering piously and fain,
  He hath paid Me sacrifice!
  (Krishna speaketh in this wise!)'),
('edwin-arnold-et:gita.18.71',0,'Yea, and whoso, full of faith,
  Heareth wisely what it saith,
  Heareth meekly,--when he dies,
  Surely shall his spirit rise
  To those regions where the Blest,
  Free of flesh, in joyance rest.]'),
('edwin-arnold-et:gita.18.72',0,'Hath this been heard by thee, O Indian Prince!
  With mind intent? hath all the ignorance--
  Which bred thy trouble--vanished, My Arjun?'),
('edwin-arnold-et:gita.18.73',0,'Arjuna.
  Trouble and ignorance are gone! the Light
  Hath come unto me, by Thy favour, Lord!
  Now am I fixed! my doubt is fled away!
  According to Thy word, so will I do!'),
('edwin-arnold-et:gita.18.74',0,'Sanjaya.
  Thus gathered I the gracious speech of Krishna, O my King!
  Thus have I told, with heart a-thrill, this wise and wondrous thing'),
('edwin-arnold-et:gita.18.75',0,'By great Vyasa''s learning writ, how Krishna''s self made known
  The Yoga, being Yoga''s Lord. So is the high truth shown!'),
('edwin-arnold-et:gita.18.76',0,'And aye, when I remember, O Lord my King, again
  Arjuna and the God in talk, and all this holy strain,
  Great is my gladness:'),
('edwin-arnold-et:gita.18.77',0,'when I muse that splendour, passing speech,
  Of Hari, visible and plain, there is no tongue to reach
  My marvel and my love and bliss.'),
('edwin-arnold-et:gita.18.78',0,'O Archer-Prince! all hail!
  O Krishna, Lord of Yoga! surely there shall not fail
  Blessing, and victory, and power, for Thy most mighty sake,
  Where this song comes of Arjun, and how with God he spake.'),
('edwin-arnold-et:paratext:1:chapter-colophon',0,'HERE ENDETH CHAPTER I. OF THE BHAGAVAD-GITA,
  Entitled "Arjun-Vishad,"
  Or "The Book of the Distress of Arjuna."'),
('edwin-arnold-et:paratext:2:chapter-colophon',0,'HERE ENDETH CHAPTER II. OF THE BHAGAVAD-GITA,
  Entitled "Sankhya-Yog,"
  Or "The Book of Doctrines."'),
('edwin-arnold-et:paratext:3:chapter-colophon',0,'HERE ENDETH CHAPTER III. OF THE BHAGAVAD-GITA,
  Entitled "Karma-Yog,"
  Or "The Book of Virtue in Work."'),
('edwin-arnold-et:paratext:4:chapter-colophon',0,'HERE ENDETH CHAPTER IV. OF THE BHAGAVAD-GITA,
  Entitled "Jnana Yog,"
  Or "The Book of the Religion of Knowledge,"'),
('edwin-arnold-et:paratext:5:chapter-colophon',0,'HERE ENDS CHAPTER V. OF THE BHAGAVAD-GITA,
  Entitled "Karmasanyasayog,"
  Or "The Book of Religion by Renouncing Fruit of Works."'),
('edwin-arnold-et:paratext:6:chapter-colophon',0,'HERE ENDETH CHAPTER VI. OF THE BHAGAVAD-GITA,
  Entitled "Atmasanyamayog,"
  Or "The Book of Religion by Self-Restraint."'),
('edwin-arnold-et:paratext:7:chapter-colophon',0,'HERE ENDETH CHAPTER VII. OF THE BHAGAVAD-GITA,
  Entitled "Vijnanayog,"
  Or "The Book of Religion by Discernment."'),
('edwin-arnold-et:paratext:8:omission-marker',0,'.    .    .    .    .    .    .    .    .    .    .    .    .    . [FN#14]');
--> statement-breakpoint
INSERT INTO commentary_unit_chunks (unit_id,chunk_index,content) VALUES
('edwin-arnold-et:paratext:8:chapter-colophon',0,'HERE ENDETH CHAPTER VIII. OF THE  BHAGAVAD-GITA,
  Entitled  "Aksharaparabrahmayog,"
  Or "The book of Religion by Devotion to the One Supreme God."'),
('edwin-arnold-et:paratext:9:chapter-colophon',0,'HERE ENDS CHAPTER IX. OF THE BHAGAVAD-GITA,
  Entitled "Rajavidyarajaguhyayog,"
  Or "The Book of Religion by the Kingly Knowledge and the Kingly
  Mystery."'),
('edwin-arnold-et:paratext:10:chapter-colophon',0,'HERE ENDETH CHAPTER X. OF THE BHAGAVAD-GITA,
  Entitled "Vibhuti Yog,"
  Or "The Book of Religion by the Heavenly Perfections."'),
('edwin-arnold-et:paratext:11:chapter-colophon',0,'HERE ENDETH CHAPTER XI. OF THE BHAGAVAD-GITA,
  Entitled "Viswarupadarsanam,"
  Or "The Book of the Manifesting of the One and Manifold."'),
('edwin-arnold-et:paratext:12:chapter-colophon',0,'HERE ENDETH CHAPTER XII. OF THE BHAGAVAD-GITA,
  Entitled "Bhaktiyog,"
  Or"The Book of the Religion of Faith."'),
('edwin-arnold-et:paratext:13:recensional-prelude',0,'Arjuna.
  Now would I hear, O gracious Kesava![FN#26]
  Of Life which seems, and Soul beyond, which sees,
  And what it is we know-or think to know.'),
('edwin-arnold-et:paratext:13:omission-marker',0,'.     .     .     .     .     .     .     .     .     .     .     .[FN#28]'),
('edwin-arnold-et:paratext:13:chapter-colophon',0,'HERE ENDS CHAPTER XIII. OF THE BHAGAVAD-GITA,
  Entitled "Kshetrakshetrajnavibhagayog,"
  Or "The Book of Religion by Separation of Matter and Spirit."'),
('edwin-arnold-et:paratext:14:chapter-colophon',0,'HERE ENDS CHAPTER XIV. OF THE BHAGAVAD-GITA
  Entitled "Gunatrayavibhagayog,"
  Or "The Book of Religion by Separation from the Qualities."'),
('edwin-arnold-et:paratext:15:chapter-colophon',0,'HERE ENDS CHAPTER XV. OF THE BHAGAVAD-GITA
  Entitled "Purushottamapraptiyog,"
  Or "The Book of Religion by attaining the Supreme."'),
('edwin-arnold-et:paratext:16:omission-marker',0,'.     .     .     .     .     .     .     .     .     .     .     .[FN#33]'),
('edwin-arnold-et:paratext:16:chapter-colophon',0,'HERE ENDETH CHAPTER XVI. OF THE BHAGAVAD-GITA,
  Entitled  "Daivasarasaupadwibhagayog,"
  Or "The Book of the Separateness of the Divine and Undivine."'),
('edwin-arnold-et:paratext:17:chapter-colophon',0,'HERE ENDETH CHAPTER XVII. OF THE  BHAGAVAD-GITA,
  Entitled "Sraddhatrayavibhagayog,"
  Or "The Book of Religion by the Threefold Kinds of Faith."'),
('edwin-arnold-et:paratext:18:chapter-colophon',0,'HERE ENDS, WITH CHAPTER XVIII.,
  Entitled "Mokshasanyasayog,"
  Or "The Book of Religion by Deliverance and Renunciation,"
  THE BHAGAVAD-GITA.');
--> statement-breakpoint
INSERT INTO commentary_fts (unit_id,author,canonical_ref,language,content_type,content) VALUES
('edwin-arnold-et:gita.1.1','Sir Edwin Arnold','gita.1.1','en','translation','Dhritirashtra:
  Ranged thus for battle on the sacred plain--
  On Kurukshetra--say, Sanjaya! say
  What wrought my people, and the Pandavas?'),
('edwin-arnold-et:gita.1.2','Sir Edwin Arnold','gita.1.2','en','translation','Sanjaya:
  When he beheld the host of Pandavas,
  Raja Duryodhana to Drona drew,
  And spake these words:'),
('edwin-arnold-et:gita.1.3','Sir Edwin Arnold','gita.1.3','en','translation','"Ah, Guru! see this line,
  How vast it is of Pandu fighting-men,
  Embattled by the son of Drupada,
  Thy scholar in the war!'),
('edwin-arnold-et:gita.1.4','Sir Edwin Arnold','gita.1.4','en','translation','Therein stand ranked
  Chiefs like Arjuna, like to Bhima chiefs,
  Benders of bows; Virata, Yuyudhan,
  Drupada, eminent upon his car,'),
('edwin-arnold-et:gita.1.5','Sir Edwin Arnold','gita.1.5','en','translation','Dhrishtaket, Chekitan, Kasi''s stout lord,
  Purujit, Kuntibhoj, and Saivya,'),
('edwin-arnold-et:gita.1.6','Sir Edwin Arnold','gita.1.6','en','translation','With Yudhamanyu, and Uttamauj
  Subhadra''s child; and Drupadi''s;-all famed!
  All mounted on their shining chariots!'),
('edwin-arnold-et:gita.1.7','Sir Edwin Arnold','gita.1.7','en','translation','On our side, too,--thou best of Brahmans! see
  Excellent chiefs, commanders of my line,
  Whose names I joy to count:'),
('edwin-arnold-et:gita.1.8','Sir Edwin Arnold','gita.1.8','en','translation','thyself the first,
  Then Bhishma, Karna, Kripa fierce in fight,
  Vikarna, Aswatthaman; next to these
  Strong Saumadatti,'),
('edwin-arnold-et:gita.1.9','Sir Edwin Arnold','gita.1.9','en','translation','with full many more
  Valiant and tried, ready this day to die
  For me their king, each with his weapon grasped,
  Each skilful in the field.'),
('edwin-arnold-et:gita.1.10','Sir Edwin Arnold','gita.1.10','en','translation','Weakest-meseems-
  Our battle shows where Bhishma holds command,
  And Bhima, fronting him, something too strong!'),
('edwin-arnold-et:gita.1.11','Sir Edwin Arnold','gita.1.11','en','translation','Have care our captains nigh to Bhishma''s ranks
  Prepare what help they may! Now, blow my shell!"'),
('edwin-arnold-et:gita.1.12','Sir Edwin Arnold','gita.1.12','en','translation','Then, at the signal of the aged king,
  With blare to wake the blood, rolling around
  Like to a lion''s roar, the trumpeter
  Blew the great Conch;'),
('edwin-arnold-et:gita.1.13','Sir Edwin Arnold','gita.1.13','en','translation','and, at the noise of it,
  Trumpets and drums, cymbals and gongs and horns
  Burst into sudden clamour; as the blasts
  Of loosened tempest, such the tumult seemed!'),
('edwin-arnold-et:gita.1.14','Sir Edwin Arnold','gita.1.14','en','translation','Then might be seen, upon their car of gold
  Yoked with white steeds, blowing their battle-shells,
  Krishna the God, Arjuna at his side:'),
('edwin-arnold-et:gita.1.15','Sir Edwin Arnold','gita.1.15','en','translation','Krishna, with knotted locks, blew his great conch
  Carved of the "Giant''s bone;" Arjuna blew
  Indra''s loud gift; Bhima the terrible--
  Wolf-bellied Bhima-blew a long reed-conch;'),
('edwin-arnold-et:gita.1.16','Sir Edwin Arnold','gita.1.16','en','translation','And Yudhisthira, Kunti''s blameless son,
  Winded a mighty shell, "Victory''s Voice;"
  And Nakula blew shrill upon his conch
  Named the "Sweet-sounding," Sahadev on his
  Called"Gem-bedecked,"'),
('edwin-arnold-et:gita.1.17','Sir Edwin Arnold','gita.1.17','en','translation','and Kasi''s Prince on his.
  Sikhandi on his car, Dhrishtadyumn,
  Virata, Satyaki the Unsubdued,'),
('edwin-arnold-et:gita.1.18','Sir Edwin Arnold','gita.1.18','en','translation','Drupada, with his sons, (O Lord of Earth!)
  Long-armed Subhadra''s children, all blew loud,'),
('edwin-arnold-et:gita.1.19','Sir Edwin Arnold','gita.1.19','en','translation','So that the clangour shook their foemen''s hearts,
  With quaking earth and thundering heav''n.'),
('edwin-arnold-et:gita.1.20','Sir Edwin Arnold','gita.1.20','en','translation','Then ''twas-
  Beholding Dhritirashtra''s battle set,
  Weapons unsheathing, bows drawn forth, the war
  Instant to break-Arjun, whose ensign-badge
  Was Hanuman the monkey, spake this thing
  To Krishna the Divine, his charioteer:'),
('edwin-arnold-et:gita.1.21','Sir Edwin Arnold','gita.1.21','en','translation','"Drive, Dauntless One! to yonder open ground
  Betwixt the armies;'),
('edwin-arnold-et:gita.1.22','Sir Edwin Arnold','gita.1.22','en','translation','I would see more nigh
  These who will fight with us, those we must slay
  To-day, in war''s arbitrament;'),
('edwin-arnold-et:gita.1.23','Sir Edwin Arnold','gita.1.23','en','translation','for, sure,
  On bloodshed all are bent who throng this plain,
  Obeying Dhritirashtra''s sinful son."'),
('edwin-arnold-et:gita.1.24','Sir Edwin Arnold','gita.1.24','en','translation','Thus, by Arjuna prayed, (O Bharata!)
  Between the hosts that heavenly Charioteer
  Drove the bright car, reining its milk-white steeds'),
('edwin-arnold-et:gita.1.25','Sir Edwin Arnold','gita.1.25','en','translation','Where Bhishma led,and Drona,and their Lords.
  "See!" spake he to Arjuna, "where they stand,
  Thy kindred of the Kurus:"'),
('edwin-arnold-et:gita.1.26','Sir Edwin Arnold','gita.1.26','en','translation','and the Prince
  Marked on each hand the kinsmen of his house,
  Grandsires and sires, uncles and brothers and sons,
  Cousins and sons-in-law and nephews, mixed
  With friends and honoured elders; some this side,
  Some that side ranged: and, seeing those opposed,
  Such kith grown enemies-Arjuna''s heart
  Melted with pity, while he uttered this:'),
('edwin-arnold-et:gita.1.27','Sir Edwin Arnold','gita.1.27','en','translation','and the Prince
  Marked on each hand the kinsmen of his house,
  Grandsires and sires, uncles and brothers and sons,
  Cousins and sons-in-law and nephews, mixed
  With friends and honoured elders; some this side,
  Some that side ranged: and, seeing those opposed,
  Such kith grown enemies-Arjuna''s heart
  Melted with pity, while he uttered this:'),
('edwin-arnold-et:gita.1.28','Sir Edwin Arnold','gita.1.28','en','translation','Arjuna.
  Krishna! as I behold, come here to shed
  Their common blood, yon concourse of our kin,'),
('edwin-arnold-et:gita.1.29','Sir Edwin Arnold','gita.1.29','en','translation','My members fail, my tongue dries in my mouth,
  A shudder thrills my body, and my hair
  Bristles with horror;'),
('edwin-arnold-et:gita.1.30','Sir Edwin Arnold','gita.1.30','en','translation','from my weak hand slips
  Gandiv, the goodly bow; a fever burns
  My skin to parching; hardly may I stand;
  The life within me seems to swim and faint;'),
('edwin-arnold-et:gita.1.31','Sir Edwin Arnold','gita.1.31','en','translation','Nothing do I foresee save woe and wail!
  It is not good, O Keshav! nought of good
  Can spring from mutual slaughter!'),
('edwin-arnold-et:gita.1.32','Sir Edwin Arnold','gita.1.32','en','translation','Lo, I hate
  Triumph and domination, wealth and ease,
  Thus sadly won! Aho! what victory
  Can bring delight, Govinda! what rich spoils
  Could profit; what rule recompense; what span
  Of life itself seem sweet, bought with such blood?'),
('edwin-arnold-et:gita.1.33','Sir Edwin Arnold','gita.1.33','en','translation','Seeing that these stand here, ready to die,
  For whose sake life was fair, and pleasure pleased,
  And power grew precious:-'),
('edwin-arnold-et:gita.1.34','Sir Edwin Arnold','gita.1.34','en','translation','grandsires, sires, and sons,
  Brothers, and fathers-in-law, and sons-in-law,
  Elders and friends!'),
('edwin-arnold-et:gita.1.35','Sir Edwin Arnold','gita.1.35','en','translation','Shall I deal death on these
  Even though they seek to slay us? Not one blow,
  O Madhusudan! will I strike to gain

  The rule of all Three Worlds; then, how much less
  To seize an earthly kingdom!'),
('edwin-arnold-et:gita.1.36','Sir Edwin Arnold','gita.1.36','en','translation','Killing these
  Must breed but anguish, Krishna! If they be
  Guilty, we shall grow guilty by their deaths;'),
('edwin-arnold-et:gita.1.37','Sir Edwin Arnold','gita.1.37','en','translation','Their sins will light on us, if we shall slay
  Those sons of Dhritirashtra, and our kin;
  What peace could come of that, O Madhava?'),
('edwin-arnold-et:gita.1.38','Sir Edwin Arnold','gita.1.38','en','translation','For if indeed, blinded by lust and wrath,
  These cannot see, or will not see, the sin
  Of kingly lines o''erthrown and kinsmen slain,'),
('edwin-arnold-et:gita.1.39','Sir Edwin Arnold','gita.1.39','en','translation','How should not we, who see, shun such a crime--
  We who perceive the guilt and feel the shame--
  O thou Delight of Men, Janardana?'),
('edwin-arnold-et:gita.1.40','Sir Edwin Arnold','gita.1.40','en','translation','By overthrow of houses perisheth
  Their sweet continuous household piety,
  And-rites neglected, piety extinct--
  Enters impiety upon that home;'),
('edwin-arnold-et:gita.1.41','Sir Edwin Arnold','gita.1.41','en','translation','Its women grow unwomaned, whence there spring
  Mad passions, and the mingling-up of castes,'),
('edwin-arnold-et:gita.1.42','Sir Edwin Arnold','gita.1.42','en','translation','Sending a Hell-ward road that family,
  And whoso wrought its doom by wicked wrath.
  Nay, and the souls of honoured ancestors
  Fall from their place of peace, being bereft
  Of funeral-cakes and the wan death-water.[FN#1]'),
('edwin-arnold-et:gita.1.44','Sir Edwin Arnold','gita.1.44','en','translation','So teach our holy hymns.'),
('edwin-arnold-et:gita.1.45','Sir Edwin Arnold','gita.1.45','en','translation','Thus, if we slay
  Kinsfolk and friends for love of earthly power,
  Ahovat! what an evil fault it were!'),
('edwin-arnold-et:gita.1.46','Sir Edwin Arnold','gita.1.46','en','translation','Better I deem it, if my kinsmen strike,
  To face them weaponless, and bare my breast
  To shaft and spear, than answer blow with blow.'),
('edwin-arnold-et:gita.1.47','Sir Edwin Arnold','gita.1.47','en','translation','So speaking, in the face of those two hosts,
  Arjuna sank upon his chariot-seat,
  And let fall bow and arrows, sick at heart.'),
('edwin-arnold-et:gita.2.1','Sir Edwin Arnold','gita.2.1','en','translation','Sanjaya.
  Him, filled with such compassion and such grief,
  With eyes tear-dimmed, despondent, in stern words
  The Driver, Madhusudan, thus addressed:'),
('edwin-arnold-et:gita.2.2','Sir Edwin Arnold','gita.2.2','en','translation','Krishna.
  How hath this weakness taken thee? Whence springs
  The inglorious trouble, shameful to the brave,
  Barring the path of virtue?'),
('edwin-arnold-et:gita.2.3','Sir Edwin Arnold','gita.2.3','en','translation','Nay, Arjun!
  Forbid thyself to feebleness! it mars
  Thy warrior-name! cast off the coward-fit!
  Wake! Be thyself! Arise, Scourge of thy Foes!'),
('edwin-arnold-et:gita.2.4','Sir Edwin Arnold','gita.2.4','en','translation','Arjuna.
  How can I, in the battle, shoot with shafts
  On Bhishma, or on Drona-O thou Chief!--
  Both worshipful, both honourable men?'),
('edwin-arnold-et:gita.2.5','Sir Edwin Arnold','gita.2.5','en','translation','Better to live on beggar''s bread
    With those we love alive,
  Than taste their blood in rich feasts spread,
    And guiltily survive!'),
('edwin-arnold-et:gita.2.6','Sir Edwin Arnold','gita.2.6','en','translation','Ah! were it worse-who knows?--to be
    Victor or vanquished here,
  When those confront us angrily
    Whose death leaves living drear?'),
('edwin-arnold-et:gita.2.7','Sir Edwin Arnold','gita.2.7','en','translation','In pity lost, by doubtings tossed,
    My thoughts-distracted-turn
  To Thee, the Guide I reverence most,
    That I may counsel learn:'),
('edwin-arnold-et:gita.2.8','Sir Edwin Arnold','gita.2.8','en','translation','I know not what would heal the grief
    Burned into soul and sense,
  If I were earth''s unchallenged chief--
    A god--and these gone thence!'),
('edwin-arnold-et:gita.2.9','Sir Edwin Arnold','gita.2.9','en','translation','Sanjaya.
  So spake Arjuna to the Lord of  Hearts,
  And sighing,"I will not fight!" held silence then.'),
('edwin-arnold-et:gita.2.10','Sir Edwin Arnold','gita.2.10','en','translation','To whom, with tender smile, (O Bharata! )
  While the Prince wept despairing ''twixt those hosts,
  Krishna made answer in divinest verse:'),
('edwin-arnold-et:gita.2.11','Sir Edwin Arnold','gita.2.11','en','translation','Krishna.
  Thou grievest where no grief should be! thou speak''st
  Words lacking wisdom! for the wise in heart
  Mourn not for those that live, nor those that die.'),
('edwin-arnold-et:gita.2.12','Sir Edwin Arnold','gita.2.12','en','translation','Nor I, nor thou, nor any one of these,
  Ever was not, nor ever will not be,
  For ever and for ever afterwards.
  All, that doth live, lives always!'),
('edwin-arnold-et:gita.2.13','Sir Edwin Arnold','gita.2.13','en','translation','To man''s frame
  As there come infancy and youth and age,
  So come there raisings-up and layings-down
  Of other and of other life-abodes,
  Which the wise know, and fear not.'),
('edwin-arnold-et:gita.2.14','Sir Edwin Arnold','gita.2.14','en','translation','This that irks--
  Thy sense-life, thrilling to the elements--
  Bringing thee heat and cold, sorrows and joys,
  ''Tis brief and mutable! Bear with it, Prince!
  As the wise bear.'),
('edwin-arnold-et:gita.2.15','Sir Edwin Arnold','gita.2.15','en','translation','The soul which is not moved,
  The soul that with a strong and constant calm
  Takes sorrow and takes joy indifferently,
  Lives in the life undying!'),
('edwin-arnold-et:gita.2.16','Sir Edwin Arnold','gita.2.16','en','translation','That which is
  Can never cease to be; that which is not
  Will not exist. To see this truth of both
  Is theirs who part essence from accident,
  Substance from shadow.'),
('edwin-arnold-et:gita.2.17','Sir Edwin Arnold','gita.2.17','en','translation','Indestructible,
  Learn thou! the Life is, spreading life through all;
  It cannot anywhere, by any means,
  Be anywise diminished, stayed, or changed.'),
('edwin-arnold-et:gita.2.18','Sir Edwin Arnold','gita.2.18','en','translation','But for these fleeting frames which it informs
  With spirit deathless, endless, infinite,
  They perish. Let them perish, Prince! and fight!'),
('edwin-arnold-et:gita.2.19','Sir Edwin Arnold','gita.2.19','en','translation','He who shall say, "Lo! I have slain a man!"
  He who shall think, "Lo! I am slain!" those both
  Know naught! Life cannot slay. Life is not slain!'),
('edwin-arnold-et:gita.2.20','Sir Edwin Arnold','gita.2.20','en','translation','Never the spirit was born; the spirit shall cease to be never;
  Never was time it was not; End and Beginning are dreams!
  Birthless and deathless and changeless remaineth the spirit for ever;
  Death hath not touched it at all, dead though the house of it seems!'),
('edwin-arnold-et:gita.2.21','Sir Edwin Arnold','gita.2.21','en','translation','Who knoweth it exhaustless, self-sustained,
  Immortal, indestructible,--shall such
  Say, "I have killed a man, or caused to kill?"'),
('edwin-arnold-et:gita.2.22','Sir Edwin Arnold','gita.2.22','en','translation','Nay, but as when one layeth
    His worn-out robes away,
  And taking new ones, sayeth,
    "These will I wear to-day!"
  So putteth by the spirit
    Lightly its garb of flesh,
  And passeth to inherit
    A residence afresh.'),
('edwin-arnold-et:gita.2.23','Sir Edwin Arnold','gita.2.23','en','translation','I say to thee weapons reach not the Life;
  Flame burns it not, waters cannot o''erwhelm,
  Nor dry winds wither it.'),
('edwin-arnold-et:gita.2.24','Sir Edwin Arnold','gita.2.24','en','translation','Impenetrable,
  Unentered, unassailed, unharmed, untouched,
  Immortal, all-arriving, stable, sure,'),
('edwin-arnold-et:gita.2.25','Sir Edwin Arnold','gita.2.25','en','translation','Invisible, ineffable, by word
  And thought uncompassed, ever all itself,
  Thus is the Soul declared! How wilt thou, then,--
  Knowing it so,--grieve when thou shouldst not grieve?'),
('edwin-arnold-et:gita.2.26','Sir Edwin Arnold','gita.2.26','en','translation','How, if thou hearest that the man new-dead
  Is, like the man new-born, still living man--
  One same, existent Spirit--wilt thou weep?'),
('edwin-arnold-et:gita.2.27','Sir Edwin Arnold','gita.2.27','en','translation','The end of birth is death; the end of death
  Is birth: this is ordained! and mournest thou,
  Chief of the stalwart arm! for what befalls
  Which could not otherwise befall?'),
('edwin-arnold-et:gita.2.28','Sir Edwin Arnold','gita.2.28','en','translation','The birth
  Of living things comes unperceived; the death
  Comes unperceived; between them, beings perceive:
  What is there sorrowful herein, dear Prince?'),
('edwin-arnold-et:gita.2.29','Sir Edwin Arnold','gita.2.29','en','translation','Wonderful, wistful, to contemplate!
    Difficult, doubtful, to speak upon!
  Strange and great for tongue to relate,
    Mystical hearing for every one!
  Nor wotteth man this, what a marvel it is,
    When seeing, and saying, and hearing are done!'),
('edwin-arnold-et:gita.2.30','Sir Edwin Arnold','gita.2.30','en','translation','This Life within all living things, my Prince!
  Hides beyond harm; scorn thou to suffer, then,
  For that which cannot suffer.'),
('edwin-arnold-et:gita.2.31','Sir Edwin Arnold','gita.2.31','en','translation','Do thy part!
  Be mindful of thy name, and tremble not!
  Nought better can betide a martial soul
  Than lawful war;'),
('edwin-arnold-et:gita.2.32','Sir Edwin Arnold','gita.2.32','en','translation','happy the warrior
  To whom comes joy of battle--comes, as now,
  Glorious and fair, unsought; opening for him
  A gateway unto Heav''n.'),
('edwin-arnold-et:gita.2.33','Sir Edwin Arnold','gita.2.33','en','translation','But, if thou shunn''st
  This honourable field--a Kshattriya--
  If, knowing thy duty and thy task, thou bidd''st
  Duty and task go by--that shall be sin!'),
('edwin-arnold-et:gita.2.34','Sir Edwin Arnold','gita.2.34','en','translation','And those to come shall speak thee infamy
  From age to age; but infamy is worse
  For men of noble blood to bear than death!'),
('edwin-arnold-et:gita.2.35','Sir Edwin Arnold','gita.2.35','en','translation','The chiefs upon their battle-chariots
  Will deem ''twas fear that drove thee from the fray.
  Of those who held thee mighty-souled the scorn
  Thou must abide,'),
('edwin-arnold-et:gita.2.36','Sir Edwin Arnold','gita.2.36','en','translation','while all thine enemies
  Will scatter bitter speech of thee, to mock
  The valour which thou hadst; what fate could fall
  More grievously than this?'),
('edwin-arnold-et:gita.2.37','Sir Edwin Arnold','gita.2.37','en','translation','Either--being killed--
  Thou wilt win Swarga''s safety, or--alive
  And victor--thou wilt reign an earthly king.
  Therefore, arise, thou Son of Kunti! brace
  Thine arm for conflict,'),
('edwin-arnold-et:gita.2.38','Sir Edwin Arnold','gita.2.38','en','translation','nerve thy heart to meet--
  As things alike to thee--pleasure or pain,
  Profit or ruin, victory or defeat:
  So minded, gird thee to the fight, for so
  Thou shalt not sin!'),
('edwin-arnold-et:gita.2.39','Sir Edwin Arnold','gita.2.39','en','translation','Thus far I speak to thee
  As from the "Sankhya"--unspiritually--
  Hear now the deeper teaching of the Yog,
  Which holding, understanding, thou shalt burst
  Thy Karmabandh, the bondage of wrought deeds.'),
('edwin-arnold-et:gita.2.40','Sir Edwin Arnold','gita.2.40','en','translation','Here shall no end be hindered, no hope marred,
  No loss be feared: faith--yea, a little faith--
  Shall save thee from the anguish of thy dread.'),
('edwin-arnold-et:gita.2.41','Sir Edwin Arnold','gita.2.41','en','translation','Here, Glory of the Kurus! shines one rule--
  One steadfast rule--while shifting souls have laws
  Many and hard.'),
('edwin-arnold-et:gita.2.42','Sir Edwin Arnold','gita.2.42','en','translation','Specious, but wrongful deem
  The speech of those ill-taught ones who extol
  The letter of their Vedas, saying, "This
  Is all we have, or need;"'),
('edwin-arnold-et:gita.2.43','Sir Edwin Arnold','gita.2.43','en','translation','being weak at heart
  With wants, seekers of Heaven: which comes--they say--
  As "fruit of good deeds done;" promising men
  Much profit in new births for works of faith;
  In various rites abounding; following whereon
  Large merit shall accrue towards wealth and power;'),
('edwin-arnold-et:gita.2.44','Sir Edwin Arnold','gita.2.44','en','translation','Albeit, who wealth and power do most desire
  Least fixity of soul have such, least hold
  On heavenly meditation.'),
('edwin-arnold-et:gita.2.45','Sir Edwin Arnold','gita.2.45','en','translation','Much these teach,
  From Veds, concerning the "three qualities;"
  But thou, be free of the "three qualities,"
  Free of the "pairs of opposites,"[FN#2] and free
  From that sad righteousness which calculates;
  Self-ruled, Arjuna! simple, satisfied![FN#3]'),
('edwin-arnold-et:gita.2.46','Sir Edwin Arnold','gita.2.46','en','translation','Look! like as when a tank pours water forth
  To suit all needs, so do these Brahmans draw
  Text for all wants from tank of Holy Writ.'),
('edwin-arnold-et:gita.2.47','Sir Edwin Arnold','gita.2.47','en','translation','But thou, want not! ask not! Find full reward
  Of doing right in right! Let right deeds be
  Thy motive, not the fruit which comes from them.
  And live in action! Labour!'),
('edwin-arnold-et:gita.2.48','Sir Edwin Arnold','gita.2.48','en','translation','Make thine acts
  Thy piety, casting all self aside,
  Contemning gain and merit; equable
  In good or evil: equability
  Is Yog, is piety!'),
('edwin-arnold-et:gita.2.49','Sir Edwin Arnold','gita.2.49','en','translation','Yet, the right act
  Is less, far less, than the right-thinking mind.
  Seek refuge in thy soul; have there thy heaven!
  Scorn them that follow virtue for her gifts!'),
('edwin-arnold-et:gita.2.50','Sir Edwin Arnold','gita.2.50','en','translation','The mind of pure devotion--even here--
  Casts equally aside good deeds and bad,
  Passing above them. Unto pure devotion
  Devote thyself: with perfect meditation
  Comes perfect act,'),
('edwin-arnold-et:gita.2.51','Sir Edwin Arnold','gita.2.51','en','translation','and the right-hearted rise--
  More certainly because they seek no gain--
  Forth from the bands of body, step by step,
  To highest seats of bliss.'),
('edwin-arnold-et:gita.2.52','Sir Edwin Arnold','gita.2.52','en','translation','When thy firm soul
  Hath shaken off those tangled oracles
  Which ignorantly guide, then shall it soar
  To high neglect of what''s denied or said,
  This way or that way, in doctrinal writ.'),
('edwin-arnold-et:gita.2.53','Sir Edwin Arnold','gita.2.53','en','translation','Troubled no longer by the priestly lore,
  Safe shall it live, and sure; steadfastly bent
  On meditation. This is Yog--and Peace!'),
('edwin-arnold-et:gita.2.54','Sir Edwin Arnold','gita.2.54','en','translation','Arjuna.
  What is his mark who hath that steadfast heart,
  Confirmed in holy meditation? How
  Know we his speech, Kesava? Sits he, moves he
  Like other men?'),
('edwin-arnold-et:gita.2.55','Sir Edwin Arnold','gita.2.55','en','translation','Krishna.
  When one, O Pritha''s Son!
  Abandoning desires which shake the mind--
  Finds in his soul full comfort for his soul,
  He hath attained the Yog--that man is such!'),
('edwin-arnold-et:gita.2.56','Sir Edwin Arnold','gita.2.56','en','translation','In sorrows not dejected, and in joys
  Not overjoyed; dwelling outside the stress
  Of passion, fear, and anger; fixed in calms
  Of lofty contemplation;--such an one
  Is Muni, is the Sage, the true Recluse!'),
('edwin-arnold-et:gita.2.57','Sir Edwin Arnold','gita.2.57','en','translation','He who to none and nowhere overbound
  By ties of flesh, takes evil things and good
  Neither desponding nor exulting, such
  Bears wisdom''s plainest mark!'),
('edwin-arnold-et:gita.2.58','Sir Edwin Arnold','gita.2.58','en','translation','He who shall draw
  As the wise tortoise draws its four feet safe
  Under its shield, his five frail senses back
  Under the spirit''s buckler from the world
  Which else assails them, such an one, my Prince!
  Hath wisdom''s mark!'),
('edwin-arnold-et:gita.2.59','Sir Edwin Arnold','gita.2.59','en','translation','Things that solicit sense
  Hold off from the self-governed; nay, it comes,
  The appetites of him who lives beyond
  Depart,--aroused no more.'),
('edwin-arnold-et:gita.2.60','Sir Edwin Arnold','gita.2.60','en','translation','Yet may it chance,
  O Son of Kunti! that a governed mind
  Shall some time feel the sense-storms sweep, and wrest
  Strong self-control by the roots.'),
('edwin-arnold-et:gita.2.61','Sir Edwin Arnold','gita.2.61','en','translation','Let him regain
  His kingdom! let him conquer this, and sit
  On Me intent. That man alone is wise
  Who keeps the mastery of himself!'),
('edwin-arnold-et:gita.2.62','Sir Edwin Arnold','gita.2.62','en','translation','If one
  Ponders on objects of the sense, there springs
  Attraction; from attraction grows desire,
  Desire flames to fierce passion,'),
('edwin-arnold-et:gita.2.63','Sir Edwin Arnold','gita.2.63','en','translation','passion breeds
  Recklessness; then the memory--all betrayed--
  Lets noble purpose go, and saps the mind,
  Till purpose, mind, and man are all undone.'),
('edwin-arnold-et:gita.2.64','Sir Edwin Arnold','gita.2.64','en','translation','But, if one deals with objects of the sense
  Not loving and not hating, making them
  Serve his free soul, which rests serenely lord,
  Lo! such a man comes to tranquillity;'),
('edwin-arnold-et:gita.2.65','Sir Edwin Arnold','gita.2.65','en','translation','And out of that tranquillity shall rise
  The end and healing of his earthly pains,
  Since the will governed sets the soul at peace.'),
('edwin-arnold-et:gita.2.66','Sir Edwin Arnold','gita.2.66','en','translation','The soul of the ungoverned is not his,
  Nor hath he knowledge of himself; which lacked,
  How grows serenity? and, wanting that,
  Whence shall he hope for happiness?'),
('edwin-arnold-et:gita.2.67','Sir Edwin Arnold','gita.2.67','en','translation','The mind
  That gives itself to follow shows of sense
  Seeth its helm of wisdom rent away,
  And, like a ship in waves of whirlwind, drives
  To wreck and death.'),
('edwin-arnold-et:gita.2.68','Sir Edwin Arnold','gita.2.68','en','translation','Only with him, great Prince!
  Whose senses are not swayed by things of sense--
  Only with him who holds his mastery,
  Shows wisdom perfect.'),
('edwin-arnold-et:gita.2.69','Sir Edwin Arnold','gita.2.69','en','translation','What is midnight-gloom
  To unenlightened souls shines wakeful day
  To his clear gaze; what seems as wakeful day
  Is known for night, thick night of ignorance,
  To his true-seeing eyes. Such is the Saint!'),
('edwin-arnold-et:gita.2.70','Sir Edwin Arnold','gita.2.70','en','translation','And like the ocean, day by day receiving
      Floods from all lands, which never overflows
  Its boundary-line not leaping, and not leaving,
      Fed by the rivers, but unswelled by those;--

  So is the perfect one! to his soul''s ocean
      The world of sense pours streams of witchery;
  They leave him as they find, without commotion,
      Taking their tribute, but remaining sea.'),
('edwin-arnold-et:gita.2.71','Sir Edwin Arnold','gita.2.71','en','translation','Yea! whoso, shaking off the yoke of flesh
  Lives lord, not servant, of his lusts; set free
  From pride, from passion, from the sin of "Self,"
  Toucheth tranquillity!'),
('edwin-arnold-et:gita.2.72','Sir Edwin Arnold','gita.2.72','en','translation','O Pritha''s Son!
  That is the state of Brahm! There rests no dread
  When that last step is reached! Live where he will,
  Die when he may, such passeth from all ''plaining,
  To blest Nirvana, with the Gods, attaining.'),
('edwin-arnold-et:gita.3.1','Sir Edwin Arnold','gita.3.1','en','translation','Arjuna.
  Thou whom all mortals praise, Janardana!
  If meditation be a nobler thing
  Than action, wherefore, then, great Kesava!
  Dost thou impel me to this dreadful fight?'),
('edwin-arnold-et:gita.3.2','Sir Edwin Arnold','gita.3.2','en','translation','Now am I by thy doubtful speech disturbed!
  Tell me one thing, and tell me certainly;
  By what road shall I find the better end?'),
('edwin-arnold-et:gita.3.3','Sir Edwin Arnold','gita.3.3','en','translation','Krishna.
  I told thee, blameless Lord! there be two paths
  Shown to this world; two schools of wisdom.

  First
  The Sankhya''s, which doth save in way of works
  Prescribed[FN#4] by reason; next, the Yog, which bids
  Attain by meditation, spiritually:
  Yet these are one!'),
('edwin-arnold-et:gita.3.4','Sir Edwin Arnold','gita.3.4','en','translation','No man shall ''scape from act
  By shunning action; nay, and none shall come
  By mere renouncements unto perfectness.'),
('edwin-arnold-et:gita.3.5','Sir Edwin Arnold','gita.3.5','en','translation','Nay, and no jot of time, at any time,
  Rests any actionless; his nature''s law
  Compels him, even unwilling, into act;
  [For thought is act in fancy].'),
('edwin-arnold-et:gita.3.6','Sir Edwin Arnold','gita.3.6','en','translation','He who sits
  Suppressing all the instruments of flesh,
  Yet in his idle heart thinking on them,
  Plays the inept and guilty hypocrite:'),
('edwin-arnold-et:gita.3.7','Sir Edwin Arnold','gita.3.7','en','translation','But he who, with strong body serving mind,
  Gives up his mortal powers to worthy work,
  Not seeking gain, Arjuna! such an one
  Is honourable.'),
('edwin-arnold-et:gita.3.8','Sir Edwin Arnold','gita.3.8','en','translation','Do thine allotted task!
  Work is more excellent than idleness;
  The body''s life proceeds not, lacking work.'),
('edwin-arnold-et:gita.3.9','Sir Edwin Arnold','gita.3.9','en','translation','There is a task of holiness to do,
  Unlike world-binding toil, which bindeth not
  The faithful soul; such earthly duty do
  Free from desire, and thou shalt well perform
  Thy heavenly purpose.'),
('edwin-arnold-et:gita.3.10','Sir Edwin Arnold','gita.3.10','en','translation','Spake Prajapati--
  In the beginning, when all men were made,
  And, with mankind, the sacrifice-- "Do this!
  Work! sacrifice! Increase and multiply
  With sacrifice! This shall be Kamaduk,
  Your ''Cow of Plenty,'' giving back her milk
  Of all abundance.'),
('edwin-arnold-et:gita.3.11','Sir Edwin Arnold','gita.3.11','en','translation','Worship the gods thereby;
  The gods shall yield thee grace.'),
('edwin-arnold-et:gita.3.12','Sir Edwin Arnold','gita.3.12','en','translation','Those meats ye crave
  The gods will grant to Labour, when it pays
  Tithes in the altar-flame. But if one eats
  Fruits of the earth, rendering to kindly Heaven
  No gift of toil, that thief steals from his world."'),
('edwin-arnold-et:gita.3.13','Sir Edwin Arnold','gita.3.13','en','translation','Who eat of food after their sacrifice
  Are quit of fault, but they that spread a feast
  All for themselves, eat sin and drink of sin.'),
('edwin-arnold-et:gita.3.14','Sir Edwin Arnold','gita.3.14','en','translation','By food the living live; food comes of rain,
  And rain comes by the pious sacrifice,
  And sacrifice is paid with tithes of toil;'),
('edwin-arnold-et:gita.3.15','Sir Edwin Arnold','gita.3.15','en','translation','Thus action is of Brahma, who is One,
  The Only, All-pervading; at all times
  Present in sacrifice.'),
('edwin-arnold-et:gita.3.16','Sir Edwin Arnold','gita.3.16','en','translation','He that abstains
  To help the rolling wheels of this great world,
  Glutting his idle sense, lives a lost life,
  Shameful and vain.'),
('edwin-arnold-et:gita.3.17','Sir Edwin Arnold','gita.3.17','en','translation','Existing for himself,
  Self-concentrated, serving self alone,
  No part hath he in aught;'),
('edwin-arnold-et:gita.3.18','Sir Edwin Arnold','gita.3.18','en','translation','nothing achieved,
  Nought wrought or unwrought toucheth him; no hope
  Of help for all the living things of earth
  Depends from him.[FN#5]'),
('edwin-arnold-et:gita.3.19','Sir Edwin Arnold','gita.3.19','en','translation','Therefore, thy task prescribed
  With spirit unattached gladly perform,
  Since in performance of plain duty man
  Mounts to his highest bliss.'),
('edwin-arnold-et:gita.3.20','Sir Edwin Arnold','gita.3.20','en','translation','By works alone
  Janak and ancient saints reached blessedness!
  Moreover, for the upholding of thy kind,
  Action thou should''st embrace.'),
('edwin-arnold-et:gita.3.21','Sir Edwin Arnold','gita.3.21','en','translation','What the wise choose
  The unwise people take; what best men do
  The multitude will follow.'),
('edwin-arnold-et:gita.3.22','Sir Edwin Arnold','gita.3.22','en','translation','Look on me,
  Thou Son of Pritha! in the three wide worlds
  I am not bound to any toil, no height
  Awaits to scale, no gift remains to gain,
  Yet I act here!'),
('edwin-arnold-et:gita.3.23','Sir Edwin Arnold','gita.3.23','en','translation','and, if I acted not--
  Earnest and watchful--those that look to me
  For guidance, sinking back to sloth again
  Because I slumbered, would decline from good,'),
('edwin-arnold-et:gita.3.24','Sir Edwin Arnold','gita.3.24','en','translation','And I should break earth''s order and commit
  Her offspring unto ruin, Bharata!'),
('edwin-arnold-et:gita.3.25','Sir Edwin Arnold','gita.3.25','en','translation','Even as the unknowing toil, wedded to sense,
  So let the enlightened toil, sense-freed, but set
  To bring the world deliverance, and its bliss;'),
('edwin-arnold-et:gita.3.26','Sir Edwin Arnold','gita.3.26','en','translation','Not sowing in those simple, busy hearts
  Seed of despair. Yea! let each play his part
  In all he finds to do, with unyoked soul.'),
('edwin-arnold-et:gita.3.27','Sir Edwin Arnold','gita.3.27','en','translation','All things are everywhere by Nature wrought
  In interaction of the qualities.
  The fool, cheated by self, thinks, "This I did"
  And "That I wrought; "'),
('edwin-arnold-et:gita.3.28','Sir Edwin Arnold','gita.3.28','en','translation','but--ah, thou strong-armed Prince!--
  A better-lessoned mind, knowing the play
  Of visible things within the world of sense,
  And how the qualities must qualify,
  Standeth aloof even from his acts.'),
('edwin-arnold-et:gita.3.29','Sir Edwin Arnold','gita.3.29','en','translation','Th'' untaught
  Live mixed with them, knowing not Nature''s way,
  Of highest aims unwitting, slow and dull.
  Those make thou not to stumble, having the light;'),
('edwin-arnold-et:gita.3.30','Sir Edwin Arnold','gita.3.30','en','translation','But all thy dues discharging, for My sake,
  With meditation centred inwardly,
  Seeking no profit, satisfied, serene,
  Heedless of issue--fight!'),
('edwin-arnold-et:gita.3.31','Sir Edwin Arnold','gita.3.31','en','translation','They who shall keep
  My ordinance thus, the wise and willing hearts,
  Have quittance from all issue of their acts;'),
('edwin-arnold-et:gita.3.32','Sir Edwin Arnold','gita.3.32','en','translation','But those who disregard My ordinance,
  Thinking they know, know nought, and fall to loss,
  Confused and foolish.'),
('edwin-arnold-et:gita.3.33','Sir Edwin Arnold','gita.3.33','en','translation','''Sooth, the instructed one
  Doth of his kind, following what fits him most:
  And lower creatures of their kind; in vain
  Contending ''gainst the law.'),
('edwin-arnold-et:gita.3.34','Sir Edwin Arnold','gita.3.34','en','translation','Needs must it be
  The objects of the sense will stir the sense
  To like and dislike, yet th'' enlightened man
  Yields not to these, knowing them enemies.'),
('edwin-arnold-et:gita.3.35','Sir Edwin Arnold','gita.3.35','en','translation','Finally, this is better, that one do
  His own task as he may, even though he fail,
  Than take tasks not his own, though they seem good.
  To die performing duty is no ill;
  But who seeks other roads shall wander still.'),
('edwin-arnold-et:gita.3.36','Sir Edwin Arnold','gita.3.36','en','translation','Arjuna.
  Yet tell me, Teacher! by what force doth man
  Go to his ill, unwilling; as if one
  Pushed him that evil path?'),
('edwin-arnold-et:gita.3.37','Sir Edwin Arnold','gita.3.37','en','translation','Krishna.
  Kama it is!
  Passion it is! born of the Darknesses,
  Which pusheth him. Mighty of appetite,
  Sinful, and strong is this!--man''s enemy!'),
('edwin-arnold-et:gita.3.38','Sir Edwin Arnold','gita.3.38','en','translation','As smoke blots the white fire, as clinging rust
  Mars the bright mirror, as the womb surrounds
  The babe unborn, so is the world of things
  Foiled, soiled, enclosed in this desire of flesh.'),
('edwin-arnold-et:gita.3.39','Sir Edwin Arnold','gita.3.39','en','translation','The wise fall, caught in it; the unresting foe
  It is of wisdom, wearing countless forms,
  Fair but deceitful, subtle as a flame.'),
('edwin-arnold-et:gita.3.40','Sir Edwin Arnold','gita.3.40','en','translation','Sense, mind, and reason--these, O Kunti''s Son!
  Are booty for it; in its play with these
  It maddens man, beguiling, blinding him.'),
('edwin-arnold-et:gita.3.41','Sir Edwin Arnold','gita.3.41','en','translation','Therefore, thou noblest child of Bharata!
  Govern thy heart! Constrain th'' entangled sense!
  Resist the false, soft sinfulness which saps
  Knowledge and judgment!'),
('edwin-arnold-et:gita.3.42','Sir Edwin Arnold','gita.3.42','en','translation','Yea, the world is strong,
  But what discerns it stronger, and the mind
  Strongest; and high o''er all the ruling Soul.'),
('edwin-arnold-et:gita.3.43','Sir Edwin Arnold','gita.3.43','en','translation','Wherefore, perceiving Him who reigns supreme,
  Put forth full force of Soul in thy own soul!
  Fight! vanquish foes and doubts, dear Hero! slay
  What haunts thee in fond shapes, and would betray!'),
('edwin-arnold-et:gita.4.1','Sir Edwin Arnold','gita.4.1','en','translation','Krishna.
  This deathless Yoga, this deep union,
  I taught Vivaswata,[FN#6] the Lord of Light;
  Vivaswata to Manu gave it; he
  To Ikshwaku;'),
('edwin-arnold-et:gita.4.2','Sir Edwin Arnold','gita.4.2','en','translation','so passed it down the line
  Of all my royal Rishis. Then, with years,
  The truth grew dim and perished, noble Prince!'),
('edwin-arnold-et:gita.4.3','Sir Edwin Arnold','gita.4.3','en','translation','Now once again to thee it is declared--
  This ancient lore, this mystery supreme--
  Seeing I find thee votary and friend.'),
('edwin-arnold-et:gita.4.4','Sir Edwin Arnold','gita.4.4','en','translation','Arjuna.
  Thy birth, dear Lord, was in these later days,
  And bright Vivaswata''s preceded time!
  How shall I comprehend this thing thou sayest,
  "From the beginning it was I who taught?"'),
('edwin-arnold-et:gita.4.5','Sir Edwin Arnold','gita.4.5','en','translation','Krishna.
  Manifold the renewals of my birth
  Have been, Arjuna! and of thy births, too!
  But mine I know, and thine thou knowest not,
  O Slayer of thy Foes!'),
('edwin-arnold-et:gita.4.6','Sir Edwin Arnold','gita.4.6','en','translation','Albeit I be
  Unborn, undying, indestructible,
  The Lord of all things living; not the less--
  By Maya, by my magic which I stamp
  On floating Nature-forms, the primal vast--
  I come, and go, and come.'),
('edwin-arnold-et:gita.4.7','Sir Edwin Arnold','gita.4.7','en','translation','When Righteousness
  Declines, O Bharata! when Wickedness
  Is strong, I rise,'),
('edwin-arnold-et:gita.4.8','Sir Edwin Arnold','gita.4.8','en','translation','from age to age, and take
  Visible shape, and move a man with men,
  Succouring the good, thrusting the evil back,
  And setting Virtue on her seat again.'),
('edwin-arnold-et:gita.4.9','Sir Edwin Arnold','gita.4.9','en','translation','Who knows the truth touching my births on earth
  And my divine work, when he quits the flesh
  Puts on its load no more, falls no more down
  To earthly birth: to Me he comes, dear Prince!'),
('edwin-arnold-et:gita.4.10','Sir Edwin Arnold','gita.4.10','en','translation','Many there be who come! from fear set free,
  From anger, from desire; keeping their hearts
  Fixed upon me--my Faithful--purified
  By sacred flame of Knowledge. Such as these
  Mix with my being.'),
('edwin-arnold-et:gita.4.11','Sir Edwin Arnold','gita.4.11','en','translation','Whoso worship me,
  Them I exalt; but all men everywhere
  Shall fall into my path;'),
('edwin-arnold-et:gita.4.12','Sir Edwin Arnold','gita.4.12','en','translation','albeit, those souls
  Which seek reward for works, make sacrifice
  Now, to the lower gods. I say to thee
  Here have they their reward.'),
('edwin-arnold-et:gita.4.13','Sir Edwin Arnold','gita.4.13','en','translation','But I am He
  Made the Four Castes, and portioned them a place
  After their qualities and gifts. Yea, I
  Created, the Reposeful; I that live
  Immortally, made all those mortal births:'),
('edwin-arnold-et:gita.4.14','Sir Edwin Arnold','gita.4.14','en','translation','For works soil not my essence, being works
  Wrought uninvolved.[FN#7] Who knows me acting thus
  Unchained by action, action binds not him;'),
('edwin-arnold-et:gita.4.15','Sir Edwin Arnold','gita.4.15','en','translation','And, so perceiving, all those saints of old
  Worked, seeking for deliverance. Work thou
  As, in the days gone by, thy fathers did.'),
('edwin-arnold-et:gita.4.16','Sir Edwin Arnold','gita.4.16','en','translation','Thou sayst, perplexed, It hath been asked before
  By singers and by sages, "What is act,
  And what inaction? "I will teach thee this,
  And, knowing, thou shalt learn which work doth save'),
('edwin-arnold-et:gita.4.17','Sir Edwin Arnold','gita.4.17','en','translation','Needs must one rightly meditate those three--
  Doing,--not doing,--and undoing. Here
  Thorny and dark the path is!'),
('edwin-arnold-et:gita.4.18','Sir Edwin Arnold','gita.4.18','en','translation','He who sees
  How action may be rest, rest action--he
  Is wisest ''mid his kind; he hath the truth!
  He doeth well, acting or resting.'),
('edwin-arnold-et:gita.4.19','Sir Edwin Arnold','gita.4.19','en','translation','Freed
  In all his works from prickings of desire,
  Burned clean in act by the white fire of truth,
  The wise call that man wise;'),
('edwin-arnold-et:gita.4.20','Sir Edwin Arnold','gita.4.20','en','translation','and such an one,
  Renouncing fruit of deeds, always content.
  Always self-satisfying, if he works,
  Doth nothing that shall stain his separate soul,'),
('edwin-arnold-et:gita.4.21','Sir Edwin Arnold','gita.4.21','en','translation','Which--quit of fear and hope--subduing self--
  Rejecting outward impulse--yielding up
  To body''s need nothing save body, dwells
  Sinless amid all sin,'),
('edwin-arnold-et:gita.4.22','Sir Edwin Arnold','gita.4.22','en','translation','with equal calm
  Taking what may befall, by grief unmoved,
  Unmoved by joy, unenvyingly; the same
  In good and evil fortunes; nowise bound
  By bond of deeds.'),
('edwin-arnold-et:gita.4.23','Sir Edwin Arnold','gita.4.23','en','translation','Nay, but of such an one,
  Whose crave is gone, whose soul is liberate,
  Whose heart is set on truth--of such an one
  What work he does is work of sacrifice,
  Which passeth purely into ash and smoke
  Consumed upon the altar!'),
('edwin-arnold-et:gita.4.24','Sir Edwin Arnold','gita.4.24','en','translation','All''s then God!
  The sacrifice is Brahm, the ghee and grain
  Are Brahm, the fire is Brahm, the flesh it eats
  Is Brahm, and unto Brahm attaineth he
  Who, in such office, meditates on Brahm.'),
('edwin-arnold-et:gita.4.25','Sir Edwin Arnold','gita.4.25','en','translation','Some votaries there be who serve the gods
  With flesh and altar-smoke; but other some
  Who, lighting subtler fires, make purer rite
  With will of worship.'),
('edwin-arnold-et:gita.4.26','Sir Edwin Arnold','gita.4.26','en','translation','Of the which be they
  Who, in white flame of continence, consume
  Joys of the sense, delights of eye and ear,
  Forgoing tender speech and sound of song:'),
('edwin-arnold-et:gita.4.27','Sir Edwin Arnold','gita.4.27','en','translation','And they who, kindling fires with torch of Truth,
  Burn on a hidden altar-stone the bliss
  Of youth and love, renouncing happiness:'),
('edwin-arnold-et:gita.4.28','Sir Edwin Arnold','gita.4.28','en','translation','And they who lay for offering there their wealth,
  Their penance, meditation, piety,
  Their steadfast reading of the scrolls, their lore
  Painfully gained with long austerities:'),
('edwin-arnold-et:gita.4.29','Sir Edwin Arnold','gita.4.29','en','translation','And they who, making silent sacrifice,
  Draw in their breath to feed the flame of thought,
  And breathe it forth to waft the heart on high,
  Governing the ventage of each entering air
  Lest one sigh pass which helpeth not the soul:'),
('edwin-arnold-et:gita.4.30','Sir Edwin Arnold','gita.4.30','en','translation','And they who, day by day denying needs,
  Lay life itself upon the altar-flame,
  Burning the body wan. Lo! all these keep
  The rite of offering, as if they slew
  Victims; and all thereby efface much sin.'),
('edwin-arnold-et:gita.4.31','Sir Edwin Arnold','gita.4.31','en','translation','Yea! and who feed on the immortal food
  Left of such sacrifice, to Brahma pass,
  To The Unending. But for him that makes
  No sacrifice, he hath nor part nor lot
  Even in the present world. How should he share
  Another, O thou Glory of thy Line?'),
('edwin-arnold-et:gita.4.32','Sir Edwin Arnold','gita.4.32','en','translation','In sight of Brahma all these offerings
  Are spread and are accepted! Comprehend
  That all proceed by act; for knowing this,
  Thou shalt be quit of doubt.'),
('edwin-arnold-et:gita.4.33','Sir Edwin Arnold','gita.4.33','en','translation','The sacrifice
  Which Knowledge pays is better than great gifts
  Offered by wealth, since gifts'' worth--O my Prince!
  Lies in the mind which gives, the will that serves:'),
('edwin-arnold-et:gita.4.34','Sir Edwin Arnold','gita.4.34','en','translation','And these are gained by reverence, by strong search,
  By humble heed of those who see the Truth
  And teach it.'),
('edwin-arnold-et:gita.4.35','Sir Edwin Arnold','gita.4.35','en','translation','Knowing Truth, thy heart no more
  Will ache with error, for the Truth shall show
  All things subdued to thee, as thou to Me.'),
('edwin-arnold-et:gita.4.36','Sir Edwin Arnold','gita.4.36','en','translation','Moreover, Son of Pandu! wert thou worst
  Of all wrong-doers, this fair ship of Truth
  Should bear thee safe and dry across the sea
  Of thy transgressions.'),
('edwin-arnold-et:gita.4.37','Sir Edwin Arnold','gita.4.37','en','translation','As the kindled flame
  Feeds on the fuel till it sinks to ash,
  So unto ash, Arjuna! unto nought
  The flame of Knowledge wastes works'' dross away!'),
('edwin-arnold-et:gita.4.38','Sir Edwin Arnold','gita.4.38','en','translation','There is no purifier like thereto
  In all this world, and he who seeketh it
  Shall find it--being grown perfect--in himself.'),
('edwin-arnold-et:gita.4.39','Sir Edwin Arnold','gita.4.39','en','translation','Believing, he receives it when the soul
  Masters itself, and cleaves to Truth, and comes--
  Possessing knowledge--to the higher peace,
  The uttermost repose.'),
('edwin-arnold-et:gita.4.40','Sir Edwin Arnold','gita.4.40','en','translation','But those untaught,
  And those without full faith, and those who fear
  Are shent; no peace is here or other where,
  No hope, nor happiness for whoso doubts.'),
('edwin-arnold-et:gita.4.41','Sir Edwin Arnold','gita.4.41','en','translation','He that, being self-contained, hath vanquished doubt,
  Disparting self from service, soul from works,
  Enlightened and emancipate, my Prince!
  Works fetter him no more!'),
('edwin-arnold-et:gita.4.42','Sir Edwin Arnold','gita.4.42','en','translation','Cut then atwain
  With sword of wisdom, Son of Bharata!
  This doubt that binds thy heart-beats! cleave the bond
  Born of thy ignorance! Be bold and wise!
  Give thyself to the field with me! Arise!'),
('edwin-arnold-et:gita.5.1','Sir Edwin Arnold','gita.5.1','en','translation','Arjuna.
  Yet, Krishna! at the one time thou dost laud
  Surcease of works, and, at another time,
  Service through work. Of these twain plainly tell
  Which is the better way?'),
('edwin-arnold-et:gita.5.2','Sir Edwin Arnold','gita.5.2','en','translation','Krishna.
  To cease from works
  Is well, and to do works in holiness
  Is well; and both conduct to bliss supreme;
  But of these twain the better way is his
  Who working piously refraineth not.'),
('edwin-arnold-et:gita.5.3','Sir Edwin Arnold','gita.5.3','en','translation','That is the true Renouncer, firm and fixed,
  Who--seeking nought, rejecting nought--dwells proof
  Against the "opposites."[FN#8] O valiant Prince!
  In doing, such breaks lightly from all deed:'),
('edwin-arnold-et:gita.5.4','Sir Edwin Arnold','gita.5.4','en','translation','''Tis the new scholar talks as they were two,
  This Sankhya and this Yoga: wise men know
  Who husbands one plucks golden fruit of both!'),
('edwin-arnold-et:gita.5.5','Sir Edwin Arnold','gita.5.5','en','translation','The region of high rest which Sankhyans reach
  Yogins attain. Who sees these twain as one
  Sees with clear eyes!'),
('edwin-arnold-et:gita.5.6','Sir Edwin Arnold','gita.5.6','en','translation','Yet such abstraction, Chief!
  Is hard to win without much holiness.
  Whoso is fixed in holiness, self-ruled,
  Pure-hearted, lord of senses and of self,
  Lost in the common life of all which lives--
  A "Yogayukt"--he is a Saint who wends
  Straightway to Brahm. Such an one is not touched
  By taint of deeds.'),
('edwin-arnold-et:gita.5.7','Sir Edwin Arnold','gita.5.7','en','translation','Yet such abstraction, Chief!
  Is hard to win without much holiness.
  Whoso is fixed in holiness, self-ruled,
  Pure-hearted, lord of senses and of self,
  Lost in the common life of all which lives--
  A "Yogayukt"--he is a Saint who wends
  Straightway to Brahm. Such an one is not touched
  By taint of deeds.'),
('edwin-arnold-et:gita.5.8','Sir Edwin Arnold','gita.5.8','en','translation','"Nought of myself I do!"
  Thus will he think-who holds the truth of truths--
  In seeing, hearing, touching, smelling; when
  He eats, or goes, or breathes; slumbers'),
('edwin-arnold-et:gita.5.9','Sir Edwin Arnold','gita.5.9','en','translation','or talks,
  Holds fast or loosens, opes his eyes or shuts;
  Always assured "This is the sense-world plays
  With senses."'),
('edwin-arnold-et:gita.5.10','Sir Edwin Arnold','gita.5.10','en','translation','He that acts in thought of Brahm,
  Detaching end from act, with act content,
  The world of sense can no more stain his soul
  Than waters mar th'' enamelled lotus-leaf.'),
('edwin-arnold-et:gita.5.11','Sir Edwin Arnold','gita.5.11','en','translation','With life, with heart, with mind,-nay, with the help
  Of all five senses--letting selfhood go--
  Yogins toil ever towards their souls'' release.'),
('edwin-arnold-et:gita.5.12','Sir Edwin Arnold','gita.5.12','en','translation','Such votaries, renouncing fruit of deeds,
  Gain endless peace: the unvowed, the passion-bound,
  Seeking a fruit from works, are fastened down.'),
('edwin-arnold-et:gita.5.13','Sir Edwin Arnold','gita.5.13','en','translation','The embodied sage, withdrawn within his soul,
  At every act sits godlike in "the town
  Which hath nine gateways,"[FN#9] neither doing aught
  Nor causing any deed.'),
('edwin-arnold-et:gita.5.14','Sir Edwin Arnold','gita.5.14','en','translation','This world''s Lord makes
  Neither the work, nor passion for the work,
  Nor lust for fruit of work; the man''s own self
  Pushes to these!'),
('edwin-arnold-et:gita.5.15','Sir Edwin Arnold','gita.5.15','en','translation','The Master of this World
  Takes on himself the good or evil deeds
  Of no man--dwelling beyond! Mankind errs here
  By folly, darkening knowledge.'),
('edwin-arnold-et:gita.5.16','Sir Edwin Arnold','gita.5.16','en','translation','But, for whom
  That darkness of the soul is chased by light,
  Splendid and clear shines manifest the Truth
  As if a Sun of Wisdom sprang to shed
  Its beams of dawn.'),
('edwin-arnold-et:gita.5.17','Sir Edwin Arnold','gita.5.17','en','translation','Him meditating still,
  Him seeking, with Him blended, stayed on Him,
  The souls illuminated take that road
  Which hath no turning back--their sins flung off
  By strength of faith. [Who will may have this Light;
  Who hath it sees.]'),
('edwin-arnold-et:gita.5.18','Sir Edwin Arnold','gita.5.18','en','translation','To him who wisely sees,
  The Brahman with his scrolls and sanctities,
  The cow, the elephant, the unclean dog,
  The Outcast gorging dog''s meat, are all one.'),
('edwin-arnold-et:gita.5.19','Sir Edwin Arnold','gita.5.19','en','translation','The world is overcome--aye! even here!
  By such as fix their faith on Unity.
  The sinless Brahma dwells in Unity,
  And they in Brahma.'),
('edwin-arnold-et:gita.5.20','Sir Edwin Arnold','gita.5.20','en','translation','Be not over-glad
  Attaining joy, and be not over-sad
  Encountering grief, but, stayed on Brahma, still
  Constant let each abide!'),
('edwin-arnold-et:gita.5.21','Sir Edwin Arnold','gita.5.21','en','translation','The sage whose soul
  Holds off from outer contacts, in himself
  Finds bliss; to Brahma joined by piety,
  His spirit tastes eternal peace.'),
('edwin-arnold-et:gita.5.22','Sir Edwin Arnold','gita.5.22','en','translation','The joys
  Springing from sense-life are but quickening wombs
  Which breed sure griefs: those joys begin and end!
  The wise mind takes no pleasure, Kunti''s Son!
  In such as those!'),
('edwin-arnold-et:gita.5.23','Sir Edwin Arnold','gita.5.23','en','translation','But if a man shall learn,
  Even while he lives and bears his body''s chain,
  To master lust and anger, he is blest!'),
('edwin-arnold-et:gita.5.24','Sir Edwin Arnold','gita.5.24','en','translation','He is the Yukta; he hath happiness,
  Contentment, light, within: his life is merged
  In Brahma''s life; he doth Nirvana touch!'),
('edwin-arnold-et:gita.5.25','Sir Edwin Arnold','gita.5.25','en','translation','Thus go the Rishis unto rest, who dwell
  With sins effaced, with doubts at end, with hearts
  Governed and calm. Glad in all good they live,
  Nigh to the peace of God;'),
('edwin-arnold-et:gita.5.26','Sir Edwin Arnold','gita.5.26','en','translation','and all those live
  Who pass their days exempt from greed and wrath,
  Subduing self and senses, knowing the Soul!'),
('edwin-arnold-et:gita.5.27','Sir Edwin Arnold','gita.5.27','en','translation','The Saint who shuts outside his placid soul
  All touch of sense, letting no contact through;
  Whose quiet eyes gaze straight from fixed brows,
  Whose outward breath and inward breath are drawn
  Equal and slow through nostrils still and close;'),
('edwin-arnold-et:gita.5.28','Sir Edwin Arnold','gita.5.28','en','translation','That one-with organs, heart, and mind constrained,
  Bent on deliverance, having put away
  Passion, and fear, and rage;--hath, even now,
  Obtained deliverance, ever and ever freed.'),
('edwin-arnold-et:gita.5.29','Sir Edwin Arnold','gita.5.29','en','translation','Yea! for he knows Me Who am He that heeds
  The sacrifice and worship, God revealed;
  And He who heeds not, being Lord of Worlds,
  Lover of all that lives, God unrevealed,
  Wherein who will shall find surety and shield!'),
('edwin-arnold-et:gita.6.1','Sir Edwin Arnold','gita.6.1','en','translation','Krishna.
  Therefore, who doeth work rightful to do,
  Not seeking gain from work, that man, O Prince!
  Is Sanyasi and Yogi--both in one
  And he is neither who lights not the flame
  Of sacrifice, nor setteth hand to task.'),
('edwin-arnold-et:gita.6.2','Sir Edwin Arnold','gita.6.2','en','translation','Regard as true Renouncer him that makes
  Worship by work, for who renounceth not
  Works not as Yogin.'),
('edwin-arnold-et:gita.6.3','Sir Edwin Arnold','gita.6.3','en','translation','So is that well said:
  "By works the votary doth rise to faith,
  And saintship is the ceasing from all works;'),
('edwin-arnold-et:gita.6.4','Sir Edwin Arnold','gita.6.4','en','translation','Because the perfect Yogin acts--but acts
  Unmoved by passions and unbound by deeds,
  Setting result aside.'),
('edwin-arnold-et:gita.6.5','Sir Edwin Arnold','gita.6.5','en','translation','Let each man raise
  The Self by Soul, not trample down his Self,
  Since Soul that is Self''s friend may grow Self''s foe.'),
('edwin-arnold-et:gita.6.6','Sir Edwin Arnold','gita.6.6','en','translation','Soul is Self''s friend when Self doth rule o''er Self,
  But Self turns enemy if Soul''s own self
  Hates Self as not itself.[FN#10]'),
('edwin-arnold-et:gita.6.7','Sir Edwin Arnold','gita.6.7','en','translation','The sovereign soul
  Of him who lives self-governed and at peace
  Is centred in itself, taking alike
  Pleasure and pain; heat, cold; glory and shame.'),
('edwin-arnold-et:gita.6.8','Sir Edwin Arnold','gita.6.8','en','translation','He is the Yogi, he is Yukta, glad
  With joy of light and truth; dwelling apart
  Upon a peak, with senses subjugate
  Whereto the clod, the rock, the glistering gold
  Show all as one.'),
('edwin-arnold-et:gita.6.9','Sir Edwin Arnold','gita.6.9','en','translation','By this sign is he known
  Being of equal grace to comrades, friends,
  Chance-comers, strangers, lovers, enemies,
  Aliens and kinsmen; loving all alike,
  Evil or good.'),
('edwin-arnold-et:gita.6.10','Sir Edwin Arnold','gita.6.10','en','translation','Sequestered should he sit,
  Steadfastly meditating, solitary,
  His thoughts controlled, his passions laid away,
  Quit of belongings.'),
('edwin-arnold-et:gita.6.11','Sir Edwin Arnold','gita.6.11','en','translation','In a fair, still spot
  Having his fixed abode,--not too much raised,
  Nor yet too low,--let him abide, his goods
  A cloth, a deerskin, and the Kusa-grass.'),
('edwin-arnold-et:gita.6.12','Sir Edwin Arnold','gita.6.12','en','translation','There, setting hard his mind upon The One,
  Restraining heart and senses, silent, calm,
  Let him accomplish Yoga, and achieve
  Pureness of soul,'),
('edwin-arnold-et:gita.6.13','Sir Edwin Arnold','gita.6.13','en','translation','holding immovable
  Body and neck and head, his gaze absorbed
  Upon his nose-end,[FN#11] rapt from all around,'),
('edwin-arnold-et:gita.6.14','Sir Edwin Arnold','gita.6.14','en','translation','Tranquil in spirit, free of fear, intent
  Upon his Brahmacharya vow, devout,
  Musing on Me, lost in the thought of Me.'),
('edwin-arnold-et:gita.6.15','Sir Edwin Arnold','gita.6.15','en','translation','That Yojin, so devoted, so controlled,
  Comes to the peace beyond,--My peace, the peace
  Of high Nirvana!'),
('edwin-arnold-et:gita.6.16','Sir Edwin Arnold','gita.6.16','en','translation','But for earthly needs
  Religion is not his who too much fasts
  Or too much feasts, nor his who sleeps away
  An idle mind; nor his who wears to waste
  His strength in vigils.'),
('edwin-arnold-et:gita.6.17','Sir Edwin Arnold','gita.6.17','en','translation','Nay, Arjuna! call
  That the true piety which most removes
  Earth-aches and ills, where one is moderate
  In eating and in resting, and in sport;
  Measured in wish and act; sleeping betimes,
  Waking betimes for duty.'),
('edwin-arnold-et:gita.6.18','Sir Edwin Arnold','gita.6.18','en','translation','When the man,
  So living, centres on his soul the thought
  Straitly restrained--untouched internally
  By stress of sense--then is he Yukta.'),
('edwin-arnold-et:gita.6.19','Sir Edwin Arnold','gita.6.19','en','translation','See!
  Steadfast a lamp burns sheltered from the wind;
  Such is the likeness of the Yogi''s mind
  Shut from sense-storms and burning bright to Heaven.'),
('edwin-arnold-et:gita.6.20','Sir Edwin Arnold','gita.6.20','en','translation','When mind broods placid, soothed with holy wont;
  When Self contemplates self, and in itself
  Hath comfort;'),
('edwin-arnold-et:gita.6.21','Sir Edwin Arnold','gita.6.21','en','translation','when it knows the nameless joy
  Beyond all scope of sense, revealed to soul--
  Only to soul! and, knowing, wavers not,
  True to the farther Truth;'),
('edwin-arnold-et:gita.6.22','Sir Edwin Arnold','gita.6.22','en','translation','when, holding this,
  It deems no other treasure comparable,
  But, harboured there, cannot be stirred or shook
  By any gravest grief,'),
('edwin-arnold-et:gita.6.23','Sir Edwin Arnold','gita.6.23','en','translation','call that state "peace,"
  That happy severance Yoga; call that man
  The perfect Yogin!

  Steadfastly the will
  Must toil thereto, till efforts end in ease,
  And thought has passed from thinking.'),
('edwin-arnold-et:gita.6.24','Sir Edwin Arnold','gita.6.24','en','translation','Shaking off
  All longings bred by dreams of fame and gain,
  Shutting the doorways of the senses close
  With watchful ward;'),
('edwin-arnold-et:gita.6.25','Sir Edwin Arnold','gita.6.25','en','translation','so, step by step, it comes
  To gift of peace assured and heart assuaged,
  When the mind dwells self-wrapped, and the soul broods
  Cumberless.'),
('edwin-arnold-et:gita.6.26','Sir Edwin Arnold','gita.6.26','en','translation','But, as often as the heart
  Breaks--wild and wavering--from control, so oft
  Let him re-curb it, let him rein it back
  To the soul''s governance;'),
('edwin-arnold-et:gita.6.27','Sir Edwin Arnold','gita.6.27','en','translation','for perfect bliss
  Grows only in the bosom tranquillised,
  The spirit passionless, purged from offence,
  Vowed to the Infinite.'),
('edwin-arnold-et:gita.6.28','Sir Edwin Arnold','gita.6.28','en','translation','He who thus vows
  His soul to the Supreme Soul, quitting sin,
  Passes unhindered to the endless bliss
  Of unity with Brahma.'),
('edwin-arnold-et:gita.6.29','Sir Edwin Arnold','gita.6.29','en','translation','He so vowed,
  So blended, sees the Life-Soul resident
  In all things living, and all living things
  In that Life-Soul contained.'),
('edwin-arnold-et:gita.6.30','Sir Edwin Arnold','gita.6.30','en','translation','And whoso thus
  Discerneth Me in all, and all in Me,
  I never let him go; nor looseneth he
  Hold upon Me;'),
('edwin-arnold-et:gita.6.31','Sir Edwin Arnold','gita.6.31','en','translation','but, dwell he where he may,
  Whate''er his life, in Me he dwells and lives,
  Because he knows and worships Me, Who dwell
  In all which lives, and cleaves to Me in all.'),
('edwin-arnold-et:gita.6.32','Sir Edwin Arnold','gita.6.32','en','translation','Arjuna! if a man sees everywhere--
  Taught by his own similitude--one Life,
  One Essence in the Evil and the Good,
  Hold him a Yogi, yea! well-perfected!'),
('edwin-arnold-et:gita.6.33','Sir Edwin Arnold','gita.6.33','en','translation','Arjuna.
  Slayer of Madhu! yet again, this Yog,
  This Peace, derived from equanimity,
  Made known by thee--I see no fixity
  Therein, no rest,'),
('edwin-arnold-et:gita.6.34','Sir Edwin Arnold','gita.6.34','en','translation','because the heart of men
  Is unfixed, Krishna! rash, tumultuous,
  Wilful and strong. It were all one, I think,
  To hold the wayward wind, as tame man''s heart.'),
('edwin-arnold-et:gita.6.35','Sir Edwin Arnold','gita.6.35','en','translation','Krishna.
  Hero long-armed! beyond denial, hard
  Man''s heart is to restrain, and wavering;
  Yet may it grow restrained by habit, Prince!
  By wont of self-command.'),
('edwin-arnold-et:gita.6.36','Sir Edwin Arnold','gita.6.36','en','translation','This Yog, I say,
  Cometh not lightly to th'' ungoverned ones;
  But he who will be master of himself
  Shall win it, if he stoutly strive thereto.'),
('edwin-arnold-et:gita.6.37','Sir Edwin Arnold','gita.6.37','en','translation','Arjuna.
  And what road goeth he who, having faith,
  Fails, Krishna! in the striving; falling back
  From holiness, missing the perfect rule?'),
('edwin-arnold-et:gita.6.38','Sir Edwin Arnold','gita.6.38','en','translation','Is he not lost, straying from Brahma''s light,
  Like the vain cloud, which floats ''twixt earth and heaven
  When lightning splits it, and it vanisheth?'),
('edwin-arnold-et:gita.6.39','Sir Edwin Arnold','gita.6.39','en','translation','Fain would I hear thee answer me herein,
  Since, Krishna! none save thou can clear the doubt.'),
('edwin-arnold-et:gita.6.40','Sir Edwin Arnold','gita.6.40','en','translation','Krishna.
  He is not lost, thou Son of Pritha! No!
  Nor earth, nor heaven is forfeit, even for him,
  Because no heart that holds one right desire
  Treadeth the road of loss!'),
('edwin-arnold-et:gita.6.41','Sir Edwin Arnold','gita.6.41','en','translation','He who should fail,
  Desiring righteousness, cometh at death
  Unto the Region of the Just; dwells there
  Measureless years, and being born anew,
  Beginneth life again in some fair home
  Amid the mild and happy.'),
('edwin-arnold-et:gita.6.42','Sir Edwin Arnold','gita.6.42','en','translation','It may chance
  He doth descend into a Yogin house
  On Virtue''s breast; but that is rare! Such birth
  Is hard to be obtained on this earth, Chief!'),
('edwin-arnold-et:gita.6.43','Sir Edwin Arnold','gita.6.43','en','translation','So hath he back again what heights of heart
  He did achieve, and so he strives anew
  To perfectness, with better hope, dear Prince!'),
('edwin-arnold-et:gita.6.44','Sir Edwin Arnold','gita.6.44','en','translation','For by the old desire he is drawn on
  Unwittingly; and only to desire
  The purity of Yog is to pass
  Beyond the Sabdabrahm, the spoken Ved.'),
('edwin-arnold-et:gita.6.45','Sir Edwin Arnold','gita.6.45','en','translation','But, being Yogi, striving strong and long,
  Purged from transgressions, perfected by births
  Following on births, he plants his feet at last
  Upon the farther path.'),
('edwin-arnold-et:gita.6.46','Sir Edwin Arnold','gita.6.46','en','translation','Such as one ranks
  Above ascetics, higher than the wise,
  Beyond achievers of vast deeds! Be thou
  Yogi Arjuna!'),
('edwin-arnold-et:gita.6.47','Sir Edwin Arnold','gita.6.47','en','translation','And of such believe,
  Truest and best is he who worships Me
  With inmost soul, stayed on My Mystery!'),
('edwin-arnold-et:gita.7.1','Sir Edwin Arnold','gita.7.1','en','translation','Krishna.
  Learn now, dear Prince! how, if thy soul be set
  Ever on Me--still exercising Yog,
  Still making Me thy Refuge--thou shalt come
  Most surely unto perfect hold of Me.'),
('edwin-arnold-et:gita.7.2','Sir Edwin Arnold','gita.7.2','en','translation','I will declare to thee that utmost lore,
  Whole and particular, which, when thou knowest,
  Leaveth no more to know here in this world.'),
('edwin-arnold-et:gita.7.3','Sir Edwin Arnold','gita.7.3','en','translation','Of many thousand mortals, one, perchance,
  Striveth for Truth; and of those few that strive--
  Nay, and rise high--one only--here and there--
  Knoweth Me, as I am, the very Truth.'),
('edwin-arnold-et:gita.7.4','Sir Edwin Arnold','gita.7.4','en','translation','Earth, water, flame, air, ether, life, and mind,
  And individuality--those eight
  Make up the showing of Me, Manifest.'),
('edwin-arnold-et:gita.7.5','Sir Edwin Arnold','gita.7.5','en','translation','These be my lower Nature; learn the higher,
  Whereby, thou Valiant One! this Universe
  Is, by its principle of life, produced;'),
('edwin-arnold-et:gita.7.6','Sir Edwin Arnold','gita.7.6','en','translation','Whereby the worlds of visible things are born
  As from a Yoni. Know! I am that womb:
  I make and I unmake this Universe:'),
('edwin-arnold-et:gita.7.7','Sir Edwin Arnold','gita.7.7','en','translation','Than me there is no other Master, Prince!
  No other Maker! All these hang on me
  As hangs a row of pearls upon its string.'),
('edwin-arnold-et:gita.7.8','Sir Edwin Arnold','gita.7.8','en','translation','I am the fresh taste of the water; I
  The silver of the moon, the gold o'' the sun,
  The word of worship in the Veds, the thrill
  That passeth in the ether, and the strength
  Of man''s shed seed.'),
('edwin-arnold-et:gita.7.9','Sir Edwin Arnold','gita.7.9','en','translation','I am the good sweet smell
  Of the moistened earth, I am the fire''s red light,
  The vital air moving in all which moves,
  The holiness of hallowed souls,'),
('edwin-arnold-et:gita.7.10','Sir Edwin Arnold','gita.7.10','en','translation','the root
  Undying, whence hath sprung whatever is;
  The wisdom of the wise, the intellect
  Of the informed, the greatness of the great.
  The splendour of the splendid.'),
('edwin-arnold-et:gita.7.11','Sir Edwin Arnold','gita.7.11','en','translation','Kunti''s Son!
  These am I, free from passion and desire;
  Yet am I right desire in all who yearn,
  Chief of the Bharatas!'),
('edwin-arnold-et:gita.7.12','Sir Edwin Arnold','gita.7.12','en','translation','for all those moods,
  Soothfast, or passionate, or ignorant,
  Which Nature frames, deduce from me; but all
  Are merged in me--not I in them!'),
('edwin-arnold-et:gita.7.13','Sir Edwin Arnold','gita.7.13','en','translation','The world--
  Deceived by those three qualities of being--
  Wotteth not Me Who am outside them all,
  Above them all, Eternal!'),
('edwin-arnold-et:gita.7.14','Sir Edwin Arnold','gita.7.14','en','translation','Hard it is
  To pierce that veil divine of various shows
  Which hideth Me; yet they who worship Me
  Pierce it and pass beyond.'),
('edwin-arnold-et:gita.7.15','Sir Edwin Arnold','gita.7.15','en','translation','I am not known
  To evil-doers, nor to foolish ones,
  Nor to the base and churlish; nor to those
  Whose mind is cheated by the show of things,
  Nor those that take the way of Asuras.[FN#12]');
--> statement-breakpoint
INSERT INTO commentary_fts (unit_id,author,canonical_ref,language,content_type,content) VALUES
('edwin-arnold-et:gita.7.16','Sir Edwin Arnold','gita.7.16','en','translation','Four sorts of mortals know me: he who weeps,
  Arjuna! and the man who yearns to know;
  And he who toils to help; and he who sits
  Certain of me, enlightened.'),
('edwin-arnold-et:gita.7.17','Sir Edwin Arnold','gita.7.17','en','translation','Of these four,
  O Prince of India! highest, nearest, best
  That last is, the devout soul, wise, intent
  Upon "The One." Dear, above all, am I
  To him; and he is dearest unto me!'),
('edwin-arnold-et:gita.7.18','Sir Edwin Arnold','gita.7.18','en','translation','All four are good, and seek me; but mine own,
  The true of heart, the faithful--stayed on me,
  Taking me as their utmost blessedness,
  They are not "mine,"but I--even I myself!'),
('edwin-arnold-et:gita.7.19','Sir Edwin Arnold','gita.7.19','en','translation','At end of many births to Me they come!
  Yet hard the wise Mahatma is to find,
  That man who sayeth, "All is Vasudev!"[FN#13]'),
('edwin-arnold-et:gita.7.20','Sir Edwin Arnold','gita.7.20','en','translation','There be those, too, whose knowledge, turned aside
  By this desire or that, gives them to serve
  Some lower gods, with various rites, constrained
  By that which mouldeth them.'),
('edwin-arnold-et:gita.7.21','Sir Edwin Arnold','gita.7.21','en','translation','Unto all such--
  Worship what shrine they will, what shapes, in faith--
  ''Tis I who give them faith! I am content!'),
('edwin-arnold-et:gita.7.22','Sir Edwin Arnold','gita.7.22','en','translation','The heart thus asking favour from its God,
  Darkened but ardent, hath the end it craves,
  The lesser blessing--but ''tis I who give!'),
('edwin-arnold-et:gita.7.23','Sir Edwin Arnold','gita.7.23','en','translation','Yet soon is withered what small fruit they reap:
  Those men of little minds, who worship so,
  Go where they worship, passing with their gods.
  But Mine come unto me!'),
('edwin-arnold-et:gita.7.24','Sir Edwin Arnold','gita.7.24','en','translation','Blind are the eyes
  Which deem th'' Unmanifested manifest,
  Not comprehending Me in my true Self!'),
('edwin-arnold-et:gita.7.25','Sir Edwin Arnold','gita.7.25','en','translation','Imperishable, viewless, undeclared,
  Hidden behind my magic veil of shows,
  I am not seen by all; I am not known--
  Unborn and changeless--to the idle world.'),
('edwin-arnold-et:gita.7.26','Sir Edwin Arnold','gita.7.26','en','translation','But I, Arjuna! know all things which were,
  And all which are, and all which are to be,
  Albeit not one among them knoweth Me!'),
('edwin-arnold-et:gita.7.27','Sir Edwin Arnold','gita.7.27','en','translation','By passion for the "pairs of opposites,"
  By those twain snares of Like and Dislike, Prince!
  All creatures live bewildered,'),
('edwin-arnold-et:gita.7.28','Sir Edwin Arnold','gita.7.28','en','translation','save some few
  Who, quit of sins, holy in act, informed,
  Freed from the "opposites,"and fixed in faith,
  Cleave unto Me.'),
('edwin-arnold-et:gita.7.29','Sir Edwin Arnold','gita.7.29','en','translation','Who cleave, who seek in Me
  Refuge from birth[FN#14] and death, those have the Truth!
  Those know Me BRAHMA; know Me Soul of Souls,
  The ADHYATMAN; know KARMA, my work;'),
('edwin-arnold-et:gita.7.30','Sir Edwin Arnold','gita.7.30','en','translation','Know I am ADHIBHUTA, Lord of Life,
  And ADHIDAIVA, Lord of all the Gods,
  And ADHIYAJNA, Lord of Sacrifice;
  Worship Me well, with hearts of love and faith,
  And find and hold me in the hour of death.'),
('edwin-arnold-et:gita.8.1','Sir Edwin Arnold','gita.8.1','en','translation','Arjuna.
  Who is that BRAHMA? What that Soul of Souls,
  The ADHYATMAN? What, Thou Best of All!
  Thy work, the KARMA? Tell me what it is
  Thou namest ADHIBHUTA? What again
  Means ADHIDAIVA?'),
('edwin-arnold-et:gita.8.2','Sir Edwin Arnold','gita.8.2','en','translation','Yea, and how it comes
  Thou canst be ADHIYAJNA in thy flesh?
  Slayer of Madhu! Further, make me know
  How good men find thee in the hour of death?'),
('edwin-arnold-et:gita.8.3','Sir Edwin Arnold','gita.8.3','en','translation','Krishna.
  I BRAHMA am! the One Eternal GOD,
  And ADHYATMAN is My Being''s name,
  The Soul of Souls! What goeth forth from Me,
  Causing all life to live, is KARMA called:'),
('edwin-arnold-et:gita.8.4','Sir Edwin Arnold','gita.8.4','en','translation','And, Manifested in divided forms,
  I am the ADHIBHUTA, Lord of Lives;
  And ADHIDAIVA, Lord of all the Gods,
  Because I am PURUSHA, who begets.
  And ADHIYAJNA, Lord of Sacrifice,
  I--speaking with thee in this body here--
  Am, thou embodied one! (for all the shrines
  Flame unto Me!)'),
('edwin-arnold-et:gita.8.5','Sir Edwin Arnold','gita.8.5','en','translation','And, at the hour of death,
  He that hath meditated Me alone,
  In putting off his flesh, comes forth to Me,
  Enters into My Being--doubt thou not!'),
('edwin-arnold-et:gita.8.6','Sir Edwin Arnold','gita.8.6','en','translation','But, if he meditated otherwise
  At hour of death, in putting off the flesh,
  He goes to what he looked for, Kunti''s Son!
  Because the Soul is fashioned to its like.'),
('edwin-arnold-et:gita.8.7','Sir Edwin Arnold','gita.8.7','en','translation','Have Me, then, in thy heart always! and fight!
  Thou too, when heart and mind are fixed on Me,
  Shalt surely come to Me!'),
('edwin-arnold-et:gita.8.8','Sir Edwin Arnold','gita.8.8','en','translation','All come who cleave
  With never-wavering will of firmest faith,
  Owning none other Gods: all come to Me,
  The Uttermost, Purusha, Holiest!'),
('edwin-arnold-et:gita.8.9','Sir Edwin Arnold','gita.8.9','en','translation','Whoso hath known Me, Lord of sage and singer,
     Ancient of days; of all the Three Worlds Stay,
  Boundless,--but unto every atom Bringer
     Of that which quickens it: whoso, I say,

  Hath known My form, which passeth mortal knowing;
    Seen my effulgence--which no eye hath seen--
  Than the sun''s burning gold more brightly glowing,
    Dispersing darkness,--unto him hath been'),
('edwin-arnold-et:gita.8.10','Sir Edwin Arnold','gita.8.10','en','translation','Right life! And, in the hour when life is ending,
    With mind set fast and trustful piety,
  Drawing still breath beneath calm brows unbending,
    In happy peace that faithful one doth die,--

  In glad peace passeth to Purusha''s heaven.'),
('edwin-arnold-et:gita.8.11','Sir Edwin Arnold','gita.8.11','en','translation','The place which they who read the Vedas name
  AKSHARAM, "Ultimate;" whereto have striven
     Saints and ascetics--their road is the same.'),
('edwin-arnold-et:gita.8.12','Sir Edwin Arnold','gita.8.12','en','translation','That way--the highest way--goes he who shuts
  The gates of all his senses, locks desire
  Safe in his heart, centres the vital airs
  Upon his parting thought, steadfastly set;'),
('edwin-arnold-et:gita.8.13','Sir Edwin Arnold','gita.8.13','en','translation','And, murmuring OM, the sacred syllable--
  Emblem of BRAHM--dies, meditating Me.'),
('edwin-arnold-et:gita.8.14','Sir Edwin Arnold','gita.8.14','en','translation','For who, none other Gods regarding, looks
  Ever to Me, easily am I gained
  By such a Yogi;'),
('edwin-arnold-et:gita.8.15','Sir Edwin Arnold','gita.8.15','en','translation','and, attaining Me,
  They fall not--those Mahatmas--back to birth,
  To life, which is the place of pain, which ends,
  But take the way of utmost blessedness.'),
('edwin-arnold-et:gita.8.16','Sir Edwin Arnold','gita.8.16','en','translation','The worlds, Arjuna!--even Brahma''s world--
  Roll back again from Death to Life''s unrest;
  But they, O Kunti''s Son! that reach to Me,
  Taste birth no more.'),
('edwin-arnold-et:gita.8.17','Sir Edwin Arnold','gita.8.17','en','translation','If ye know Brahma''s Day
  Which is a thousand Yugas; if ye know
  The thousand Yugas making Brahma''s Night,
  Then know ye Day and Night as He doth know!'),
('edwin-arnold-et:gita.8.18','Sir Edwin Arnold','gita.8.18','en','translation','When that vast Dawn doth break, th'' Invisible
  Is brought anew into the Visible;
  When that deep Night doth darken, all which is
  Fades back again to Him Who sent it forth;'),
('edwin-arnold-et:gita.8.19','Sir Edwin Arnold','gita.8.19','en','translation','Yea! this vast company of living things--
  Again and yet again produced--expires
  At Brahma''s Nightfall; and, at Brahma''s Dawn,
  Riseth, without its will, to life new-born.'),
('edwin-arnold-et:gita.8.20','Sir Edwin Arnold','gita.8.20','en','translation','But--higher, deeper, innermost--abides
  Another Life, not like the life of sense,
  Escaping sight, unchanging. This endures
  When all created things have passed away:'),
('edwin-arnold-et:gita.8.21','Sir Edwin Arnold','gita.8.21','en','translation','This is that Life named the Unmanifest,
  The Infinite! the All! the Uttermost.
  Thither arriving none return. That Life
  Is Mine, and I am there!'),
('edwin-arnold-et:gita.8.22','Sir Edwin Arnold','gita.8.22','en','translation','And, Prince! by faith
  Which wanders not, there is a way to come
  Thither. I, the PURUSHA, I Who spread
  The Universe around me--in Whom dwell
  All living Things--may so be reached and seen!'),
('edwin-arnold-et:gita.8.28','Sir Edwin Arnold','gita.8.28','en','translation','Richer than holy fruit on Vedas growing,
     Greater than gifts, better than prayer or fast,
  Such wisdom is! The Yogi, this way knowing,
     Comes to the Utmost Perfect Peace at last.'),
('edwin-arnold-et:gita.9.1','Sir Edwin Arnold','gita.9.1','en','translation','Krishna.
  Now will I open unto thee--whose heart
  Rejects not--that last lore, deepest-concealed,
  That farthest secret of My Heavens and Earths,
  Which but to know shall set thee free from ills,--'),
('edwin-arnold-et:gita.9.2','Sir Edwin Arnold','gita.9.2','en','translation','A royal lore! a Kingly mystery!
  Yea! for the soul such light as purgeth it
  From every sin; a light of holiness
  With inmost splendour shining; plain to see;
  Easy to walk by, inexhaustible!'),
('edwin-arnold-et:gita.9.3','Sir Edwin Arnold','gita.9.3','en','translation','They that receive not this, failing in faith
  To grasp the greater wisdom, reach not Me,
  Destroyer of thy foes! They sink anew
  Into the realm of Flesh, where all things change!'),
('edwin-arnold-et:gita.9.4','Sir Edwin Arnold','gita.9.4','en','translation','By Me the whole vast Universe of things
  Is spread abroad;--by Me, the Unmanifest!
  In Me are all existences contained;
  Not I in them!'),
('edwin-arnold-et:gita.9.5','Sir Edwin Arnold','gita.9.5','en','translation','Yet they are not contained,
  Those visible things! Receive and strive to embrace
  The mystery majestical! My Being--
  Creating all, sustaining all--still dwells
  Outside of all!'),
('edwin-arnold-et:gita.9.6','Sir Edwin Arnold','gita.9.6','en','translation','See! as the shoreless airs
  Move in the measureless space, but are not space,
  [And space were space without the moving airs];
  So all things are in Me, but are not I.'),
('edwin-arnold-et:gita.9.7','Sir Edwin Arnold','gita.9.7','en','translation','At closing of each Kalpa, Indian Prince!
  All things which be back to My Being come:
  At the beginning of each Kalpa, all
  Issue new-born from Me.'),
('edwin-arnold-et:gita.9.8','Sir Edwin Arnold','gita.9.8','en','translation','By Energy
  And help of Prakriti my outer Self,
  Again, and yet again, I make go forth
  The realms of visible things--without their will--
  All of them--by the power of Prakriti.'),
('edwin-arnold-et:gita.9.9','Sir Edwin Arnold','gita.9.9','en','translation','Yet these great makings, Prince! involve Me not
  Enchain Me not! I sit apart from them,
  Other, and Higher, and Free; nowise attached!'),
('edwin-arnold-et:gita.9.10','Sir Edwin Arnold','gita.9.10','en','translation','Thus doth the stuff of worlds, moulded by Me,
  Bring forth all that which is, moving or still,
  Living or lifeless! Thus the worlds go on!'),
('edwin-arnold-et:gita.9.11','Sir Edwin Arnold','gita.9.11','en','translation','The minds untaught mistake Me, veiled in form;--
  Naught see they of My secret Presence, nought
  Of My hid Nature, ruling all which lives.'),
('edwin-arnold-et:gita.9.12','Sir Edwin Arnold','gita.9.12','en','translation','Vain hopes pursuing, vain deeds doing; fed
  On vainest knowledge, senselessly they seek
  An evil way, the way of brutes and fiends.'),
('edwin-arnold-et:gita.9.13','Sir Edwin Arnold','gita.9.13','en','translation','But My Mahatmas, those of noble soul
  Who tread the path celestial, worship Me
  With hearts unwandering,--knowing Me the Source,
  Th'' Eternal Source, of Life.'),
('edwin-arnold-et:gita.9.14','Sir Edwin Arnold','gita.9.14','en','translation','Unendingly
  They glorify Me; seek Me; keep their vows
  Of reverence and love, with changeless faith
  Adoring Me.'),
('edwin-arnold-et:gita.9.15','Sir Edwin Arnold','gita.9.15','en','translation','Yea, and those too adore,
  Who, offering sacrifice of wakened hearts,
  Have sense of one pervading Spirit''s stress,
  One Force in every place, though manifold!'),
('edwin-arnold-et:gita.9.16','Sir Edwin Arnold','gita.9.16','en','translation','I am the Sacrifice! I am the Prayer!
  I am the Funeral-Cake set for the dead!
  I am the healing herb! I am the ghee,
  The Mantra, and the flame, and that which burns!'),
('edwin-arnold-et:gita.9.17','Sir Edwin Arnold','gita.9.17','en','translation','I am-of all this boundless Universe-
  The Father, Mother, Ancestor, and Guard!
  The end of Learning! That which purifies
  In lustral water! I am OM! I am
  Rig-Veda, Sama-Veda, Yajur-Ved;'),
('edwin-arnold-et:gita.9.18','Sir Edwin Arnold','gita.9.18','en','translation','The Way, the Fosterer, the Lord, the Judge,
  The Witness; the Abode, the Refuge-House,
  The Friend, the Fountain and the Sea of Life
  Which sends, and swallows up; Treasure of Worlds
  And Treasure-Chamber! Seed and Seed-Sower,
  Whence endless harvests spring!'),
('edwin-arnold-et:gita.9.19','Sir Edwin Arnold','gita.9.19','en','translation','Sun''s heat is mine;
  Heaven''s rain is mine to grant or to withhold;
  Death am I, and Immortal Life I am,
  Arjuna! SAT and ASAT, Visible Life,
  And Life Invisible!'),
('edwin-arnold-et:gita.9.20','Sir Edwin Arnold','gita.9.20','en','translation','Yea! those who learn
    The threefold Veds, who drink the Soma-wine,
  Purge sins, pay sacrifice--from Me they earn
    Passage to Swarga; where the meats divine

  Of great gods feed them in high Indra''s heaven.'),
('edwin-arnold-et:gita.9.21','Sir Edwin Arnold','gita.9.21','en','translation','Yet they, when that prodigious joy is o''er,
  Paradise spent, and wage for merits given,
    Come to the world of death and change once more.

  They had their recompense! they stored their treasure,
    Following the threefold Scripture and its writ;
  Who seeketh such gaineth the fleeting pleasure
    Of joy which comes and goes! I grant them it!'),
('edwin-arnold-et:gita.9.22','Sir Edwin Arnold','gita.9.22','en','translation','But to those blessed ones who worship Me,
  Turning not otherwhere, with minds set fast,
  I bring assurance of full bliss beyond.'),
('edwin-arnold-et:gita.9.23','Sir Edwin Arnold','gita.9.23','en','translation','Nay, and of hearts which follow other gods
  In simple faith, their prayers arise to me,
  O Kunti''s Son! though they pray wrongfully;'),
('edwin-arnold-et:gita.9.24','Sir Edwin Arnold','gita.9.24','en','translation','For I am the Receiver and the Lord
  Of every sacrifice, which these know not
  Rightfully; so they fall to earth again!'),
('edwin-arnold-et:gita.9.25','Sir Edwin Arnold','gita.9.25','en','translation','Who follow gods go to their gods; who vow
  Their souls to Pitris go to Pitris; minds
  To evil Bhuts given o''er sink to the Bhuts;
  And whoso loveth Me cometh to Me.'),
('edwin-arnold-et:gita.9.26','Sir Edwin Arnold','gita.9.26','en','translation','Whoso shall offer Me in faith and love
  A leaf, a flower, a fruit, water poured forth,
  That offering I accept, lovingly made
  With pious will.'),
('edwin-arnold-et:gita.9.27','Sir Edwin Arnold','gita.9.27','en','translation','Whate''er thou doest, Prince!
  Eating or sacrificing, giving gifts,
  Praying or fasting, let it all be done
  For Me, as Mine.'),
('edwin-arnold-et:gita.9.28','Sir Edwin Arnold','gita.9.28','en','translation','So shalt thou free thyself
  From Karmabandh, the chain which holdeth men
  To good and evil issue, so shalt come
  Safe unto Me-when thou art quit of flesh--
  By faith and abdication joined to Me!'),
('edwin-arnold-et:gita.9.29','Sir Edwin Arnold','gita.9.29','en','translation','I am alike for all! I know not hate,
  I know not favour! What is made is Mine!
  But them that worship Me with love, I love;
  They are in Me, and I in them!'),
('edwin-arnold-et:gita.9.30','Sir Edwin Arnold','gita.9.30','en','translation','Nay, Prince!
  If one of evil life turn in his thought
  Straightly to Me, count him amidst the good;
  He hath the high way chosen;'),
('edwin-arnold-et:gita.9.31','Sir Edwin Arnold','gita.9.31','en','translation','he shall grow
  Righteous ere long; he shall attain that peace
  Which changes not. Thou Prince of India!
  Be certain none can perish, trusting Me!'),
('edwin-arnold-et:gita.9.32','Sir Edwin Arnold','gita.9.32','en','translation','O Pritha''s Son! whoso will turn to Me,
  Though they be born from the very womb of Sin,
  Woman or man; sprung of the Vaisya caste
  Or lowly disregarded Sudra,--all
  Plant foot upon the highest path;'),
('edwin-arnold-et:gita.9.33','Sir Edwin Arnold','gita.9.33','en','translation','how then
  The holy Brahmans and My Royal Saints?
  Ah! ye who into this ill world are come--
  Fleeting and false--set your faith fast on Me!'),
('edwin-arnold-et:gita.9.34','Sir Edwin Arnold','gita.9.34','en','translation','Fix heart and thought on Me! Adore Me! Bring
  Offerings to Me! Make Me prostrations! Make
  Me your supremest joy! and, undivided,
  Unto My rest your spirits shall be guided.'),
('edwin-arnold-et:gita.10.1','Sir Edwin Arnold','gita.10.1','en','translation','Krishna.[FN#l6]
  Hear farther yet, thou Long-Armed Lord! these latest words I say--
  Uttered to bring thee bliss and peace, who lovest Me alway--'),
('edwin-arnold-et:gita.10.2','Sir Edwin Arnold','gita.10.2','en','translation','Not the great company of gods nor kingly Rishis know
  My Nature, Who have made the gods and Rishis long ago;'),
('edwin-arnold-et:gita.10.3','Sir Edwin Arnold','gita.10.3','en','translation','He only knoweth-only he is free of sin, and wise,
  Who seeth Me, Lord of the Worlds, with faith-enlightened eyes,
  Unborn, undying, unbegun.'),
('edwin-arnold-et:gita.10.4','Sir Edwin Arnold','gita.10.4','en','translation','Whatever Natures be
  To mortal men distributed, those natures spring from Me!
  Intellect, skill, enlightenment, endurance, self-control,
  Truthfulness, equability, and grief or joy of soul,
  And birth and death, and fearfulness, and fearlessness, and shame,
  And honour, and sweet harmlessness,[FN#17] and peace which is the
  same
  Whate''er befalls, and mirth, and tears, and piety, and thrift,
  And wish to give, and will to help,--all cometh of My gift!'),
('edwin-arnold-et:gita.10.5','Sir Edwin Arnold','gita.10.5','en','translation','Whatever Natures be
  To mortal men distributed, those natures spring from Me!
  Intellect, skill, enlightenment, endurance, self-control,
  Truthfulness, equability, and grief or joy of soul,
  And birth and death, and fearfulness, and fearlessness, and shame,
  And honour, and sweet harmlessness,[FN#17] and peace which is the
  same
  Whate''er befalls, and mirth, and tears, and piety, and thrift,
  And wish to give, and will to help,--all cometh of My gift!'),
('edwin-arnold-et:gita.10.6','Sir Edwin Arnold','gita.10.6','en','translation','The Seven Chief Saints, the Elders Four, the Lordly Manus set--
  Sharing My work--to rule the worlds, these too did I beget;
  And Rishis, Pitris, Manus, all, by one thought of My mind;
  Thence did arise, to fill this world, the races of mankind;'),
('edwin-arnold-et:gita.10.7','Sir Edwin Arnold','gita.10.7','en','translation','Wherefrom who comprehends My Reign of mystic Majesty--
  That truth of truths--is thenceforth linked in faultless faith to Me:'),
('edwin-arnold-et:gita.10.8','Sir Edwin Arnold','gita.10.8','en','translation','Yea! knowing Me the source of all, by Me all creatures wrought,
  The wise in spirit cleave to Me, into My Being brought;'),
('edwin-arnold-et:gita.10.9','Sir Edwin Arnold','gita.10.9','en','translation','Hearts fixed on Me; breaths breathed to Me; praising Me, each to each,
  So have they happiness and peace, with pious thought and speech;'),
('edwin-arnold-et:gita.10.10','Sir Edwin Arnold','gita.10.10','en','translation','And unto these--thus serving well, thus loving ceaselessly--
  I give a mind of perfect mood, whereby they draw to Me;'),
('edwin-arnold-et:gita.10.11','Sir Edwin Arnold','gita.10.11','en','translation','And, all for love of them, within their darkened souls I dwell,
  And, with bright rays of wisdom''s lamp, their ignorance dispel.'),
('edwin-arnold-et:gita.10.12','Sir Edwin Arnold','gita.10.12','en','translation','Arjuna.
  Yes! Thou art Parabrahm! The High Abode!
  The Great Purification! Thou art God
  Eternal, All-creating, Holy, First,
  Without beginning! Lord of Lords and Gods!'),
('edwin-arnold-et:gita.10.13','Sir Edwin Arnold','gita.10.13','en','translation','Declared by all the Saints--by Narada,
  Vyasa Asita, and Devalas;
  And here Thyself declaring unto me!'),
('edwin-arnold-et:gita.10.14','Sir Edwin Arnold','gita.10.14','en','translation','What Thou hast said now know I to be truth,
  O Kesava! that neither gods nor men
  Nor demons comprehend Thy mystery
  Made manifest, Divinest!'),
('edwin-arnold-et:gita.10.15','Sir Edwin Arnold','gita.10.15','en','translation','Thou Thyself
  Thyself alone dost know, Maker Supreme!
  Master of all the living! Lord of Gods!
  King of the Universe!'),
('edwin-arnold-et:gita.10.16','Sir Edwin Arnold','gita.10.16','en','translation','To Thee alone
  Belongs to tell the heavenly excellence
  Of those perfections wherewith Thou dost fill
  These worlds of Thine; Pervading, Immanent!'),
('edwin-arnold-et:gita.10.17','Sir Edwin Arnold','gita.10.17','en','translation','How shall I learn, Supremest Mystery!
  To know Thee, though I muse continually?
  Under what form of Thine unnumbered forms
  Mayst Thou be grasped?'),
('edwin-arnold-et:gita.10.18','Sir Edwin Arnold','gita.10.18','en','translation','Ah! yet again recount,
  Clear and complete, Thy great appearances,
  The secrets of Thy Majesty and Might,
  Thou High Delight of Men! Never enough
  Can mine ears drink the Amrit[FN#18] of such words!'),
('edwin-arnold-et:gita.10.19','Sir Edwin Arnold','gita.10.19','en','translation','Krishna.
  Hanta! So be it! Kuru Prince! I will to thee unfold
  Some portions of My Majesty, whose powers are manifold!'),
('edwin-arnold-et:gita.10.20','Sir Edwin Arnold','gita.10.20','en','translation','I am the Spirit seated deep in every creature''s heart;
  From Me they come; by Me they live; at My word they depart!'),
('edwin-arnold-et:gita.10.21','Sir Edwin Arnold','gita.10.21','en','translation','Vishnu of the Adityas I am, those Lords of Light;
  Maritchi of the Maruts, the Kings of Storm and Blight;
  By day I gleam, the golden Sun of burning cloudless Noon;
  By Night, amid the asterisms I glide, the dappled Moon!'),
('edwin-arnold-et:gita.10.22','Sir Edwin Arnold','gita.10.22','en','translation','Of Vedas I am Sama-Ved, of gods in Indra''s Heaven
  Vasava; of the faculties to living beings given
  The mind which apprehends and thinks;'),
('edwin-arnold-et:gita.10.23','Sir Edwin Arnold','gita.10.23','en','translation','of Rudras Sankara;
  Of Yakshas and of Rakshasas, Vittesh; and Pavaka
  Of Vasus, and of mountain-peaks Meru;'),
('edwin-arnold-et:gita.10.24','Sir Edwin Arnold','gita.10.24','en','translation','Vrihaspati
  Know Me ''mid planetary Powers; ''mid Warriors heavenly
  Skanda; of all the water-floods the Sea which drinketh each,'),
('edwin-arnold-et:gita.10.25','Sir Edwin Arnold','gita.10.25','en','translation','And Bhrigu of the holy Saints, and OM of sacred speech;
  Of prayers the prayer ye whisper;[FN#19] of hills Himala''s snow,'),
('edwin-arnold-et:gita.10.26','Sir Edwin Arnold','gita.10.26','en','translation','And Aswattha, the fig-tree, of all the trees that grow;
  Of the Devarshis, Narada; and Chitrarath of them
  That sing in Heaven, and Kapila of Munis,'),
('edwin-arnold-et:gita.10.27','Sir Edwin Arnold','gita.10.27','en','translation','and the gem
  Of flying steeds, Uchchaisravas, from Amrit-wave which burst;
  Of elephants Airavata; of males the Best and First;'),
('edwin-arnold-et:gita.10.28','Sir Edwin Arnold','gita.10.28','en','translation','Of weapons Heav''n''s hot thunderbolt; of cows white Kamadhuk,
  From whose great milky udder-teats all hearts'' desires are strook;
  Vasuki of the serpent-tribes, round Mandara entwined;'),
('edwin-arnold-et:gita.10.29','Sir Edwin Arnold','gita.10.29','en','translation','And thousand-fanged Ananta, on whose broad coils reclined
  Leans Vishnu; and of water-things Varuna; Aryam
  Of Pitris, and, of those that judge, Yama the Judge I am;'),
('edwin-arnold-et:gita.10.30','Sir Edwin Arnold','gita.10.30','en','translation','Of Daityas dread Prahlada; of what metes days and years,
  Time''s self I am; of woodland-beasts-buffaloes, deers, and bears-
  The lordly-painted tiger; of birds the vast Garud,'),
('edwin-arnold-et:gita.10.31','Sir Edwin Arnold','gita.10.31','en','translation','The whirlwind ''mid the winds; ''mid chiefs Rama with blood imbrued,
  Makar ''mid fishes of the sea, and Ganges ''mid the streams;'),
('edwin-arnold-et:gita.10.32','Sir Edwin Arnold','gita.10.32','en','translation','Yea! First, and Last, and Centre of all which is or seems
  I am, Arjuna! Wisdom Supreme of what is wise,
  Words on the uttering lips I am, and eyesight of the eyes,'),
('edwin-arnold-et:gita.10.33','Sir Edwin Arnold','gita.10.33','en','translation','And "A" of written characters, Dwandwa[FN#20] of knitted speech,
  And Endless Life, and boundless Love, whose power sustaineth each;'),
('edwin-arnold-et:gita.10.34','Sir Edwin Arnold','gita.10.34','en','translation','And bitter Death which seizes all, and joyous sudden Birth,
  Which brings to light all beings that are to be on earth;
  And of the viewless virtues, Fame, Fortune, Song am I,
  And Memory, and Patience; and Craft, and Constancy:'),
('edwin-arnold-et:gita.10.35','Sir Edwin Arnold','gita.10.35','en','translation','Of Vedic hymns the Vrihatsam, of metres Gayatri,
  Of months the Margasirsha, of all the seasons three
  The flower-wreathed Spring;'),
('edwin-arnold-et:gita.10.36','Sir Edwin Arnold','gita.10.36','en','translation','in dicer''s-play the conquering
  Double-Eight;
  The splendour of the splendid, and the greatness of the great,
  Victory I am, and Action! and the goodness of the good,'),
('edwin-arnold-et:gita.10.37','Sir Edwin Arnold','gita.10.37','en','translation','And Vasudev of Vrishni''s race, and of this Pandu brood
  Thyself!--Yea, my Arjuna! thyself; for thou art Mine!
  Of poets Usana, of saints Vyasa, sage divine;'),
('edwin-arnold-et:gita.10.38','Sir Edwin Arnold','gita.10.38','en','translation','The policy of conquerors, the potency of kings,
  The great unbroken silence in learning''s secret things;
  The lore of all the learned,'),
('edwin-arnold-et:gita.10.39','Sir Edwin Arnold','gita.10.39','en','translation','the seed of all which springs.
  Living or lifeless, still or stirred, whatever beings be,
  None of them is in all the worlds, but it exists by Me!'),
('edwin-arnold-et:gita.10.40','Sir Edwin Arnold','gita.10.40','en','translation','Nor tongue can tell, Arjuna! nor end of telling come
  Of these My boundless glories, whereof I teach thee some;'),
('edwin-arnold-et:gita.10.41','Sir Edwin Arnold','gita.10.41','en','translation','For wheresoe''er is wondrous work, and majesty, and might,
  From Me hath all proceeded. Receive thou this aright!'),
('edwin-arnold-et:gita.10.42','Sir Edwin Arnold','gita.10.42','en','translation','Yet how shouldst thou receive, O Prince! the vastness of this word?
  I, who am all, and made it all, abide its separate Lord!'),
('edwin-arnold-et:gita.11.1','Sir Edwin Arnold','gita.11.1','en','translation','Arjuna.
  This, for my soul''s peace, have I heard from Thee,
  The unfolding of the Mystery Supreme
  Named Adhyatman; comprehending which,
  My darkness is dispelled;'),
('edwin-arnold-et:gita.11.2','Sir Edwin Arnold','gita.11.2','en','translation','for now I know--
  O Lotus-eyed![FN#21]--whence is the birth of men,
  And whence their death, and what the majesties
  Of Thine immortal rule.'),
('edwin-arnold-et:gita.11.3','Sir Edwin Arnold','gita.11.3','en','translation','Fain would I see,
  As thou Thyself declar''st it, Sovereign Lord!
  The likeness of that glory of Thy Form
  Wholly revealed.'),
('edwin-arnold-et:gita.11.4','Sir Edwin Arnold','gita.11.4','en','translation','O Thou Divinest One!
  If this can be, if I may bear the sight,
  Make Thyself visible, Lord of all prayers!
  Show me Thy very self, the Eternal God!'),
('edwin-arnold-et:gita.11.5','Sir Edwin Arnold','gita.11.5','en','translation','Krishna.
  Gaze, then, thou Son of Pritha! I manifest for thee
  Those hundred thousand thousand shapes that clothe my Mystery:
  I show thee all my semblances, infinite, rich, divine,
  My changeful hues, my countless forms.'),
('edwin-arnold-et:gita.11.6','Sir Edwin Arnold','gita.11.6','en','translation','See! in this face of mine,
  Adityas, Vasus, Rudras, Aswins, and Maruts; see
  Wonders unnumbered, Indian Prince! revealed to none save thee.'),
('edwin-arnold-et:gita.11.7','Sir Edwin Arnold','gita.11.7','en','translation','Behold! this is the Universe!--Look! what is live and dead
  I gather all in one--in Me! Gaze, as thy lips have said,
  On GOD ETERNAL, VERY GOD! See Me! see what thou prayest!'),
('edwin-arnold-et:gita.11.8','Sir Edwin Arnold','gita.11.8','en','translation','Thou canst not!--nor, with human eyes, Arjuna! ever mayest!
  Therefore I give thee sense divine. Have other eyes, new light!
  And, look! This is My glory, unveiled to mortal sight!'),
('edwin-arnold-et:gita.11.9','Sir Edwin Arnold','gita.11.9','en','translation','Sanjaya.
  Then, O King! the God, so saying,
  Stood, to Pritha''s Son displaying
  All the splendour, wonder, dread
  Of His vast Almighty-head.'),
('edwin-arnold-et:gita.11.10','Sir Edwin Arnold','gita.11.10','en','translation','Out of countless eyes beholding,
  Out of countless mouths commanding,
  Countless mystic forms enfolding
  In one Form: supremely standing
  Countless radiant glories wearing,
  Countless heavenly weapons bearing,'),
('edwin-arnold-et:gita.11.11','Sir Edwin Arnold','gita.11.11','en','translation','Crowned with garlands of star-clusters,
  Robed in garb of woven lustres,
  Breathing from His perfect Presence
  Breaths of every subtle essence
  Of all heavenly odours; shedding
  Blinding brilliance; overspreading--
  Boundless, beautiful--all spaces
  With His all-regarding faces;
  So He showed!'),
('edwin-arnold-et:gita.11.12','Sir Edwin Arnold','gita.11.12','en','translation','If there should rise
  Suddenly within the skies
  Sunburst of a thousand suns
  Flooding earth with beams undeemed-of,
  Then might be that Holy One''s
  Majesty and radiance dreamed of!'),
('edwin-arnold-et:gita.11.13','Sir Edwin Arnold','gita.11.13','en','translation','So did Pandu''s Son behold
  All this universe enfold
  All its huge diversity
  Into one vast shape, and be
  Visible, and viewed, and blended
  In one Body--subtle, splendid,
  Nameless--th'' All-comprehending
  God of Gods, the Never-Ending
  Deity!'),
('edwin-arnold-et:gita.11.14','Sir Edwin Arnold','gita.11.14','en','translation','But, sore amazed,
  Thrilled, o''erfilled, dazzled, and dazed,
  Arjuna knelt; and bowed his head,
  And clasped his palms; and cried, and said:'),
('edwin-arnold-et:gita.11.15','Sir Edwin Arnold','gita.11.15','en','translation','Arjuna.
  Yea! I have seen! I see!
  Lord! all is wrapped in Thee!
  The gods are in Thy glorious frame! the creatures
  Of earth, and heaven, and hell
  In Thy Divine form dwell,
  And in Thy countenance shine all the features

  Of Brahma, sitting lone
  Upon His lotus-throne;
  Of saints and sages, and the serpent races
  Ananta, Vasuki;'),
('edwin-arnold-et:gita.11.16','Sir Edwin Arnold','gita.11.16','en','translation','Yea! mightiest Lord! I see
  Thy thousand thousand arms, and breasts, and faces,
  And eyes,--on every side
  Perfect, diversified;
  And nowhere end of Thee, nowhere beginning,
  Nowhere a centre! Shifts--
  Wherever soul''s gaze lifts--
  Thy central Self, all-wielding, and all-winning!'),
('edwin-arnold-et:gita.11.17','Sir Edwin Arnold','gita.11.17','en','translation','Infinite King! I see
  The anadem on Thee,
  The club, the shell, the discus; see Thee burning
  In beams insufferable,
  Lighting earth, heaven, and hell
  With brilliance blazing, glowing, flashing; turning

  Darkness to dazzling day,
  Look I whichever way;'),
('edwin-arnold-et:gita.11.18','Sir Edwin Arnold','gita.11.18','en','translation','Ah, Lord! I worship Thee, the Undivided,
  The Uttermost of thought,
  The Treasure-Palace wrought
  To hold the wealth of the worlds; the Shield provided

  To shelter Virtue''s laws;
  The Fount whence Life''s stream draws
  All waters of all rivers of all being:'),
('edwin-arnold-et:gita.11.19','Sir Edwin Arnold','gita.11.19','en','translation','The One Unborn, Unending:
  Unchanging and Unblending!
  With might and majesty, past thought, past seeing!

  Silver of moon and gold
  Of sun are glories rolled
  From Thy great eyes; Thy visage, beaming tender
  Throughout the stars and skies,
  Doth to warm life surprise
  Thy Universe.'),
('edwin-arnold-et:gita.11.20','Sir Edwin Arnold','gita.11.20','en','translation','The worlds are filled with wonder

  Of Thy perfections! Space
  Star-sprinkled, and void place
  From pole to pole of the Blue, from bound to bound,
  Hath Thee in every spot,
  Thee, Thee!--Where Thou art not,
  O Holy, Marvellous Form! is nowhere found!

  O Mystic, Awful One!
  At sight of Thee, made known,
  The Three Worlds quake;'),
('edwin-arnold-et:gita.11.21','Sir Edwin Arnold','gita.11.21','en','translation','the lower gods draw nigh Thee;
  They fold their palms, and bow
  Body, and breast, and brow,
  And, whispering worship, laud and magnify Thee!

  Rishis and Siddhas cry
  "Hail! Highest Majesty!"
  From sage and singer breaks the hymn of glory
  In dulcet harmony,
  Sounding the praise of Thee;
  While countless companies take up the story,'),
('edwin-arnold-et:gita.11.22','Sir Edwin Arnold','gita.11.22','en','translation','Rudras, who ride the storms,
  Th'' Adityas'' shining forms,
  Vasus and Sadhyas, Viswas, Ushmapas;
  Maruts, and those great Twins
  The heavenly, fair, Aswins,
  Gandharvas, Rakshasas, Siddhas, and Asuras,[FN#22]--

  These see Thee, and revere
  In sudden-stricken fear;'),
('edwin-arnold-et:gita.11.23','Sir Edwin Arnold','gita.11.23','en','translation','Yea! the Worlds,--seeing Thee with form stupendous,
  With faces manifold,
  With eyes which all behold,
  Unnumbered eyes, vast arms, members tremendous,

  Flanks, lit with sun and star,
  Feet planted near and far,
  Tushes of terror, mouths wrathful and tender;--
  The Three wide Worlds before Thee
  Adore, as I adore Thee,
  Quake, as I quake, to witness so much splendour!'),
('edwin-arnold-et:gita.11.24','Sir Edwin Arnold','gita.11.24','en','translation','I mark Thee strike the skies
  With front, in wondrous wise
  Huge, rainbow-painted, glittering; and thy mouth
  Opened, and orbs which see
  All things, whatever be
  In all Thy worlds, east, west, and north and south.

  O Eyes of God! O Head!
  My strength of soul is fled,
  Gone is heart''s force, rebuked is mind''s desire!'),
('edwin-arnold-et:gita.11.25','Sir Edwin Arnold','gita.11.25','en','translation','When I behold Thee so,
  With awful brows a-glow,
  With burning glance, and lips lighted by fire

  Fierce as those flames which shall
  Consume, at close of all,
  Earth, Heaven! Ah me! I see no Earth and Heaven!
  Thee, Lord of Lords! I see,
  Thee only-only Thee!
  Now let Thy mercy unto me be given,

  Thou Refuge of the World!'),
('edwin-arnold-et:gita.11.26','Sir Edwin Arnold','gita.11.26','en','translation','Lo! to the cavern hurled
  Of Thy wide-opened throat, and lips white-tushed,
  I see our noblest ones,
  Great Dhritarashtra''s sons,
  Bhishma, Drona, and Karna, caught and crushed!

  The Kings and Chiefs drawn in,
  That gaping gorge within;
  The best of both these armies torn and riven!
  Between Thy jaws they lie
  Mangled full bloodily,
  Ground into dust and death!'),
('edwin-arnold-et:gita.11.27','Sir Edwin Arnold','gita.11.27','en','translation','Lo! to the cavern hurled
  Of Thy wide-opened throat, and lips white-tushed,
  I see our noblest ones,
  Great Dhritarashtra''s sons,
  Bhishma, Drona, and Karna, caught and crushed!

  The Kings and Chiefs drawn in,
  That gaping gorge within;
  The best of both these armies torn and riven!
  Between Thy jaws they lie
  Mangled full bloodily,
  Ground into dust and death!'),
('edwin-arnold-et:gita.11.28','Sir Edwin Arnold','gita.11.28','en','translation','Like streams down-driven

  With helpless haste, which go
  In headlong furious flow
  Straight to the gulfing deeps of th'' unfilled ocean,
  So to that flaming cave
  Those heroes great and brave
  Pour, in unending streams, with helpless motion!'),
('edwin-arnold-et:gita.11.29','Sir Edwin Arnold','gita.11.29','en','translation','Like moths which in the night
  Flutter towards a light,
  Drawn to their fiery doom, flying and dying,
  So to their death still throng,
  Blind, dazzled, borne along
  Ceaselessly, all those multitudes, wild flying!'),
('edwin-arnold-et:gita.11.30','Sir Edwin Arnold','gita.11.30','en','translation','Thou, that hast fashioned men,
  Devourest them again,
  One with another, great and small, alike!
  The creatures whom Thou mak''st,
  With flaming jaws Thou tak''st,
  Lapping them up! Lord God! Thy terrors strike

  From end to end of earth,
  Filling life full, from birth
  To death, with deadly, burning, lurid dread!'),
('edwin-arnold-et:gita.11.31','Sir Edwin Arnold','gita.11.31','en','translation','Ah, Vishnu! make me know
  Why is Thy visage so?
  Who art Thou, feasting thus upon Thy dead?

  Who? awful Deity!
  I bow myself to Thee,
  Namostu Te, Devavara! Prasid![FN#23]
  O Mightiest Lord! rehearse
  Why hast Thou face so fierce?
  Whence doth this aspect horrible proceed?'),
('edwin-arnold-et:gita.11.32','Sir Edwin Arnold','gita.11.32','en','translation','Krishna.
  Thou seest Me as Time who kills,
  Time who brings all to doom,
  The Slayer Time, Ancient of Days, come hither to consume;
  Excepting thee, of all these hosts of hostile chiefs arrayed,
  There stands not one shall leave alive the battlefield!'),
('edwin-arnold-et:gita.11.33','Sir Edwin Arnold','gita.11.33','en','translation','Dismayed
  No longer be! Arise! obtain renown! destroy thy foes!
  Fight for the kingdom waiting thee when thou hast vanquished those.
  By Me they fall--not thee! the stroke of death is dealt them now,
  Even as they show thus gallantly; My instrument art thou!'),
('edwin-arnold-et:gita.11.34','Sir Edwin Arnold','gita.11.34','en','translation','Strike, strong-armed Prince, at Drona! at Bhishma strike! deal death
  On Karna, Jyadratha; stay all their warlike breath!
  ''Tis I who bid them perish! Thou wilt but slay the slain;
  Fight! they must fall, and thou must live, victor upon this plain!'),
('edwin-arnold-et:gita.11.35','Sir Edwin Arnold','gita.11.35','en','translation','Sanjaya.
  Hearing mighty Keshav''s word,
  Tremblingly that helmed Lord
  Clasped his lifted palms, and--praying
  Grace of Krishna--stood there, saying,
  With bowed brow and accents broken,
  These words, timorously spoken:'),
('edwin-arnold-et:gita.11.36','Sir Edwin Arnold','gita.11.36','en','translation','Arjuna.
  Worthily, Lord of Might!
  The whole world hath delight
  In Thy surpassing power, obeying Thee;
  The Rakshasas, in dread
  At sight of Thee, are sped
  To all four quarters; and the company

  Of Siddhas sound Thy name.'),
('edwin-arnold-et:gita.11.37','Sir Edwin Arnold','gita.11.37','en','translation','How should they not proclaim
  Thy Majesties, Divinest, Mightiest?
  Thou Brahm, than Brahma greater!
  Thou Infinite Creator!
  Thou God of gods, Life''s Dwelling-place and Rest!

  Thou, of all souls the Soul!
  The Comprehending Whole!
  Of being formed, and formless being the Framer;'),
('edwin-arnold-et:gita.11.38','Sir Edwin Arnold','gita.11.38','en','translation','O Utmost One! O Lord!
  Older than eld, Who stored
  The worlds with wealth of life! O Treasure-Claimer,

  Who wottest all, and art
  Wisdom Thyself! O Part
  In all, and All; for all from Thee have risen
  Numberless now I see
  The aspects are of Thee!'),
('edwin-arnold-et:gita.11.39','Sir Edwin Arnold','gita.11.39','en','translation','Vayu[FN#24] Thou art, and He who keeps the prison

  Of Narak, Yama dark;
  And Agni''s shining spark;
  Varuna''s waves are Thy waves. Moon and starlight
  Are Thine! Prajapati
  Art Thou, and ''tis to Thee
  They knelt in worshipping the old world''s far light,

  The first of mortal men.
  Again, Thou God! again
  A thousand thousand times be magnified!'),
('edwin-arnold-et:gita.11.40','Sir Edwin Arnold','gita.11.40','en','translation','Honour and worship be--
  Glory and praise,--to Thee
  Namo, Namaste, cried on every side;

  Cried here, above, below,
  Uttered when Thou dost go,
  Uttered where Thou dost come! Namo! we call;
  Namostu! God adored!
  Namostu! Nameless Lord!
  Hail to Thee! Praise to Thee! Thou One in all;

  For Thou art All! Yea, Thou!'),
('edwin-arnold-et:gita.11.41','Sir Edwin Arnold','gita.11.41','en','translation','Ah! if in anger now
  Thou shouldst remember I did think Thee Friend,
  Speaking with easy speech,
  As men use each to each;
  Did call Thee "Krishna," "Prince," nor comprehend

  Thy hidden majesty,
  The might, the awe of Thee;
  Did, in my heedlessness, or in my love,'),
('edwin-arnold-et:gita.11.42','Sir Edwin Arnold','gita.11.42','en','translation','On journey, or in jest,
  Or when we lay at rest,
  Sitting at council, straying in the grove,

  Alone, or in the throng,
  Do Thee, most Holy! wrong,
  Be Thy grace granted for that witless sin!'),
('edwin-arnold-et:gita.11.43','Sir Edwin Arnold','gita.11.43','en','translation','For Thou art, now I know,
  Father of all below,
  Of all above, of all the worlds within

  Guru of Gurus; more
  To reverence and adore
  Than all which is adorable and high!
  How, in the wide worlds three
  Should any equal be?
  Should any other share Thy Majesty?'),
('edwin-arnold-et:gita.11.44','Sir Edwin Arnold','gita.11.44','en','translation','Therefore, with body bent
  And reverent intent,
  I praise, and serve, and seek Thee, asking grace.
  As father to a son,
  As friend to friend, as one
  Who loveth to his lover, turn Thy face

  In gentleness on me!'),
('edwin-arnold-et:gita.11.45','Sir Edwin Arnold','gita.11.45','en','translation','Good is it I did see
  This unknown marvel of Thy Form! But fear
  Mingles with joy! Retake,
  Dear Lord! for pity''s sake
  Thine earthly shape, which earthly eyes may bear!'),
('edwin-arnold-et:gita.11.46','Sir Edwin Arnold','gita.11.46','en','translation','Be merciful, and show
  The visage that I know;
  Let me regard Thee, as of yore, arrayed
  With disc and forehead-gem,
  With mace and anadem,
  Thou that sustainest all things! Undismayed

  Let me once more behold
  The form I loved of old,
  Thou of the thousand arms and countless eyes!
  This frightened heart is fain
  To see restored again
  My Charioteer, in Krishna''s kind disguise.'),
('edwin-arnold-et:gita.11.47','Sir Edwin Arnold','gita.11.47','en','translation','Krishna.
  Yea! thou hast seen, Arjuna! because I loved thee well,
  The secret countenance of Me, revealed by mystic spell,
  Shining, and wonderful, and vast, majestic, manifold,
  Which none save thou in all the years had favour to behold;'),
('edwin-arnold-et:gita.11.48','Sir Edwin Arnold','gita.11.48','en','translation','For not by Vedas cometh this, nor sacrifice, nor alms,
  Nor works well-done, nor penance long, nor prayers, nor chaunted
  psalms,
  That mortal eyes should bear to view the Immortal Soul unclad,
  Prince of the Kurus! This was kept for thee alone! Be glad!'),
('edwin-arnold-et:gita.11.49','Sir Edwin Arnold','gita.11.49','en','translation','Let no more trouble shake thy heart, because thine eyes have seen
  My terror with My glory. As I before have been
  So will I be again for thee; with lightened heart behold!
  Once more I am thy Krishna, the form thou knew''st of old!'),
('edwin-arnold-et:gita.11.50','Sir Edwin Arnold','gita.11.50','en','translation','Sanjaya.
  These words to Arjuna spake
  Vasudev, and straight did take
  Back again the semblance dear
  Of the well-loved charioteer;
  Peace and joy it did restore
  When the Prince beheld once more
  Mighty BRAHMA''s form and face
  Clothed in Krishna''s gentle grace.'),
('edwin-arnold-et:gita.11.51','Sir Edwin Arnold','gita.11.51','en','translation','Arjuna.
  Now that I see come back, Janardana!
  This friendly human frame, my mind can think
  Calm thoughts once more; my heart beats still again!'),
('edwin-arnold-et:gita.11.52','Sir Edwin Arnold','gita.11.52','en','translation','Krishna.
  Yea! it was wonderful and terrible
  To view me as thou didst, dear Prince! The gods
  Dread and desire continually to view!'),
('edwin-arnold-et:gita.11.53','Sir Edwin Arnold','gita.11.53','en','translation','Yet not by Vedas, nor from sacrifice,
  Nor penance, nor gift-giving, nor with prayer
  Shall any so behold, as thou hast seen!'),
('edwin-arnold-et:gita.11.54','Sir Edwin Arnold','gita.11.54','en','translation','Only by fullest service, perfect faith,
  And uttermost surrender am I known
  And seen, and entered into, Indian Prince!'),
('edwin-arnold-et:gita.11.55','Sir Edwin Arnold','gita.11.55','en','translation','Who doeth all for Me; who findeth Me
  In all; adoreth always; loveth all
  Which I have made, and Me, for Love''s sole end
  That man, Arjuna! unto Me doth wend.'),
('edwin-arnold-et:gita.12.1','Sir Edwin Arnold','gita.12.1','en','translation','Arjuna.
  Lord! of the men who serve Thee--true in heart--
  As God revealed; and of the men who serve,
  Worshipping Thee Unrevealed, Unbodied, Far,
  Which take the better way of faith and life?'),
('edwin-arnold-et:gita.12.2','Sir Edwin Arnold','gita.12.2','en','translation','Krishna.
  Whoever serve Me--as I show Myself--
  Constantly true, in full devotion fixed,
  Those hold I very holy.'),
('edwin-arnold-et:gita.12.3','Sir Edwin Arnold','gita.12.3','en','translation','But who serve--
  Worshipping Me The One, The Invisible,
  The Unrevealed, Unnamed, Unthinkable,
  Uttermost, All-pervading, Highest, Sure--'),
('edwin-arnold-et:gita.12.4','Sir Edwin Arnold','gita.12.4','en','translation','Who thus adore Me, mastering their sense,
  Of one set mind to all, glad in all good,
  These blessed souls come unto Me.'),
('edwin-arnold-et:gita.12.5','Sir Edwin Arnold','gita.12.5','en','translation','Yet, hard
  The travail is for such as bend their minds
  To reach th'' Unmanifest That viewless path
  Shall scarce be trod by man bearing the flesh!'),
('edwin-arnold-et:gita.12.6','Sir Edwin Arnold','gita.12.6','en','translation','But whereso any doeth all his deeds
  Renouncing self for Me, full of Me, fixed
  To serve only the Highest, night and day
  Musing on Me--'),
('edwin-arnold-et:gita.12.7','Sir Edwin Arnold','gita.12.7','en','translation','him will I swiftly lift
  Forth from life''s ocean of distress and death,
  Whose soul clings fast to Me.'),
('edwin-arnold-et:gita.12.8','Sir Edwin Arnold','gita.12.8','en','translation','Cling thou to Me!
  Clasp Me with heart and mind! so shalt thou dwell
  Surely with Me on high.'),
('edwin-arnold-et:gita.12.9','Sir Edwin Arnold','gita.12.9','en','translation','But if thy thought
  Droops from such height; if thou be''st weak to set
  Body and soul upon Me constantly,
  Despair not! give Me lower service! seek
  To reach Me, worshipping with steadfast will;'),
('edwin-arnold-et:gita.12.10','Sir Edwin Arnold','gita.12.10','en','translation','And, if thou canst not worship steadfastly,
  Work for Me, toil in works pleasing to Me!
  For he that laboureth right for love of Me
  Shall finally attain!'),
('edwin-arnold-et:gita.12.11','Sir Edwin Arnold','gita.12.11','en','translation','But, if in this
  Thy faint heart fails, bring Me thy failure! find
  Refuge in Me! let fruits of labour go,
  Renouncing hope for Me, with lowliest heart,
  So shalt thou come;'),
('edwin-arnold-et:gita.12.12','Sir Edwin Arnold','gita.12.12','en','translation','for, though to know is more
  Than diligence, yet worship better is
  Than knowing, and renouncing better still.
  Near to renunciation--very near--
  Dwelleth Eternal Peace!'),
('edwin-arnold-et:gita.12.13','Sir Edwin Arnold','gita.12.13','en','translation','Who hateth nought
  Of all which lives, living himself benign,
  Compassionate, from arrogance exempt,
  Exempt from love of self, unchangeable
  By good or ill; patient,'),
('edwin-arnold-et:gita.12.14','Sir Edwin Arnold','gita.12.14','en','translation','contented, firm
  In faith, mastering himself, true to his word,
  Seeking Me, heart and soul; vowed unto Me,--
  That man I love!'),
('edwin-arnold-et:gita.12.15','Sir Edwin Arnold','gita.12.15','en','translation','Who troubleth not his kind,
  And is not troubled by them; clear of wrath,
  Living too high for gladness, grief, or fear,
  That man I love!'),
('edwin-arnold-et:gita.12.16','Sir Edwin Arnold','gita.12.16','en','translation','Who, dwelling quiet-eyed,[FN#25]
  Stainless, serene, well-balanced, unperplexed,
  Working with Me, yet from all works detached,
  That man I love!'),
('edwin-arnold-et:gita.12.17','Sir Edwin Arnold','gita.12.17','en','translation','Who, fixed in faith on Me,
  Dotes upon none, scorns none; rejoices not,
  And grieves not, letting good or evil hap
  Light when it will, and when it will depart,
  That man I love!'),
('edwin-arnold-et:gita.12.18','Sir Edwin Arnold','gita.12.18','en','translation','Who, unto friend and foe
  Keeping an equal heart, with equal mind
  Bears shame and glory; with an equal peace
  Takes heat and cold, pleasure and pain; abides
  Quit of desires,'),
('edwin-arnold-et:gita.12.19','Sir Edwin Arnold','gita.12.19','en','translation','hears praise or calumny
  In passionless restraint, unmoved by each;
  Linked by no ties to earth, steadfast in Me,
  That man I love!'),
('edwin-arnold-et:gita.12.20','Sir Edwin Arnold','gita.12.20','en','translation','But most of all I love
  Those happy ones to whom ''tis life to live
  In single fervid faith and love unseeing,
  Drinking the blessed Amrit of my Being!'),
('edwin-arnold-et:gita.13.1','Sir Edwin Arnold','gita.13.1','en','translation','Krishna.
  Yea! Son of Kunti! for this flesh ye see
  Is Kshetra, is the field where Life disports;
  And that which views and knows it is the Soul,
  Kshetrajna.'),
('edwin-arnold-et:gita.13.2','Sir Edwin Arnold','gita.13.2','en','translation','In all "fields," thou Indian prince!
  I am Kshetrajna. I am what surveys!
  Only that knowledge knows which knows the known
  By the knower![FN#27]'),
('edwin-arnold-et:gita.13.3','Sir Edwin Arnold','gita.13.3','en','translation','What it is, that "field" of life,
  What qualities it hath, and whence it is,
  And why it changeth, and the faculty
  That wotteth it, the mightiness of this,
  And how it wotteth-hear these things from Me!'),
('edwin-arnold-et:gita.13.5','Sir Edwin Arnold','gita.13.5','en','translation','The elements, the conscious life, the mind,
  The unseen vital force, the nine strange gates
  Of the body, and the five domains of sense;'),
('edwin-arnold-et:gita.13.6','Sir Edwin Arnold','gita.13.6','en','translation','Desire, dislike, pleasure and pain, and thought
  Deep-woven, and persistency of being;
  These all are wrought on Matter by the Soul!'),
('edwin-arnold-et:gita.13.7','Sir Edwin Arnold','gita.13.7','en','translation','Humbleness, truthfulness, and harmlessness,
  Patience and honour, reverence for the wise.
  Purity, constancy, control of self,'),
('edwin-arnold-et:gita.13.8','Sir Edwin Arnold','gita.13.8','en','translation','Contempt of sense-delights, self-sacrifice,
  Perception of the certitude of ill
  In birth, death, age, disease, suffering, and sin;'),
('edwin-arnold-et:gita.13.9','Sir Edwin Arnold','gita.13.9','en','translation','Detachment, lightly holding unto home,
  Children, and wife, and all that bindeth men;
  An ever-tranquil heart in fortunes good
  And fortunes evil,'),
('edwin-arnold-et:gita.13.10','Sir Edwin Arnold','gita.13.10','en','translation','with a will set firm
  To worship Me--Me only! ceasing not;
  Loving all solitudes, and shunning noise
  Of foolish crowds;'),
('edwin-arnold-et:gita.13.11','Sir Edwin Arnold','gita.13.11','en','translation','endeavours resolute
  To reach perception of the Utmost Soul,
  And grace to understand what gain it were
  So to attain,--this is true Wisdom, Prince!
  And what is otherwise is ignorance!'),
('edwin-arnold-et:gita.13.12','Sir Edwin Arnold','gita.13.12','en','translation','Now will I speak of knowledge best to know-
  That Truth which giveth man Amrit to drink,
  The Truth of HIM, the Para-Brahm, the All,
  The Uncreated;; not Asat, not Sat,
  Not Form, nor the Unformed; yet both, and more;--'),
('edwin-arnold-et:gita.13.13','Sir Edwin Arnold','gita.13.13','en','translation','Whose hands are everywhere, and everywhere
  Planted His feet, and everywhere His eyes
  Beholding, and His ears in every place
  Hearing, and all His faces everywhere
  Enlightening and encompassing His worlds.'),
('edwin-arnold-et:gita.13.14','Sir Edwin Arnold','gita.13.14','en','translation','Glorified in the senses He hath given,
  Yet beyond sense He is; sustaining all,
  Yet dwells He unattached: of forms and modes
  Master, yet neither form nor mode hath He;'),
('edwin-arnold-et:gita.13.15','Sir Edwin Arnold','gita.13.15','en','translation','He is within all beings--and without--
  Motionless, yet still moving; not discerned
  For subtlety of instant presence; close
  To all, to each; yet measurelessly far!'),
('edwin-arnold-et:gita.13.16','Sir Edwin Arnold','gita.13.16','en','translation','Not manifold, and yet subsisting still
  In all which lives; for ever to be known
  As the Sustainer, yet, at the End of Times,
  He maketh all to end--and re-creates.'),
('edwin-arnold-et:gita.13.17','Sir Edwin Arnold','gita.13.17','en','translation','The Light of Lights He is, in the heart of the Dark
  Shining eternally. Wisdom He is
  And Wisdom''s way, and Guide of all the wise,
  Planted in every heart.'),
('edwin-arnold-et:gita.13.18','Sir Edwin Arnold','gita.13.18','en','translation','So have I told
  Of Life''s stuff, and the moulding, and the lore
  To comprehend. Whoso, adoring Me,
  Perceiveth this, shall surely come to Me!'),
('edwin-arnold-et:gita.13.19','Sir Edwin Arnold','gita.13.19','en','translation','Know thou that Nature and the Spirit both
  Have no beginning! Know that qualities
  And changes of them are by Nature wrought;'),
('edwin-arnold-et:gita.13.20','Sir Edwin Arnold','gita.13.20','en','translation','That Nature puts to work the acting frame,
  But Spirit doth inform it, and so cause
  Feeling of pain and pleasure.'),
('edwin-arnold-et:gita.13.21','Sir Edwin Arnold','gita.13.21','en','translation','Spirit, linked
  To moulded matter, entereth into bond
  With qualities by Nature framed, and, thus
  Married to matter, breeds the birth again
  In good or evil yonis.[FN#29]'),
('edwin-arnold-et:gita.13.22','Sir Edwin Arnold','gita.13.22','en','translation','Yet is this
  Yea! in its bodily prison!--Spirit pure,
  Spirit supreme; surveying, governing,
  Guarding, possessing; Lord and Master still
  PURUSHA, Ultimate, One Soul with Me.'),
('edwin-arnold-et:gita.13.23','Sir Edwin Arnold','gita.13.23','en','translation','Whoso thus knows himself, and knows his soul
  PURUSHA, working through the qualities
  With Nature''s modes, the light hath come for him!
  Whatever flesh he bears, never again
  Shall he take on its load.'),
('edwin-arnold-et:gita.13.24','Sir Edwin Arnold','gita.13.24','en','translation','Some few there be
  By meditation find the Soul in Self
  Self-schooled; and some by long philosophy
  And holy life reach thither; some by works:'),
('edwin-arnold-et:gita.13.25','Sir Edwin Arnold','gita.13.25','en','translation','Some, never so attaining, hear of light
  From other lips, and seize, and cleave to it
  Worshipping; yea! and those--to teaching true--
  Overpass Death!'),
('edwin-arnold-et:gita.13.26','Sir Edwin Arnold','gita.13.26','en','translation','Wherever, Indian Prince!
  Life is--of moving things, or things unmoved,
  Plant or still seed--know, what is there hath grown
  By bond of Matter and of Spirit:'),
('edwin-arnold-et:gita.13.27','Sir Edwin Arnold','gita.13.27','en','translation','Know
  He sees indeed who sees in all alike
  The living, lordly Soul; the Soul Supreme,
  Imperishable amid the Perishing:'),
('edwin-arnold-et:gita.13.28','Sir Edwin Arnold','gita.13.28','en','translation','For, whoso thus beholds, in every place,
  In every form, the same, one, Living Life,
  Doth no more wrongfulness unto himself,
  But goes the highest road which brings to bliss.'),
('edwin-arnold-et:gita.13.29','Sir Edwin Arnold','gita.13.29','en','translation','Seeing, he sees, indeed, who sees that works
  Are Nature''s wont, for Soul to practise by
  Acting, yet not the agent;'),
('edwin-arnold-et:gita.13.30','Sir Edwin Arnold','gita.13.30','en','translation','sees the mass
  Of separate living things--each of its kind--
  Issue from One, and blend again to One:
  Then hath he BRAHMA, he attains!'),
('edwin-arnold-et:gita.13.31','Sir Edwin Arnold','gita.13.31','en','translation','O Prince!
  That Ultimate, High Spirit, Uncreate,
  Unqualified, even when it entereth flesh
  Taketh no stain of acts, worketh in nought!'),
('edwin-arnold-et:gita.13.32','Sir Edwin Arnold','gita.13.32','en','translation','Like to the ethereal air, pervading all,
  Which, for sheer subtlety, avoideth taint,
  The subtle Soul sits everywhere, unstained:'),
('edwin-arnold-et:gita.13.33','Sir Edwin Arnold','gita.13.33','en','translation','Like to the light of the all-piercing sun
  [Which is not changed by aught it shines upon,]
  The Soul''s light shineth pure in every place;'),
('edwin-arnold-et:gita.13.34','Sir Edwin Arnold','gita.13.34','en','translation','And they who, by such eye of wisdom, see
  How Matter, and what deals with it, divide;
  And how the Spirit and the flesh have strife,
  Those wise ones go the way which leads to Life!'),
('edwin-arnold-et:gita.14.1','Sir Edwin Arnold','gita.14.1','en','translation','Krishna.
  Yet farther will I open unto thee
  This wisdom of all wisdoms, uttermost,
  The which possessing, all My saints have passed
  To perfectness.'),
('edwin-arnold-et:gita.14.2','Sir Edwin Arnold','gita.14.2','en','translation','On such high verities
  Reliant, rising into fellowship
  With Me, they are not born again at birth
  Of Kalpas, nor at Pralyas suffer change!'),
('edwin-arnold-et:gita.14.3','Sir Edwin Arnold','gita.14.3','en','translation','This Universe the womb is where I plant
  Seed of all lives! Thence, Prince of India, comes
  Birth to all beings!'),
('edwin-arnold-et:gita.14.4','Sir Edwin Arnold','gita.14.4','en','translation','Whoso, Kunti''s Son!
  Mothers each mortal form, Brahma conceives,
  And I am He that fathers, sending seed!'),
('edwin-arnold-et:gita.14.5','Sir Edwin Arnold','gita.14.5','en','translation','Sattwan, Rajas, and Tamas, so are named
  The qualities of Nature, "Soothfastness,"
  "Passion," and "Ignorance." These three bind down
  The changeless Spirit in the changeful flesh.'),
('edwin-arnold-et:gita.14.6','Sir Edwin Arnold','gita.14.6','en','translation','Whereof sweet "Soothfastness," by purity
  Living unsullied and enlightened, binds
  The sinless Soul to happiness and truth;'),
('edwin-arnold-et:gita.14.7','Sir Edwin Arnold','gita.14.7','en','translation','And Passion, being kin to appetite,
  And breeding impulse and propensity,
  Binds the embodied Soul, O Kunti''s Son!
  By tie of works.'),
('edwin-arnold-et:gita.14.8','Sir Edwin Arnold','gita.14.8','en','translation','But Ignorance, begot
  Of Darkness, blinding mortal men, binds down
  Their souls to stupor, sloth, and drowsiness.'),
('edwin-arnold-et:gita.14.9','Sir Edwin Arnold','gita.14.9','en','translation','Yea, Prince of India! Soothfastness binds souls
  In pleasant wise to flesh; and Passion binds
  By toilsome strain; but Ignorance, which blots
  The beams of wisdom, binds the soul to sloth.'),
('edwin-arnold-et:gita.14.10','Sir Edwin Arnold','gita.14.10','en','translation','Passion and Ignorance, once overcome,
  Leave Soothfastness, O Bharata! Where this
  With Ignorance are absent, Passion rules;
  And Ignorance in hearts not good nor quick.'),
('edwin-arnold-et:gita.14.11','Sir Edwin Arnold','gita.14.11','en','translation','When at all gateways of the Body shines
  The Lamp of Knowledge, then may one see well
  Soothfastness settled in that city reigns;'),
('edwin-arnold-et:gita.14.12','Sir Edwin Arnold','gita.14.12','en','translation','Where longing is, and ardour, and unrest,
  Impulse to strive and gain, and avarice,
  Those spring from Passion--Prince!--engrained;'),
('edwin-arnold-et:gita.14.13','Sir Edwin Arnold','gita.14.13','en','translation','and where
  Darkness and dulness, sloth and stupor are,
  ''Tis Ignorance hath caused them, Kuru Chief!'),
('edwin-arnold-et:gita.14.14','Sir Edwin Arnold','gita.14.14','en','translation','Moreover, when a soul departeth, fixed
  In Soothfastness, it goeth to the place--
  Perfect and pure--of those that know all Truth.'),
('edwin-arnold-et:gita.14.15','Sir Edwin Arnold','gita.14.15','en','translation','If it departeth in set habitude
  Of Impulse, it shall pass into the world
  Of spirits tied to works; and, if it dies
  In hardened Ignorance, that blinded soul
  Is born anew in some unlighted womb.'),
('edwin-arnold-et:gita.14.16','Sir Edwin Arnold','gita.14.16','en','translation','The fruit of Soothfastness is true and sweet;
  The fruit of lusts is pain and toil; the fruit
  Of Ignorance is deeper darkness. Yea!'),
('edwin-arnold-et:gita.14.17','Sir Edwin Arnold','gita.14.17','en','translation','For Light brings light, and Passion ache to have;
  And gloom, bewilderments, and ignorance
  Grow forth from Ignorance.'),
('edwin-arnold-et:gita.14.18','Sir Edwin Arnold','gita.14.18','en','translation','Those of the first
  Rise ever higher; those of the second mode
  Take a mid place; the darkened souls sink back
  To lower deeps, loaded with witlessness!'),
('edwin-arnold-et:gita.14.19','Sir Edwin Arnold','gita.14.19','en','translation','When, watching life, the living man perceives
  The only actors are the Qualities,
  And knows what rules beyond the Qualities,
  Then is he come nigh unto Me!'),
('edwin-arnold-et:gita.14.20','Sir Edwin Arnold','gita.14.20','en','translation','The Soul,
  Thus passing forth from the Three Qualities--
  Whereby arise all bodies--overcomes
  Birth, Death, Sorrow, and Age; and drinketh deep
  The undying wine of Amrit.'),
('edwin-arnold-et:gita.14.21','Sir Edwin Arnold','gita.14.21','en','translation','Arjuna.
  Oh, my Lord!
  Which be the signs to know him that hath gone
  Past the Three Modes? How liveth he? What way
  Leadeth him safe beyond the threefold Modes?'),
('edwin-arnold-et:gita.14.22','Sir Edwin Arnold','gita.14.22','en','translation','Krishna.
  He who with equanimity surveys
  Lustre of goodness, strife of passion, sloth
  Of ignorance, not angry if they are,
  Not wishful when they are not:'),
('edwin-arnold-et:gita.14.23','Sir Edwin Arnold','gita.14.23','en','translation','he who sits
  A sojourner and stranger in their midst
  Unruffled, standing off, saying--serene--
  When troubles break, "These be the Qualities!"'),
('edwin-arnold-et:gita.14.24','Sir Edwin Arnold','gita.14.24','en','translation','He unto whom--self-centred--grief and joy
  Sound as one word; to whose deep-seeing eyes
  The clod, the marble, and the gold are one;
  Whose equal heart holds the same gentleness
  For lovely and unlovely things, firm-set,
  Well-pleased in praise and dispraise;'),
('edwin-arnold-et:gita.14.25','Sir Edwin Arnold','gita.14.25','en','translation','satisfied
  With honour or dishonour; unto friends
  And unto foes alike in tolerance;
  Detached from undertakings,--he is named
  Surmounter of the Qualities!'),
('edwin-arnold-et:gita.14.26','Sir Edwin Arnold','gita.14.26','en','translation','And such--
  With single, fervent faith adoring Me,
  Passing beyond the Qualities, conforms
  To Brahma, and attains Me!'),
('edwin-arnold-et:gita.14.27','Sir Edwin Arnold','gita.14.27','en','translation','For I am
  That whereof Brahma is the likeness! Mine
  The Amrit is; and Immortality
  Is mine; and mine perfect Felicity!'),
('edwin-arnold-et:gita.15.1','Sir Edwin Arnold','gita.15.1','en','translation','Krishna.
  Men call the Aswattha,--the Banyan-tree,--
  Which hath its boughs beneath, its roots above,--
  The ever-holy tree. Yea! for its leaves
  Are green and waving hymns which whisper Truth!
  Who knows the Aswattha, knows Veds, and all.'),
('edwin-arnold-et:gita.15.2','Sir Edwin Arnold','gita.15.2','en','translation','Its branches shoot to heaven and sink to earth,[FN#30]
  Even as the deeds of men, which take their birth
    From qualities: its silver sprays and blooms,
  And all the eager verdure of its girth,
  Leap to quick life at kiss of sun and air,
  As men''s lives quicken to the temptings fair
    Of wooing sense: its hanging rootlets seek
  The soil beneath, helping to hold it there,

  As actions wrought amid this world of men
  Bind them by ever-tightening bonds again.'),
('edwin-arnold-et:gita.15.3','Sir Edwin Arnold','gita.15.3','en','translation','If ye knew well the teaching of the Tree,
  What its shape saith; and whence it springs; and, then

  How it must end, and all the ills of it,
  The axe of sharp Detachment ye would whet,
    And cleave the clinging snaky roots, and lay
  This Aswattha of sense-life low,--to set'),
('edwin-arnold-et:gita.15.4','Sir Edwin Arnold','gita.15.4','en','translation','New growths upspringing to that happier sky,--
  Which they who reach shall have no day to die,
    Nor fade away, nor fall--to Him, I mean,
  FATHER and FIRST, Who made the mystery

  Of old Creation;'),
('edwin-arnold-et:gita.15.5','Sir Edwin Arnold','gita.15.5','en','translation','for to Him come they
  From passion and from dreams who break away;
    Who part the bonds constraining them to flesh,
  And,--Him, the Highest, worshipping alway--

  No longer grow at mercy of what breeze
  Of summer pleasure stirs the sleeping trees,
    What blast of tempest tears them, bough and stem
  To the eternal world pass such as these!'),
('edwin-arnold-et:gita.15.6','Sir Edwin Arnold','gita.15.6','en','translation','Another Sun gleams there! another Moon!
  Another Light,--not Dusk, nor Dawn, nor Noon--
    Which they who once behold return no more;
  They have attained My rest, life''s Utmost boon!'),
('edwin-arnold-et:gita.15.7','Sir Edwin Arnold','gita.15.7','en','translation','When, in this world of manifested life,
  The undying Spirit, setting forth from Me,
  Taketh on form, it draweth to itself
  From Being''s storehouse,--which containeth all,--
  Senses and intellect.'),
('edwin-arnold-et:gita.15.8','Sir Edwin Arnold','gita.15.8','en','translation','The Sovereign Soul
  Thus entering the flesh, or quitting it,
  Gathers these up, as the wind gathers scents,
  Blowing above the flower-beds.'),
('edwin-arnold-et:gita.15.9','Sir Edwin Arnold','gita.15.9','en','translation','Ear and Eye,
  And Touch and Taste, and Smelling, these it takes,--
  Yea, and a sentient mind;--linking itself
  To sense-things so.'),
('edwin-arnold-et:gita.15.10','Sir Edwin Arnold','gita.15.10','en','translation','The unenlightened ones
  Mark not that Spirit when he goes or comes,
  Nor when he takes his pleasure in the form,
  Conjoined with qualities; but those see plain
  Who have the eyes to see.'),
('edwin-arnold-et:gita.15.11','Sir Edwin Arnold','gita.15.11','en','translation','Holy souls see
  Which strive thereto. Enlightened, they perceive
  That Spirit in themselves; but foolish ones,
  Even though they strive, discern not, having hearts
  Unkindled, ill-informed!'),
('edwin-arnold-et:gita.15.12','Sir Edwin Arnold','gita.15.12','en','translation','Know, too, from Me
  Shineth the gathered glory of the suns
  Which lighten all the world: from Me the moons
  Draw silvery beams, and fire fierce loveliness.'),
('edwin-arnold-et:gita.15.13','Sir Edwin Arnold','gita.15.13','en','translation','I penetrate the clay, and lend all shapes
  Their living force; I glide into the plant--
  Root, leaf, and bloom--to make the woodlands green
  With springing sap.'),
('edwin-arnold-et:gita.15.14','Sir Edwin Arnold','gita.15.14','en','translation','Becoming vital warmth,
  I glow in glad, respiring frames, and pass,
  With outward and with inward breath, to feed
  The body by all meats.[FN#31]');
--> statement-breakpoint
INSERT INTO commentary_fts (unit_id,author,canonical_ref,language,content_type,content) VALUES
('edwin-arnold-et:gita.15.16','Sir Edwin Arnold','gita.15.16','en','translation','For in this world
  Being is twofold: the Divided, one;
  The Undivided, one. All things that live
  Are "the Divided." That which sits apart,
  "The Undivided."'),
('edwin-arnold-et:gita.15.17','Sir Edwin Arnold','gita.15.17','en','translation','Higher still is He,
  The Highest, holding all, whose Name is LORD,
  The Eternal, Sovereign, First! Who fills all worlds,
  Sustaining them.'),
('edwin-arnold-et:gita.15.18','Sir Edwin Arnold','gita.15.18','en','translation','And--dwelling thus beyond
  Divided Being and Undivided--I
  Am called of men and Vedas, Life Supreme,
  The PURUSHOTTAMA.'),
('edwin-arnold-et:gita.15.19','Sir Edwin Arnold','gita.15.19','en','translation','Who knows Me thus,
  With mind unclouded, knoweth all, dear Prince!
  And with his whole soul ever worshippeth Me.'),
('edwin-arnold-et:gita.15.20','Sir Edwin Arnold','gita.15.20','en','translation','Now is the sacred, secret Mystery
  Declared to thee! Who comprehendeth this
  Hath wisdom! He is quit of works in bliss!'),
('edwin-arnold-et:gita.16.1','Sir Edwin Arnold','gita.16.1','en','translation','Krishna.
  Fearlessness, singleness of soul, the will
  Always to strive for wisdom; opened hand
  And governed appetites; and piety,
  And love of lonely study; humbleness,
  Uprightness,'),
('edwin-arnold-et:gita.16.2','Sir Edwin Arnold','gita.16.2','en','translation','heed to injure nought which lives,
  Truthfulness, slowness unto wrath, a mind
  That lightly letteth go what others prize;
  And equanimity, and charity
  Which spieth no man''s faults; and tenderness
  Towards all that suffer; a contented heart,
  Fluttered by no desires; a bearing mild,
  Modest, and grave,'),
('edwin-arnold-et:gita.16.3','Sir Edwin Arnold','gita.16.3','en','translation','with manhood nobly mixed,
  With patience, fortitude, and purity;
  An unrevengeful spirit, never given
  To rate itself too high;--such be the signs,
  O Indian Prince! of him whose feet are set
  On that fair path which leads to heavenly birth!'),
('edwin-arnold-et:gita.16.4','Sir Edwin Arnold','gita.16.4','en','translation','Deceitfulness, and arrogance, and pride,
  Quickness to anger, harsh and evil speech,
  And ignorance, to its own darkness blind,--
  These be the signs, My Prince! of him whose birth
  Is fated for the regions of the vile.[FN#32]'),
('edwin-arnold-et:gita.16.5','Sir Edwin Arnold','gita.16.5','en','translation','The Heavenly Birth brings to deliverance,
  So should''st thou know! The birth with Asuras
  Brings into bondage. Be thou joyous, Prince!
  Whose lot is set apart for heavenly Birth.'),
('edwin-arnold-et:gita.16.6','Sir Edwin Arnold','gita.16.6','en','translation','Two stamps there are marked on all living men,
  Divine and Undivine; I spake to thee
  By what marks thou shouldst know the Heavenly Man,
  Hear from me now of the Unheavenly!'),
('edwin-arnold-et:gita.16.7','Sir Edwin Arnold','gita.16.7','en','translation','They comprehend not, the Unheavenly,
  How Souls go forth from Me; nor how they come
  Back unto Me: nor is there Truth in these,
  Nor purity, nor rule of Life.'),
('edwin-arnold-et:gita.16.8','Sir Edwin Arnold','gita.16.8','en','translation','"This world
  Hath not a Law, nor Order, nor a Lord,"
  So say they: "nor hath risen up by Cause
  Following on Cause, in perfect purposing,
  But is none other than a House of Lust."'),
('edwin-arnold-et:gita.16.9','Sir Edwin Arnold','gita.16.9','en','translation','And, this thing thinking, all those ruined ones--
  Of little wit, dark-minded--give themselves
  To evil deeds, the curses of their kind.'),
('edwin-arnold-et:gita.16.10','Sir Edwin Arnold','gita.16.10','en','translation','Surrendered to desires insatiable,
  Full of deceitfulness, folly, and pride,
  In blindness cleaving to their errors, caught
  Into the sinful course,'),
('edwin-arnold-et:gita.16.11','Sir Edwin Arnold','gita.16.11','en','translation','they trust this lie
  As it were true--this lie which leads to death--
  Finding in Pleasure all the good which is,
  And crying "Here it finisheth!"'),
('edwin-arnold-et:gita.16.12','Sir Edwin Arnold','gita.16.12','en','translation','Ensnared
  In nooses of a hundred idle hopes,
  Slaves to their passion and their wrath, they buy
  Wealth with base deeds, to glut hot appetites;'),
('edwin-arnold-et:gita.16.13','Sir Edwin Arnold','gita.16.13','en','translation','"Thus much, to-day," they say, "we gained! thereby
  Such and such wish of heart shall have its fill;
  And this is ours! and th'' other shall be ours!'),
('edwin-arnold-et:gita.16.14','Sir Edwin Arnold','gita.16.14','en','translation','To-day we slew a foe, and we will slay
  Our other enemy to-morrow! Look!
  Are we not lords? Make we not goodly cheer?
  Is not our fortune famous, brave, and great?'),
('edwin-arnold-et:gita.16.15','Sir Edwin Arnold','gita.16.15','en','translation','Rich are we, proudly born! What other men
  Live like to us? Kill, then, for sacrifice!
  Cast largesse, and be merry!" So they speak
  Darkened by ignorance;'),
('edwin-arnold-et:gita.16.16','Sir Edwin Arnold','gita.16.16','en','translation','and so they fall--
  Tossed to and fro with projects, tricked, and bound
  In net of black delusion, lost in lusts--
  Down to foul Naraka.'),
('edwin-arnold-et:gita.16.17','Sir Edwin Arnold','gita.16.17','en','translation','Conceited, fond,
  Stubborn and proud, dead-drunken with the wine
  Of wealth, and reckless, all their offerings
  Have but a show of reverence, being not made
  In piety of ancient faith.'),
('edwin-arnold-et:gita.16.18','Sir Edwin Arnold','gita.16.18','en','translation','Thus vowed
  To self-hood, force, insolence, feasting, wrath,
  These My blasphemers, in the forms they wear
  And in the forms they breed, my foemen are,'),
('edwin-arnold-et:gita.16.19','Sir Edwin Arnold','gita.16.19','en','translation','Hateful and hating; cruel, evil, vile,
  Lowest and least of men, whom I cast down
  Again, and yet again, at end of lives,
  Into some devilish womb,'),
('edwin-arnold-et:gita.16.20','Sir Edwin Arnold','gita.16.20','en','translation','whence--birth by birth--
  The devilish wombs re-spawn them, all beguiled;
  And, till they find and worship Me, sweet Prince!
  Tread they that Nether Road.'),
('edwin-arnold-et:gita.16.21','Sir Edwin Arnold','gita.16.21','en','translation','The Doors of Hell
  Are threefold, whereby men to ruin pass,--
  The door of Lust, the door of Wrath, the door
  Of Avarice. Let a man shun those three!'),
('edwin-arnold-et:gita.16.22','Sir Edwin Arnold','gita.16.22','en','translation','He who shall turn aside from entering
  All those three gates of Narak, wendeth straight
  To find his peace, and comes to Swarga''s gate.'),
('edwin-arnold-et:gita.17.1','Sir Edwin Arnold','gita.17.1','en','translation','Arjuna.
  If men forsake the holy ordinance,
  Heedless of Shastras, yet keep faith at heart
  And worship, what shall be the state of those,
  Great Krishna! Sattwan, Rajas, Tamas? Say!'),
('edwin-arnold-et:gita.17.2','Sir Edwin Arnold','gita.17.2','en','translation','Krishna.
  Threefold the faith is of mankind and springs
  From those three qualities,--becoming "true,"
  Or "passion-stained," or "dark," as thou shalt hear!'),
('edwin-arnold-et:gita.17.3','Sir Edwin Arnold','gita.17.3','en','translation','The faith of each believer, Indian Prince!
  Conforms itself to what he truly is.
  Where thou shalt see a worshipper, that one
  To what he worships lives  assimilate,
  [Such as the shrine, so is the votary,]'),
('edwin-arnold-et:gita.17.4','Sir Edwin Arnold','gita.17.4','en','translation','The "soothfast" souls adore true gods; the souls
  Obeying Rajas worship Rakshasas[FN#34]
  Or Yakshas; and the men of Darkness pray
  To Pretas and to Bhutas.[FN#35]'),
('edwin-arnold-et:gita.17.5','Sir Edwin Arnold','gita.17.5','en','translation','Yea, and those
  Who  practise bitter penance, not enjoined
  By rightful rule--penance which hath its root
  In self-sufficient, proud hypocrisies--
  Those men, passion-beset, violent, wild,'),
('edwin-arnold-et:gita.17.6','Sir Edwin Arnold','gita.17.6','en','translation','Torturing--the witless ones--My elements
  Shut in fair company within their flesh,
  (Nay, Me myself, present within the flesh!)
  Know them to devils devoted, not to Heaven!'),
('edwin-arnold-et:gita.17.7','Sir Edwin Arnold','gita.17.7','en','translation','For like as foods are threefold for mankind
  In nourishing, so is there threefold way
  Of worship, abstinence, and almsgiving!
  Hear this of Me!'),
('edwin-arnold-et:gita.17.8','Sir Edwin Arnold','gita.17.8','en','translation','there is a food which brings
  Force, substance, strength, and health, and joy to live,
  Being well-seasoned, cordial, comforting,
  The "Soothfast" meat.'),
('edwin-arnold-et:gita.17.9','Sir Edwin Arnold','gita.17.9','en','translation','And there be foods which bring
  Aches and unrests, and burning blood, and grief,
  Being too biting, heating, salt, and sharp,
  And therefore craved by too strong appetite.'),
('edwin-arnold-et:gita.17.10','Sir Edwin Arnold','gita.17.10','en','translation','And there is foul food--kept from over-night,[FN#36]
  Savourless, filthy, which the foul will eat,
  A feast of rottenness, meet for the lips
  Of such as love the "Darkness."'),
('edwin-arnold-et:gita.17.11','Sir Edwin Arnold','gita.17.11','en','translation','Thus with rites;--
  A sacrifice not for rewardment made,
  Offered in rightful wise, when he who vows
  Sayeth, with heart devout, "This I should do!"
  Is "Soothfast" rite.'),
('edwin-arnold-et:gita.17.12','Sir Edwin Arnold','gita.17.12','en','translation','But sacrifice for gain,
  Offered for good repute, be sure that this,
  O Best of Bharatas! is Rajas-rite,
  With stamp of "passion."'),
('edwin-arnold-et:gita.17.13','Sir Edwin Arnold','gita.17.13','en','translation','And a sacrifice
  Offered against the laws, with no due dole
  Of food-giving, with no accompaniment
  Of hallowed hymn, nor largesse to the priests,
  In faithless celebration, call it vile,
  The deed of "Darkness!"--lost!'),
('edwin-arnold-et:gita.17.14','Sir Edwin Arnold','gita.17.14','en','translation','Worship of gods
  Meriting worship; lowly reverence
  Of Twice-borns, Teachers, Elders; Purity,
  Rectitude, and the Brahmacharya''s vow,
  And not to injure any helpless thing,--
  These make a true religiousness of Act.'),
('edwin-arnold-et:gita.17.15','Sir Edwin Arnold','gita.17.15','en','translation','Words causing no man woe, words ever true,
  Gentle and pleasing words, and those ye say
  In murmured reading of a Sacred Writ,--
  These make the true religiousness of Speech.'),
('edwin-arnold-et:gita.17.16','Sir Edwin Arnold','gita.17.16','en','translation','Serenity of soul, benignity,
  Sway of the silent Spirit, constant stress
  To sanctify the Nature,--these things make
  Good rite, and true religiousness of Mind.'),
('edwin-arnold-et:gita.17.17','Sir Edwin Arnold','gita.17.17','en','translation','Such threefold faith, in highest piety
  Kept, with no hope of gain, by hearts devote,
  Is perfect work of Sattwan, true belief.'),
('edwin-arnold-et:gita.17.18','Sir Edwin Arnold','gita.17.18','en','translation','Religion shown in act of proud display
  To win good entertainment, worship, fame,
  Such--say I--is of Rajas, rash and vain.'),
('edwin-arnold-et:gita.17.19','Sir Edwin Arnold','gita.17.19','en','translation','Religion followed by a witless will
  To torture self, or come at power to hurt
  Another,--''tis of Tamas, dark and ill.'),
('edwin-arnold-et:gita.17.20','Sir Edwin Arnold','gita.17.20','en','translation','The gift lovingly given, when one shall say
  "Now must I gladly give!" when he who takes
  Can render nothing back; made in due place,
  Due time, and to a meet recipient,
  Is gift of Sattwan, fair and profitable.'),
('edwin-arnold-et:gita.17.21','Sir Edwin Arnold','gita.17.21','en','translation','The gift selfishly given, where to receive
  Is hoped again, or when some end is sought,
  Or where the gift is proffered with a grudge,
  This is of Rajas, stained with impulse, ill.'),
('edwin-arnold-et:gita.17.22','Sir Edwin Arnold','gita.17.22','en','translation','The gift churlishly flung, at evil time,
  In wrongful place, to base recipient,
  Made in disdain or harsh unkindliness,
  Is gift of Tamas, dark; it doth not bless![FN#37]'),
('edwin-arnold-et:gita.18.1','Sir Edwin Arnold','gita.18.1','en','translation','Arjuna.
  Fain would I better know, Thou Glorious One!
  The very truth--Heart''s Lord!--of Sannyas,
  Abstention; and  enunciation, Lord!
  Tyaga; and what separates these twain!'),
('edwin-arnold-et:gita.18.2','Sir Edwin Arnold','gita.18.2','en','translation','Krishna.
  The poets rightly teach that Sannyas
  Is the foregoing of all acts which spring
  Out of desire; and their wisest say
  Tyaga is renouncing fruit of acts.'),
('edwin-arnold-et:gita.18.3','Sir Edwin Arnold','gita.18.3','en','translation','There be among the saints some who have held
  All action sinful, and to be renounced;
  And some who answer, "Nay! the goodly acts--
  As worship, penance, alms--must be performed!"'),
('edwin-arnold-et:gita.18.4','Sir Edwin Arnold','gita.18.4','en','translation','Hear now My sentence, Best of Bharatas!

  ''Tis well set forth, O Chaser of thy Foes!
  Renunciation is of threefold form,'),
('edwin-arnold-et:gita.18.5','Sir Edwin Arnold','gita.18.5','en','translation','And Worship, Penance, Alms, not to be stayed;
  Nay, to be gladly done; for all those three
  Are purifying waters for true souls!'),
('edwin-arnold-et:gita.18.6','Sir Edwin Arnold','gita.18.6','en','translation','Yet must be practised even those high works
  In yielding up attachment, and all fruit
  Produced by works. This is My judgment, Prince!
  This My insuperable and fixed decree!'),
('edwin-arnold-et:gita.18.7','Sir Edwin Arnold','gita.18.7','en','translation','Abstaining from a work by right prescribed
  Never is meet! So to abstain doth spring
  From "Darkness," and Delusion teacheth it.'),
('edwin-arnold-et:gita.18.8','Sir Edwin Arnold','gita.18.8','en','translation','Abstaining from a work grievous to flesh,
  When one saith "''Tis unpleasing!" this is null!
  Such an one acts from "passion;" nought of gain
  Wins his Renunciation!'),
('edwin-arnold-et:gita.18.9','Sir Edwin Arnold','gita.18.9','en','translation','But, Arjun!
  Abstaining from attachment to the work,
  Abstaining from rewardment in the work,
  While yet one doeth it full faithfully,
  Saying, "Tis right to do!" that is "true " act
  And abstinence!'),
('edwin-arnold-et:gita.18.10','Sir Edwin Arnold','gita.18.10','en','translation','Who doeth duties so,
  Unvexed if his work fail, if it succeed
  Unflattered, in his own heart justified,
  Quit of debates and doubts, his is "true" act:'),
('edwin-arnold-et:gita.18.11','Sir Edwin Arnold','gita.18.11','en','translation','For, being in the body, none may stand
  Wholly aloof from act; yet, who abstains
  From profit of his acts is abstinent.'),
('edwin-arnold-et:gita.18.12','Sir Edwin Arnold','gita.18.12','en','translation','The fruit of labours, in the lives to come,
  Is threefold for all men,--Desirable,
  And Undesirable, and mixed of both;
  But no fruit is at all where no work was.'),
('edwin-arnold-et:gita.18.13','Sir Edwin Arnold','gita.18.13','en','translation','Hear from me, Long-armed Lord! the makings five
  Which go to every act, in Sankhya taught
  As necessary.'),
('edwin-arnold-et:gita.18.14','Sir Edwin Arnold','gita.18.14','en','translation','First the force; and then
  The agent; next, the various instruments;
  Fourth, the especial effort; fifth, the God.'),
('edwin-arnold-et:gita.18.15','Sir Edwin Arnold','gita.18.15','en','translation','What work soever any mortal doth
  Of body, mind, or speech, evil or good,
  By these five doth he that.'),
('edwin-arnold-et:gita.18.16','Sir Edwin Arnold','gita.18.16','en','translation','Which being thus,
  Whoso, for lack of knowledge, seeth himself
  As the sole actor, knoweth nought at all
  And seeth nought.'),
('edwin-arnold-et:gita.18.17','Sir Edwin Arnold','gita.18.17','en','translation','Therefore, I say, if one--
  Holding aloof from self--with unstained mind
  Should slay all yonder host, being bid to slay,
  He doth not slay; he is not bound thereby!'),
('edwin-arnold-et:gita.18.18','Sir Edwin Arnold','gita.18.18','en','translation','Knowledge, the thing known, and the mind which knows,
  These make the threefold starting-ground of act.
  The act, the actor, and the instrument,
  These make the threefold total of the deed.'),
('edwin-arnold-et:gita.18.19','Sir Edwin Arnold','gita.18.19','en','translation','But knowledge, agent, act, are differenced
  By three dividing qualities. Hear now
  Which be the qualities dividing them.'),
('edwin-arnold-et:gita.18.20','Sir Edwin Arnold','gita.18.20','en','translation','There is "true" Knowledge. Learn thou it is this:
  To see one changeless Life in all the Lives,
  And in the Separate, One Inseparable.'),
('edwin-arnold-et:gita.18.21','Sir Edwin Arnold','gita.18.21','en','translation','There is imperfect Knowledge: that which sees
  The separate existences apart,
  And, being separated, holds them real.'),
('edwin-arnold-et:gita.18.22','Sir Edwin Arnold','gita.18.22','en','translation','There is false Knowledge: that which blindly clings
  To one as if ''twere all, seeking no Cause,
  Deprived of light, narrow, and dull, and "dark."'),
('edwin-arnold-et:gita.18.23','Sir Edwin Arnold','gita.18.23','en','translation','There is "right" Action: that which being enjoined--
  Is wrought without attachment, passionlessly,
  For duty, not for love, nor hate, nor gain.'),
('edwin-arnold-et:gita.18.24','Sir Edwin Arnold','gita.18.24','en','translation','There is "vain" Action: that which men pursue
  Aching to satisfy desires, impelled
  By sense of self, with all-absorbing stress:
  This is of Rajas--passionate and vain.'),
('edwin-arnold-et:gita.18.25','Sir Edwin Arnold','gita.18.25','en','translation','There is "dark" Action: when one doth a thing
  Heedless of issues, heedless of the hurt
  Or wrong for others, heedless if he harm
  His own soul--''tis of Tamas, black and bad!'),
('edwin-arnold-et:gita.18.26','Sir Edwin Arnold','gita.18.26','en','translation','There is the "rightful"doer. He who acts
  Free from self-seeking, humble, resolute,
  Steadfast, in good or evil hap the same,
  Content to do aright-he "truly" acts.'),
('edwin-arnold-et:gita.18.27','Sir Edwin Arnold','gita.18.27','en','translation','There is th'' "impassioned" doer. He that works
  From impulse, seeking profit, rude and bold
  To overcome, unchastened; slave by turns
  Of sorrow and of joy: of Rajas he!'),
('edwin-arnold-et:gita.18.28','Sir Edwin Arnold','gita.18.28','en','translation','And there be evil doers; loose of heart,
  Low-minded, stubborn, fraudulent, remiss,
  Dull, slow, despondent--children of the "dark."'),
('edwin-arnold-et:gita.18.29','Sir Edwin Arnold','gita.18.29','en','translation','Hear, too, of Intellect and Steadfastness
  The threefold separation, Conqueror-Prince!
  How these are set apart by Qualities.'),
('edwin-arnold-et:gita.18.30','Sir Edwin Arnold','gita.18.30','en','translation','Good is the Intellect which comprehends
  The coming forth and going back of life,
  What must be done, and what must not be done,
  What should be feared, and what should not be feared,
  What binds and what emancipates the soul:
  That is of Sattwan, Prince! of "soothfastness."'),
('edwin-arnold-et:gita.18.31','Sir Edwin Arnold','gita.18.31','en','translation','Marred is the Intellect which, knowing right
  And knowing wrong, and what is well to do
  And what must not be done, yet understands
  Nought with firm mind, nor as the calm truth is:
  This is of Rajas, Prince! and "passionate!"'),
('edwin-arnold-et:gita.18.32','Sir Edwin Arnold','gita.18.32','en','translation','Evil is Intellect which, wrapped in gloom,
  Looks upon wrong as right, and sees all things
  Contrariwise of Truth. O Pritha''s Son!
  That is of Tamas, "dark" and desperate!'),
('edwin-arnold-et:gita.18.33','Sir Edwin Arnold','gita.18.33','en','translation','Good is the steadfastness whereby a man
  Masters his beats of heart, his very breath
  Of life, the action of his senses; fixed
  In never-shaken faith and piety:
  That is of Sattwan, Prince! "soothfast" and fair!'),
('edwin-arnold-et:gita.18.34','Sir Edwin Arnold','gita.18.34','en','translation','Stained is the steadfastness whereby a man
  Holds to his duty, purpose, effort, end,
  For life''s sake, and the love of goods to gain,
  Arjuna! ''tis of Rajas, passion-stamped!'),
('edwin-arnold-et:gita.18.35','Sir Edwin Arnold','gita.18.35','en','translation','Sad is the steadfastness wherewith the fool
  Cleaves to his sloth, his sorrow, and his fears,
  His folly and despair. This--Pritha''s Son!--
  Is born of Tamas, "dark" and miserable!'),
('edwin-arnold-et:gita.18.36','Sir Edwin Arnold','gita.18.36','en','translation','Hear further, Chief of Bharatas! from Me
  The threefold kinds of Pleasure which there be.

  Good Pleasure is the pleasure that endures,
  Banishing pain for aye;'),
('edwin-arnold-et:gita.18.37','Sir Edwin Arnold','gita.18.37','en','translation','bitter at first
  As poison to the soul, but afterward
  Sweet as the taste of Amrit. Drink of that!
  It springeth in the Spirit''s deep content.'),
('edwin-arnold-et:gita.18.38','Sir Edwin Arnold','gita.18.38','en','translation','And painful Pleasure springeth from the bond
  Between the senses and the sense-world. Sweet
  As Amrit is its first taste, but its last
  Bitter as poison. ''Tis of Rajas, Prince!'),
('edwin-arnold-et:gita.18.39','Sir Edwin Arnold','gita.18.39','en','translation','And foul and "dark" the Pleasure is which springs
  From sloth and sin and foolishness; at first
  And at the last, and all the way of life
  The soul bewildering. ''Tis of Tamas, Prince!'),
('edwin-arnold-et:gita.18.40','Sir Edwin Arnold','gita.18.40','en','translation','For nothing lives on earth, nor ''midst the gods
  In utmost heaven, but hath its being bound
  With these three Qualities, by Nature framed.'),
('edwin-arnold-et:gita.18.41','Sir Edwin Arnold','gita.18.41','en','translation','The work of Brahmans, Kshatriyas, Vaisyas,
  And Sudras, O thou Slayer of thy Foes!
  Is fixed by reason of the Qualities
  Planted in each:'),
('edwin-arnold-et:gita.18.42','Sir Edwin Arnold','gita.18.42','en','translation','A Brahman''s virtues, Prince!
  Born of his nature, are serenity,
  Self-mastery, religion, purity,
  Patience, uprightness, learning, and to know
  The truth of things which be.'),
('edwin-arnold-et:gita.18.43','Sir Edwin Arnold','gita.18.43','en','translation','A Kshatriya''s pride,
  Born of his nature, lives in valour, fire,
  Constancy, skilfulness, spirit in fight,
  And open-handedness and noble mien,
  As of a lord of men.'),
('edwin-arnold-et:gita.18.44','Sir Edwin Arnold','gita.18.44','en','translation','A Vaisya''s task,
  Born with his nature, is to till the ground,
  Tend cattle, venture trade. A Sudra''s state,
  Suiting his nature, is to minister.'),
('edwin-arnold-et:gita.18.45','Sir Edwin Arnold','gita.18.45','en','translation','Whoso performeth--diligent, content--
  The work allotted him, whate''er it be,
  Lays hold of perfectness! Hear how a man
  Findeth perfection, being so content:'),
('edwin-arnold-et:gita.18.46','Sir Edwin Arnold','gita.18.46','en','translation','He findeth it through worship--wrought by work--
  Of Him that is the Source of all which lives,
  Of HIM by Whom the universe was stretched.'),
('edwin-arnold-et:gita.18.47','Sir Edwin Arnold','gita.18.47','en','translation','Better thine own work is, though done with fault,
  Than doing others'' work, ev''n excellently.
  He shall not fall in sin who fronts the task
  Set him by Nature''s hand!'),
('edwin-arnold-et:gita.18.48','Sir Edwin Arnold','gita.18.48','en','translation','Let no man leave
  His natural duty, Prince! though it bear blame!
  For every work hath blame, as every flame
  Is wrapped in smoke!'),
('edwin-arnold-et:gita.18.49','Sir Edwin Arnold','gita.18.49','en','translation','Only that man attains
  Perfect surcease of work whose work was wrought
  With mind unfettered, soul wholly subdued,
  Desires for ever dead, results renounced.'),
('edwin-arnold-et:gita.18.50','Sir Edwin Arnold','gita.18.50','en','translation','Learn from me, Son of Kunti! also this,
  How one, attaining perfect peace, attains
  BRAHM, the supreme, the highest height of all!'),
('edwin-arnold-et:gita.18.51','Sir Edwin Arnold','gita.18.51','en','translation','Devoted--with a heart grown pure, restrained
  In lordly self-control, forgoing wiles
  Of song and senses, freed from love and hate,'),
('edwin-arnold-et:gita.18.52','Sir Edwin Arnold','gita.18.52','en','translation','Dwelling ''mid solitudes, in diet spare,
  With body, speech, and will tamed to obey,
  Ever to holy meditation vowed,
  From passions liberate,'),
('edwin-arnold-et:gita.18.53','Sir Edwin Arnold','gita.18.53','en','translation','quit of the Self,
  Of arrogance, impatience, anger, pride;
  Freed from surroundings, quiet, lacking nought--
  Such an one grows to oneness with the BRAHM;'),
('edwin-arnold-et:gita.18.54','Sir Edwin Arnold','gita.18.54','en','translation','Such an one, growing one with BRAHM, serene,
  Sorrows no more, desires no more; his soul,
  Equally loving all that lives, loves well
  Me, Who have made them, and attains to Me.'),
('edwin-arnold-et:gita.18.55','Sir Edwin Arnold','gita.18.55','en','translation','By this same love and worship doth he know
  Me as I am, how high and wonderful,
  And knowing, straightway enters into Me.'),
('edwin-arnold-et:gita.18.56','Sir Edwin Arnold','gita.18.56','en','translation','And whatsoever deeds he doeth--fixed
  In Me, as in his refuge--he hath won
  For ever and for ever by My grace
  Th'' Eternal Rest!'),
('edwin-arnold-et:gita.18.57','Sir Edwin Arnold','gita.18.57','en','translation','So win thou! In thy thoughts
  Do all thou dost for Me! Renounce for Me!
  Sacrifice heart and mind and will to Me!
  Live in the faith of Me!'),
('edwin-arnold-et:gita.18.58','Sir Edwin Arnold','gita.18.58','en','translation','In faith of Me
  All dangers thou shalt vanquish, by My grace;
  But, trusting to thyself and heeding not,
  Thou can''st but perish!'),
('edwin-arnold-et:gita.18.59','Sir Edwin Arnold','gita.18.59','en','translation','If this day thou say''st,
  Relying on thyself, "I will not fight!"
  Vain will the purpose prove! thy qualities
  Would spur thee to the war.'),
('edwin-arnold-et:gita.18.60','Sir Edwin Arnold','gita.18.60','en','translation','What thou dost shun,
  Misled by fair illusions, thou wouldst seek
  Against thy will, when the task comes to thee
  Waking the promptings in thy nature set.'),
('edwin-arnold-et:gita.18.61','Sir Edwin Arnold','gita.18.61','en','translation','There lives a Master in the hearts of men
  Maketh their deeds, by subtle  pulling--strings,
  Dance to what tune HE will.'),
('edwin-arnold-et:gita.18.62','Sir Edwin Arnold','gita.18.62','en','translation','With all thy soul
  Trust Him, and take Him for thy succour, Prince!
  So--only so, Arjuna!--shalt thou gain--
  By grace of Him--the uttermost repose,
  The Eternal Place!'),
('edwin-arnold-et:gita.18.63','Sir Edwin Arnold','gita.18.63','en','translation','Thus hath been opened thee
  This Truth of Truths, the Mystery more hid
  Than any secret mystery. Meditate!
  And--as thou wilt--then act!'),
('edwin-arnold-et:gita.18.64','Sir Edwin Arnold','gita.18.64','en','translation','Nay! but once more
  Take My last word, My utmost meaning have!
  Precious thou art to Me; right well-beloved!
  Listen! I tell thee for thy comfort this.'),
('edwin-arnold-et:gita.18.65','Sir Edwin Arnold','gita.18.65','en','translation','Give Me thy heart! adore Me! serve Me! cling
  In faith and love and reverence to Me!
  So shalt thou come to Me! I promise true,
  For thou art sweet to Me!'),
('edwin-arnold-et:gita.18.66','Sir Edwin Arnold','gita.18.66','en','translation','And let go those--
  Rites and writ duties! Fly to Me alone!
  Make Me thy single refuge! I will free
  Thy soul from all its  sins! Be of good cheer!'),
('edwin-arnold-et:gita.18.67','Sir Edwin Arnold','gita.18.67','en','translation','[Hide, the holy Krishna saith,
  This from him that hath no faith,
  Him that worships not, nor seeks
  Wisdom''s teaching when she speaks:
  Hide it from all men who mock;'),
('edwin-arnold-et:gita.18.68','Sir Edwin Arnold','gita.18.68','en','translation','But, wherever, ''mid the flock
  Of My lovers, one shall teach
  This  divinest, wisest, speech--
  Teaching in the faith to bring
  Truth to them, and offering
  Of all honour unto Me--
  Unto Brahma cometh he!'),
('edwin-arnold-et:gita.18.69','Sir Edwin Arnold','gita.18.69','en','translation','Nay, and nowhere shall ye find
  Any man of all mankind
  Doing dearer deed for Me;
  Nor shall any dearer be
  In My earth.'),
('edwin-arnold-et:gita.18.70','Sir Edwin Arnold','gita.18.70','en','translation','Yea, furthermore,
  Whoso reads this converse o''er,
  Held by Us upon the plain,
  Pondering piously and fain,
  He hath paid Me sacrifice!
  (Krishna speaketh in this wise!)'),
('edwin-arnold-et:gita.18.71','Sir Edwin Arnold','gita.18.71','en','translation','Yea, and whoso, full of faith,
  Heareth wisely what it saith,
  Heareth meekly,--when he dies,
  Surely shall his spirit rise
  To those regions where the Blest,
  Free of flesh, in joyance rest.]'),
('edwin-arnold-et:gita.18.72','Sir Edwin Arnold','gita.18.72','en','translation','Hath this been heard by thee, O Indian Prince!
  With mind intent? hath all the ignorance--
  Which bred thy trouble--vanished, My Arjun?'),
('edwin-arnold-et:gita.18.73','Sir Edwin Arnold','gita.18.73','en','translation','Arjuna.
  Trouble and ignorance are gone! the Light
  Hath come unto me, by Thy favour, Lord!
  Now am I fixed! my doubt is fled away!
  According to Thy word, so will I do!'),
('edwin-arnold-et:gita.18.74','Sir Edwin Arnold','gita.18.74','en','translation','Sanjaya.
  Thus gathered I the gracious speech of Krishna, O my King!
  Thus have I told, with heart a-thrill, this wise and wondrous thing'),
('edwin-arnold-et:gita.18.75','Sir Edwin Arnold','gita.18.75','en','translation','By great Vyasa''s learning writ, how Krishna''s self made known
  The Yoga, being Yoga''s Lord. So is the high truth shown!'),
('edwin-arnold-et:gita.18.76','Sir Edwin Arnold','gita.18.76','en','translation','And aye, when I remember, O Lord my King, again
  Arjuna and the God in talk, and all this holy strain,
  Great is my gladness:'),
('edwin-arnold-et:gita.18.77','Sir Edwin Arnold','gita.18.77','en','translation','when I muse that splendour, passing speech,
  Of Hari, visible and plain, there is no tongue to reach
  My marvel and my love and bliss.'),
('edwin-arnold-et:gita.18.78','Sir Edwin Arnold','gita.18.78','en','translation','O Archer-Prince! all hail!
  O Krishna, Lord of Yoga! surely there shall not fail
  Blessing, and victory, and power, for Thy most mighty sake,
  Where this song comes of Arjun, and how with God he spake.');

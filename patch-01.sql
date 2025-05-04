ALTER TABLE public.version
ADD COLUMN description text;

ALTER TABLE public.version_aud
ADD COLUMN description text;

ALTER TABLE public.version
ADD COLUMN link VARCHAR(255);

ALTER TABLE public.version_aud
ADD COLUMN link VARCHAR(255);

UPDATE public.version 
SET description = 'Initial version of NIEM.  Added Universal Core (u) and Common Core (c) namespaces and 7 new domains: Emergency Management (em), Immigration (im), Infrastructure Protection (ip), Intelligence (intel), International Trade (it), Justice (j) and Screening (scr).',
    link = 'https://github.com/NIEM/NIEM-Releases/tree/niem-1.0'
WHERE version_number = '1.0';

UPDATE public.version 
SET description = 'Merged the Universal Core (u) and Common Core (c) namespaces into a single NIEM Core (nc) namespace.  Added support for augmentations via type substitution.',
    link = 'https://github.com/NIEM/NIEM-Releases/tree/niem-2.0'
WHERE version_number = '2.0';

UPDATE public.version 
SET description = 'Added 3 new domains: Chemical, Biological, Radiological, Nuclear (cbrn), Family Service (fs), and Maritime (m).',
    link = 'https://github.com/NIEM/NIEM-Releases/tree/niem-2.1'
WHERE version_number = '2.1';

UPDATE public.version 
SET description = 'Added 1 new domain: Biometrics (biom). Renamed the Family Services (fs) domain as Children, Youth, and Family Services (cyfs).  Military Operations (mo) introduced as a domain update.  Refactored augmentations to use element substitution.',
    link = 'https://github.com/NIEM/NIEM-Releases/tree/niem-3.0'
WHERE version_number = '3.0';

UPDATE public.version 
SET description = 'Added 2 new domains: Human Services (hs) and Military Operations (mo).',
    link = 'https://github.com/NIEM/NIEM-Releases/tree/niem-3.1'
WHERE version_number = '3.1';

UPDATE public.version 
SET description = 'Added 1 new domain: Surface Transportation (st).',
    link = 'https://github.com/NIEM/NIEM-Releases/tree/niem-3.2'
WHERE version_number = '3.2';

UPDATE public.version 
SET description = 'Added 1 new domain: Agriculture (ag).  Merged the Children, Youth, and Family Services (cyfs) domain into the Human Services (hs) domain.',
    link = 'https://github.com/NIEM/NIEM-Releases/tree/niem-4.0'
WHERE version_number = '4.0';

UPDATE public.version 
SET description = 'General content changes.',
    link = 'https://github.com/NIEM/NIEM-Releases/tree/niem-4.1'
WHERE version_number = '4.1';

UPDATE public.version 
SET description = 'General content changes.',
    link = 'https://github.com/NIEM/NIEM-Releases/tree/niem-4.2'
WHERE version_number = '4.2';

UPDATE public.version 
SET description = 'Added Controlled Unclassified Information (cui) and Statistics (stat) as auxiliary content.',
    link = 'https://github.com/NIEM/NIEM-Releases/tree/niem-5.0'
WHERE version_number = '5.0';

UPDATE public.version 
SET description = 'Added 1 new domain: Cyber (cyber).',
    link = 'https://github.com/NIEM/NIEM-Releases/tree/niem-5.1'
WHERE version_number = '5.1';

UPDATE public.version 
SET description = 'Added 1 new domain: Learning and Development (lrn-dev).  Added USMTF (usmtf) as a sub-domain of MilOps (mo).',
    link = 'https://github.com/NIEM/NIEM-Releases/tree/niem-5.2'
WHERE version_number = '5.2';

UPDATE public.version 
SET description = 'Released as an OASIS Open Project.  Updated the representations for roles and metadata and added support for additional augmentation techniques.',
    link = 'https://github.com/niemopen/niem-model/tree/6.0-ps02'
WHERE version_number = '6.0';




UPDATE public.version_aud 
SET description = 'Initial version of NIEM.  Added Universal Core (u) and Common Core (c) namespaces and 7 new domains: Emergency Management (em), Immigration (im), Infrastructure Protection (ip), Intelligence (intel), International Trade (it), Justice (j) and Screening (scr).',
    link = 'https://github.com/NIEM/NIEM-Releases/tree/niem-1.0'
WHERE version_number = '1.0';

UPDATE public.version_aud 
SET description = 'Merged the Universal Core (u) and Common Core (c) namespaces into a single NIEM Core (nc) namespace.  Added support for augmentations via type substitution.',
    link = 'https://github.com/NIEM/NIEM-Releases/tree/niem-2.0'
WHERE version_number = '2.0';

UPDATE public.version_aud 
SET description = 'Added 3 new domains: Chemical, Biological, Radiological, Nuclear (cbrn), Family Service (fs), and Maritime (m).',
    link = 'https://github.com/NIEM/NIEM-Releases/tree/niem-2.1'
WHERE version_number = '2.1';

UPDATE public.version_aud 
SET description = 'Added 1 new domain: Biometrics (biom). Renamed the Family Services (fs) domain as Children, Youth, and Family Services (cyfs).  Military Operations (mo) introduced as a domain update.  Refactored augmentations to use element substitution.',
    link = 'https://github.com/NIEM/NIEM-Releases/tree/niem-3.0'
WHERE version_number = '3.0';

UPDATE public.version_aud 
SET description = 'Added 2 new domains: Human Services (hs) and Military Operations (mo).',
    link = 'https://github.com/NIEM/NIEM-Releases/tree/niem-3.1'
WHERE version_number = '3.1';

UPDATE public.version_aud 
SET description = 'Added 1 new domain: Surface Transportation (st).',
    link = 'https://github.com/NIEM/NIEM-Releases/tree/niem-3.2'
WHERE version_number = '3.2';

UPDATE public.version_aud 
SET description = 'Added 1 new domain: Agriculture (ag).  Merged the Children, Youth, and Family Services (cyfs) domain into the Human Services (hs) domain.',
    link = 'https://github.com/NIEM/NIEM-Releases/tree/niem-4.0'
WHERE version_number = '4.0';

UPDATE public.version_aud 
SET description = 'General content changes.',
    link = 'https://github.com/NIEM/NIEM-Releases/tree/niem-4.1'
WHERE version_number = '4.1';

UPDATE public.version_aud 
SET description = 'General content changes.',
    link = 'https://github.com/NIEM/NIEM-Releases/tree/niem-4.2'
WHERE version_number = '4.2';

UPDATE public.version_aud 
SET description = 'Added Controlled Unclassified Information (cui) and Statistics (stat) as auxiliary content.',
    link = 'https://github.com/NIEM/NIEM-Releases/tree/niem-5.0'
WHERE version_number = '5.0';

UPDATE public.version_aud 
SET description = 'Added 1 new domain: Cyber (cyber).',
    link = 'https://github.com/NIEM/NIEM-Releases/tree/niem-5.1'
WHERE version_number = '5.1';

UPDATE public.version_aud 
SET description = 'Added 1 new domain: Learning and Development (lrn-dev).  Added USMTF (usmtf) as a sub-domain of MilOps (mo).',
    link = 'https://github.com/NIEM/NIEM-Releases/tree/niem-5.2'
WHERE version_number = '5.2';

UPDATE public.version_aud 
SET description = 'Released as an OASIS Open Project.  Updated the representations for roles and metadata and added support for additional augmentation techniques.',
    link = 'https://github.com/niemopen/niem-model/tree/6.0-ps02'
WHERE version_number = '6.0';

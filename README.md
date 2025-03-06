# DOM_biochemical_reaction

The purpose of these scripts is to quantitatively analyze key biochemical reactions including demethylation/methylation, decarboxylation/carboxylation, dehydration/hydration, dehydrogenation/hydrogenation, deamination/amination. The analysis is based on the quantification of alterations in functional groups, identified through changes in chemical formulas before and after the reactions, using the following equations for each chemical reaction:

Demethylation: CcHhOoNnPpSs +a[H] →Cc-aHh-3aOoNnPpSs+a[CH3]

Decarboxylation: CcHhOoNnPpSs +a[H] →Cc-aHh-aOo-2aNnPpSs+a[COOH]

Dehydration: CcHhOoNnPpSs →CcHh-2aOo-aNnPpSs+a[H2O]

Dehydrogenation: CcHhOoNnPpSs →CcHh-2aOoNnPpSs+a[H2]

Deamination: CcHhOoNnPpSs +a[O] →CcHh-3aOoNn-aPpSs+a[NH3]

## Usage of the scripts

```
perl CO2_parser2_v2.pl -site1 site1-v2.txt  -site2 site2-v2.txt  -output CO2_parser.txt # parse the decarboxylation
perl H2_parser2_v2.pl -site1 site1-v2.txt  -site2 site2-v2.txt  -output H2_parser.txt # parse the dehydrogenation
perl H2O_parser2_v2.pl -site1 site1-v2.txt  -site2 site2-v2.txt  -output H2O_parser.txt # parse the dehydration
perl NH3O_parser2_v2.pl -site1 site1-v2.txt  -site2 site2-v2.txt  -output NH3O_parser.txt # parse the deamination
perl CH2_parser2_v2.pl -site1 site1-v2.txt  -site2 site2-v2.txt  -output CH2_parser.txt # parse the demethylation
```

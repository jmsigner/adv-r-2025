Data from dead mountain pines sampled in the Swiss National Park (Bigler & Rigling 2013; Bigler 2016)

Correspondence author:
Christof Bigler
Chair of Forest Ecology
Institute of Terrestrial Ecosystems
Department of Environmental Systems Science
ETH Zurich
CHN G77
Universitaetstrasse 22
8092 Zurich
Switzerland

E-mail: christof.bigler@env.ethz.ch
Personal homepage: http://www.fe.ethz.ch/en/die-gruppe/people/person-detail.html?persid=58107
Website of the Department of Environmental Systems Science (ETH Zurich): http://www.usys.ethz.ch/en

File list:
Data1.txt
Data2.txt
Data3.txt

The files are tab-separated text files. Factors are written in quotation marks.

################################################################

Description of Data1.txt:

This file contains 5 columns (variables) x 23956 rows (excluding the first row, which contains the header with the variable names). The data were used to plot the development of DBH (diameter at breast height) inside bark with tree age classified by early growth and colored by lifespan (Figure 1 in Bigler 2016).

The variables are:

1) core.code
The variable "core.code" is a unique identifier of the tree cores (e.g. "D003.L1"), which identifies the tree (e.g. "D003" is from the dead mountain pine "D003") and the core ("L1" for the core that was taken on the left side of the tree, "R1" for the core that was taken on the right side of the tree). It contains 160 different values with each corresponding to one tree core. From each tree only one core was selected (see Bigler 2016).

2) age
The variable "age" (unit: number of years) indicates the age at a given DBH and of a given tree core. Since many cores did not hit the pith of the tree, the first entry of each core often starts after the age of 1 year.

3) DBH
The variable "DBH" (diameter at breast height inside bark; unit: cm) indicates the diameter at a given age and of a given tree core. The DBH was derived from the measured ring widths (accounting for missed rings between first ring on the core and the pith) as DBH = 2 x cumulated ring widths (see Bigler 2016).

4) lc.growth.rate50.cat
The variable "lc.growth.rate50.cat" indicates 6 categories of early growth (mean ring width over +the first 50 years): > 1.5 mm, 1.25 - 1.5 mm, 1.0 - 1.25 mm, 0.75 - 1.0 mm, 0.5 - 0.75 mm, < 0.5 mm

5) longest.core.age
The variable "longest.core.age" (unit: number of years) corresponds to the lifespan of the tree (= maximum age of the tree).


Example:
Rows 1 - 133 (exluding the first row) contain the data of core "D003.L1". The first DBH measurement is 2.11 cm, when the tree was 12 years old. The last DBH measurement is 14.946 cm, when the tree was 144 years old (which corresponds to the lifespan of tree "D003").


################################################################

Description of Data2.txt:

This file contains 13 columns (variables) x 160 rows (excluding the first row, which contains the header with the variable names). The data were used to create: (1) a boxplot with DBH (diameter at breast height) inside bark versus categories of early growth (Fig. 2a in Bigler 2016); (2) a boxplot with lifespan versus categories of early growth (Fig. 2b in Bigler 2016); (3) pairwise scatter plots between lifespan, early growth, DBH inside bark and topographical variables (S1 Fig. in Bigler 2016); and (4) a scatter plot between early growth and lifespan (S3 Fig. in Bigler 2016). The data were further used to estimate linear mixed-effects models for predicting lifespan of mountain pines (Tables 1 and 2 in Bigler 2016).

The variables are:

1) code.tree
The variable "code.tree" is a unique identifier of the trees. It contains 160 values with each corresponding to one tree.

2) site
The variable "site" indicates the 20 sites (e.g. "SNP.South.18" is a south-facing site in the Swiss National Park, SNP). The site aspects ("North", "East", "West", "South") indicate the main aspect of each site.

3) aspect.tree
The variable "aspect.tree" (unit: degree °) is the north-based azimuth for each tree as measured with a compass in the field (0° = North, 90° = East, 180° = South, 270° = West).

4) NS
The variable "NS" was derived from "aspect.tree" and indicates the North-South gradient (NS = cos(aspect.tree/360 * 2 * pi)). A value of 1 represents a north-facing site, a value of -1 represents a south-facing site.

5) EW
The variable "EW" was derived from "aspect.tree" and indicates the East-West gradient (EW = sin(aspect.tree/360 * 2 * pi)). A value of 1 represents an east-facing site, a value of -1 represents a west-facing site.

6) z.coord.tree
The variable "z.coord.tree" represents the elevation (unit: m a.s.l., above sea level) for each tree as measured with a GPS in the field.

7) slope
The variable "slope" represents the slope steepness (unit: degree °) for each tree as measured with a Vertex IV in the field. A value of 45° corresponds to 100% slope steepness.

8) tree.height
The variable "tree.height" is the tree height (unit: m) as measured with a Vertex IV in the field.

9) longest.core.code
The variable "longest.core.code" is a unique identifier and indicates the code of the tree core that was selected for the analyses (for further details see Bigler 2016). This variable corresponds to the variable "core.code" in the file Data1.txt.

10) longest.core.age
The variable "longest.core.age" indicates the lifespan of a tree. This variable corresponds to the variable "longest.core.age" in the file Data1.txt.

11) longest.core.dbhbb
The variable "longest.core.dbhbb" contains the DBH (diameter at breast height) inside bark (unit: cm). The variable corresponds to the maximum DBH value measured for a core in the variable "DBH" in the file Data1.txt.

12) lc.growth.rate50
The variable "lc.growth.rate50" contains the early growth (mean ring width over the first 50 years; unit: mm) of the core indicated in the variable "longest.core.code".

13) lc.growth.rate50.cat
The variable "lc.growth.rate50.cat" indicates the 6 categories of early growth (mean ring width over the first 50 years): > 1.5 mm, 1.25 - 1.5 mm, 1.0 - 1.25 mm, 0.75 - 1.0 mm, 0.5 - 0.75 mm, < 0.5 mm. The variable corresponds to the variable "lc.growth.rate50.cat" in the file Data1.txt.


Example: 
Tree "D003" (variable "code.tree") belongs to the site "SNP.South.18" (variable "site"), has an aspect of 214°, was growing on 1919.6 m a.s.l. and a slope with 34° slope steepness, tree height is 10.3 m. The core selected for further analyses was "D003.L1" (variable "longest.core.code"), lifespan is 144 years, the maximum DBH is 14.946 cm, and early growth is 0.84 mm.


################################################################

Description of Data3.txt:

This file contains 5 columns (variables) x 24546 rows (excluding the first row, which contains the header with the variable names). The data were used to plot establishment and mortality dates classified by early growth and colored by lifespan (Figure 3 in Bigler 2016) and to plot plot-specific variability of early growth (S2 Fig.). The year of establishment was estimated as the formation year of the first tree ring (corrected for missed rings between pith and first tree ring on the core). The year of mortality was estimated by the formation year of the last tree ring on the core. Due to the occurrence of partial cambial mortality, the year of mortality was only approximated (see Bigler & Rigling 2013).

The variables are:

1) longest.core.code
The variable "longest.core.code" is a unique identifier and indicates the code of the tree core that was selected for the analyses (for further details see Bigler 2016). This variable corresponds to the variables "core.code" in the file Data1.txt and "longest.core.code" in the file Data2.txt.

2) lc.growth.rate50
The variable "lc.growth.rate50" contains the early growth (mean ring width over the first 50 years; unit: mm) of the core indicated in the variable "longest.core.code".

3) lc.growth.rate50.cat
The variable "lc.growth.rate50.cat" indicates the 6 categories of early growth (mean ring width over the first 50 years): > 1.5 mm, 1.25 - 1.5 mm, 1.0 - 1.25 mm, 0.75 - 1.0 mm, 0.5 - 0.75 mm, < 0.5 mm. The variable corresponds to the variable "lc.growth.rate50.cat" in the files Data1.txt and Data2.txt.

4) longest.core.age
The variable "longest.core.age" indicates the lifespan of a tree. This variable corresponds to the variable "longest.core.age" in the files Data1.txt and Data2.txt.

5) year
The variable "year" indicates the calendar year.


Example:
Rows 1 - 144 (exluding the first row) contain the data of core "D003.L1". The estimated year of establishment was 1820, the estimated year of mortality was 1963. Early growth of the tree is 0.84 mm, the lifespan is 144 years.


################################################################
References:

Bigler C. & Rigling A. (2013) Precision and accuracy of tree-ring-based death dates of mountain pines in the Swiss National Park. Trees - Structure and Function, 27, 1703-1712.

Bigler C. (2016) Trade-offs between growth rate, tree size and lifespan of mountain pine (Pinus montana) in the Swiss National Park. PLOS ONE

_your zenodo badge here_

# li-etal_2023

**Persistent Urban Heat**

Dan Li<sup>1\*</sup>, Linying Wang<sup>1</sup>, Weilin Liao<sup>2</sup>, Ting Sun<sup>3</sup>, Gabriel Katul<sup>4</sup>, Elie Bou-Zeid<sup>5</sup>, and Björn Maronga<sup>6,7</sup>

<sup>1 </sup> Department of Earth and Environment, Boston University, Boston, USA

<sup>2 </sup> Guangdong Key Laboratory for Urbanization and Geo-simulation, School of Geography and Planning, Sun Yat-sen University, Guangzhou, China 

<sup>3 </sup> Institute for Risk and Disaster Reduction, University of College London, London, UK

<sup>4 </sup> Department of Civil and Environmental Engineering, Duke University, Durham, USA

<sup>5 </sup> Department of Civil and Environmental Engineering, Princeton University, Princeton, USA

<sup>6 </sup> Institute of Meteorology and Climatology, Leibniz University Hannover, Hannover, Germany

<sup>7 </sup> Geophysical Institute, University of Bergen, Bergen, Norway

\* corresponding author:  lidan@bu.edu

## Abstract
While urban surface and near-surface air temperatures are known to be often higher than their rural counterparts, a phenomenon labeled as urban heat islands (UHIs), whether urban temperatures are more persistent than rural temperatures at time scales commensurate to heat waves has not been addressed despite the importance for human health. Combining numerical simulations by a global model with a surface energy balance theory, we demonstrate that urban surface and near-surface air temperatures are significantly more persistent than their rural counterparts in cities dominated by materials with large thermal inertia. Further use of these materials will result in even stronger urban temperature persistence, especially for tropical cities. Mitigation strategies that can simultaneously ameliorate the larger magnitude and stronger persistence of urban temperatures are recommended.

## Journal reference
Li, D., L. Wang, W. Liao, T. Sun, G. Katul, E. Bou-Zeid, & B. Maronga (2023). Persistent Urban Heat. Science Advances. 

## Code reference

https://github.com/IMMM-SFA/urban_clm5/tree/greenroof_version2.3.3

## Data reference

### Input data

https://svn-ccsm-inputdata.cgd.ucar.edu/trunk/inputdata/

### Output data

Perlmutter: 

/global/cfs/cdirs/m2702/wangly/li-etal_2023_SA/urban_I2000Clm50Sp_f09_g17_regular_roof/

/global/cfs/cdirs/m2702/wangly/li-etal_2023_SA/urban_I2000Clm50Sp_f09_g17_regular_roof_urbuniform/

/global/cfs/cdirs/m2702/wangly/li-etal_2023_SA/urban_I2000Clm50Sp_f09_g17_regular_roof_urbuniform2/

/global/cfs/cdirs/m2702/wangly/li-etal_2023_SA/urban_I2000Clm50Sp_f09_g17_regular_roof_urbuniform3/

/global/cfs/cdirs/m2702/wangly/li-etal_2023_SA/urban_I2000Clm50Sp_f09_g17_regular_roof_urbuniform4/

/global/cfs/cdirs/m2702/wangly/li-etal_2023_SA/urban_I2000Clm50Sp_f09_g17_regular_roof_urbuniform5/

/global/cfs/cdirs/m2702/wangly/li-etal_2023_SA/urban_I2000Clm50Sp_f09_g17_regular_roof_urbuniform6/

## Contributing modeling software
| Model | Version | Repository Link | DOI |
|-------|---------|-----------------|-----|
| CESM2 | release-cesm2.0.1 | https://github.com/ESCOMP/CESM/releases/tag/release-cesm2.0.1 | 10.1029/2019MS001916 |

## Reproduce my experiment

1. Install the software components required to conduct the experiment from [Contributing modeling software](#contributing-modeling-software). The detailed download instructions are also available online https://www.cesm.ucar.edu/models/cesm2/release_download.html
2. Download and install the supporting input data required to conduct the experiement from [Input data](#input-data)
3. Create the surface data input for the uniform city simulations

| Script Name | Description | How to Run |
| --- | --- | --- |
| `surfdata_uniform_urban1.ncl` | Script to generate the uniform city surfdata | `ncl surfdata_uniform_urban1.ncl` |
| `surfdata_uniform_urban2.ncl` | Script to generate the uniform city surfdata by multiplying the heat capacity and thermal conductivity by factors of 2, 5, 10, 20 and 50| `ncl surfdata_uniform_urban2.ncl` |

4. Run the following scripts in the `workflow` directory to re-create this experiment:

| Script Name | Description | How to Run |
| --- | --- | --- |
| `create_spinup_case.sh` | Script to run the first part of my experiment (spinup) | `./create_spinup_case.sh` |
| `create_exp_case.sh` | Script to run the last part of my experiment (control run and six sensitivity runs with increased thermal inertia of the imperious
urban land) | `./create_exp_case.sh` |

5. Download the output data from my experiment [Output data](#output-data)
6. Run the following scripts in the `workflow` directory for post-processing my outputs.

| Script Name | Description | How to Run |
| --- | --- | --- |
| `xxx` | Script for post-processing CLMU outputs | `xxx` |

## Reproduce my figures
Use the scripts found in the `figures` directory to reproduce the figures used in this publication.

| Script Name | Description | How to Run |
| --- | --- | --- |
| `xxx` | Script to generate my figures | `xxx` |

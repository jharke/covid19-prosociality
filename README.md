
This repository provides replication files for:

**COVID-19 and pro-sociality: How do donors respond to local pandemic severity, increased salience, and media coverage?**

*Maja Adena (WZB) and Julian Harke (WZB)*

# Description of files

## Experiment - oTree code

For our sessions we use [oTree](https://otree.org/). The
implementation of our experiment can be found in [otree](otree).

The [required Python packages](otree/requirements.txt) can be installed via[^1]:
```bash
pip install -r requirements.txt
```
**Note:** oTree 3.4.0 requires Python 3.7.x - 3.8.x.

The experiment can be started via:
```bash
otree runprodserver
```

Visit [localhost:8000](http://localhost:8000) to start the experiment.

## Analysis - Stata

For the analysis we use [Stata](https://www.stata.com/).


### Data

The folder [stata_files/data](stata_files/data) contains two datasets:

- **corona_donation_experiment_anonymized.dta**: This Stata file
  contains the anonymized survey and experimental data.
- **UTLAdata_lnskew.dta**: This Stata file contains region data at
  UTLA level.

The description of the variables can be found in
[3_labels.do](stata_files/do_files/3_labels.do).

### Do-files

The folder [stata_files/do_files](stata_files/do_files) contains the
code to replicate our results.

The required Stata packages can be installed via:

```stata
ssc install estout
ssc install erepost
ssc install reghdfe
```

To replicate our analysis run
[0_MAIN.do](stata_files/do_files/0_MAIN.do)[^2].

# Replication output

Results will be stored in the replication output folder as follow:

- **prepared_panel_data.dta**: This Stata file contains all data from
  merging *corona_donation_experiment_anonymized.dta* with
  *UTLAdata_lnskew.dta* as well as edited data (for code see dofiles
  [1_merging.do](stata_files/do_files/1_merging.do) and
  [2_variables.do](stata_files/do_files/2_variables.do)).

- **Tables_descriptives.rtf** and **Tables_descriptives.tex**: These
  files contain tables of descriptive output for the paper.

- **Tables_regressions.rtf** and **Tables_regressions.tex**: These
  files contain regression tables presented in the paper and
  regression tables for the supporting hypotheses as described in
  Online Appendix, section D.

## Sources of data
<details>
<summary>Show data sources</summary>

| Source                                               | License and Terms of Use                                                                                                         |
|------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------|
| [nomis](https://www.nomisweb.co.uk/)                 | Attribution required, [Open Government Licence v3.0](https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/) |
| [COVID-19 UK Data](https://coronavirus.data.gov.uk/) | Attribution required, [Open Government Licence v3.0](https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/) |

</details>

[^1]: We recommend installing the required Python packages inside an
    virtual environment.
[^2]: The do-files
    [5-rtf_regressions.do](stata_files/do_files/5-rtf_regressions.do)
    and
    [5-tex_regressions.do](stata_files/do_files/5-tex_regressions.do)
    create identical output but in either *rtf* or *TeX* format. The
    same applies to do-files
    [6-rtf_descriptivestats.do](stata_files/do_files/6-rtf_descriptivestats.do)
    and
    [6-tex_descriptivestats.do](stata_files/do_files/6-tex_descriptivestats.do).

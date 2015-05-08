# Rnaseq
An R package for tasks related to RNA-seq data


#### To load library within your R console
```
library(devtools);
install_github("zhezhangsh/Rnaseq");
library(Rnaseq);
```


#### Align reads with STAR

- Under unix/linux shell, copy these 2 files into your working directory, preferentially where the outputs will be
```
wget https://raw.githubusercontent.com/zhezhangsh/Rnaseq/master/examples/RunStar.yaml
wget https://raw.githubusercontent.com/zhezhangsh/Rnaseq/master/examples/RunStar.r
```

- Edit the RunStar.yaml file to specify inputs. Refer to STAR manual for details: https://github.com/alexdobin/STAR/blob/master/doc/STARmanual.pdf


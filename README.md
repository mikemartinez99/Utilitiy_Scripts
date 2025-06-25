# Utilitiy_Scripts
Helpful day to day utilities

## Sample Sheet Generation
The [sample sheet generation folder](https://github.com/mikemartinez99/Utilitiy_Scripts/tree/main/sample_sheet_generation) contains two scripts that work in conjunction with one another:

1. `make_sample_sheet.sh`
2. `linkMeta.R`

The first script is a driver which generates a temporary sample sheet. The R-script makes use of `openxlsx` and `stringr` to open the slims metadata sheet from the sequencing facility and link file names to external IDs, preventing human error in making the sample sheet. By default, this pipeline outputs comma-separated files (.csv) but can be easily modified to output tab-separated files if desired in the `linkMeta.R` file. 

### Implementation
To view usage menu for the code, run the following:
```shell
bash make_sample_sheet.sh
```

1. Copy the scripts from the utilities folder to your working directory
```shell
cd <workingDir>
cp /dartfs-hpc/rc/lab/G/GMBSR_bioinfo/misc/utilities/general_pipeline_utilities/sample_sheet_generation/* .
```

2. Ensure that you have the slims metadata file in your working directory. It should be named `metadata.xlsx` by default. If it is not, change the file name to represent this
```shell
mv <some_file.xlsx` metadata.xlsx
```

**If on discovery, polaris, or andes, follow steps 3A. If local, skip to step 4**
3A. If on discovery, activate the conda environment with all R dependencies
```shell
conda activate sampleSheets
```

4. Run the script directly on data path or on a symlink of data
```shell
# If data is stored in paired end
bash make_sample_sheet.sh ./data paired

# If data is single end
bash make_sample_sheet.sh ./data single
```



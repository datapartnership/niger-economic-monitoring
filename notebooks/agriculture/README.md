# Agriculture in Niger

## Request

Using NASA remote sensing data, analyze changing trends in plantings. For each year over the past 10 years, analyze changes in the total square area of new plantings. For 2023-4, identify the total area of farms that have seen relatively consistent historic plantings but do not have observed plantings for the 2023-24 growing season. Monthly updates can be requested, if possible.

Using NASA remote sensing data, prepare historical drought analysis for Niger and bordering countries. Estimate hectares of farmland where drought has occurred over the past 5 years.

Combine the past 5 years of planting, drought, and conflict statistics to determine to what extent droughts and conflict may have impacted plantings.

## Setup

```bash
conda create -n niger python=3.10
conda activate niger
pip install ipykernel
python -m ipykernel install --user --n niger
cd Repos # or any directory to save repositories
git clone https://github.com/andresfchamorro/phenolopy.git
cd phenolopy
git checkout -b dev
git pull origin dev
cd ..
pip install earthengine-api
python -m pip install git+https://github.com/worldbank/GEE_Zonal.git
pip install geemap
pip install xarray
pip install geojson
pip install tqdm
pip install dask[distributed]
pip install plotnine
pip install rasterstats
pip install xee
```

## Notebooks

- **evi-reference.ipynb**: Extracts vegetation index for static crop areas, defines a baseline, and examines how the current season relate to the baseline.

- **evi-timesat**: Seasonality analysis of EVI data.

- **evi-classification.ipynb**: Random forest classifier to predict active crops based on seasonality parameters, based on example from https://learn.geo4.dev/Satellite%20Crop%20Mapping.html.

- **evi-conflict.ipynb**: Overlay conflict data and EVI.

- **crop-area-zs**: Zonal statistics of crop areas.

- **drought.ipynb**: Drought analysis.

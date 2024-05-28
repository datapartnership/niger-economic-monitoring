# Movement Analysis

A key driver in understanding economic activity is movement of people. Movement is useful in dtermining where people live, where they work and where the most activity takes place in a country. To understand this better, the Data Lab aims to use movement data from three datasets - Colocation Maps and Commuting Zones from Meta and Movement data from Mapbox. 

The West African region has been politically unstable in the recent year. In September 2023, Niger, Mali and Burkina Faso created an Alliance of Sahel States (AES) and in January 2024, decided to withdraw from the Economic Community of West African States (ECOWAS). This occurence followed the coup d'état in Niger in July 2023. Given this interdependence, this movement analysis takes into consideration movement across borders as far as data is available. 

## Data

### Meta Colocation Maps

Colocation Maps estimate how often people from different regions are in the same area at the same time, or “colocated.” In particular, for a pair of geographic regions x and y, these maps estimate the rate at which a randomly chosen person from x and a randomly chosen person from y are simultaneously located in the same general area during a randomly chosen time in a given week.

- **Weekly measured coobservation rate (weekly_measured_coobservation_rate)**: The rate at which a randomly chosen person from polygon 1 and a randomly chosen person from polygon 2 were simultaneously observed in a randomly chosen 5-minute period, regardless of where they are in the world. This is different from the weekly measured colocation rate, in which the randomly chosen pair of people must have been observed not only in the same 5-minute period, but also in the same level-16 Bing tile.
- **Weekly measured colocation rate (weekly_measured_colocation_rate)**: The rate at which a randomly chosen person from polygon 1 and a randomly chosen person from polygon 2 were simultaneously observed in the same level-16 Bing tile in a randomly chosen 5-minute period
- **Weekly colocation rate (weekly_colocation_rate)**: Of all the times that people from polygon 1 and polygon 2 could have been observed to be colocated, how often were they colocated? Mathematically, this is the weekly measured colocation rate (weekly_measured_colocation_rate) over the weekly measured coobservation rate (weekly_measured_coobservation_rate).This adjusts the colocation rate in light of the fact that people from polygon 1 and polygon 2 were only simultaneously observed some fraction of the time, and only in those cases can we determine whether they were colocated. This adjusted value is what we propose that partners use in their analysis.
- **Is home tile colocation (is_home_tile_colocation)**: The value in this column represents the response to this statement: These pairs of people are in their shared home tile at the same time. If the value is true, the rate of colocation in the shared home tile is reported in the weekly measured colocation rate (weekly_measured_colocation_rate) and weekly colocation rate (weekly_colocation_rate) columns, which report raw and corrected rates, respectively. If the value is false, the weekly measured colocation rate (weekly_measured_colocation_rate) and weekly colocation rate (weekly_colocation_rate) columns report raw and corrected rates, respectively, at which pairs of people are colocated but at least one person in each pair is outside their home tile.

### Meta Commuting Zones

Commuting zones represent the areas where people spend most of their time and conduct most of their economic activity. These areas of economic integration are independent from political boundaries and can illustrate how economic communities and commute patterns transcend regional boundaries.

#### Methodology and Data Collection

- **Population sample**: Commuting Zones draws from a sample of people who use the Facebook mobile app and have enabled the Location Services setting. 
- **Spatial methods**: The Commuting Zones spatial shapes are built by defining a community network. They start with a node for each city or town where people who use Facebook live. They define the edges of the graph using a formula. They then reduce the complexity of this graph using a Louvain clustering algorithm. Once they have a simplified network/graph, they use Voronoi shapes to define the polygon for the commuting zone. 

    (#residents moving from i to j + #residents moving from j to i) / (#residents in i + #residents in j)

    
- **Temporal span**: Commuting zones are rebuilt at most every 3 months, when the commuting zone shapes are generated using the previous few weeks of Location Services data.
- **Minimum counts/size**: To generate a commuting zone, there must be at least 50 people estimated to live within its boundary and a minimum size of at least 1 kilometer by 1 kilometer.
- **Estimated population (win_population)**: Estimated population within the zone (calculated from the publicly available Facebook High-Resolution Population Density Maps or WorldPop estimates). These population estimates are provided as counts per grid tile on the earth’s surface. They map each of these tiles to a commuting zone, then aggregate population by taking the sum of all the tiles within the commuting zone polygon defined in the geometry field. They then winsorizethe bottom and top 5% of commuting zones. This means that the population counts per commuting zone below the 5% percentile are replaced by the 5% percentile value, and those above the 95% percentile are replaced by the 95% percentile value. All commuting zones have a population of at least 50.
- **Local business count (local_business_locations_count)**: A scaled score of 1-1,000 calculated by counting all the Facebook Pages of this type within each commuting zone globally. We then winsorize those values. This means that the Page counts per commuting zone below the 2.5% percentile are replaced by the 2.5% percentile value, and those above the 97.5% percentile are replaced by the 97.5% percentile value. The winsorized count of Pages in each commuting zone is then scaled between 0 and 1,000. That means that the smallest winsorized value is given a score of 0 and the highest is given a score of 1,000, with all intermediate values assigned linearly.

### Mapbox Movement

Mapbox Movement data has currently been requested from Mapbox through the Development Data Partnership. The analysis will be published as soon as the data becomes available. 
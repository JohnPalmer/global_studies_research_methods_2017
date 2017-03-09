# import libraries
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.cm as cm
import matplotlib
matplotlib.style.use('ggplot')
from sklearn.cluster import KMeans
import pandas as pd
import os

# setting working directory
os.chdir(os.path.expanduser('ADD YOUR DIRECTORY HERE'))

# importing csv data
df=pd.read_csv('nyc_assault.csv', sep=',')

# creating two-column data frame for analysis
X = df.loc[:, ['X_COORD_CD','Y_COORD_CD']] 

# calculating k-means 
kmeans = KMeans(n_clusters=9, random_state=0).fit(X)

# adding cluster labels to original data
df['label'] = kmeans.labels_

# colors for plotting
cmap = cm.get_cmap('seismic', 9)
mycols = list(map(lambda x: matplotlib.colors.rgb2hex(cmap(x)[:3]), df['label'].tolist()))
df['color'] = mycols

# saving as new csv
df.to_csv('nyc_assault_labeled.csv')

# plotting
ax = df.plot.scatter(x='X_COORD_CD', y='Y_COORD_CD', c=df['color'])
ax.axis('off')
fig = ax.get_figure()
fig.savefig('clusterplot.png', figsize=(50,50), dpi=300)


